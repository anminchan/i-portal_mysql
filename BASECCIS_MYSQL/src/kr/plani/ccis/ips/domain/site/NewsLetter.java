package kr.plani.ccis.ips.domain.site;

import kr.plani.ccis.ips.domain.DefaultDomain;

import org.apache.ibatis.type.Alias;

import java.io.Serializable;

@Alias("newsLetter")
public class NewsLetter extends DefaultDomain implements Serializable {

	private static final long serialVersionUID = 5804508759198546913L;
	
	private String newsLetterId;
	private String openYn;
	private String sendDueDate;
	private String template;
	private String upImage;;
	private String upImageFileName;
	private String upImageSFileName;
	private String upImageFilePath;
	private String upImageHtml;
	private String pubNo;
	private String pubDate;
	private String pubTime;
	
	private String newsLetterBodyId;
	private String kHtml;
	public String[] kHtmlArr;
	public String[] newsLetterBodyIdArr;

	private String fileId;
	private String userFileName;
	private String systemFileName;
	private String filePath;
	private String fileExtension;
	private String fileSize;
	
	private String appEmail;
	private String rcvYn;
	private String sendFlag;
	
	private String version;
	
	private String HH;
	private String MM;
	
	private String newsLetter;
	private String newsLetterGubun;
	private String newsLetterPNC;

	// 저장 처리 상태
	private String saveStatus;
	
	private String previewHtml;
	
	public String getNewsLetterId() {
		return newsLetterId;
	}
	public void setNewsLetterId(String newsLetterId) {
		this.newsLetterId = newsLetterId;
	}
	public String getOpenYn() {
		return openYn;
	}
	public void setOpenYn(String openYn) {
		this.openYn = openYn;
	}
	public String getSendDueDate() {
		return sendDueDate;
	}
	public void setSendDueDate(String sendDueDate) {
		this.sendDueDate = sendDueDate;
	}
	public String getTemplate() {
		return template;
	}
	public void setTemplate(String template) {
		this.template = template;
	}
	public String getUpImage() {
		return upImage;
	}
	public void setUpImage(String upImage) {
		this.upImage = upImage;
	}
	public String getPubNo() {
		return pubNo;
	}
	public void setPubNo(String pubNo) {
		this.pubNo = pubNo;
	}
	public String getPubDate() {
		return pubDate;
	}
	public void setPubDate(String pubDate) {
		this.pubDate = pubDate;
	}
	public String getPubTime() {
		return pubTime;
	}
	public void setPubTime(String pubTime) {
		this.pubTime = pubTime;
	}
	public String getNewsLetterBodyId() {
		return newsLetterBodyId;
	}
	public void setNewsLetterBodyId(String newsLetterBodyId) {
		this.newsLetterBodyId = newsLetterBodyId;
	}
	public String getkHtml() {
		return kHtml;
	}
	public void setkHtml(String kHtml) {
		this.kHtml = kHtml;
	}
	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	public String getUserFileName() {
		return userFileName;
	}
	public void setUserFileName(String userFileName) {
		this.userFileName = userFileName;
	}
	public String getSystemFileName() {
		return systemFileName;
	}
	public void setSystemFileName(String systemFileName) {
		this.systemFileName = systemFileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileExtension() {
		return fileExtension;
	}
	public void setFileExtension(String fileExtension) {
		this.fileExtension = fileExtension;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public String[] getkHtmlArr() {
		return kHtmlArr;
	}
	public void setkHtmlArr(String[] kHtmlArr) {
		this.kHtmlArr = kHtmlArr;
	}
	public String getAppEmail() {
		return appEmail;
	}
	public void setAppEmail(String appEmail) {
		this.appEmail = appEmail;
	}
	public String[] getNewsLetterBodyIdArr() {
		return newsLetterBodyIdArr;
	}
	public void setNewsLetterBodyIdArr(String[] newsLetterBodyIdArr) {
		this.newsLetterBodyIdArr = newsLetterBodyIdArr;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getRcvYn() {
		return rcvYn;
	}
	public void setRcvYn(String rcvYn) {
		this.rcvYn = rcvYn;
	}
	public String getSendFlag() {
		return sendFlag;
	}
	public void setSendFlag(String sendFlag) {
		this.sendFlag = sendFlag;
	}
	public String getHH() {
		return HH;
	}
	public void setHH(String hH) {
		HH = hH;
	}
	public String getMM() {
		return MM;
	}
	public void setMM(String mM) {
		MM = mM;
	}
	public String getNewsLetter() {
		return newsLetter;
	}
	public void setNewsLetter(String newsLetter) {
		this.newsLetter = newsLetter;
	}
	public String getNewsLetterGubun() {
		return newsLetterGubun;
	}
	public void setNewsLetterGubun(String newsLetterGubun) {
		this.newsLetterGubun = newsLetterGubun;
	}
	public String getNewsLetterPNC() {
		return newsLetterPNC;
	}
	public void setNewsLetterPNC(String newsLetterPNC) {
		this.newsLetterPNC = newsLetterPNC;
	}

	public String getUpImageSFileName()
	{
		return upImageSFileName;
	}

	public void setUpImageSFileName(String upImageSFileName)
	{
		this.upImageSFileName = upImageSFileName;
	}

	public String getUpImageHtml()
	{
		return upImageHtml;
	}

	public void setUpImageHtml(String upImageHtml)
	{
		this.upImageHtml = upImageHtml;
	}

	public String getUpImageFileName()
	{
		return upImageFileName;
	}

	public void setUpImageFileName(String upImageFileName)
	{
		this.upImageFileName = upImageFileName;
	}

	public String getUpImageFilePath()
	{
		return upImageFilePath;
	}

	public void setUpImageFilePath(String upImageFilePath)
	{
		this.upImageFilePath = upImageFilePath;
	}

	public String getSaveStatus()
	{
		return saveStatus;
	}

	public void setSaveStatus(String saveStatus)
	{
		this.saveStatus = saveStatus;
	}
	public String getPreviewHtml() {
		return previewHtml;
	}
	public void setPreviewHtml(String previewHtml) {
		this.previewHtml = previewHtml;
	}
}
