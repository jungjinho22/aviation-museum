<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!-- 등록 전문정보 탭 -->
            <div class="tab-pane" id="messages" role="tabpanel" style="display:block;">
                <div class="mb-0">
                  <!--  -->
                  <div class="st_wrap">
                    <label class="col-md-2 col-form-label st_title">전문정보검색</label>
                    <form id="rgstrSpecialitySearchForm" name="rgstrSpecialitySearchForm" method="post" class="form-horizontal">
	                    <select class="form-select st_select pro_info" id="speciality_code_idx" name=speciality_code_idx>
	                       <option value="">전체</option>
	                       <c:forEach var="specialityCodeList" items="${specialityCodeList}">
	                     	 	<option value="${specialityCodeList.speciality_code_idx}">${specialityCodeList.speciality_nm}</option>
	                       </c:forEach>
	                    </select>
	                    <select class="form-select st_select pro_info" id="search_type" name="search_type">
	                      <option value="">전체</option>
	                      <option value="item_no">자료번호</option>
	                      <option value="item_detail_no">세부번호</option>
	                      <option value="item_nm">명칭</option>
	                    </select>
	                    <input type="text" class="form-control st_input pro_info" list="datalistOptions" placeholder="내용을 입력해 주세요." id="search_word" name="search_word" >
	                    <button class="btn btn-secondary waves-effect waves-light btn_ml" type="button" onClick="rgstrSpecialitySearchList();">조회</button>
                    </form>
                    <button type="button" onClick="rgstrSpecialityExcelList();">엑셀파일</button>
                </div>
                <!--  -->
                <form id="sForm" name="sForm" method="post" class="form-horizontal">
                	<input type="hidden" id="speciality_code_idx2" name="speciality_code_idx" value="" />
                	<input type="hidden" id="search_type2" name="search_type" value="" />
                	<input type="hidden" id="search_word2" name="search_word" value="" />
	                <div class="card-body">
	                  <div class="table-responsive">
	                    <table class="table mb-0">
	                      <thead>
	                        <tr class="tr_bgc">
	                          <th>번호</th>
	                          <th>일자</th>
	                          <th>소장구분</th>
	                          <th>자료번호</th>
	                          <th>세부번호</th>
	                          <th>명칭</th>
	                          <th>구분</th>
	                          <th>제목</th>
	                        </tr>
	                      </thead>
	                      <tbody>
	                      	<c:forEach var="specialityList" items="${specialityList}">
		                        <tr>
		                          <td>${perPageNum + 1 - specialityList.rnum}</td>
		                          <td>${specialityList.reg_date}</td>
		                          <td>${specialityList.possession_nm}</td>
		                          <td>${specialityList.item_no}</td>
		                          <td>${specialityList.item_detail_no}</td>
		                          <td>${specialityList.item_nm}</td>
		                          <td>${specialityList.speciality_nm}</td>
		                          <td>${specialityList.title}</td>
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
	                </div>
	            </form>  
                <!--  -->
                </div>
            </div>
            
            <script>
	    		$('input[type="text"]').keydown(function() {
		  			  if (event.keyCode === 13) {
		  			    event.preventDefault();
		  			  };
				});
  		
	    		<%-- 등록전문 조건 검색 --%>
	    		function rgstrSpecialitySearchList(){
	    			var speciality_code_idx = $('#speciality_code_idx').val();
	    			var search_word = $('#search_word').val();
	    			var search_type = $('#search_type').val();
	    			// 태그 조건 검색			
	    			var queryString = $("form[name=rgstrSpecialitySearchForm]").serialize();
	
	    				$.ajax({
	    					type : 'post',
	    					url : '/rgstrSpecialityAjax.do',
	    					data : queryString,
	    					dataType : 'html',
	    					contentType : "application/x-www-form-urlencoded;charset=UTF-8",
	    					error: function(xhr, status, error){
	    						alert(error);
	    					},
	    					success : function(data){
	    						$('#tab-content').empty().append(data);
	    						$('#speciality_code_idx2').val(speciality_code_idx);
	    						$('#search_word2').val(search_word);
	    						$('#search_type2').val(search_type);
	    					}
	    				});
	    		}
	    		
	    		function rgstrSpecialityExcelList() {
	    			var $form = $('#sForm');

	    				$form.attr("action", "/rgstrExcelDownload.do");
	    				$form.submit();

	    		}
	    		
	    		<%-- 등록 전문정본 페이지 이동 --%>
	    		function goPage(value) {
	    			var perPageNum = $('#perPageNum').val();
	    			var search_word = $('#search_word').val();
	    			var search_type = $('#search_type').val();
	    			var page = value;
	    			$.ajax({
	    				type : 'POST',                 
	    				url : '/rgstrSpecialityAjax.do',   
	    				data:{
	    					perPageNum : perPageNum,
	    					search_type : search_type,
	    					search_word : search_word,
	    					page : page
	    				},
	    				dataType : "html",           
	    				contentType : "application/x-www-form-urlencoded;charset=UTF-8",
	    				error : function() {        
	    					alert('통신실패!');
	    				},
	    				success : function(data) {  
	    					$('#tab-content').empty().append(data);
//     						$('#perPageNum').val(perPageNum);
//     						$('#search_word').val(search_word);
//     						$('#search_type').val(search_type);
	    				}
	    			});
	    		}
            </script>