package com.wtwi.fin.attraction.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

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
		//int numOfRows = 10;
		//int pageNo = 1;
		
		String  req = url + 
					  "?ServiceKey=" + serviceKey +
					  "&contentTypeId=" + contentType +
					  "&areaCode=" + areaCode +
					  "&listYN=Y&MobileOS=ETC" +
					  "&MobileApp=" + MobileApp +
					  "&arrange=" + arrange +
					  //"&numOfRows" + numOfRows +
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
	
	
	@RequestMapping(value="view/{contentid}" , method=RequestMethod.GET)
	//@ResponseBody
	public String attractionSelectView(@PathVariable("contentid") int contentid, 
										Model model , 
										@ModelAttribute Attraction attraction) {
		
		System.out.println(contentid);
		
		
		String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon";
		String serviceKey = "%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D";
		String MobileOS = "ETC";
		String MobileApp = "WhereTheWeatherIs";
		String type = "json";
		
		/*
		 	http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon
		 	?serviceKey=%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D
		 	&numOfRows=10
		 	&pageNo=1
		 	&MobileOS=ETC
		 	&MobileApp=AppTest
		 	&contentId=126508
		 	&defaultYN=Y
		 	&firstImageYN=Y
		 	&areacodeYN=Y
		 	&catcodeYN=Y
		 	&addrinfoYN=Y
		 	&mapinfoYN=Y
		 	&overviewYN=Y
		*/
		String  req = url + 
				  "?ServiceKey=" + serviceKey +
				  "&MobileOS=" + MobileOS +
				  "&MobileApp=" + MobileApp +
				  "&contentId=" + contentid +
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
		
		// result에는 json 객체 담겨있음.
		
		
		// JSON 형태의 문자열을 JsonObject로 변경하여 값을 꺼내쓸 수 있는 형태로 변환
		JsonObject convertedObj = new Gson().fromJson(result.toString(), JsonObject.class);
		/// Json 형태의 데이터(message.getPayload())를 뒤에있는 Object 형태(JsonObject.class)로 변경해서 반환해주겠다
		
		JsonObject response = new Gson().fromJson(convertedObj.get("response").toString(), JsonObject.class); 
		JsonObject body = new Gson().fromJson(response.get("body").toString(), JsonObject.class); 
		JsonObject items = new Gson().fromJson(body.get("items").toString(), JsonObject.class); 
		JsonObject item = new Gson().fromJson(items.get("item").toString(), JsonObject.class); 
		
		System.out.println(response);
		System.out.println(body);
		System.out.println(items);
		System.out.println(item);
		
		Attraction attr = new Attraction();
		
		
		// 변경된 JsonObject에서 값 추출
		// JsonObject.get("key") == (Object)value (Object타입의 밸류 -> 형변환이나 toString을 통해 문자열로 변환하면됨)
		String addr1 = item.get("addr1").toString(); 
		addr1 = addr1.substring(1, addr1.length()-1);
		
		System.out.println(addr1);
		
		String addr2 = item.get("addr2").toString(); 
		addr2 = addr2.substring(1, addr2.length()-1);
		
		System.out.println(addr2);
		
		int areacode = Integer.parseInt(item.get("areacode").toString());
		
		System.out.println(areacode);
		
		int booktour = Integer.parseInt(item.get("booktour").toString()); 
		
		System.out.println(booktour);
		
		String cat1 = item.get("cat1").toString(); 
		cat1 = cat1.substring(1, cat1.length()-1);
		String cat2 = item.get("cat2").toString(); 
		cat2 = cat2.substring(1, cat2.length()-1);
		String cat3 = item.get("cat3").toString(); 
		cat3 = cat3.substring(1, cat3.length()-1);
		
		System.out.println(cat1);
		System.out.println(cat2);
		System.out.println(cat3);
		
		int contenttypeid = Integer.parseInt(item.get("contenttypeid").toString());
		
		System.out.println("contenttypeid : " + contenttypeid);
		
		long createdtime = Long.parseLong(item.get("createdtime").toString());
		
		System.out.println("createdtime : " + createdtime);
		
		String firstImage = item.get("firstimage").toString(); 
		firstImage = firstImage.substring(1, firstImage.length()-1);
		
		System.out.println(firstImage);
		String firstImage2 = item.get("firstimage2").toString(); 
		firstImage2 = firstImage2.substring(1, firstImage2.length()-1);
		System.out.println(firstImage2);
		
		String homepage = item.get("homepage").toString(); 
		homepage = homepage.substring(1, homepage.length()-1);
		
		System.out.println(homepage);

		double mapx = Double.parseDouble(item.get("mapx").toString()); 
		double mapy = Double.parseDouble(item.get("mapy").toString()); 
		int mlevel = Integer.parseInt(item.get("mlevel").toString());
		
		System.out.println(mapx);
		System.out.println(mapy);
		System.out.println(mlevel);
		
		long modifiedtime = Long.parseLong(item.get("modifiedtime").toString());
		
		System.out.println(modifiedtime);
		
		String overview = item.get("overview").toString(); 
		overview = overview.substring(1, overview.length()-1);
		
		System.out.println(overview);
		
		int sigungucode = Integer.parseInt(item.get("sigungucode").toString());
		
		System.out.println(sigungucode);
		
		String title = item.get("title").toString(); 
		title = title.substring(1, title.length()-1);
		
		System.out.println(title);
		
		int zipcode = Integer.parseInt(item.get("zipcode").toString());
		
		System.out.println(zipcode);
		
		
		
		
		attr.setAddr1(addr1);
		attr.setAddr2(addr2);
		attr.setAreacode(areacode);
		attr.setBooktour(booktour);
		attr.setCat1(cat1);
		attr.setCat2(cat2);
		attr.setCat3(cat3);
		attr.setContentid(contentid);
		attr.setContenttypeid(contenttypeid);	
		attr.setCreatedtime(createdtime);
		attr.setFirstImage(firstImage);
		attr.setFirstImage2(firstImage2);
		attr.setHomepage(homepage);
		attr.setMapx(mapx);
		attr.setMapy(mapy);
		attr.setMlevel(mlevel);
		attr.setModifiedtime(modifiedtime);
		attr.setOverview(overview);
		attr.setSigungucode(sigungucode);
		attr.setTitle(title);
		attr.setZipcode(zipcode);
		
		
		System.out.println("attr 투스트링이다 !" + attr);
		
				
		
		model.addAttribute("attraction",result);
		return "attraction/attractionView";
		
	}
	
	
	
	
	
	
	
	
	
	

}
