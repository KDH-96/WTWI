package com.wtwi.fin.member.controller;

import java.security.PrivateKey;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.maven.shared.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wtwi.fin.auth.SNSLogin;
import com.wtwi.fin.auth.SnsValue;
import com.wtwi.fin.member.model.service.MemberService;
import com.wtwi.fin.member.model.service.MemberServiceImpl;
import com.wtwi.fin.member.model.vo.Member;
import com.wtwi.fin.member.model.vo.RSA;
import com.wtwi.fin.member.model.vo.RSAUtil;

@Controller
@RequestMapping(value = "/member/*", method = RequestMethod.GET)
@SessionAttributes({ "loginMember" })
public class MemberController {
 
	@Autowired
	private MemberService service;

	@Autowired
	private RSAUtil rsaUtil;
  
	@Inject
	private SnsValue naverSns;
	@Inject
	private SnsValue googleSns;
	@Inject
	private GoogleConnectionFactory googleConnectionFactory;
	@Inject
	private OAuth2Parameters googleOAuth2Parameters;
	
	
	@RequestMapping(value="auth/{snsService}/callback", method=RequestMethod.GET) 
	public String snsLoginCallback(@PathVariable("snsService") String snsService, Model model, @RequestParam("code") String code/*access Token 발급을 위한 code가 들어옴*/, RedirectAttributes ra) throws Exception{
		
		// 1) code를 이용해서 access_token 받기 
		// 2) access_token을 이용해서 사용자 profile 정보 가져오기
		SnsValue sns = null;
		if(StringUtils.equals("naver", snsService)) sns = naverSns;
		else sns = googleSns;
		
		SNSLogin snsLogin = new SNSLogin(sns);
		Member snsMember = snsLogin.getUserProfile(code);
		model.addAttribute("result", snsMember);
	
		// 3) DB에 해당 유저가 존재하는지 Check
		Member member = null;
		member = service.getSnsEmail(snsMember);
		// 4) 존재 시 강제 로그인, 미 존재시 가입페이지로!!
		if(member == null) { // 존재X -> 회원가입 
			member = service.snsSignup(snsMember);
			if(member != null) { // 회원가입 성공
				swalSetMessage(ra, "success", "환영합니다 :)", null);
				model.addAttribute("loginMember", member);
			} else { // 회원가입 실패
				swalSetMessage(ra, "error", "회원가입 실패", "문제가 지속될 경우, 대표전화로 문의해주세요.");	
				
			}
		} else { // 존재O -> 로그인
			model.addAttribute("loginMember", member);
		}
		
		return "redirect:/";
	}

	@RequestMapping("signUpActive")
	public String signUp() {

		return "member/signUp";

	}

	@RequestMapping(value = "signUp", method = RequestMethod.POST)
	public String signUp(@ModelAttribute Member inputMember, RedirectAttributes ra) {
		int result = service.signUp(inputMember);
		if (result > 0) {
			swalSetMessage(ra, "success", "회원가입 성공!", "로그인 후 사이트를 이용해주세요 :)");
		} else {
			swalSetMessage(ra, "error", "회원가입 실패", "문제가 지속될 경우, 대표전화로 문의해주세요.");
		}
		return "redirect:/";

	}

	@ResponseBody
	@RequestMapping(value = "idDupCheck", method = RequestMethod.POST)
	public int idDupCheck(@RequestParam("id") String id, RedirectAttributes ra) {

		int result = service.idDupCheck(id);

		return result;
	}

	// 로그인 페이지 진입
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String loginForm(HttpSession session, Model model) {
		
		///////////////////////////// RSA 개인키 발급 //////////////////////////////////
		PrivateKey key = (PrivateKey) session.getAttribute("RSAprivateKey");
		if (key != null) { 
			session.removeAttribute("RSAprivateKey");
		}
		RSA rsa = rsaUtil.createRSA();
		model.addAttribute("modulus", rsa.getModulus());
		model.addAttribute("exponent", rsa.getExponent());
		session.setAttribute("RSAprivateKey", rsa.getPrivateKey());

		///////////////////////////// 소셜 로그인//////////////////////////////////
		// 1) Naver
		SNSLogin snsLogin = new SNSLogin(naverSns);
		model.addAttribute("naver_url", snsLogin.getNaverAuthURL());

		// 2) Google
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		model.addAttribute("google_url", url);

		return "member/login";
	}

	@RequestMapping(value = "loginAction", method = RequestMethod.POST)
	public String login(Member member, HttpSession session, RedirectAttributes ra, Model model,
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "save", required = false) String save) {

		// 1) session에 올려져있는 개인키가 있나 찾아보고 key 변수에 저장
		PrivateKey key = (PrivateKey) session.getAttribute("RSAprivateKey");

		// 2) 없으면 요청 파기하고 다시 메인으로
		if (key == null) {
			swalSetMessage(ra, "error", "로그인 실패", "문제가 지속될 경우, 대표번호로 문의바랍니다.");
			return "redirect:/";
		}

		// 3) 있다면 안전하게 로그인 정보가 도착했으니 session에서는 내리기
		session.removeAttribute("RSAprivateKey");

		// 4) 암호화되어서 도착한 아이디/비밀번호를 개인키를 이용해 복호화
		try {
			String memberId = rsaUtil.getDecryptText(key, member.getMemberId());
			String memberPw = rsaUtil.getDecryptText(key, member.getMemberPw());

			// 복호화된 정보를 로그인을 위해 다시 member 객체에 set
			member.setMemberId(memberId);
			member.setMemberPw(memberPw);
		} catch (Exception e) {
			e.printStackTrace();
			swalSetMessage(ra, "error", "로그인 실패", "문제가 지속될 경우, 대표번호로 문의바랍니다.");
			return "redirect:/";
		}

		// 로그인 로직 실행
		Member loginMember = service.login(member);

		if (loginMember != null) {
			model.addAttribute("loginMember", loginMember);
			Cookie cookie = new Cookie("saveId", loginMember.getMemberId());

			if (save != null) {
				cookie.setMaxAge(60 * 60 * 24 * 30);
			} else {
				cookie.setMaxAge(0);
			}

			cookie.setPath(request.getContextPath());
			response.addCookie(cookie);

		} else {
			ra.addFlashAttribute("icon", "error");
			ra.addFlashAttribute("title", "로그인 실패");
			ra.addFlashAttribute("text", "아이디 또는 비밀번호가 일치하지 않습니다.");
		}

		return "redirect:/";

	}

	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout(SessionStatus status, @RequestHeader("referer") String referer) {

		status.setComplete();

		return "redirect:" + referer;
	}

	@RequestMapping(value = "myPage", method = RequestMethod.GET)
	public String myPage() {
		return "member/myPage";
	}

	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(@ModelAttribute("loginMember") Member loginMember, Member inputMember, String inputEmail,
			String inputPhone, String inputAddress, RedirectAttributes ra) {

		inputMember.setMemberNo(loginMember.getMemberNo());
		inputMember.setMemberEmail(inputEmail);
		inputMember.setMemberPhone(inputPhone);
		inputMember.setMemberAddress(inputAddress);

		int result = service.updateMember(inputMember);

		if (result > 0) {
			swalSetMessage(ra, "success", "내 정보 수정 성공!", null);
		} else {
			swalSetMessage(ra, "error", "내 정보 수정 실패", null);
		}
		return "redirect:/member/myPage";
	}

	public static void swalSetMessage(RedirectAttributes ra, String icon, String title, String text) {
		ra.addFlashAttribute("icon", icon);
		ra.addFlashAttribute("title", title);
		ra.addFlashAttribute("text", text);
	}

	@RequestMapping(value = "updateAction", method = RequestMethod.POST)
	public String update(@ModelAttribute("loginMember") Member loginMember,
			@RequestParam("inputEmail") String inputEmail, String inputPhone, String inputAddress, Member inputMember,
			RedirectAttributes ra) {

		inputMember.setMemberNo(loginMember.getMemberNo());
		inputMember.setMemberEmail(inputEmail);
		inputMember.setMemberPhone(inputPhone);
		inputMember.setMemberAddress(inputAddress);

		int result = service.updateMember(inputMember);

		if (result > 0) {
			swalSetMessage(ra, "success", "회원정보 수정 성공", null);

			loginMember.setMemberEmail(inputEmail);
			loginMember.setMemberPhone(inputPhone);
			loginMember.setMemberAddress(inputAddress);
		} else {
			swalSetMessage(ra, "error", "회원정보 수정 실패", null);
		}

		return "redirect:/member/myPage";
	}

	@RequestMapping(value = "changePwd", method = RequestMethod.GET)
	public String changPwd() {
		return "member/changePwd";
	}

	@RequestMapping(value = "changePwdAction", method = RequestMethod.POST)
	public String changePwd(@ModelAttribute("loginMember") Member loginMember, String currentPwd,
			@RequestParam("newPwd1") String newPwd, RedirectAttributes ra) {

		int result = service.changePwd(currentPwd, newPwd, loginMember);
		String path = "redirect:";
		if (result > 0) {
			swalSetMessage(ra, "success", "비밀번호 수정 성공", null);
			path += "myPage";
		} else {
			swalSetMessage(ra, "error", "비밀번호 수정 실패", null);
			path += "changePwd";
		}

		return path;
	}

	@RequestMapping(value = "secession", method = RequestMethod.GET)
	public String secession() {
		return "member/secession";
	}

	@RequestMapping(value = "secessionAction", method = RequestMethod.POST)
	public String secession(@ModelAttribute("loginMember") Member loginMember,
			@RequestParam("currentPwd") String currentPwd, RedirectAttributes ra, SessionStatus status) {

		int result = service.secession(currentPwd, loginMember);

		String path = "redirect:";
		if (result > 0) {
			swalSetMessage(ra, "success", "회원탈퇴가 완료되었습니다.", null);
			status.setComplete();
			path += "/";
		} else {
			swalSetMessage(ra, "error", "회원탈퇴를 실패하였습니다.", null);
			path += "myPage";
		}
		return path;
	}

}