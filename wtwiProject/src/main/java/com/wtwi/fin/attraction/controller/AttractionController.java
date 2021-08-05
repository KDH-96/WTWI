package com.wtwi.fin.attraction.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Set;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.annotation.JsonAppend.Attr;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.wtwi.fin.attraction.model.vo.Attraction;

@Controller
@RequestMapping("/attraction/*")
public class AttractionController {
	
	// 명소 목록 조회
	@RequestMapping("list")
	public String attractionView() {
		
		
		return "attraction/attractionList";
	}
	
	@RequestMapping("search/area")
	@ResponseBody
	public String attractionListView(String contentTypeS , int areaCode) {
		
		int contentType = Integer.parseInt(contentTypeS);
		
		String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList";
		String serviceKey = "%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D";
		String MobileApp = "WhereTheWeatherIs";
		String type = "json";
		String arrange = "B";
		int numOfRows = 12;
		//int pageNo = 1;
		
		String  req = url + 
					  "?ServiceKey=" + serviceKey +
					  "&contentTypeId=" + contentType +
					  "&areaCode=" + areaCode +
					  "&listYN=Y&MobileOS=ETC" +
					  "&MobileApp=" + MobileApp +
					  "&arrange=" + arrange +
					  "&numOfRows" + numOfRows +
					  //"&pageNo=" + pageNo +
					  "&_type=" + type;
		
		String result = "";
		URL requestURL;
		try {
			requestURL = new URL(req);
			HttpURLConnection conn = (HttpURLConnection) requestURL.openConnection();
			
			conn.setRequestMethod("GET");
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8")); //공공데이터에서 값을 요때 얻어옴
			//InputStreamReader : 바이트스트림을 문자스트림으로 
			//BufferedReader : 성능향상
			String line = null;
			
			while((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println(req);
			System.out.println(result);
			//jsonparser : String을 json Object 로 바꿔줌 -> json Object가 되면 자바에서 쓸수 있음 -> 별도의 변환작업으로 vo로 만들 수 있고 DB 저장도 가능 
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	
	
	/*****상세조회*******************************************************************************************/
	
	@RequestMapping(value="view/{contentid}" , method=RequestMethod.GET)
	//@ResponseBody
	public String attractionSelectView(@PathVariable("contentid") int attractionNo, 
										Model model , 
										@ModelAttribute Attraction attr) {
		
		String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon";
		String serviceKey = "%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D";
		String MobileOS = "ETC";
		String MobileApp = "WhereTheWeatherIs";
		String type = "json";
		/*
		 	http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon
		 	?serviceKey=%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D
		 	&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&contentId=126508&defaultYN=Y
		 	&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y
		*/
		
		String  req = url + 
				  "?ServiceKey=" + serviceKey +
				  "&MobileOS=" + MobileOS +
				  "&MobileApp=" + MobileApp +
				  "&contentId=" + attractionNo +
				  "&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y" +
				  "&_type=" + type
				  ;
	
		String result = "";
		URL requestURL;
		try {
			requestURL = new URL(req);
			HttpURLConnection conn = (HttpURLConnection) requestURL.openConnection();
			conn.setRequestMethod("GET");
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8")); //공공데이터에서 값을 요때 얻어옴
			String line = null;
			while((line = br.readLine()) != null) {
				result += line;
			}
			//System.out.println(req);
			//System.out.println("요기! result : " +  result);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		//*** result에 json 객체가 담겨있음.****************************************************************************

		
		// JSON 형태의 문자열을 JsonObject로 변경하여 값을 꺼내쓸 수 있는 형태로 변환
		JsonObject convertedObj = new Gson().fromJson(result.toString(), JsonObject.class);
		JsonObject response = new Gson().fromJson(convertedObj.get("response").toString(), JsonObject.class); 
		JsonObject body = new Gson().fromJson(response.get("body").toString(), JsonObject.class); 
		JsonObject items = new Gson().fromJson(body.get("items").toString(), JsonObject.class); 
		JsonObject item = new Gson().fromJson(items.get("item").toString(), JsonObject.class); 
		
		//*** 필요한 정보들은 item에 k:v 형태로 담겨있음 ***********************************************************************
		System.out.println("아이템 확인 : " + item);
		
		
		
		// 변경된 JsonObject에서 값 추출
		// JsonObject.get("key") == (Object)value (Object타입의 밸류 -> 형변환이나 toString을 통해 문자열로 변환하면됨)
		
		// 받아오지 못하는 경우가 있기 때문에 필드 기본값을 지정
		// attraction의 PK인 attractionNo은 파라미터로 받아옴
		String attractionAddr = null; // addr1
		String addr2 = null;
		int areacode = 0;
		int booktour = 0;
		String cat1 = null;
		String cat2 = null;
		String cat3 = null;
		int attractionTypeNo = 0; // contenttypeid
		long createdTime = 0; 
		String attractionPhoto = null; // firstimage
		String attractionPhoto2 = null; // firstimage2
		String attractionHomePage = null; // homepage
		double latitude = 0; // mapx
		double longitude = 0; // mapy
		int mLevel = 0;
		long modifiedTime = 0;
		String attractionInfo = null; // overview
		int readCount = 0; 
		int sigunguCode = 0;
		String attractionPhone = null; // tel
		String attractionNm = null; // title
		int zipCode = 0;
		int eventStartDate = 0;
		int eventEndDate = 0;

		Set<String> itemKeys = item.keySet(); // 키들을 set에 담기
		
		for(String key : itemKeys) {
			
			System.out.println(key + " : " + item.get(key) );  // k : v 형태로 출력
			
			// key에따라 형변환하여 알맞은 변수에 대입
			switch(key) {
			case "addr1" : attractionAddr = item.get(key).toString().replaceAll("\"", ""); break;
			case "addr2" : addr2 = item.get(key).toString().replaceAll("\"", ""); break;
			case "areacode" : areacode = Integer.parseInt(item.get(key).toString().replaceAll("\"", ""));break;
			case "booktour" : booktour = Integer.parseInt(item.get(key).toString().replaceAll("\"", ""));break;
			case "cat1" : item.get(key).toString().replaceAll("\"", "");break;
			case "cat2" : item.get(key).toString().replaceAll("\"", "");break;
			case "cat3" : item.get(key).toString().replaceAll("\"", "");break;
			case "contenttypeid" : attractionTypeNo = Integer.parseInt(item.get(key).toString().replaceAll("\"", ""));break;
			case "createdtime" : createdTime = Long.parseLong(item.get(key).toString().replaceAll("\"", ""));break;
			case "firstimage" : attractionPhoto = item.get(key).toString().replaceAll("\"", ""); break;
			case "firstimage2" : attractionPhoto2 = item.get(key).toString().replaceAll("\"", ""); break;
			case "homepage" : attractionHomePage = item.get(key).toString().replaceAll("\"", ""); break;
			case "mapx" : latitude = Double.parseDouble(item.get(key).toString().replaceAll("\"", "")); break;
			case "mapy" : longitude = Double.parseDouble(item.get(key).toString().replaceAll("\"", "")); break;
			case "mlevel" : mLevel = Integer.parseInt(item.get(key).toString().replaceAll("\"", ""));break;
			case "modifiedtime" : modifiedTime = Long.parseLong(item.get(key).toString().replaceAll("\"", ""));break;
			case "overview" : attractionInfo = item.get(key).toString().replaceAll("\"", "");break;
			case "sigungucode" : sigunguCode = Integer.parseInt(item.get(key).toString().replaceAll("\"", ""));break;
			case "tel" : attractionPhone = item.get(key).toString().replaceAll("\"", "");break;
			case "title" : attractionNm = item.get(key).toString().replaceAll("\"", "");break;
			case "zipcode" : zipCode = Integer.parseInt(item.get(key).toString().replaceAll("\"", ""));break;
			case "readcount" : readCount = Integer.parseInt(item.get(key).toString().replaceAll("\"", ""));break;
			case "eventstartdate" : eventStartDate = Integer.parseInt(item.get(key).toString().replaceAll("\"", ""));break;
			case "eventenddate" : eventEndDate = Integer.parseInt(item.get(key).toString().replaceAll("\"", ""));break;
			}
			
			/* 이후에 코드 줄일 때 참고 하기! -> 0805
			 * switch(key) { case "addr1" : case "addr2": break;
			 * case "sigunguCode" : break; }
			 */
		}

		attr.setAttractionAddr(attractionAddr);
		attr.setAddr2(addr2);
		attr.setAreacode(areacode);
		attr.setBooktour(booktour);
		attr.setCat1(cat1);
		attr.setCat2(cat2);
		attr.setCat3(cat3);
		attr.setAttractionNo(attractionNo);
		attr.setAttractionTypeNo(attractionTypeNo);	
		attr.setCreatedTime(createdTime);
		attr.setAttractionPhoto(attractionPhoto);
		attr.setAttractionPhoto2(attractionPhoto2);
		attr.setAttractionHomePage(attractionHomePage);
		attr.setLatitude(latitude);
		attr.setLongitude(longitude);
		attr.setmLevel(mLevel);
		attr.setModifiedTime(modifiedTime);
		attr.setAttractionInfo(attractionInfo);
		attr.setSigunguCode(sigunguCode);
		attr.setAttractionNm(attractionNm);
		attr.setZipCode(zipCode);
		attr.setAttractionPhone(attractionPhone);
		
		attr.setEventStartDate(eventStartDate);
		attr.setEventEndDate(eventEndDate);
		attr.setReadCount(readCount);
		
		
		model.addAttribute("attr",attr);
		return "attraction/attractionView";
		
	}
	
	
	
	
	
	

}
