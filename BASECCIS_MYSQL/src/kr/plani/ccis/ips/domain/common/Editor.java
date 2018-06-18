package kr.plani.ccis.ips.domain.common;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("editor")
public class Editor extends DefaultDomain implements Serializable {

	private static final long serialVersionUID = 1000652579114690205L;
	
	// 공통
	private String editorId;

	public String getEditorId() {
		return editorId;
	}

	public void setEditorId(String editorId) {
		this.editorId = editorId;
	}

}
