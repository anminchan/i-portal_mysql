package kr.plani.ccis.base.domain;

import org.apache.ibatis.type.Alias;

@Alias("siteSet")
public class SiteSet {
	public String siteLayer = "common";		//사이트 레이아웃 지정
	public String siteKye = "";				//사이트 고유키
	public String siteType = "";				//동적,정적,모바일 구분
	public String bodyType = "typeA";			//메인 바디 타입
	public String siteLang = "K";
	public String mainGubun = "";

	public String getSiteLayer() {
		return siteLayer;
	}

	public void setSiteLayer(String siteLayer) {
		this.siteLayer = siteLayer;
	}

	public String getSiteKye() {
		return siteKye;
	}

	public void setSiteKye(String siteKye) {
		this.siteKye = siteKye;
	}

	public String getSiteType() {
		return siteType;
	}

	public void setSiteType(String siteType) {
		this.siteType = siteType;
	}

	public String getBodyType() {
		return bodyType;
	}

	public void setBodyType(String bodyType) {
		this.bodyType = bodyType;
	}

	public String getSiteLang() {
		return siteLang;
	}

	public void setSiteLang(String siteLang) {
		this.siteLang = siteLang;
	}

	public String getMainGubun() {
		return mainGubun;
	}

	public void setMainGubun(String mainGubun) {
		this.mainGubun = mainGubun;
	}
	
	
	
}
