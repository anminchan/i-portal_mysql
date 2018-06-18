package kr.plani.ccis.ips.mapper.site;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("contentMgrMapper")
public interface ContentMgrMapper {
	
	/* 정적 콘텐츠 */
	public Object viewContent(Object obj);
	public Object actContent(Object obj);
	public List<?> listHistory(Object obj);
	
	/* 통합게시판 */
	public int listBoardCnt(Object obj);
	public List<?> listBoard(Object obj);
	public List<?> listBoardFiles(Object obj);
	public List<?> listBoardFrevNext(Object obj);
	public List<?> listBoardAppealUser(Object obj);
	public Object viewBoard(Object obj);
	public Object viewBoardAnswer(Object obj);
	
	public void insertTitle(Object obj);
	public void insertContents(Object obj);
	public void insertHistory(Object obj);
	public void insertLink(Object obj);
	public void insertAppealLink(Object obj);
	public void insertAppealLinkUser(Object obj);
	public void insertFiles(Object obj);
	public void insertGuestInfo(Object obj);
	public void insertAppealUser(Object obj);
	
	public void updateTitle(Object obj);
	public void updateBoardHitCount(Object obj);
	public void updateContents(Object obj);
	public void updateLink(Object obj);
	public void updateProcess(Object obj);
	public void updateCompleteProcess(Object obj);

	public void deleteResetLink(Object obj);
	public void deleteResetTitle(Object obj);
	public void deleteResetContents(Object obj);
	public void deleteLink(Object obj);
	public void deleteTitle(Object obj);
	public void deleteContents(Object obj);
	public void deleteFiles(Object obj);
	public void deleteAllFiles(Object obj);
	public void deleteAllAppealUser(Object obj);
	
	/*자유형 게시판*/
	public Object listFreeBoard(Object obj);
	public Object viewFreeBoard(Object obj);
	public Object actFreeBoard(Object obj);

	/*공지형 게시판*/
	public Object listNoticeBoard(Object obj);
	public Object viewNoticeBoard(Object obj);
	public Object actNoticeBoard(Object obj);
	
	/*썸네일형 게시판*/
	public Object listThumbnailBoard(Object obj);
	public Object viewThumbnailBoard(Object obj);
	public Object actThumbnailBoard(Object obj);
	
	/*링크형 게시판*/
	public Object listLinkBoard(Object obj);
	public Object viewLinkBoard(Object obj);
	public Object actLinkBoard(Object obj);

	/*클리핑형 게시판*/
	public Object listClippingBoard(Object obj);
	public Object viewClippingBoard(Object obj);
	public Object actClippingBoard(Object obj);

	/*동영상형 게시판*/
	public Object listVodBoard(Object obj);
	public Object viewVodBoard(Object obj);
	public Object actVodBoard(Object obj);

	/*민원형 게시판*/
	public Object listAppealBoard(Object obj);
	public Object listAppealBoardSend(Object obj);
	public Object viewAppealBoard(Object obj);
	public Object actAppealBoard(Object obj);
	public Object actAppealUserBoard(Object obj);
	public Object actReplyBoard(Object obj);
	
	/*My민원형 게시판*/
	public Object listMyAppealBoard(Object obj);
	
	/*My관리자답변형 게시판*/
	public Object listMyReplyBoard(Object obj);

	/*카드형 게시판*/
	public Object listCardBoard(Object obj);
	public Object viewCardBoard(Object obj);
	public Object actCardBoard(Object obj);
	
	/*권한 조회*/
	public Object listRole(Object obj);

	/*댓글*/
	public Object listReply(Object obj);
	public Object viewReplyBoard(Object obj);
	public Object actReply(Object obj);

	public Object update(Object obj);
	public Object delete(Object obj);
	
	public List<?> ListContentsLink(Object obj);
	public Object actListContentLink(Object obj);
	public Object actListBoardLink(Object obj);
	public Object chkTransYn(Object obj);
	public void actBbsTrans(Object obj);
	public void actBbsLinkTrans(Object obj);
	public int getTransTargetCnt(Object obj);
	public int getTransCnt(Object obj);
	public List<?> getTransTargetList(Object obj);
	public void insetTransLink(Object obj);
	
	public List<?> selectKeywordSearchList(Object obj);
	
	/*CMS 메인 답변글 Count*/
	public List<?> selectAnswerCountList(Object obj);
	
}
