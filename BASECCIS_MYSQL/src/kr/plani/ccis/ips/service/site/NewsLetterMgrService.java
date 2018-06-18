package kr.plani.ccis.ips.service.site;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.common.util.NamoCrossFile;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.site.NewsLetter;
import kr.plani.ccis.ips.domain.site.NewsLetterPortlet;
import kr.plani.ccis.ips.domain.site.NewsLetterPortletContents;
import kr.plani.ccis.ips.mapper.site.NewsLetterMgrMapper;

@Service("newsLetterMgrService")
public class NewsLetterMgrService extends EgovAbstractServiceImpl
{
	@Resource
	private NewsLetterMgrMapper newNewsLetterMgrMapper;

	/*첨부파일관련*/
	@Resource
	private NamoCrossFile namoCrossFile;

	/*****************************************************************
	* getNewsLetterList - 뉴스레터 목록 조회
	* @param obj
	* @return List
	* @throws Exception
	*******************************************************************/
	public List<?> getNewsLetterList(Object obj) throws Exception
	{
		NewsLetter inObj = (NewsLetter)obj;

		return newNewsLetterMgrMapper.listNewsLetter(inObj);
	}

	/*****************************************************************
	* getNewsLetter - 뉴스레터 상세 조회
	* @param obj
	* @return Object
	* @throws Exception
	*******************************************************************/
	public Object getNewsLetter(Object obj) throws Exception
	{
		NewsLetter inObj = (NewsLetter)obj;

		return newNewsLetterMgrMapper.viewNewsLetter(inObj);
	}

	/*****************************************************************
	 * insertNewsLetter - 뉴스레터 추가
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public void insertNewsLetter(Object obj) throws Exception
	{
		NewsLetter inObj = (NewsLetter)obj;

		if(!StringUtil.getString(inObj.getSendDueDate(), "-").equals("-")) inObj.setSendDueDate(inObj.getSendDueDate().replaceAll("-", ""));
		if(!StringUtil.getString(inObj.getPubDate(), "-").equals("-")) inObj.setPubDate(inObj.getPubDate().replaceAll("-", ""));

		newNewsLetterMgrMapper.insertNewsLetter(inObj);
	}

	/*****************************************************************
	 * updateNewsLetter - 뉴스레터 수정
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public void updateNewsLetter(Object obj) throws Exception
	{
		NewsLetter inObj = (NewsLetter)obj;

		if(!StringUtil.getString(inObj.getSendDueDate(), "-").equals("-")) inObj.setSendDueDate(inObj.getSendDueDate().replaceAll("-", ""));
		if(!StringUtil.getString(inObj.getPubDate(), "-").equals("-")) inObj.setPubDate(inObj.getPubDate().replaceAll("-", ""));

		newNewsLetterMgrMapper.updateNewsLetter(inObj);
	}

	/*****************************************************************
	 * deleteNewsLetter - 뉴스레터 삭제
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public void deleteNewsLetter(Object obj) throws Exception
	{
		NewsLetter inObj = (NewsLetter)obj;

		newNewsLetterMgrMapper.deleteNewsLetter(inObj);
	}

	/*****************************************************************
	 * updateNewsLetterPoretlet - 뉴스레터 포틀릿 추가
	 * @param newsLetter
	 * @param request
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@Transactional
	public void updateNewsLetterPoretlet(NewsLetter newsLetter, HttpServletRequest request)
	{
		// 기존 뉴스레터 포틀릿 정보 삭제
		newNewsLetterMgrMapper.deleteNewsLetterPortlet(newsLetter);

		// 기존 뉴스레터 포틀릿 콘텐츠 정보 삭제
		newNewsLetterMgrMapper.deleteNewsLetterPortletContents(newsLetter);

		// 새로운 포틀릿 정보 목록 입력
		String[] portletInfoList = StringUtil.getStringSplit(newsLetter.getInDMLData(), "#");

		// 입력 데이터 구조
		// DIVID|OLD_DIVID(데이터를 찾아서 입력하기 위해 필요)|PORTLETTYPE
		for (String portletInfo : portletInfoList)
		{
			String[] portletInfoDatas = StringUtil.getStringSplit(portletInfo, "|");

			// 데이터 입력을 위하여 세팅
			NewsLetterPortlet newsLetterPortlet = new NewsLetterPortlet();

			// 기존 defaultDoamin의 정보 복사
			newsLetterPortlet.setCopyParam(newsLetter);

			// 포틀릿 정보 세팅
			String newsLetterId = newsLetter.getNewsLetterId();
			String divId = portletInfoDatas[0];
			String oldDivId = portletInfoDatas[1];
			String portletType = portletInfoDatas[2];

			String portletContentsDivId = "divPC_" + oldDivId;

			String content_title_use = StringUtil.getString(request.getParameter("contents_title_use_" + portletContentsDivId), "-");
			String contents_title = StringUtil.getString(request.getParameter("contents_title_" + portletContentsDivId), "-");
			int contents_count = Integer.parseInt(StringUtil.getString(request.getParameter("contents_count_" + portletContentsDivId), "0"));

			newsLetterPortlet.setNewsLetterId(newsLetterId);
			newsLetterPortlet.setDivId(divId);
			newsLetterPortlet.setPortletType(portletType);
			newsLetterPortlet.setContents_title_use(content_title_use);
			newsLetterPortlet.setContents_title(contents_title);
			newsLetterPortlet.setContents_count(contents_count);

			// 포틀릿 개별 정보 입력
			newNewsLetterMgrMapper.insertNewsLetterPortlet(newsLetterPortlet);


			// 포틀릿 콘텐츠 상세정보 저장
			NewsLetterPortletContents newsLetterPortletContents = new NewsLetterPortletContents();

			newsLetterPortletContents.setCopyParam(newsLetter);

			newsLetterPortletContents.setNewsLetterId(newsLetterId);
			newsLetterPortletContents.setDivId(divId);

			for (int i = 0; i < contents_count; i++)
			{
				String subject = request.getParameter(portletContentsDivId + "_subject_" + String.valueOf(i));
				String link = request.getParameter(portletContentsDivId + "_link_" + String.valueOf(i));
				String uimgfilename = request.getParameter(portletContentsDivId + "_uimgfilename_" + String.valueOf(i));
				String imgObjectId = portletContentsDivId + "_uimgfilename_" + String.valueOf(i) + "_obj";
				String ouimgfilename = request.getParameter(portletContentsDivId + "_ouimgfilename_" + String.valueOf(i));
				String osimgfilename = request.getParameter(portletContentsDivId + "_osimgfilename_" + String.valueOf(i));
				String oimgfilepath = request.getParameter(portletContentsDivId + "_oimgfilepath_" + String.valueOf(i));
				String imagedesc = request.getParameter(portletContentsDivId + "_imagedesc_" + String.valueOf(i));
				String contents = request.getParameter(portletContentsDivId + "_contents_" + String.valueOf(i));
				String html = request.getParameter(portletContentsDivId + "_html_" + String.valueOf(i));

				newsLetterPortletContents.setSeq(i);

				newsLetterPortletContents.setSubject(subject);
				newsLetterPortletContents.setLink(link);
				
				// 파일 저장이 필요할 경우 파일 업로드 처리
//				if ( StringUtil.isNotBlank(uimgfilename) )
//				{
//					if ( StringUtils.isNotBlank(osimgfilename) )
//					{				
//						namoCrossFile.fileDeleteAttempt(oimgfilepath, osimgfilename);
//					}
//
//					Files uploadFiles = (Files) namoCrossFile.fileUploadAttempt(imgObjectId, request);
//
//					newsLetterPortletContents.setUserImgFileName(uploadFiles.getUserFileName());
//					newsLetterPortletContents.setSystemImgFileName(uploadFiles.getSystemFileName());
//					newsLetterPortletContents.setImgFilePath(uploadFiles.getFilePath());
//				}
//				else 
				if ( StringUtil.isNotBlank(osimgfilename) )
				{
					newsLetterPortletContents.setUserImgFileName(ouimgfilename);
					newsLetterPortletContents.setSystemImgFileName(osimgfilename);
					newsLetterPortletContents.setImgFilePath(oimgfilepath);
				}

				newsLetterPortletContents.setImgDesc(imagedesc);
				newsLetterPortletContents.setContents(contents);
				newsLetterPortletContents.setHtml(html);

				newNewsLetterMgrMapper.insertNewsLetterPortletContents(newsLetterPortletContents);
			}
		}
	}

	public List getNewsLetterPortletLineList(NewsLetter newsLetter)
	{
		return newNewsLetterMgrMapper.listPortletLine(newsLetter);
	}

	public List getNewsLetterPortletList(NewsLetter newsLetter)
	{
		List<NewsLetterPortlet> newsLetterPortletList = newNewsLetterMgrMapper.listPortlet(newsLetter);

		for ( NewsLetterPortlet newsLetterPortlet : newsLetterPortletList )
		{
			List<NewsLetterPortletContents> newsLetterPortletContentsList = newNewsLetterMgrMapper.listPortletContents(newsLetterPortlet);

			newsLetterPortlet.setContents_count(newsLetterPortletContentsList!=null ? newsLetterPortletContentsList.size() : 0);
			newsLetterPortlet.setNewsLetterPortletContentsList(newsLetterPortletContentsList);
		}

		return newsLetterPortletList;
	}

	public List<?> selectNewsLetterApp(Object obj) throws Exception
	{
		NewsLetter inObj = (NewsLetter)obj;

		return newNewsLetterMgrMapper.selectNewsLetterApp(inObj);
	}

	public List<?> selectMailResult(Object obj) throws Exception
	{
		NewsLetter inObj = (NewsLetter) obj;
		return newNewsLetterMgrMapper.selectMailResult(inObj);
	}

	@Transactional
	public String sendEmailCancel(HttpServletRequest request) throws Exception
	{
		String msg = "FAILURE";

		String siteId = request.getParameter("siteId");
		String newsLetterId = request.getParameter("newsLetterId");
		String menuId = request.getParameter("menuId");

		HashMap hmParam = new HashMap();
		hmParam.put("newsLetterId", newsLetterId);
		hmParam.put("menuId", menuId);

		List<HashMap<String, String>> list = (List<HashMap<String, String>>) newNewsLetterMgrMapper.selectEmailSendForm(hmParam);

		HashMap<String, String> hm = new HashMap<String, String>();

		hm = (HashMap<String, String>) list.get(0);

		String sendFlag = hm.get("SEND_FLAG").toString();

		if (sendFlag.equals("N"))
		{

			hmParam.put("SEQ", hm.get("SEQ"));

			newNewsLetterMgrMapper.deleteSendList(hmParam);
			newNewsLetterMgrMapper.deleteSendForm(hmParam);

			msg = "SUCCESS";
		}
		else
		{
			msg = "SEND";
		}

		return msg;
	}

	public void updatePreviewHtml(Object inObj) throws Exception{
		newNewsLetterMgrMapper.updatePreviewHtml(inObj);
	}
}
