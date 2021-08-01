package com.wtwi.fin.member.model.service;

import com.wtwi.fin.member.model.vo.Member;

public interface MemberService {

	/*public abstract */ Member login(Member inputMember);

	int idDupCheck(String id);

	int signUp(Member inputMember);

	int updateMember(Member inputMember);
	
	int changePwd(String currentPwd, String newPwd, Member loginMember);
	
	int secession(String currentPwd, Member loginMember);

	Member getSnsEmail(Member snsMember);

	Member snsSignup(Member snsMember);
}
