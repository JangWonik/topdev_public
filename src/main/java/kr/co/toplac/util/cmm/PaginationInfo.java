package kr.co.toplac.util.cmm;

/**
 * Created by icwking on 2015. 9. 22..
 */
public class PaginationInfo {

    /**
     * Required Fields
     * - 이 필드들은 페이징 계산을 위해 반드시 입력되어야 하는 필드 값들이다.
     *
     * currentPageNo : 현재 페이지 번호
     * recordCountPerPage : 한 페이지당 게시되는 게시물 건 수
     * pageSize : 페이지 리스트에 게시되는 페이지 건수,
     * totalRecordCount : 전체 게시물 건 수.
     */

    private long currentPageNo;
    private long recordCountPerPage;
    private long pageSize;
    private long totalRecordCount;
    
    public long getRecordCountPerPage() {
        return recordCountPerPage;
    }

    public void setRecordCountPerPage(long recordCountPerPage) {
        this.recordCountPerPage = recordCountPerPage;
    }

    public long getPageSize() {
        return pageSize;
    }

    public void setPageSize(long pageSize) {
        this.pageSize = pageSize;
    }

    public long getCurrentPageNo() {
        return currentPageNo;
    }

    public void setCurrentPageNo(long currentPageNo) {
        this.currentPageNo = currentPageNo;
    }

    public void setTotalRecordCount(long totalRecordCount) {
        this.totalRecordCount = totalRecordCount;
    }

    public long getTotalRecordCount() {
        return totalRecordCount;
    }



	/**
     * Not Required Fields
     * - 이 필드들은 Required Fields 값을 바탕으로 계산해서 정해지는 필드 값이다.
     *
     * totalPageCount: 페이지 개수
     * firstPageNoOnPageList : 페이지 리스트의 첫 페이지 번호
     * lastPageNoOnPageList : 페이지 리스트의 마지막 페이지 번호
     * firstRecordIndex : 페이징 SQL의 조건절에 사용되는 시작 rownum.
     * lastRecordIndex : 페이징 SQL의 조건절에 사용되는 마지막 rownum.
     */

    private long totalPageCount;
    private long firstPageNoOnPageList;
    private long lastPageNoOnPageList;
    private long firstRecordIndex;
    private long lastRecordIndex;
    private long virtualIndex;

    public long getTotalPageCount() {
        totalPageCount = ((getTotalRecordCount() - 1) / getRecordCountPerPage()) + 1;
        return totalPageCount;
    }

    public long getFirstPageNo() {
        return 1;
    }

    public long getLastPageNo() {
        return getTotalPageCount();
    }

    public long getFirstPageNoOnPageList() {
        firstPageNoOnPageList = ((getCurrentPageNo() - 1) / getPageSize()) * getPageSize() + 1;
        return firstPageNoOnPageList;
    }

    public long getLastPageNoOnPageList() {
        lastPageNoOnPageList = getFirstPageNoOnPageList() + getPageSize() - 1;
        if (lastPageNoOnPageList > getTotalPageCount()) {
            lastPageNoOnPageList = getTotalPageCount();
        }
        return lastPageNoOnPageList;
    }

    public long getFirstRecordIndex() {
        firstRecordIndex = (getCurrentPageNo() - 1) * getRecordCountPerPage();
        return firstRecordIndex;
    }

    public long getLastRecordIndex() {
        lastRecordIndex = getCurrentPageNo() * getRecordCountPerPage();
        return lastRecordIndex;
    }

    public long getVirtualIndex() {
        virtualIndex = totalRecordCount - ((currentPageNo - 1) * recordCountPerPage);
        return virtualIndex;
    }
    
    
    /**
     * 
     * 동일 VIEW 내부에서 fnGoPage 사용 시, 페이지를 구분하기 위한 값
     * 180723 lds 추가
     * 
     */
    
    private String pageName;
    
    public String getPageName() {
		return pageName;
	}

	public void setPageName(String pageName) {
		this.pageName = pageName;
	}
    
    
}
