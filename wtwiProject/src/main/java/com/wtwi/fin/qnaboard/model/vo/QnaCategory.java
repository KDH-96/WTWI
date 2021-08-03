package com.wtwi.fin.qnaboard.model.vo;

public class QnaCategory {
	private int qnaCategoryNo;
	private String qnaCategoryNm;
	
	public QnaCategory() {}

	public int getQnaCategoryNo() {
		return qnaCategoryNo;
	}

	public void setQnaCategoryNo(int qnaCategoryNo) {
		this.qnaCategoryNo = qnaCategoryNo;
	}

	public String getQnaCategoryNm() {
		return qnaCategoryNm;
	}

	public void setQnaCategoryNm(String qnaCategoryNm) {
		this.qnaCategoryNm = qnaCategoryNm;
	}

	@Override
	public String toString() {
		return "QnaCategory [qnaCategoryNo=" + qnaCategoryNo + ", qnaCategoryNm=" + qnaCategoryNm + "]";
	}
	

}
