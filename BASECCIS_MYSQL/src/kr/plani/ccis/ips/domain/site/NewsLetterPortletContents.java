package kr.plani.ccis.ips.domain.site;

import kr.plani.ccis.ips.domain.DefaultDomain;
import org.apache.ibatis.type.Alias;

import java.io.Serializable;

@Alias("newsLetterPortletContents")
public class NewsLetterPortletContents extends DefaultDomain implements Serializable
{
	private static final long serialVersionUID = 3330765357877677299L;

	// 뉴스레터 포틀릿 콘텐츠 정보
	private String newsLetterId;
	private String divId;
	private int seq;

	private String subject;
	private String link;
	private String userImgFileName;
	private String systemImgFileName;
	private String imgFilePath;
	private String imgDesc;
	private String contents;
	private String html;

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

	public int getSeq()
	{
		return seq;
	}

	public void setSeq(int seq)
	{
		this.seq = seq;
	}

	public String getSubject()
	{
		return subject;
	}

	public void setSubject(String subject)
	{
		this.subject = subject;
	}

	public String getLink()
	{
		return link;
	}

	public void setLink(String link)
	{
		this.link = link;
	}

	public String getUserImgFileName()
	{
		return userImgFileName;
	}

	public void setUserImgFileName(String userImgFileName)
	{
		this.userImgFileName = userImgFileName;
	}

	public String getSystemImgFileName()
	{
		return systemImgFileName;
	}

	public void setSystemImgFileName(String systemImgFileName)
	{
		this.systemImgFileName = systemImgFileName;
	}

	public String getImgFilePath()
	{
		return imgFilePath;
	}

	public void setImgFilePath(String imgFilePath)
	{
		this.imgFilePath = imgFilePath;
	}

	public String getImgDesc()
	{
		return imgDesc;
	}

	public void setImgDesc(String imgDesc)
	{
		this.imgDesc = imgDesc;
	}

	public String getContents()
	{
		return contents;
	}

	public void setContents(String contents)
	{
		this.contents = contents;
	}

	public String getHtml()
	{
		return html;
	}

	public void setHtml(String html)
	{
		this.html = html;
	}
}