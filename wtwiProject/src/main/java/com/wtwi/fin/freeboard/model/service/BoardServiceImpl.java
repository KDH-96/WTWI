package com.wtwi.fin.freeboard.model.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.wtwi.fin.freeboard.exception.SaveFileException;
import com.wtwi.fin.freeboard.model.dao.BoardDAO;
import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Category;
import com.wtwi.fin.freeboard.model.vo.Image;
import com.wtwi.fin.freeboard.model.vo.Pagination;
import com.wtwi.fin.freeboard.model.vo.Search;

/**
 * @author 세은
 */
@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO dao;

	// 전체 게시글 수 조회(1)
	@Override
	public Pagination getPaganation(Pagination pg) {
		
		Pagination selectPg = dao.getListCount(); // 전체 게시글 수 조회
		return new Pagination(pg.getCurrentPage(), selectPg.getListCount()); // 페이지네이션 객체 생성 후 반환
	}

	// 게시글 목록 조회(2)
	@Override
	public List<Board> selectBoardList(Pagination pagination) {
		return dao.selectBoardList(pagination);
	}

	// 게시글 상세 조회(3)
	@Transactional(rollbackFor=Exception.class)
	@Override
	public Board selectBoard(int freeNo) {
		
		// 3-1) 게시글 상세 조회
		Board board = dao.selectBoard(freeNo);
		
		// 3-2) 게시글 상세 조회 성공 후 조회수 1 증가
		if(board!=null) {
			dao.increaseReadCount(freeNo);
			board.setFreeReadCount(board.getFreeReadCount()+1);
		}
		return board;
	}

	// 카테고리 목록 조회(4)
	@Override
	public List<Category> selectCategory() {
		return dao.selectCategory();
	}

	// 검색 게시글 수 조회(5)
	@Override
	public Pagination getPaganation(Search search, Pagination pg) {
		
		Pagination selectPg = dao.getSearchListCount(search);
		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}

	// 검색 게시글 목록 조회(6)
	@Override
	public List<Board> selectBoardList(Search search, Pagination pagination) {
		return dao.selectSearchBoardList(search, pagination);
	}

	// 이미지 파일을 서버에 저장(7)
	@Override
	public String uploadFile(MultipartFile file, String webPath, String savePath) {
		
		// 파일명 변경
		String fileName = rename(file.getOriginalFilename());
		
		// 파일을 서버에 저장
		try {
			file.transferTo(new File(savePath+"/"+fileName));
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new SaveFileException();
		}
		return fileName;
	}
	
	// 게시글 삽입(8)
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertBoard(Board board, List<String> imgs, String webPath) {
		
		// XSS 방지처리 -> 추후
		
		// 개행문자 처리
		board.setFreeContent(board.getFreeContent().replaceAll("<p>", ""));
		board.setFreeContent(board.getFreeContent().replaceAll("</p>", ""));
		
		// 8-1) 게시글 삽입하고 게시글 번호 얻어오기
		int freeNo = dao.insertBoard(board);
		
		if(freeNo>0) { // 게시글 삽입 성공
			
			List<Image> images = new ArrayList<Image>();
			
			for(int i=0; i<imgs.size(); i++) {
				if(!imgs.get(i).equals("")) {
					String filePath = webPath;
					String fileName = imgs.get(i).substring(filePath.length());
					Image img = new Image();
					img.setFileName(fileName);
					img.setFilePath(filePath);
					img.setFreeNo(freeNo);
					images.add(img);
				}
			}
			
			// 업로드된 이미지가 있을 경우
			// 8-2) 이미지 파일 정보 DB에 삽입하기
			if(!images.isEmpty()) {
				dao.insertImages(images);
			}
		}
		return freeNo;
	}
	
	// DB에서 24시간보다 이전에 추가된 파일명 조회(9)
	@Override
	public List<String> selectDbList(String standard) {
		return dao.selectDbList(standard);
	}

	// 크로스 사이트 스크립트 방지 처리 메소드
	public static String replaceParameter(String param) {
		String result = param;
		if(param != null) {
			result = result.replaceAll("&", "&amp;");
			result = result.replaceAll("<", "&lt;");
			result = result.replaceAll(">", "&gt;");
			result = result.replaceAll("\"", "&quot;");
		}
		return result;
	}
	
	// 파일명 변경 메소드
	private String rename(String originFileName) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String date = sdf.format(new java.util.Date(System.currentTimeMillis()));
		int ranNum = (int)(Math.random()*100000); // 5자리 랜덤 숫자 생성
		String str = "_" + String.format("%05d", ranNum);
		String ext = originFileName.substring(originFileName.lastIndexOf("."));
		return date + str + ext;
	}

}
