package kr.plani.ccis.ips.domain.site;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("tabooWord")
public class TabooWord extends DefaultDomain {

	private int seq;
	private String keyBoard;
	private String keyBoardVal;
	
	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getKeyBoard() {
		return keyBoard;
	}

	public void setKeyBoard(String keyBoard) {
		this.keyBoard = keyBoard;
	}

	public String getKeyBoardVal() {
		return keyBoardVal;
	}

	public void setKeyBoardVal(String keyBoardVal) {
		this.keyBoardVal = keyBoardVal;
	}

}
