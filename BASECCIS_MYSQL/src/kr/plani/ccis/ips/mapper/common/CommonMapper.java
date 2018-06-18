package kr.plani.ccis.ips.mapper.common;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("commonMapper")
public interface CommonMapper {
	
	/*
	 * 사이트명 받아오기
	 */
	public String getSiteName(Object obj);
	
	/*
	 * 그룹 목록 받아오기
	 */
	public List<?> listGroup(Object obj);
	
	/*
	 * 로그인
	 */
	public int getLoginIdCheck(Object obj);
	public Object getLogin(Object obj);
	
	/*
	 * 로그인
	 */
	public Object getSSOLogin(Object obj);
	

	/*
	 * 기업회원정보 가져오기
	 */
	public List<?> searchCompanyPop(Object obj);
	
	
	/*
	 * 기업회원정보 가져오기
	 */
	public List<?> searchMemberPop(Object obj);
	
	
	/*
	 * 개인정보 조회 로그 저장
	 */
	public void insertUserInfoLog(Object obj);
	
	
	/*
	 * 경영공시 담당자 조회
	 */
	public List<?> selectAutonomyPersonList(Object obj);
	
	public int insertChangeLog(Object obj);
	
	public void unifiedSearchLog(Object obj);
	
	/*
	 * 로그인아웃 로그 저장
	 */
	public void insertUserLogInOutLog(Object obj);
	
	/*
	 * 로그인 정보 조회
	 */
	public List<?> getLoginInfo(Object obj);
	
	/*
	 * 다른기기 로그인 체크
	 */
	public String getLoignCheck(Object obj);
	
	/*
	 * 테이블조회
	 */
	public List<?> selectTableList(Object obj);
	public List<?> selectTableDetailList(Object obj);
	
}
