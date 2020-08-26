package com.spring.project.common;

public class PagingManager {
	private int nowPage;
	private int totalPage;
	private int totalBlock;
	private int nowBlock;
	private int startPage;
	private int endPage;
	private int totalCount;
	
	public PagingManager(int totalCount, int nowPage) {
		this.nowPage = nowPage;
		this.totalCount=totalCount;
		setTotalPage();
		setTotalBlock();
		setNowBlock();
		setStartPage();
		setEndPage();
	}
	public void setEndPage() {
		if(nowBlock<totalBlock) {
			this.endPage = nowBlock*10;
		}else {
			this.endPage = totalPage;
		}
	}
	public void setStartPage() {
		this.startPage=(int)((this.nowBlock-1)*10.0+1);
	}
	public void setNowBlock() {
		this.nowBlock = (int)Math.ceil(this.nowPage/10.0);
	}
	public void setTotalBlock() {
		this.totalBlock = (int)Math.ceil(totalPage/10.0);
	}
	public void setTotalPage() {
		this.totalPage = (int)Math.ceil(totalCount/10.0);		
	}
	public int getNowPage() {
		return nowPage;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public int getTotalBlock() {
		return totalBlock;
	}
	public int getNowBlock() {
		return nowBlock;
	}
	public int getStartPage() {
		return startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public int getTotalCount() {
		return totalCount;
	}
	
}
