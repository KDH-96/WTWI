package com.wtwi.fin.attraction.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Base64.Encoder;
import java.util.List;
import java.util.Map;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.java8.Base64;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.wtwi.fin.attraction.model.vo.Attraction;
import com.wtwi.fin.attraction.model.vo.Pagination;

@Controller
@RequestMapping("/attraction/*")
public class AttractionController {

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
	int attractionNo = 0;

	/***
	 * 명소 목록 조회
	 ***************************************************************************************************/
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String attractionList(String keyword, Model model, Pagination pg) {

		System.out.println("컨트롤러 첫줄에서 keyword가 있는지 확인 : " + keyword);

		Gson gson = new Gson();

		if (keyword == null) { // 검색 하지 않았을 때
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

			String req = url + "?ServiceKey=" + serviceKey + "&MobileOS=" + MobileOS + "&MobileApp=" + MobileApp
					+ "&arrange=" + arrange + "&mapX=" + longitude + "&mapY=" + latitude + "&radius=" + radius
					+ "&listYN=Y" + "&_type=" + type;

			// 만들어진 req를 가지고 api에서 결과 가져오기
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

			// for (JsonElement obj : item) { // {k:v,k:v..} 하나에 접근 (명소 하나 하나에 접근한다)
			for (int i = 0; i < item.size(); i++) { // {k:v,k:v..} 하나에 접근 (명소 하나 하나에 접근한다)
				// item에는 {k:v,k:v..}{k:v,k:v..}{k:v,k:v..}{k:v,k:v..}.. 이렇게 담겨 있고
				// {k:v,k:v..} 이거는 하나의 JsonElement

				JsonObject jobj = (JsonObject) item.get(i);
				// JsonElement 타입을 JsonObject 타입의 jobj에 담음.
				// jobj에 담긴 것 : {k:v,k:v..} 즉, 명소 한 개의 형태.

				attr = new Attraction();
				Set<String> itemKeys = jobj.keySet();
				// 명소 1개에 있는 모든 key들을 itemKeys에 저장
				for (String key : itemKeys) { // 모든 키에 접근을 해서

					// key에따라 형변환하여 알맞은 변수에 대입
					attr = makingAttr(key, jobj, attr);
				}
				// 여기까지 하면 attr 객체 하나 완성 == 명소 하나 완성
				// System.out.println("attrList" + attrList);
				attrList.add(attr);
			}
			model.addAttribute("attrList", attrList);

			return "attraction/attractionList";

		} else { // 검색 했을 때

			int attractionNo = 0;
			int cp = 1;
			/*
			 * http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchKeyword
			 * ?serviceKey=%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%
			 * 2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D
			 * &MobileApp=AppTest &MobileOS=ETC &listYN=Y &arrange=A
			 * &keyword=%EA%B0%95%EC%9B%90
			 */
			System.out.println(keyword);

			// 한글 인코딩
//         try {
//			keyword = new String(keyword.getBytes("keyword"),"utf-8");
//		} catch (UnsupportedEncodingException e1) {
//			e1.printStackTrace();
//		}

			String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchKeyword";
			String serviceKey = "%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D";
			String MobileApp = "WhereTheWeatherIs";
			String MobileOS = "ETC";
			String arrange = "A";
			// &keyword=keyword
			String type = "json";

			String req = url + "?ServiceKey=" + serviceKey + "&MobileApp=" + MobileApp + "&MobileOS=" + MobileOS
					+ "&listYN=Y" + "&arrange=" + arrange + "&keyword=" + keyword + "&_type=" + type;

			// 만들어진 req를 가지고 api에서 결과 가져오기
			String result = makingResult(req);

			JsonObject convertedObj = gson.fromJson(result.toString(), JsonObject.class);
			JsonObject response = gson.fromJson(convertedObj.get("response").toString(), JsonObject.class);
			JsonObject body = gson.fromJson(response.get("body").toString(), JsonObject.class);
			JsonObject items = gson.fromJson(body.get("items").toString(), JsonObject.class);
			JsonArray item = items.get("item").getAsJsonArray();

			List<Attraction> attrList = new ArrayList<Attraction>();

			Attraction attr = null;

//         for (JsonElement obj : item) { // {k:v,k:v..} 하나에 접근 (명소 하나 하나에 접근한다)
			for (int i = 0; i < item.size(); i++) { // {k:v,k:v..} 하나에 접근 (명소 하나 하나에 접근한다)
				// item에는 {k:v,k:v..}{k:v,k:v..}{k:v,k:v..}{k:v,k:v..}.. 이렇게 담겨 있고
				// {k:v,k:v..} 이거는 하나의 JsonElement

				JsonObject jobj = (JsonObject) item.get(i);
				// JsonElement 타입을 JsonObject 타입의 jobj에 담음.
				// jobj에 담긴 것 : {k:v,k:v..} 즉, 명소 한 개의 형태.

				attr = new Attraction();
				Set<String> itemKeys = jobj.keySet();
				// 명소 1개에 있는 모든 key들을 itemKeys에 저장
				for (String key : itemKeys) { // 모든 키에 접근을 해서

					// key에따라 형변환하여 알맞은 변수에 대입
					attr = makingAttr(key, jobj, attr);
				}
				// 여기까지 하면 attr 객체 하나 완성 == 명소 하나 완성
				// System.out.println("attrList" + attrList);
				attrList.add(attr);
			}
			model.addAttribute("attrList", attrList);

			return "attraction/attractionList";

		}

	}

	/***
	 * 드롭 박스 이용
	 ***************************************************************************************************/
	@RequestMapping("find/area")
	@ResponseBody
	public String attractionListView(String contentTypeS, int areaCode) {

		int contentType = Integer.parseInt(contentTypeS);

		String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList";
		String serviceKey = "%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D";
		String MobileApp = "WhereTheWeatherIs";
		String type = "json";
		String arrange = "B";
		int numOfRows = 12;
		// int pageNo = 1;

		/*
		 * http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode
		 * ?serviceKey=%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%
		 * 2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D
		 * &numOfRows=12 &pageNo=1 &MobileOS=ETC &MobileApp=AppTest &areaCode=1
		 * 
		 */

		String req = url + "?ServiceKey=" + serviceKey + "&numOfRows=" + numOfRows + "&contentTypeId=" + contentType
				+ "&areaCode=" + areaCode + "&listYN=Y&MobileOS=ETC" + "&MobileApp=" + MobileApp + "&arrange=" + arrange
				+
				// "&pageNo=" + pageNo +
				"&_type=" + type;

		String result = makingResult(req);

		JsonObject convertedObj = new Gson().fromJson(result.toString(), JsonObject.class);
		JsonObject response = new Gson().fromJson(convertedObj.get("response").toString(), JsonObject.class);
		JsonObject body = new Gson().fromJson(response.get("body").toString(), JsonObject.class);
		JsonObject items = new Gson().fromJson(body.get("items").toString(), JsonObject.class);
		JsonArray item = items.get("item").getAsJsonArray();

		System.out.println("몇개 : " + item.size());

		return result;
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

		model.addAttribute("attr", attr);
		return "attraction/attractionView";

	}

	/**** 상세 조회 : 메인(준석) *********************************************************************************************/
	@RequestMapping(value = "view/{contentid}", method = RequestMethod.POST)
	@ResponseBody
	public String attractionSelectView(@PathVariable("contentid") int attractionNo, @ModelAttribute Attraction attr) {

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
	/**** Controller에서 사용하는 메소드 **************************************************************************************/
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
	       case "zipcode" : zipCode = Integer.parseInt(jobj.get(key).toString().replaceAll("\"", ""));break; 
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

}