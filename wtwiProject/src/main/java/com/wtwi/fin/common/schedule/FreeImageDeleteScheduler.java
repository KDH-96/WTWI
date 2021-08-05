package com.wtwi.fin.common.schedule;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.wtwi.fin.freeboard.model.service.BoardService;

@Component
public class FreeImageDeleteScheduler {
	
	@Autowired
	private BoardService service;
	
	@Autowired
	private ServletContext servletContext; // 서버 경로 얻어옴
	
	//@Scheduled(cron="0 * * * * *") // 테스트용 매 분
	@Scheduled(cron="0 0 0 * * *") // 매일 0시마다 실행
	public void deleteImages() {
		
		String savePath = servletContext.getRealPath("/resources/images/freeboard");
		
		File[] serverFileList = new File(savePath).listFiles();
		
		//Date oneDaysAgo = new Date(System.currentTimeMillis()-(60*60*1000)); // 1시간 전
		Date oneDaysAgo = new Date(System.currentTimeMillis()-(24*60*60*1000)); // 24시간 전
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHH");
		String standard = sdf.format(oneDaysAgo);
		
		// 24시간보다 더 이전에 생성된 파일 List
		List<File> list = new ArrayList<File>();
		for(File f : serverFileList) {
			//System.out.println(f.getName());
			String fileName = f.getName();
			if(fileName.substring(0, 10).compareTo(standard)<0) {
				// 파일명과 기준(standard)을 비교해 파일명이 작성된 시간이 24시간보다 더 이전일 때 리스트에 추가
				list.add(f);
			}
		}
		
		// DB에서 24시간보다 이전에 추가된 파일명 조회(9)
		List<String> dbList = service.selectDbList(standard);
		
		//for(String s : dbList) System.out.println(s);
		
		if(!list.isEmpty() && !dbList.isEmpty()) {
			for(File f : list) {
				if(dbList.indexOf(f.getName())<0) {
					//System.out.println(f.getName()+"삭제");
					f.delete();
				}
			}
		}
	}
}
