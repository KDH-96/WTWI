package com.wtwi.fin.admin.model.service;

import java.util.List;


import com.wtwi.fin.member.model.vo.Pagination;
import com.wtwi.fin.member.model.vo.Report;
import com.wtwi.fin.member.model.vo.Search;

public interface AdminReportService {

	/** 신고 조회 페이지네이션
	 * @param pg
	 * @return
	 */
	Pagination getReportPagination(Pagination pg);

	/** 신고 전체 목록
	 * @param pagination
	 * @return
	 */
	List<Report> selectReportBoardList(Pagination pg);

	/** 신고 조회 페이지네이션(검색)
	 * @param search
	 * @param pg
	 * @return
	 */
	Pagination getReportPagination(Search search, Pagination pg);

	/** 신고 전체 목록(검색)
	 * @param search
	 * @param pagination
	 * @return
	 */
	List<Report> selectSearchReportBoardList(Search search, Pagination pg);

	/** 신고 상태 변경
	 * @param reportNo
	 * @return
	 */
	int changeReportStatus(Report report);

	

}
