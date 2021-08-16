package com.wtwi.fin.member.model.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.bag.SynchronizedSortedBag;
import org.json.simple.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.github.scribejava.core.model.Response;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.wtwi.fin.attraction.controller.AttractionController;
import com.wtwi.fin.auth.SNSValue;
import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Reply;
import com.wtwi.fin.member.model.vo.Pagination;
import com.wtwi.fin.member.model.vo.Report;
import com.wtwi.fin.member.model.vo.Review;
import com.wtwi.fin.member.model.vo.Search;
import com.wtwi.fin.qnaboard.model.vo.QnaBoard;
import com.wtwi.fin.member.model.dao.MypageDAO;
import com.wtwi.fin.member.model.vo.Chat;
import com.wtwi.fin.member.model.vo.Member;
import com.wtwi.fin.member.model.vo.News;

@Service
public class MypageServiceImpl implements MypageService {
	
	@Autowired
	private AttractionController attractionController;
	
	@Autowired
	@Qualifier("naverSns")
	private SNSValue naverSns;

	@Autowired
	private MypageDAO dao;
	
	// 메인 명소추천 목록
	@Override
	public List<Review> selectReviewList(int memberNo) {
		// TODO Auto-generated method stub
		return dao.selectReviewList(memberNo);
	}

	// 내가 쓴 글(자유게시판) 전체 게시글 수
	@Override
	public Pagination getFreePagination(Member member, Pagination pg) {

		Pagination selectPg = dao.getFreeListCount(member);

		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}

	// 내가 쓴 글(자유게시판) 게시글 목록 조회
	@Override
	public List<Board> selectFreeBoardList(Pagination pagination, String order) {

		return dao.selectFreeBoardList(pagination, order);
	}

	// 내가 쓴 글(자유게시판) 전체 게시글 수 (검색)
	@Override
	public Pagination getFreePagination(Search search, Pagination pg) {

		Pagination selectPg = dao.getSearchFreeListCount(search);

		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}

	// 내가 쓴 글(자유게시판) 게시글 목록 조회(검색)
	@Override
	public List<Board> selectSearchFreeBoardList(Search search, Pagination pagination) {

		return dao.selectFreeBoardList(search, pagination);
	}

	/////////////////////////////////////////////////////////////////////////////////////

	// 내가 쓴 글(문의게시판) 전체 게시글 수 조회
	@Override
	public Pagination getQnAPagination(Member member, Pagination pg) {

		Pagination selectPg = dao.getQnAListCount(member);

		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}

	// 내가 쓴 글(문의게시판) 게시글 목록 조회(검색)
	@Override
	public List<QnaBoard> selectQnABoardList(Pagination pagination) {

		return dao.selectQnABoardList(pagination);
	}

	// 내가 쓴 글(문의게시판) 전체 게시글 수 (검색)
	@Override
	public Pagination getQnAPagination(Search search, Pagination pg) {

		Pagination selectPg = dao.getSearchQnAListCount(search);

		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}

	// 내가 쓴 글(문의게시판) 게시글 목록 조회(검색)
	@Override
	public List<QnaBoard> selectSearchQnABoardList(Search search, Pagination pagination) {

		return dao.selectQnABoardList(search, pagination);
	}

	/////////////////////////////////////////////////////////////////////////////////////

	// 1:1 문의내역 전체 게시글 수
	@Override
	public Pagination getChatPagination(Member member, Pagination pg) {
		;
		Pagination selectPg = dao.getChatListCount(member);

		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}

	// 1:1 문의내역 게시글 목록 조회(검색)
	@Override
	public List<Chat> selectChatBoardList(Pagination pagination) {

		return dao.selectChatBoardList(pagination);
	}

	// 1:1 문의내역 전체 게시글 수 (검색)
	@Override
	public Pagination getChatPagination(Search search, Pagination pg) {

		Pagination selectPg = dao.getSearchChatListCount(search);

		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}

	// 1:1 문의내역 게시글 목록 조회(검색)
	@Override
	public List<Chat> selectSearchChatBoardList(Search search, Pagination pagination) {

		return dao.selectChatBoardList(search, pagination);
	}

	/////////////////////////////////////////////////////////////////////////////////////

	// 신고내역 전체 게시글 수
	@Override
	public Pagination getReportPagination(Member member, Pagination pg) {
		;
		Pagination selectPg = dao.getReportListCount(member);

		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}

	// 신고내역 게시글 목록 조회
	@Override
	public List<Report> selectReportBoardList(Pagination pagination, String order) {

		return dao.selectReportBoardList(pagination);
	}

	// 신고내역 전체 게시글 수 (검색)
	@Override
	public Pagination getReportPagination(Search search, Pagination pg) {

		Pagination selectPg = dao.getSearchReportListCount(search);

		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}

	// 신고내역 게시글 목록 조회(검색)
	@Override
	public List<Report> selectSearchReportBoardList(Search search, Pagination pagination) {

		return dao.selectSearchReportBoardList(search, pagination);
	}

	/////////////////////////////////////////////////////////////////////////////////////

	// 댓글 내역 전체 게시글 수 
	@Override
	public Pagination getReplyPagination(Member member, Pagination pg) {
		;
		Pagination selectPg = dao.getReplyListCount(member);

		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}

	// 댓글 내역목록 조회
	@Override
	public List<Reply> selectReplyBoardList(Pagination pagination, String order) {

		return dao.selectReplyBoardList(pagination);
	}

	// 댓글 내역 전체 게시글 수 (검색)
	@Override
	public Pagination getReplyPagination(Search search, Pagination pg) {

		Pagination selectPg = dao.getSearchReplyListCount(search);

		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}

	// 댓글 내역 게시글 목록 조회(검색)
	@Override
	public List<Reply> selectSearchReplyBoardList(Search search, Pagination pagination) {

		return dao.selectSearchReplyBoardList(search, pagination);
	}
	
	
	/////////////////////////////////////////////////////////////////////////////////////
	
	// 명소후기 전체 게시글 수 
	@Override
	public Pagination getReviewPagination(Member member, Pagination pg) {
		;
		Pagination selectPg = dao.getReviewListCount(member);
		
		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}
	
	// 명소후기 목록 조회
	@Override
	public List<Review> selectReviewBoardList(Pagination pagination, String order) {
		
		return dao.selectReviewBoardList(pagination, order);
	}
	
	// 명소후기 전체 게시글 수 (검색)
	@Override
	public Pagination getReviewPagination(Search search, Pagination pg) {
		
		Pagination selectPg = dao.getSearchReviewListCount(search);
		
		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}
	
	// 명소후기 게시글 목록 조회(검색)
	@Override
	public List<Review> selectSearchReviewBoardList(Search search, Pagination pagination) {
		
		return dao.selectSearchReviewBoardList(search, pagination);
	}
	
	// 추천 명소 날씨 가져오기
	@Override
	public String getWeatherInfo(String latitude, String longitude, String check) {
		String result = "";
		String apiId = "fab85c55ea80aa78f7d32ab07532fe33";   
		URL url;
		try {
			BufferedReader bf;
			if(check.equals("all")) {
				url = new URL(" https://api.openweathermap.org/data/2.5/forecast?lat=" + latitude + "&lon=" + longitude + "&exclude=current,hourly,minutely&units=metric&appid="+ apiId);				
				bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
				result = bf.readLine();
			} else {
				url = new URL(" https://api.openweathermap.org/data/2.5/weather?lat=" + latitude + "&lon=" + longitude + "&appid="+ apiId);				
				bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
				result = bf.readLine();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	
	// 네이버 뉴스 가져오기
	@Override
	public List<News> getNaverNews() {
		String result = "";
		String clientId = this.naverSns.getClientId();//애플리케이션 클라이언트 아이디값";
        String clientSecret = this.naverSns.getClientSecret();//애플리케이션 클라이언트 시크릿값";
        StringBuffer response = new StringBuffer();
        try {
            String text = URLEncoder.encode("여행명소", "UTF-8"); //검색어";
            String apiURL = "https://openapi.naver.com/v1/search/news.json?query="+ text + "&display=10&start=1&sort=date&bloggername=the_trip"; // 뉴스의 json 결과
       //String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // 블로그의 xml 결과 
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            result = response.toString();
        } catch (Exception e) {
            System.out.println(e);
        }
    

		return parseJson(response.toString());
	}

	
	public List<News> parseJson(String response) {
		
		
		ObjectMapper mapper = new ObjectMapper();
		List<News> news = new ArrayList<News>();
		try {
			JsonNode rootNode = mapper.readTree(response);
			JsonNode newsArr= rootNode.get("items");
			for(int i=0; i<newsArr.size(); i++ ) {
				News article = new News();
				article.setTitle(newsArr.get(i).get("title").asText());
				article.setLink(newsArr.get(i).get("link").asText());
				news.add(article);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return news;
	}

	@Override
	public List<Review> getAttractionSrc(List<Review> reviewList) {
		String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon";
	      String serviceKey = "DHk4yd104VmwtFzoXL%2FaSUlkcYnhFtx9HXNr3Lv1PAMGEGcycENblBxYxe8VLsQpvNXgAUwBeoN5otWGxWkhIg%3D%3D";
	      String MobileOS = "ETC";
	      String MobileApp = "WhereTheWeatherIs";
	      String type = "json";

	      for(int i =0; i<reviewList.size(); i++) {
	    	  String req = url + "?ServiceKey=" + serviceKey + "&MobileOS=" + MobileOS + "&MobileApp=" + MobileApp
	  	            + "&contentId=" + reviewList.get(i).getAttractionNo()
	  	            + "&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y"
	  	            + "&_type=" + type;

	  	      String result = attractionController.makingResult(req);
	  	      // *** result에 json 객체가
	  	      // 담겨있음.****************************************************************************

	  	      // JSON 형태의 문자열을 JsonObject로 변경하여 값을 꺼내쓸 수 있는 형태로 변환
	  	      JsonObject convertedObj = new Gson().fromJson(result.toString(), JsonObject.class);
	  	      JsonObject response = new Gson().fromJson(convertedObj.get("response").toString(), JsonObject.class);
	  	      JsonObject body = new Gson().fromJson(response.get("body").toString(), JsonObject.class);
	  	      JsonObject items = new Gson().fromJson(body.get("items").toString(), JsonObject.class);
	  	      JsonObject item = new Gson().fromJson(items.get("item").toString(), JsonObject.class);

	  	      // *** 필요한 정보들은 item에 k:v 형태로 담겨있음
	  	      // ***********************************************************************
	  	      if(item.get("firstimage") == null) {
	  	    	  reviewList.get(i).setSrc("http://tong.visitkorea.or.kr/cms/resource_photo/20/791720_image2_1.jpg");
	  	      } else {	  	    	  
	  	    	  String src = item.get("firstimage").getAsString();
	  	    	  reviewList.get(i).setSrc(src);
	  	      }
	      }
		return reviewList;
	}
	
	
}
