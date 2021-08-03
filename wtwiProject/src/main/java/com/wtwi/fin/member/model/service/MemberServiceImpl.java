package com.wtwi.fin.member.model.service;

import org.apache.maven.shared.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wtwi.fin.member.model.dao.MemberDAO;
import com.wtwi.fin.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	@Autowired
	private MemberDAO dao;

	@Override
	public Member login(Member inputMember) {

		Member loginMember = dao.login(inputMember.getMemberId());

		if (loginMember != null) {

			if (!bCryptPasswordEncoder.matches(inputMember.getMemberPw(), loginMember.getMemberPw())) {

				loginMember = null;

			} else {
 
				loginMember.setMemberPw(null);

			}
		}

		return loginMember;
	}

	// 아이디 중복체크 Service
	@Override
	public int idDupCheck(String id) {
		return dao.idDupCheck(id);
	}

	// 회원가입 Service
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int signUp(Member inputMember) {
		String encPwd = bCryptPasswordEncoder.encode(inputMember.getMemberPw());


		inputMember.setMemberPw(encPwd);


		return dao.signUp(inputMember);
	}

	// 내 정보 수정 Service
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateMember(Member inputMember) {
		return dao.updateMember(inputMember);
	}

	// 비밀번호 수정 Service
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int changePwd(String currentPwd, String newPwd, Member loginMember) {

		String savePwd = dao.selectPassword(loginMember.getMemberNo());

		int result = 0;

		if (bCryptPasswordEncoder.matches(currentPwd, savePwd)) {

			String encPwd = bCryptPasswordEncoder.encode(newPwd);

			loginMember.setMemberPw(encPwd);

			result = dao.changePassword(loginMember);

			loginMember.setMemberPw(null);
		}

		return result;
	}

	// 회원탈퇴 Service
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int secession(String currentPwd, Member loginMember) {

		String savePwd = dao.selectPassword(loginMember.getMemberNo());

		int result = 0;

		if (bCryptPasswordEncoder.matches(currentPwd, savePwd)) {

			result = dao.secession(loginMember);

		}
		return result;
	}
	
	// 소셜 로그인 회원 분류 
	@Override
	public Member getSnsEmail(Member snsMember) {
		
		return dao.getSnsEmail(snsMember);
	}
	
	// 소셜 회원 회원가입 및 로그인
	@Transactional(rollbackFor = Exception.class)
	@Override
	public Member snsSignup(Member snsMember) {
		
		String encPwd = bCryptPasswordEncoder.encode(snsMember.getMemberPw());
		snsMember.setMemberPw(encPwd);
		int result = dao.snsSignup(snsMember);
		
		Member member = null;
		
		if(result > 0) {
			member = dao.getSnsEmail(snsMember);
		}
		return member;
	}
	
	// coolSMS 핸드폰 번호 중복 검사
	@Override
	public int selectPhone(String memberPhone) {
		// TODO Auto-generated method stub
		return dao.selectPhone(memberPhone);
	}
	
	

}
