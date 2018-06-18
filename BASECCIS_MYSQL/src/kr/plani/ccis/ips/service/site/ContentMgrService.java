package kr.plani.ccis.ips.service.site;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.DefaultDomain;
import kr.plani.ccis.ips.domain.site.Content;
import kr.plani.ccis.ips.domain.site.ContentSet;
import kr.plani.ccis.ips.domain.site.Files;
import kr.plani.ccis.ips.domain.site.GuestInfo;
import kr.plani.ccis.ips.domain.site.Link;
import kr.plani.ccis.ips.domain.site.Reply;
import kr.plani.ccis.ips.domain.site.Title;
import kr.plani.ccis.ips.mapper.site.ContentMgrMapper;
import kr.plani.ccis.ips.mapper.site.ContentSetMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("contentsMgrService")
public class ContentMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private ContentMgrMapper contentMgrMapper;
	
	@Resource
	private ContentSetMgrMapper contentSetMapper;

	/*****************************************************************
	* getObjectList 콘텐츠트리 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public List<?> getObjectList(Object obj) throws Exception
	{
		Content inObj = (Content)obj;
		return contentSetMapper.list(inObj);
	}	
	@Override
	public Object getObject(Object obj) throws Exception {
		return null;
	}

	@Override
	public Object insertObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object updateObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object deleteObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	/************************************************************
	 * getBoardList 게시판 리스트 갯수
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public int getBoardListCnt(Object obj) throws Exception {
		Title inObj = (Title)obj;
		return contentMgrMapper.listBoardCnt(inObj);
	}
	
	/************************************************************
	 * getBoardList 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public List<?> getBoardList(Object obj) throws Exception {
		Title inObj = (Title)obj;
		
		return contentMgrMapper.listBoard(inObj);
	}
	
	/************************************************************
	 * getBoardList 게시판 상세보기
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getBoardView(Object obj) throws Exception {
		Title inObj = (Title)obj;
		
		return contentMgrMapper.viewBoard(inObj);
	}
	
	/************************************************************
	 * getBoardFiles 게시판 파일 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public List<?> getBoardFiles(Object obj) throws Exception {
		Title inObj = (Title)obj;
		
		return contentMgrMapper.listBoardFiles(inObj);
	}
	
	/************************************************************
	 * getBoardFrevNext 게시판 이전이후게시글 조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public List<?> getBoardFrevNext(Object obj) throws Exception {
		Title inObj = (Title)obj;
		
		return contentMgrMapper.listBoardFrevNext(inObj);
	}
	
	/************************************************************
	 * getBoardViewAnswer 게시판 민원형상세보기
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getBoardViewAnswer(Object obj) throws Exception {
		Title inObj = (Title)obj;
		
		return contentMgrMapper.viewBoardAnswer(inObj);
	}
	
	/************************************************************
	 * getBoardAppealUser 게시판 민원형답변자 조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public List<?> getBoardAppealUser(Object obj) throws Exception {
		Title inObj = (Title)obj;
		
		return contentMgrMapper.listBoardAppealUser(inObj);
	}
	
	@Transactional
	public Object actBoard(Object obj, Object objFile, Object objGuestInfo) throws Exception {
		Content inObj = (Content)obj;
		Files inFileObj = (Files)objFile;
		GuestInfo inGuestInfoObj = (GuestInfo)objGuestInfo;
		
		try{
			if(inObj.getInCondition().equals("입력")){
				contentMgrMapper.insertTitle(inObj);
				contentMgrMapper.insertContents(inObj);
				contentMgrMapper.insertLink(inObj);
				
				if(objFile != null){
					if(Integer.parseInt(inFileObj.getFileCount()) > 0){
						Files fileObj = new Files();
						for(int i=0; i<Integer.parseInt(inFileObj.getFileCount()); i++){
							fileObj.setFileId(Integer.toString(i+1));
							fileObj.setTitleId(Integer.toString(inObj.getTitleId()));
							fileObj.setUserFileName(inFileObj.getUserFileName().split("#")[i]);
							fileObj.setSystemFileName(inFileObj.getSystemFileName().split("#")[i]);
							fileObj.setFilePath(inFileObj.getFilePath().split("#")[i]);
							fileObj.setFileExtension(inFileObj.getFileExtension().split("#")[i]);
							fileObj.setFileSize(inFileObj.getFileSize().split("#")[i]);
							fileObj.setInDMLUserId(inObj.getInDMLUserId());
							fileObj.setInDMLIp(inObj.getInDMLIp());
							
							contentMgrMapper.insertFiles(fileObj);
						}
					}
				}
				
				if(inGuestInfoObj.getGuestName() != null && inGuestInfoObj.getGuestName() != "-"){
					inGuestInfoObj.setTitleId(Integer.toString(inObj.getTitleId()));
					inGuestInfoObj.setInDMLUserId(inObj.getInDMLUserId());
					inGuestInfoObj.setInDMLIp(inObj.getInDMLIp());
					contentMgrMapper.insertGuestInfo(inGuestInfoObj);
				}
				
				/*if(inObj.getBoardKind().equals("APPEAL") && inObj.getAppealUserId() != null && !inObj.getAppealUserId().equals("")){
					contentMgrMapper.insertAppealUser(inObj);
					contentMgrMapper.updateProcess(inObj);
				}*/
			}else if(inObj.getInCondition().equals("수정")){
				contentMgrMapper.updateTitle(inObj);
				contentMgrMapper.updateContents(inObj);
				contentMgrMapper.updateLink(inObj);
				
				if(objFile != null){
					contentMgrMapper.deleteAllFiles(inObj);
					if(Integer.parseInt(inFileObj.getFileCount()) > 0){
						Files fileObj = new Files();
						for(int i=0; i<Integer.parseInt(inFileObj.getFileCount()); i++){
							fileObj.setFileId(Integer.toString(i+1));
							fileObj.setTitleId(Integer.toString(inObj.getTitleId()));
							fileObj.setUserFileName(inFileObj.getUserFileName().split("#")[i]);
							fileObj.setSystemFileName(inFileObj.getSystemFileName().split("#")[i]);
							fileObj.setFilePath(inFileObj.getFilePath().split("#")[i]);
							fileObj.setFileExtension(inFileObj.getFileExtension().split("#")[i]);
							fileObj.setFileSize(inFileObj.getFileSize().split("#")[i]);
							fileObj.setInDMLUserId(inObj.getInDMLUserId());
							fileObj.setInDMLIp(inObj.getInDMLIp());
							
							contentMgrMapper.insertFiles(fileObj);
						}
					}
				}
				
				/*if(inObj.getBoardKind().equals("APPEAL") && inObj.getAppealUserId() != null && !inObj.getAppealUserId().equals("")){
					contentMgrMapper.deleteAllAppealUser(inObj);
					contentMgrMapper.insertAppealUser(inObj);
					contentMgrMapper.updateProcess(inObj);
				}*/
			}else if(inObj.getInCondition().equals("삭제")){
				contentMgrMapper.deleteLink(inObj);
				contentMgrMapper.deleteContents(inObj);
				contentMgrMapper.deleteFiles(inObj);
				contentMgrMapper.deleteTitle(inObj);
			}
			
			inObj.setOutResult("SUCCESS");
			inObj.setOutNotice(inObj.getInWorkName()+inObj.getInCondition()+"에 성공하였습니다.");
		}catch(Exception e){
			e.printStackTrace();

			inObj.setOutResult("FAILURE");
			inObj.setOutNotice(inObj.getInWorkName()+inObj.getInCondition()+"에 실패하였습니다.");
		}
		
		return inObj;
	}
	
	public void updateBoardHitCount(Object obj) throws Exception {
		Link inObj = (Link)obj;
		contentMgrMapper.updateBoardHitCount(inObj);
	}
	
	/************************************************************
	 * getFreeBoardList 자유형 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getFreeBoardList(Object obj) throws Exception {
		Title inObj = (Title)obj;
		contentMgrMapper.listFreeBoard(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getFreeBoard 자유형 게시판 상세조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getFreeBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		contentMgrMapper.viewFreeBoard(inObj);
		inObj.setOutCursor(((List<?>)inObj.getOutCursor()).get(0));
		
		return inObj;
	}
	
	/**********************************************************
	 * actFreeBoard 자유형 게시판 입력/수정/삭제
	 * @param obj
	 * @return
	 * @throws Exception
	 **********************************************************/
	public Object actFreeBoard(Object obj) throws Exception {
		Content inObj = (Content)obj;
		contentMgrMapper.actFreeBoard(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getNoticeBoardList 공지형 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getListNoticeBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		contentMgrMapper.listNoticeBoard(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getNoticeBoard 공지형 게시판 상세조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getNoticeBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		contentMgrMapper.viewNoticeBoard(inObj);
		inObj.setOutCursor(((List<?>)inObj.getOutCursor()).get(0));
		
		return inObj;
	}
	
	/**********************************************************
	 * getNoticeBoardAction  공지형 게시판 입력/수정/삭제
	 * @param obj
	 * @return
	 * @throws Exception
	 **********************************************************/
	public Object actNoticeBoard(Object obj) throws Exception {
		Content inObj = (Content)obj;
		contentMgrMapper.actNoticeBoard(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getThumbnailBoardList 썸네일 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getThumbnailBoardList(Object obj) throws Exception {
		Title inObj = (Title)obj;
		contentMgrMapper.listThumbnailBoard(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getThumbnailBoard 썸네일 게시판 상세조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getThumbnailBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		contentMgrMapper.viewThumbnailBoard(inObj);
		inObj.setOutCursor(((List<?>)inObj.getOutCursor()).get(0));
		
		return inObj;
	}
	
	/**********************************************************
	 * actThumbnailBoard 썸네일 게시판 입력/수정/삭제
	 * @param obj
	 * @return
	 * @throws Exception
	 **********************************************************/
	public Object actThumbnailBoard(Object obj) throws Exception {
		Content inObj = (Content)obj;
		contentMgrMapper.actThumbnailBoard(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getListLinkBoard 링크형 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getListLinkBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		contentMgrMapper.listLinkBoard(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getLinkBoard 링크형 게시판 상세조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getLinkBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		contentMgrMapper.viewLinkBoard(inObj);
		inObj.setOutCursor(((List<?>)inObj.getOutCursor()).get(0));
		
		return inObj;
	}
	
	/**********************************************************
	 * actLinkBoard  링크형 게시판 입력/수정/삭제
	 * @param obj
	 * @return
	 * @throws Exception
	 **********************************************************/
	public Object actLinkBoard(Object obj) throws Exception {
		Content inObj = (Content)obj;
		contentMgrMapper.actLinkBoard(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getListLinkBoard 클리핑형 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getListClippingBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		contentMgrMapper.listClippingBoard(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getLinkBoard 클리핑형 게시판 상세조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getClippingBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		contentMgrMapper.viewClippingBoard(inObj);
		inObj.setOutCursor(((List<?>)inObj.getOutCursor()).get(0));
		
		return inObj;
	}
	
	/**********************************************************
	 * actLinkBoard  클리핑형 게시판 입력/수정/삭제
	 * @param obj
	 * @return
	 * @throws Exception
	 **********************************************************/
	public Object actClippingBoard(Object obj) throws Exception {
		Content inObj = (Content)obj;
		contentMgrMapper.actClippingBoard(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getListLinkBoard 민원형 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getAppealBoardList(Object obj) throws Exception {
		Title inObj = (Title)obj;
		contentMgrMapper.listAppealBoard(inObj);
		
		return inObj;
	}

	/************************************************************
	 * getListLinkBoard 민원형 게시판 SMS이력 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getAppealBoardSendList(Object obj) throws Exception {
		Title inObj = (Title)obj;
		contentMgrMapper.listAppealBoardSend(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getLinkBoard 민원형 게시판 상세조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getAppealBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		contentMgrMapper.viewAppealBoard(inObj);
		inObj.setOutCursor(((List<?>)inObj.getOutCursor()).get(0));
		
		if(((List<?>)inObj.getOutCursor1()).size() > 0 ){
		inObj.setOutCursor1(((List<?>)inObj.getOutCursor1()).get(0));
		}
		
		return inObj;
	}
	
	/**********************************************************
	 * actLinkBoard  민원형 게시판 입력/수정/삭제
	 * @param obj
	 * @return
	 * @throws Exception
	 **********************************************************/
	public Object actAppealBoard(Object obj) throws Exception {
		Content inObj = (Content)obj;
		contentMgrMapper.actAppealBoard(inObj);
		
		return inObj;
	}
	
	/**********************************************************
	 * actLinkBoard  민원형 게시판 입력/수정/삭제
	 * @param obj
	 * @return
	 * @throws Exception
	 **********************************************************/
	public Object actAppealUserBoard(Object obj) throws Exception {
		Content inObj = (Content)obj;
		contentMgrMapper.actAppealUserBoard(inObj);
		
		return inObj;
	}
	
	public Object getRoleList(Object obj) throws Exception {
		DefaultDomain inObj = (DefaultDomain)obj;
		contentMgrMapper.listRole(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getMyAppealBoardList My민원형 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getMyAppealBoardList(Object obj) throws Exception {
		Title inObj = (Title)obj;
		contentMgrMapper.listMyAppealBoard(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getMyReplyBoardList My관리자답변형 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getMyReplyBoardList(Object obj) throws Exception {
		Title inObj = (Title)obj;
		contentMgrMapper.listMyReplyBoard(inObj);
		
		return inObj;
	}
	
	/***************************************************
	 * getContentSet 콘텐츠 설정 정보 조회
	 * @param obj
	 * @return
	 * @throws Exception
	 **************************************************/
	public List<?> getContentSetList(Object obj) throws Exception {
		ContentSet inObj = (ContentSet)obj;
		return contentSetMapper.list(inObj);
	}

	/***************************************************
	 * getContentSetAdminList 콘텐츠 설정 정보 조회(관리권한이 있는 메뉴만)
	 * @param obj
	 * @return
	 * @throws Exception
	 **************************************************/
	public List<?> getContentSetAdminList(Object obj) throws Exception {
		ContentSet inObj = (ContentSet)obj;
		return contentSetMapper.listAdmin(inObj);
	}
	
	/***************************************************
	 * getContent 콘텐츠 정보 조회 (정적콘텐츠)
	 * @param obj
	 * @return
	 * @throws Exception
	 **************************************************/
	public Object getContent(Object obj) throws Exception {
		Content inObj = (Content)obj;
		return contentMgrMapper.viewContent(inObj);
	}
	
	/***************************************************
	 * getContentSet 콘텐츠 정보 입력/수정 (정적콘텐츠)
	 * @param obj
	 * @return
	 * @throws Exception
	 **************************************************/
	public Object actContent(Object obj) throws Exception {
		ContentSet inObj = (ContentSet)obj;
		
		try{
			if(inObj.getInCondition().equals("입력")){
				contentMgrMapper.deleteResetLink(inObj);
				contentMgrMapper.deleteResetTitle(inObj);
				contentMgrMapper.deleteResetContents(inObj);
				
				contentMgrMapper.insertTitle(inObj);
				contentMgrMapper.insertContents(inObj);
				contentMgrMapper.insertHistory(inObj);
				contentMgrMapper.insertLink(inObj);
			}else if(inObj.getInCondition().equals("수정")){
				contentMgrMapper.updateTitle(inObj);
				contentMgrMapper.updateContents(inObj);
				contentMgrMapper.updateLink(inObj);
				contentMgrMapper.insertHistory(inObj);
			}else if(inObj.getInCondition().equals("삭제")){
				
			}
			
			inObj.setOutResult("SUCCESS");
			inObj.setOutNotice(inObj.getInWorkName()+inObj.getInCondition()+"에 성공하였습니다.");
		}catch(Exception e){
			e.printStackTrace();

			inObj.setOutResult("FAILURE");
			inObj.setOutNotice(inObj.getInWorkName()+inObj.getInCondition()+"에 실패하였습니다.");
		}
		
		return inObj;
	}
	
	/***************************************************
	 * getContentSet 콘텐츠 정보 이력조회 (정적콘텐츠)
	 * @param obj
	 * @return
	 * @throws Exception
	 **************************************************/
	public List<?> getHistory(Object obj) throws Exception {
		ContentSet inObj = (ContentSet)obj;
		
		return contentMgrMapper.listHistory(inObj);
	}
	
	/***************************************************
	 * getContentSet 콘텐츠 설정 정보 조회
	 * @param obj
	 * @return
	 * @throws Exception
	 **************************************************/
	public Object getContentSet(Object obj) throws Exception {
		ContentSet inObj = (ContentSet)obj;		
		return contentSetMapper.view(inObj);
	}
	
	/**************************************************
	 * getReplyList 댓글 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 *************************************************/
	public Object getReplyList(Object obj) throws Exception {
		Reply inObj = (Reply)obj;
		contentMgrMapper.listReply(inObj);
		
		return inObj.getOutCursor();
	}

	/**************************************************
	 * actReply 댓글 입력/수정/삭제
	 * @param obj
	 * @return
	 * @throws Exception
	 **************************************************/
	public Object actReply(Object obj) throws Exception {
		Reply inObj = (Reply)obj;
		contentMgrMapper.actReply(inObj);
		
		return inObj;
	}

	/**************************************************
	 * actReplyBoard 관리자답변형 입력/수정/삭제
	 * @param obj
	 * @return
	 * @throws Exception
	 **************************************************/
	public Object actReplyBoard(Object obj) throws Exception {
		Content inObj = (Content)obj;
		contentMgrMapper.actReplyBoard(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getLinkBoard 민원형 게시판 상세조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getReplyBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		contentMgrMapper.viewReplyBoard(inObj);
		inObj.setOutCursor(((List<?>)inObj.getOutCursor()).get(0));
		
		if(((List<?>)inObj.getOutCursor1()).size() > 0 ){
			inObj.setOutCursor1(((List<?>)inObj.getOutCursor1()).get(0));
		}
		
		return inObj;
	}

	/************************************************************
	 * getVodBoardList 동영상형 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getListVodBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		contentMgrMapper.listVodBoard(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getVodBoard 동영상형 게시판 상세조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getVodBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		contentMgrMapper.viewVodBoard(inObj);
		inObj.setOutCursor(((List<?>)inObj.getOutCursor()).get(0));
		
		return inObj;
	}
	
	/**********************************************************
	 * getVodBoardAction  동영상형 게시판 입력/수정/삭제
	 * @param obj
	 * @return
	 * @throws Exception
	 **********************************************************/
	public Object actVodBoard(Object obj) throws Exception {
		Content inObj = (Content)obj;
		contentMgrMapper.actVodBoard(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getCardBoardList 카드형 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getCardBoardList(Object obj) throws Exception {
		Title inObj = (Title)obj;
		contentMgrMapper.listCardBoard(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getCardBoard 카드형 게시판 상세조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getCardBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		contentMgrMapper.viewCardBoard(inObj);
		inObj.setOutCursor(((List<?>)inObj.getOutCursor()).get(0));
		
		return inObj;
	}
	
	/**********************************************************
	 * actCardBoard 카드형 게시판 입력/수정/삭제
	 * @param obj
	 * @return
	 * @throws Exception
	 **********************************************************/
	public Object actCardBoard(Object obj) throws Exception {
		Content inObj = (Content)obj;
		contentMgrMapper.actCardBoard(inObj);
		
		return inObj;
	}
	
	public List<?> ListContentsLink(Object obj) throws Exception {
		Content inObj = (Content)obj;
		return contentMgrMapper.ListContentsLink(inObj);
	}
	
	public Object actListContentLink(Object obj) throws Exception {
		Content inObj = (Content)obj;
		contentMgrMapper.actListContentLink(inObj);
		
		return inObj;
	}
	
	public Object actListBoardLink(Object obj) throws Exception {
		Content inObj = (Content)obj;
		contentMgrMapper.actListBoardLink(inObj);
		
		return inObj;
	}
	
	public Object chkTransYn(Object obj) throws Exception {
		Content inObj = (Content)obj;
		
		String boardId = inObj.getBoardId();
		String[] boardIdArr = boardId.split(",");

		HashMap<String, String> rtnMsg = new HashMap<String, String>();
		
		int ORG_YN = -1; 
		int REPLY_YN = -1; 
		int REPLY_EXIST_YN = -1; 
		
		HashMap<String, String> hm = new HashMap<String, String>();
		
		hm.put("menuId", inObj.getMenuId());
		
		for(int i=0; i<boardIdArr.length; i++){
		
			hm.put("linkId", boardIdArr[i]);
			HashMap<String, BigDecimal> rsHm = (HashMap<String, BigDecimal>) contentMgrMapper.chkTransYn(hm);
			
			ORG_YN = ((BigDecimal)rsHm.get("ORG_YN")).intValue();
			REPLY_YN = ((BigDecimal)rsHm.get("REPLY_YN")).intValue();
			REPLY_EXIST_YN = ((BigDecimal)rsHm.get("REPLY_EXIST_YN")).intValue();

			// ORG_YN 			>> 원글 여부 ( 0이면 원글 아님, 1이면 원글) 1
			// REPLY_YN 		>> 답글 여부 ( 0이면 답글, 1이면 답글 아님) 1
			// REPLY_EXIST_YN 	>> 답글 존재 여부 (0이면 답글없음, 1이상이면 답글있음) 0
			
			if(ORG_YN == 0){
				rtnMsg.put("rtn", "FAILURE");
				rtnMsg.put("linkId", boardIdArr[i]);
				rtnMsg.put("msg", "원글이 아닙니다.");
				return rtnMsg;
			}
			if(REPLY_YN == 0){
				rtnMsg.put("rtn", "FAILURE");
				rtnMsg.put("linkId", boardIdArr[i]);
				rtnMsg.put("msg", "답글입니다.");
				return rtnMsg;
			}
			if(REPLY_EXIST_YN == 1){
				rtnMsg.put("rtn", "FAILURE");
				rtnMsg.put("linkId", boardIdArr[i]);
				rtnMsg.put("msg", "답글이 있습니다.");
				return rtnMsg;
			}
			
			rtnMsg.put("rtn", "SUCCESS");
		}
		
		return rtnMsg;
	}
	
	@Transactional
	public void actBbsTrans(Object obj) throws Exception {
		Content inObj = (Content)obj;

		String boardId = inObj.getBoardId();
		String[] boardIdArr = boardId.split(",");

		HashMap<String, String> rtnMsg = new HashMap<String, String>();
		
		HashMap<String, String> hm = new HashMap<String, String>();
		
		hm.put("paramMenuId", inObj.getParamMenuId());
		
		for(int i=0; i<boardIdArr.length; i++){
		
			hm.put("linkId", boardIdArr[i]);
			contentMgrMapper.actBbsTrans(hm);
			contentMgrMapper.actBbsLinkTrans(hm);
		}

		int cnt = contentMgrMapper.getTransTargetCnt(hm);
		if(cnt > 0){
			List<?> list = contentMgrMapper.getTransTargetList(hm);
			HashMap<String, String> hm2 = new HashMap<String, String>();
			
			for(int i=0; i<list.size(); i++){
				HashMap item = (HashMap)list.get(i);

				for(int j=0; j<boardIdArr.length; j++){
					hm2.put("menuId", item.get("TARGETMENUID").toString());
					hm2.put("linkId", boardIdArr[i]);
					contentMgrMapper.insetTransLink(hm2);
				}
			}
		}
	}
	
	public int getTransCnt(Object obj) throws Exception {
		ContentSet inObj = (ContentSet)obj;
		
		HashMap<String, String> hm = new HashMap<String, String>();
		hm.put("menuId", inObj.getMenuId());

		return contentMgrMapper.getTransCnt(hm);
	}
		
	// 키워드조회
	public List<?> selectKeywordSearchList(Object obj) throws Exception {
		return contentMgrMapper.selectKeywordSearchList(obj);
	}
	
	/************************************************************
	 * selectAnswerCount 민원/답변형 게시판 미답변 Count
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public List<?> selectAnswerCountList(Object obj) throws Exception {
		return contentMgrMapper.selectAnswerCountList(obj);
	}
	
}
