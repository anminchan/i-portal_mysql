package kr.plani.ccis.ips.domain.site;

import kr.plani.ccis.ips.domain.DefaultDomain;
import org.apache.ibatis.type.Alias;

import java.io.Serializable;
import java.util.List;

@Alias("newsLetterPortlet")
public class NewsLetterPortlet extends DefaultDomain implements Serializable
{
	private static final long serialVersionUID = -8117519517258201116L;

	// 뉴스레터 포틀릿 기본정보
	private String newsLetterId;
	private String divId;
	private String portletType;

	private String lineId;
	private String portletId;
	private String portletSize;

	private String contents_title_use;
	private String contents_title;
	private int contents_count;

	private List<NewsLetterPortletContents> newsLetterPortletContentsList;


	public String getNewsLetterId()
	{
		return newsLetterId;
	}

	public void setNewsLetterId(String newsLetterId)
	{
		this.newsLetterId = newsLetterId;
	}

	public String getDivId()
	{
		return divId;
	}

	public void setDivId(String divId)
	{
		this.divId = divId;
	}

	public String getPortletType()
	{
		return portletType;
	}

	public void setPortletType(String portletType)
	{
		this.portletType = portletType;
	}

	public String getContents_title_use()
	{
		return contents_title_use;
	}

	public void setContents_title_use(String contents_title_use)
	{
		this.contents_title_use = contents_title_use;
	}

	public String getContents_title()
	{
		return contents_title;
	}

	public void setContents_title(String contents_title)
	{
		this.contents_title = contents_title;
	}

	public int getContents_count()
	{
		return contents_count;
	}

	public void setContents_count(int contents_count)
	{
		this.contents_count = contents_count;
	}

	public List<NewsLetterPortletContents> getNewsLetterPortletContentsList()
	{
		return newsLetterPortletContentsList;
	}

	public void setNewsLetterPortletContentsList(List<NewsLetterPortletContents> newsLetterPortletContentsList)
	{
		this.newsLetterPortletContentsList = newsLetterPortletContentsList;
	}

	public String getLineId()
	{
		return lineId;
	}

	public void setLineId(String lineId)
	{
		this.lineId = lineId;
	}

	public String getPortletId()
	{
		return portletId;
	}

	public void setPortletId(String portletId)
	{
		this.portletId = portletId;
	}

	public String getPortletSize()
	{
		return portletSize;
	}

	public void setPortletSize(String portletSize)
	{
		this.portletSize = portletSize;
	}
}