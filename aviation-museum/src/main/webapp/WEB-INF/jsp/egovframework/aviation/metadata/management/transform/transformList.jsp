<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
				<div class="auto_btn_left">
                  <div class="auto_btn_left">
                  <span>| 총건수: ${perPageNum}건</span><span>| 총수량: 00건</span><span>| 현수량: 00건</span>
                </div>
                </div>
				<div class="table-responsive">
                      <table class="table mb-0">
                          <thead>
                              <tr class="tr_bgc">
                                  <th>#</th>
                                  <th>번호</th>
                                  <th>소장구분</th>
                                  <th>자료번호</th>
                                  <th>세부번호</th>
                                  <th>명칭</th>
                                  <th>이명칭</th>
                                  <th>영문명칭</th>
                                  <th>시대(상세)</th>
                                  <th>작가</th>
                                  <th>상태</th>
                              </tr>
                          </thead>
                          <tbody>
                          	<c:forEach var="list" items="${transformList}">
                              <tr>
                                <td><input type="checkbox"/></td>
                                <td id="rownum">${list.rownum}</td>
                                <td>${list.possession_nm} - ${list.org_nm}</td>
                                <td>${list.item_no}</td>
                                <td>${list.item_detail_no}</td>
                                <td>${list.item_nm}</td>
                                <td>${list.item_se_nm}</td>
                                <td>${list.item_eng_nm}</td>
                                <td>-</td>
                                <td>${list.author}</td>
                                <td>${list.reg_state}</td>
                              </tr>
                              </c:forEach>
                          </tbody>
                      </table>
                      <ul class="btn-group pagination">
					    <c:if test="${pageMaker.prev }">
					    <li>
					        <a href='javascript:;' onclick="goPage('${pageMaker.startPage-1 }');"><i class="fa fa-chevron-left"></i></a>
					    </li>
					    </c:if>
					    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
					    <li>
					        <a href='javascript:;' onclick="goPage('${pageNum}');"><i class="fa">${pageNum }</i></a>
					    </li>
					    </c:forEach>
					    <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
					    <li>
					        <a href="javascript:;" onclick="goPage('${pageMaker.endPage+1 }');"><i class="fa fa-chevron-right"></i></a>
					    </li>
					    </c:if>
					</ul> 
                  </div>