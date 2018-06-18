package kr.plani.ccis.ips.mapper.site;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.plani.ccis.ips.domain.site.NewsLetter;
import kr.plani.ccis.ips.domain.site.NewsLetterPortlet;
import kr.plani.ccis.ips.domain.site.NewsLetterPortletContents;

import java.util.List;

@Mapper("newsLetterMgrMapper")
public interface NewsLetterMgrMapper
{
	List<?> listNewsLetter(Object obj);
	Object viewNewsLetter(Object obj);

	void insertNewsLetter(Object obj);
	void updateNewsLetter(Object obj);
	void deleteNewsLetter(Object obj);

	void deleteNewsLetterPortlet(NewsLetter newsLetter);
	void insertNewsLetterPortlet(NewsLetterPortlet newsLetterPortlet);

	List listPortletLine(NewsLetter newsLetter);
	List<NewsLetterPortlet> listPortlet(NewsLetter newsLetter);

	void deleteNewsLetterPortletContents(NewsLetter newsLetter);
	void insertNewsLetterPortletContents(NewsLetterPortletContents newsLetterPortletContents);

	List<NewsLetterPortletContents> listPortletContents(NewsLetterPortlet newsLetterPortlet);

	public void rejectNewsLetterApp(Object obj);
	public List<?> selectNewsLetterApp(Object obj);
	public List<?> selectMailResult(Object obj);

	public List<?> selectEmailSendForm(Object obj);
	public void deleteSendForm(Object obj);
	public void deleteSendList(Object obj);
	public void updatePreviewHtml(Object inObj);
}
