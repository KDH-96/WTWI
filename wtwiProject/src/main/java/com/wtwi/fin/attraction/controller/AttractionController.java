package com.wtwi.fin.attraction.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.wtwi.fin.attraction.model.service.AttractionService;
import com.wtwi.fin.attraction.model.vo.Attraction;
import com.wtwi.fin.attraction.model.vo.Pagination;
import com.wtwi.fin.attraction.model.vo.Search;

@Controller
@RequestMapping("/attraction/*")
public class AttractionController {
   
   @Autowired
   private AttractionService service;

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
   String zipCode = null;
   int eventStartDate = 0;
   int eventEndDate = 0;
   int attractionNo = 0;

   /***
    * 명소 목록 조회 
    * 1) 위치기반
    * 2) 드롭다운
    * 3) 검색어
    ***************************************************************************************************/
   @RequestMapping(value = "list", method = RequestMethod.GET)
   public String attractionList(Search search, Model model, Pagination pg, @RequestParam(value="cp" , required=false , defaultValue="1" ) int cp) {
/*
      System.out.println("컨트롤러 첫줄에서 keyword가 있는지 확인 : " + search.getKeyword());
      System.out.println("컨트롤러 첫줄에서 contentType가 있는지 확인 : " + search.getContentType());
      System.out.println("컨트롤러 첫줄에서 areaCode가 있는지 확인 : " + search.getAreaCode());
*/
      Gson gson = new Gson();

      // 검색어가 없는 경우 -> 위치기반으로 내 주의 반경 radius미터의 명소 조회
      if (search.getKeyword() == null) {
    	  
    	  if(search.getAreaCode() == null) { // 1) 기본 : 위치기반
    		  /*
    		   * http://api.visitkorea.or.kr/openapi/service/rest/KorService/locationBasedList
    		   * ?serviceKey=%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%
    		   * 2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D
    		   * &MobileOS=ETC &MobileApp=AppTest &arrange=E &mapX=126.981611 &mapY=37.568477
    		   * &radius=1000 &listYN=Y
    		   */
    		  String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/locationBasedList";
    		  String serviceKey = "%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D";
    		  String MobileOS = "ETC";
    		  String MobileApp = "WhereTheWeatherIs";
    		  String arrange = "E"; // 가까운 거리부터 정렬
    		  double longitude = 126.981611;
    		  double latitude = 37.568477;
    		  int radius = 5000; // (거리반경, max 20000m)
    		  String type = "json";
    		  
    		  int attractionNo = 0;
    		  
    		  String req = url + "?ServiceKey=" + serviceKey 
    				  + "&numOfRows=12" 
    				  + "&pageNo=" + cp
    				  + "&MobileOS=" + MobileOS + "&MobileApp=" + MobileApp
    				  + "&arrange=" + arrange 
    				  + "&contentTypeId=12&14" 
    				  + "&mapX=" + longitude 
    				  + "&mapY=" + latitude 
    				  + "&radius=" + radius
    				  + "&listYN=Y" 
    				  + "&_type=" + type;
    		  
    		  String result = makingResult(req);
    		  
    		  JsonObject convertedObj = gson.fromJson(result.toString(), JsonObject.class);
    		  JsonObject response = gson.fromJson(convertedObj.get("response").toString(), JsonObject.class);
    		  JsonObject body = gson.fromJson(response.get("body").toString(), JsonObject.class);
    		  JsonObject items = gson.fromJson(body.get("items").toString(), JsonObject.class);
    		  JsonArray item = items.get("item").getAsJsonArray();
    		  int totalCount = Integer.parseInt(body.get("totalCount").toString().replaceAll("\"", ""));
    		  
    		  System.out.println("결과 : " + result);
    		  System.out.println("몸 : " + body);
    		  System.out.println("총 개수 : " + totalCount);
    		  
    		  List<Attraction> attrList = new ArrayList<Attraction>();
    		  
    		  Attraction attr = null;
    		  
    		  for (int i = 0; i < item.size(); i++) { // {k:v,k:v..} 하나에 접근 (명소 하나 하나에 접근한다)
    			  
    			  JsonObject jobj = (JsonObject) item.get(i);
    			  
    			  attr = new Attraction();
    			  Set<String> itemKeys = jobj.keySet();

    			  for (String key : itemKeys) { // 모든 키에 접근을 해서
    				  attr = makingAttr(key, jobj, attr);
    			  }
    			  attrList.add(attr);
    		  }
    		  pg = new Pagination(cp,totalCount);
    		  model.addAttribute("pagination", pg);
    		  model.addAttribute("radius" , radius);
    		  model.addAttribute("attrList", attrList);
    		  
    		  return "attraction/attractionList";
    		   
    	  }
    	  else { // 2) 드롭다운
		      int contentType = Integer.parseInt(search.getContentType());
		      int areaCode = Integer.parseInt(search.getAreaCode());

		      String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList";
		      String serviceKey = "%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D";
		      String MobileApp = "WhereTheWeatherIs";
		      String type = "json";
		      String arrange = "P";
		      int numOfRows = 12;
		      // int pageNo = 1;

		      /*
		       * http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode
		       * ?serviceKey=%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%
		       * 2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D
		       * &numOfRows=12 &pageNo=1 &MobileOS=ETC &MobileApp=AppTest &areaCode=1
		       */

		      String req = url 
		    		  + "?ServiceKey=" + serviceKey 
		    		  + "&numOfRows=" + numOfRows 
		    		  + "&pageNo=" + cp 
		    		  + "&contentTypeId=" + contentType
		    		  + "&areaCode=" + areaCode 
		    		  + "&listYN=Y&MobileOS=ETC" 
		    		  + "&MobileApp=" + MobileApp 
		    		  + "&arrange=" + arrange
		    		  // + "&pageNo=" + pageNo
		    		  + "&_type=" + type;

		      String result = makingResult(req);

		      JsonObject convertedObj = gson.fromJson(result.toString(), JsonObject.class);
		      JsonObject response = gson.fromJson(convertedObj.get("response").toString(), JsonObject.class);
		      JsonObject body = gson.fromJson(response.get("body").toString(), JsonObject.class);
		      JsonObject items = gson.fromJson(body.get("items").toString(), JsonObject.class);
		      JsonArray item = items.get("item").getAsJsonArray();
		      int totalCount = Integer.parseInt(body.get("totalCount").toString().replaceAll("\"", ""));

		      List<Attraction> attrList = new ArrayList<Attraction>();

		      Attraction attr = null;

		      for (int i = 0; i < item.size(); i++) { // {k:v,k:v..} 하나에 접근 (명소 하나 하나에 접근한다)

		         JsonObject jobj = (JsonObject) item.get(i);

		         attr = new Attraction();
		         Set<String> itemKeys = jobj.keySet();
		         init();
		         for (String key : itemKeys) { // 모든 키에 접근을 해서

		            attr = makingAttr(key, jobj, attr);
		         }
		         attrList.add(attr);
		      }

		      pg = new Pagination(cp,totalCount);
		      model.addAttribute("pagination", pg);
		      model.addAttribute("attrList", attrList);
		      return "attraction/attractionList";
    	  }

      } else { // 3) 검색

         int attractionNo = 0;
         /*
          * http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchKeyword
          * ?serviceKey=%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%
          * 2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D
          * &MobileApp=AppTest &MobileOS=ETC &listYN=Y &arrange=A
          * &keyword=%EA%B0%95%EC%9B%90
          */
         
         String keyword = null;
         
         try {
            keyword = URLEncoder.encode(search.getKeyword(), "UTF-8");
         } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
         }

         String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchKeyword";
         String serviceKey = "%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D";
         String MobileApp = "WhereTheWeatherIs";
         String MobileOS = "ETC";
         String arrange = "O";
         // &keyword=keyword
         String type = "json";

         String req = url + "?ServiceKey=" + serviceKey + "&numOfRows=12" 
				  + "&pageNo=" + cp + "&MobileApp=" + MobileApp + "&MobileOS=" + MobileOS
               + "&listYN=Y" + "&arrange=" + arrange + "&keyword=" + keyword + "&_type=" + type;

         String result = makingResult(req);

         JsonObject convertedObj = gson.fromJson(result.toString(), JsonObject.class);
         JsonObject response = gson.fromJson(convertedObj.get("response").toString(), JsonObject.class);
         JsonObject body = gson.fromJson(response.get("body").toString(), JsonObject.class);
         JsonObject items = gson.fromJson(body.get("items").toString(), JsonObject.class);
         JsonArray item = items.get("item").getAsJsonArray();
         int totalCount = Integer.parseInt(body.get("totalCount").toString().replaceAll("\"", ""));

         List<Attraction> attrList = new ArrayList<Attraction>();

         Attraction attr = null;

         for (int i = 0; i < item.size(); i++) { // {k:v,k:v..} 하나에 접근 (명소 하나 하나에 접근한다)

            JsonObject jobj = (JsonObject) item.get(i);

            attr = new Attraction();
            Set<String> itemKeys = jobj.keySet();

            for (String key : itemKeys) {
               attr = makingAttr(key, jobj, attr);
            }
            attrList.add(attr);
         }

         pg = new Pagination(cp,totalCount);
         model.addAttribute("pagination", pg);
         model.addAttribute("attrList", attrList);
         return "attraction/attractionList";

      }

   }
   
   
   /***
       * 명소 목록 조회(준석)
       ***************************************************************************************************/
      @RequestMapping(value = "list", method = RequestMethod.POST)
      @ResponseBody
      public String attractionList(@RequestParam("areaCode") String paramAreaCode , @RequestParam("attrType") String paramAttrType) {

         //System.out.println("컨트롤러 첫줄에서 keyword가 있는지 확인 : " + keyword);
         System.out.println("넘어온 지역코드 : " + paramAttrType);
         Gson gson = new Gson();
         
         /* 준석
         http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList
         ?serviceKey=JJM5cLUSlymmHuS%2FvQxZDLCIejOz9ypIpBRrNY1RdktshpYCM1Fx2KvlmUG8qzp%2B2msPzwhNKLhOtP3NiHt13g%3D%3D
         &numOfRows=30
         &MobileApp=AppTest
         &MobileOS=ETC
         &arrange=B
         &contentTypeId=12
         &areaCode=1
         &listYN=Y
         */
         
         System.out.println("선택한 타입 :  " + paramAttrType);
         
         String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList";
         String serviceKey = "?serviceKey=JJM5cLUSlymmHuS%2FvQxZDLCIejOz9ypIpBRrNY1RdktshpYCM1Fx2KvlmUG8qzp%2B2msPzwhNKLhOtP3NiHt13g%3D%3D";
         int numOfRows = 30;
         String MobileApp = "AppTest";
         String MobileOS = "ETC";
         String arrange = "B"; // 조회수 순으로 조회
         int contentTypeId = Integer.parseInt(paramAttrType);
         int areaCode = Integer.parseInt(paramAreaCode);
         String listYN = "Y";
         String type = "json";

         int attractionNo = 0;
         
         switch(areaCode) {
            case 11: areaCode = 1; break; // 서울
            case 26: areaCode = 6; break; // 부산
            case 27: areaCode = 4; break; // 대구
            case 28: areaCode = 2; break; // 인천
            case 29: areaCode = 5; break; // 광주
            case 30: areaCode = 3; break; // 대전
            case 31: areaCode = 7; break; // 울산
            case 36: areaCode = 8; break; // 세종
            case 41: areaCode = 31; break; // 경기
            case 42: areaCode = 32; break; // 강원
            case 43: areaCode = 33; break; // 충북
            case 44: areaCode = 34; break; // 충남
            case 45: areaCode = 37; break; // 전북
            case 46: areaCode = 38; break; // 전남
            case 47: areaCode = 35; break; // 경북
            case 48: areaCode = 36; break; // 경남
            case 50: areaCode = 39; break; // 제주
         }

         String jsonFile = url + serviceKey + "&numOfRows=" + numOfRows + "&MobileApp=" + MobileApp
               + "&MobileOS=" + MobileOS + "&arrange=" + arrange + "&contentTypeId=" + contentTypeId + "&contentTypeId=" + contentTypeId
               + "&areaCode=" + areaCode + "&listYN=" + listYN +"&_type=" + type;
         
         System.out.println(jsonFile);
         
         return jsonFile;

      }


   /**** 상세 조회 ***************************************************************************************************/
   @RequestMapping(value = "view/{contentid}", method = RequestMethod.GET)
   // @ResponseBody
   public String attractionSelectView(@PathVariable("contentid") int attractionNo, Model model,
         @ModelAttribute Attraction attr) {

      String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon";
      String serviceKey = "%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D";
      String MobileOS = "ETC";
      String MobileApp = "WhereTheWeatherIs";
      String type = "json";
      /*
       * http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon
       * ?serviceKey=%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%
       * 2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D
       * &numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&contentId=126508&
       * defaultYN=Y
       * &firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=
       * Y
       */

      String req = url + "?ServiceKey=" + serviceKey + "&MobileOS=" + MobileOS + "&MobileApp=" + MobileApp
            + "&contentId=" + attractionNo
            + "&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y"
            + "&_type=" + type;

      String result = makingResult(req);
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
      System.out.println("아이템 확인 : " + item);

      // 변경된 JsonObject에서 값 추출
      // JsonObject.get("key") == (Object)value (Object타입의 밸류 -> 형변환이나 toString을 통해
      // 문자열로 변환하면됨)

      // 받아오지 못하는 경우가 있기 때문에 필드 기본값을 지정
      // attraction의 PK인 attractionNo은 파라미터로 받아옴

      Set<String> itemKeys = item.keySet(); // 키들을 set에 담기

      
      for (String key : itemKeys) {

         System.out.println(key + " : " + item.get(key)); // k : v 형태로 출력

         // key에따라 형변환하여 알맞은 변수에 대입
         attr = makingAttr(key, item, attr);
      }
      
      try {
		String attraction = new ObjectMapper().writeValueAsString(attr);
		model.addAttribute("attraction", attraction);

      } catch (JsonProcessingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
      }
      
      model.addAttribute("attr" , attr);

      //*********************************************상세조회한 명소 반경 5키로 미터의 다른 명소들 20개 -> 상세조회 지도에 뿌릴 것

	  String url2 = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/locationBasedList";
	  String serviceKey2 = "%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D";
	  String MobileOS2 = "ETC";
	  String MobileApp2 = "WhereTheWeatherIs";
	  String arrange2 = "E"; // 가까운 거리부터 정렬
	  double longitude = attr.getLatitude();
	  double latitude = attr.getLongitude();
	  int radius = 5000; // (거리반경, max 20000m)
	  String type2 = "json";
	  
	  String req2 = url2 + "?ServiceKey=" + serviceKey2 
			  + "&numOfRows=20" 
			  + "&MobileOS=" + MobileOS2 + "&MobileApp=" + MobileApp2
			  + "&arrange=" + arrange2 
			  + "&contentTypeId=12&14" 
			  + "&mapX=" + longitude 
			  + "&mapY=" + latitude 
			  + "&radius=" + radius
			  + "&listYN=Y" 
			  + "&_type=" + type;
	  
	  String result2 = makingResult(req2);
	  
	  JsonObject convertedObj2 = new Gson().fromJson(result2.toString(), JsonObject.class);
	  JsonObject response2 = new Gson().fromJson(convertedObj2.get("response").toString(), JsonObject.class);
	  JsonObject body2 = new Gson().fromJson(response2.get("body").toString(), JsonObject.class);
	  JsonObject items2 = new Gson().fromJson(body2.get("items").toString(), JsonObject.class);
	  JsonArray item2 = items2.get("item").getAsJsonArray();
	  int totalCount2 = Integer.parseInt(body.get("totalCount").toString().replaceAll("\"", ""));
	  
	  System.out.println("결과 : " + result2);
	  System.out.println("몸 : " + body2);
	  System.out.println("총 개수 : " + totalCount2);
	  
	  List<Attraction> attrList = new ArrayList<Attraction>();
	  
	  Attraction attr2 = null;
	  
	  for (int i = 0; i < item2.size(); i++) { // {k:v,k:v..} 하나에 접근 (명소 하나 하나에 접근한다)
		  
		  JsonObject jobj2 = (JsonObject) item2.get(i);
		  
		  attr2 = new Attraction();
		  Set<String> itemKeys2 = jobj2.keySet();

		  for (String key : itemKeys2) { // 모든 키에 접근을 해서
			  attr2 = makingAttr(key, jobj2, attr2);
		  }
		  attrList.add(attr2);
	  }
	  model.addAttribute("radius" , radius);
/*	  
      try {
    	  // 여기부분 수정 필요(위치기반 연습한거에 선생님이 해준것 있음)
		List attrList = new ObjectMapper().writeValueAsString(attrList);
		model.addAttribute("attrList", attrList);

      } catch (JsonProcessingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
      }
  */    
	  Gson gson = new GsonBuilder().create();
	  String json = gson.toJson(attrList);

	  System.out.println(attrList);

	  
	  model.addAttribute("attrList", attrList);
      
      //*********************************************
      
      
      
      
      
      
      return "attraction/attractionView";

   }

   /**** 상세 조회 : 메인(준석) *********************************************************************************************/
   @RequestMapping(value = "view/{selectedMarker}", method = RequestMethod.POST)
   @ResponseBody
   public String attractionSelectView(@PathVariable("selectedMarker") int attractionNo, @ModelAttribute Attraction attr) {
      
      
      String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon";
      String serviceKey = "%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D";
      String MobileOS = "ETC";
      String MobileApp = "WhereTheWeatherIs";
      String type = "json";
      /*
       * http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon
       * ?serviceKey=%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%
       * 2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D
       * &numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&contentId=126508&
       * defaultYN=Y
       * &firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=
       * Y
       * 

       */

      String req = url + "?ServiceKey=" + serviceKey + "&MobileOS=" + MobileOS + "&MobileApp=" + MobileApp
            + "&contentId=" + attractionNo
            + "&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y"
            + "&_type=" + type;

      String result = makingResult(req);
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
      System.out.println("아이템 확인 : " + item);

      // 변경된 JsonObject에서 값 추출
      // JsonObject.get("key") == (Object)value (Object타입의 밸류 -> 형변환이나 toString을 통해
      // 문자열로 변환하면됨)

      // 받아오지 못하는 경우가 있기 때문에 필드 기본값을 지정
      // attraction의 PK인 attractionNo은 파라미터로 받아옴
      
      // 명소별 평균점수
      double avgPoint = service.getAvgPoint(attractionNo);
      attr.setAvgPoint(avgPoint);
      
      // 명소별 총 리뷰 수
      int totalReviewCount = service.getReviewCount(attractionNo);
      attr.setTotalReviewCount(totalReviewCount);
      
      
      // 명소별 평균점수도 담기!!!!!!!!!!!
      Set<String> itemKeys = item.keySet(); // 키들을 set에 담기

      for (String key : itemKeys) {

         attr = makingAttr(key, item, attr);

      }
      
      ObjectMapper mapper = new ObjectMapper();
      String jsonString = null;
      try {
         jsonString = mapper.writeValueAsString(attr);

      } catch (Exception e) {
         e.printStackTrace();
      }
      
      

      System.out.println(jsonString);

      return jsonString;

   }
   
   
   
   
   
   
   
   /********************************************************************************************************************/
   /**** DB 입력할 1회용 Controller  **************************************************************************************/
   /********************************************************************************************************************/
   // 상세조회코드 가져옴
   @RequestMapping(value="insertToDB", method=RequestMethod.POST )
   public void insertToDB(@RequestParam("testDB") String inputMsg) {
      
      System.out.println("inputMsg : " + inputMsg);

      String req1 = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?serviceKey=%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D&pageNo=1&numOfRows=5000&MobileApp=AppTest&MobileOS=ETC&arrange=B&contentTypeId=12"
            + "&areaCode=8&listYN=Y&_type=json";
      
      String result = makingResult(req1);
      // 모든 관광지 정보가 result에 담김 -> 12는 지역별로 / 14는 전체 꺼내서 저장 (2021.08.09기준)

      JsonObject convertedObj = new Gson().fromJson(result.toString(), JsonObject.class);
      JsonObject response = new Gson().fromJson(convertedObj.get("response").toString(), JsonObject.class);
      JsonObject body = new Gson().fromJson(response.get("body").toString(), JsonObject.class);
      JsonObject items = new Gson().fromJson(body.get("items").toString(), JsonObject.class);
      
      JsonArray item = items.get("item").getAsJsonArray();
      
      int totalCount = Integer.parseInt(body.get("totalCount").toString().replaceAll("\"", ""));
      //System.out.println("전체 개수 : " + totalCount);
      int numOfRows = Integer.parseInt(body.get("numOfRows").toString().replaceAll("\"", ""));
      //System.out.println("numOfRows : " + numOfRows);
      

      List<Attraction> attrList = new ArrayList<Attraction>();

      Attraction attr = null;

      for (int i = 0; i < item.size(); i++) { // {k:v,k:v..} 하나에 접근 (명소 하나 하나에 접근한다)

         JsonObject jobj = (JsonObject) item.get(i);

         attr = new Attraction();
         Set<String> itemKeys = jobj.keySet();
         //init();
         attractionPhoto = null;
         
         for (String key : itemKeys) { // 모든 키에 접근을 해서

            attr = makingAttr(key, jobj, attr);
         }
         
         attrList.add(attr);
      }
      int successNo = service.insertAttrList(attrList);
      //System.out.println("successNo : " + successNo);
   }
   
   
   
   

   /********************************************************************************************************************/
   /**** Controller에서 사용하는 메소드 **************************************************************************************/
   /********************************************************************************************************************/
   
   // result만들기
   public String makingResult(String req) {

      String result = "";
      URL requestURL;
      try {
         requestURL = new URL(req);
         HttpURLConnection conn = (HttpURLConnection) requestURL.openConnection();
         conn.setRequestMethod("GET");
         BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8")); // 공공데이터에서 값을
                                                                                 // 요때 얻어옴
         String line = null;
         while ((line = br.readLine()) != null) {
            result += line;
         }

      } catch (Exception e) {
         e.printStackTrace();
      }
      return result;
   }

   // attraction 객체 만들기
   public Attraction makingAttr(String key, JsonObject jobj, Attraction attr) {

	  
	   
         switch(key) { 
          case "addr1" : attractionAddr =jobj.get(key).toString().replaceAll("\"", ""); break; 
          case "addr2" : addr2 = jobj.get(key).toString().replaceAll("\"", ""); break; 
          case "areacode" :areacode = Integer.parseInt(jobj.get(key).toString().replaceAll("\"",""));break; 
          case "booktour" : booktour = Integer.parseInt(jobj.get(key).toString().replaceAll("\"", ""));break; 
          case "cat1" : jobj.get(key).toString().replaceAll("\"", "");break; 
          case "cat2" : jobj.get(key).toString().replaceAll("\"", "");break; 
          case "cat3" : jobj.get(key).toString().replaceAll("\"", "");break; 
          case "contentid" : attractionNo = Integer.parseInt(jobj.get(key).toString().replaceAll("\"",""));break; 
          case "contenttypeid" : attractionTypeNo = Integer.parseInt(jobj.get(key).toString().replaceAll("\"", ""));break; 
          case "createdtime" : createdTime = Long.parseLong(jobj.get(key).toString().replaceAll("\"", ""));break; 
          case "firstimage" : attractionPhoto = jobj.get(key).toString().replaceAll("\"",""); break; 
          case "firstimage2" : attractionPhoto2 = jobj.get(key).toString().replaceAll("\"", ""); break; 
          case "homepage" : attractionHomePage = jobj.get(key).toString().replaceAll("\"", ""); break;
          case "mapx" : longitude = Double.parseDouble(jobj.get(key).toString().replaceAll("\"", "")); break;
          case "mapy" : latitude = Double.parseDouble(jobj.get(key).toString().replaceAll("\"", "")); break;
          case "mlevel" : mLevel = Integer.parseInt(jobj.get(key).toString().replaceAll("\"", ""));break; 
          case "modifiedtime" : modifiedTime = Long.parseLong(jobj.get(key).toString().replaceAll("\"", ""));break; 
          case "overview" : attractionInfo = jobj.get(key).toString().replaceAll("\"","");break; 
          case "sigungucode" : sigunguCode = Integer.parseInt(jobj.get(key).toString().replaceAll("\"", ""));break; 
          case "tel" : attractionPhone = jobj.get(key).toString().replaceAll("\"", "");break; 
          case "title" : attractionNm = jobj.get(key).toString().replaceAll("\"", "");break; 
          case "zipcode" : zipCode = jobj.get(key).toString().replaceAll("\"", "");break; 
          case "readcount" : readCount = Integer.parseInt(jobj.get(key).toString().replaceAll("\"", ""));break; 
          case "eventstartdate" : eventStartDate = Integer.parseInt(jobj.get(key).toString().replaceAll("\"", ""));break; 
          case "eventenddate" : eventEndDate = Integer.parseInt(jobj.get(key).toString().replaceAll("\"", ""));break; 
         }
      
      // switch가 끝나면 {k:v,k:v..} 에 저장된 key에 따라 value값이 vo변수에 저장
      attr.setAttractionAddr(attractionAddr);
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

      return attr;

   }
   
   public void init() {
	   
	   attractionAddr = null; // addr1
	   addr2 = null;
	   areacode = 0;
	   booktour = 0;
	   cat1 = null;
	   cat2 = null;
	   cat3 = null;
	   attractionTypeNo = 0; // contenttypeid
	   createdTime = 0;
	   attractionPhoto = null; // firstimage
	   attractionPhoto2 = null; // firstimage2
	   attractionHomePage = null; // homepage
	   latitude = 0; // mapx
	   longitude = 0; // mapy
	   mLevel = 0;
	   modifiedTime = 0;
	   attractionInfo = null; // overview
	   readCount = 0;
	   sigunguCode = 0;
	   attractionPhone = null; // tel
	   attractionNm = null; // title
	   zipCode = null;
	   eventStartDate = 0;
	   eventEndDate = 0;
	   attractionNo = 0;
	   
   }

}