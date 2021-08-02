package com.wtwi.fin.member.model.dao;

import org.apache.maven.shared.utils.StringUtils;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wtwi.fin.member.model.vo.Member;

@Repository
public class MemberDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	/**
	 * 로그인 DAO
	 * 
	 * @param memberId
	 * @return loginMember
	 */
	public Member login(String memberId) {

		return sqlSession.selectOne("memberMapper.login", memberId);

	} 

	/**
	 * 아이디 중복체크 DAO
	 * 
	 * @param id
	 * @return
	 */
	public int idDupCheck(String id) {
		return sqlSession.selectOne("memberMapper.idDupCheck", id);
	}

	/**
	 * 회원가입 DAO
	 * 
	 * @param inputMember
	 * @return
	 */
	public int signUp(Member inputMember) {
		return sqlSession.insert("memberMapper.signUp", inputMember);
	}

	/**
	 * 내 정보수정 DAO
	 * 
	 * @param inputMember
	 * @return
	 */
	public int updateMember(Member inputMember) {
		return sqlSession.update("memberMapper.updateMember", inputMember);
	}

	/**
	 * 비밀번호 조회 DAO
	 * 
	 * @param memberNo
	 * @return savePwd
	 */
	public String selectPassword(int memberNo) {

		return sqlSession.selectOne("memberMapper.selectPassword", memberNo);
	}

	/**
	 * 비밀번호 수정 DAO
	 * 
	 * @param loginMember
	 * @return
	 */
	public int changePassword(Member loginMember) {

		return sqlSession.update("memberMapper.changePwd", loginMember);
	}

	/**
	 * 회원탈퇴 DAO
	 * 
	 * @param loginMember
	 * @return
	 */
	public int secession(Member loginMember) {
		return sqlSession.update("memberMapper.secession", loginMember);
	}

	/** 소셜 로그인 회원 분류 
	 * @param snsMember
	 * @return
	 */
	public Member getSnsEmail(Member snsMember) {
		Member member = sqlSession.selectOne("memberMapper.getSnsEmail", snsMember);
		return member;
			
	}

	/**
	 * 소셜 회원가입
	 * 
	 * @param snsMember
	 * @return
	 */
	public int snsSignup(Member snsMember) {
		return sqlSession.insert("memberMapper.snsSignUp", snsMember);

	}

}
