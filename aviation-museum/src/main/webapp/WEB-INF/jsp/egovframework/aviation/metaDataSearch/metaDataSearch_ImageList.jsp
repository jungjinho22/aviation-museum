<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
          <!-- Tab panes -->
          <div class="tab-content p-3 text-muted">
            <!-- 상세검색 모달 내용 -->
<div id="TagModal-1" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" style="display: none" aria-hidden="true">
  <div class="modal-dialog user-modal">
    <div class="modal-content">
      <div class="modal-header mv-modal-header">
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="metaDataDetailSearchListCloseBtn"></button>
      </div>
      <div class="modal-body mv-modal-body">
        <div class="mb-0 user-wrap">
          <div class="st_wrap">
            <label class="col-md-2 col-form-label st_title">상세검색</label>
          </div>
          <div class="card-body">
            <div class="table-responsive">
           	   <input type="hidden" name="search_type" id="search_type_temp" />
           	   <input type="hidden" name="search_type2_temp" id="search_type2_temp" />
           	   <input type="hidden" name="search_type3_temp" id="search_type3_temp" />
           	   <input type="hidden" name="detail_search_word1" id="detail_search_word1_temp" />
           	   <input type="hidden" name="detail_search_word2" id="detail_search_word2_temp" />
           	   <input type="hidden" name="detail_search_word3" id="detail_search_word3_temp" />
           	   <input type="hidden" name="searchOperator1" id="searchOperator1_temp" />
           	   <input type="hidden" name="searchOperator2" id="searchOperator2_temp" />
           	   <input type="hidden" name="search_range" id="search_range_temp" />
 			   <input type="hidden" name="start_item_no" id="start_item_no_temp" />
               <input type="hidden" name="end_item_no" id="end_item_no_temp" />
               <input type="hidden" name="country" id="country_temp"/>
               <input type="hidden" name="material1" id="material1_temp"/>
               
               <form id="metaDataDetailSearchListForm" name="metaDataDetailSearchListForm" method="post" class="form-horizontal">            	
	              <table class="table mb-0">
	                <tbody>
	                  <tr id="keyword1">
	                    <td>검색어</td>
	                    <td>
	                      <select class="form-select st_select img-select" name="search_type" id="search_type">
	                        <option value="" selected>전체</option>
	                        <option value="item_nm">명칭</option>
	                        <option value="item_se_nm">이명칭</option>
	                        <option value="item_eng_nm">영문명칭</option>
	                        <option value="keyword">키워드</option>
	                      </select>
	                    </td>
	                    <td>
	                      <input type="text" name="detail_search_word1" id="detail_search_word1" />
	                    </td>
	                    <td>
	                      <select class="form-select st_select img-select" id="searchOperator1" name="pSrchfAndOr1">
	                        <option value="" selected aria-label="복수검색">복수검색</option>
	                        <option value="AND" aria-label="AND">AND</option>
	                        <option value="OR" aria-label="OR">OR</option>
	                      </select>
	                    </td>
	                  </tr>
	                  <tr id="keyword2" style="display:none;">
	                    <td>검색어</td>
	                    <td>
	                      <select class="form-select st_select img-select" name="search_type2" id="search_type2">
	                        <option value="" selected>전체</option>
	                        <option value="item_nm">명칭</option>
	                        <option value="item_se_nm">이명칭</option>
	                        <option value="item_eng_nm">영문명칭</option>
	                        <option value="keyword">키워드</option>
	                      </select>
	                    </td>
	                    <td>
	                      <input type="text" name="detail_search_word2" id="detail_search_word2" />
	                    </td>
	                    <td>
	                      <select class="form-select st_select img-select" id="searchOperator2" name="pSrchAndOr2">
	                        <option value="" selected aria-label="복수검색">복수검색</option>
	                        <option value="AND" aria-label="AND">AND</option>
	                        <option value="OR" aria-label="OR">OR</option>
	                      </select>
	                    </td>
	                  </tr>
	                  <tr id="keyword3" style="display:none;">
	                    <td>검색어</td>
	                    <td>
	                      <select class="form-select st_select img-select" name="search_type3" id="search_type3">
	                        <option value="" selected>전체</option>
	                        <option value="item_nm">명칭</option>
	                        <option value="item_se_nm">이명칭</option>
	                        <option value="item_eng_nm">영문명칭</option>
	                        <option value="keyword">키워드</option>
	                      </select>
	                    </td>
	                    <td>
	                      <input type="text" name="detail_search_word3" id="detail_search_word3" />
	                    </td>
	                    <td>
	                    </td>
	                  </tr>
	                  <tr>
	                    <td>검색 범위</td>
	                    <td>
	                      <select class="form-select st_select img-select" name="search_range" id="search_range">
	                        <option value="" selected>전체</option>
	                        <c:forEach var="possesionList" items="${possesionList}">
	                        	<option value="${possesionList.possession_code_idx }">${possesionList.possession_nm }</option>
	                        </c:forEach>
	                      </select>
	                    </td>
	                    <td>자료번호</td>
	                    <td><input type="text" name="start_item_no" id="start_item_no" /><input type="text" name="end_item_no" id="end_item_no" /></td>
	                  </tr>
	                  <tr>
	                    <td colspan="4">검색옵션</td>
	                  </tr>
	                  <tr>
	                    <td colspan="2">
	                    	<input type="checkbox" name="country" id="country" />국적
	                    </td>
	                    <td>
	                    	<c:forEach var="countryList" items="${countryList}">
	                      		<input type="checkbox" class="country" name="country" id="country_code_idx" value="${countryList.country_code_idx}"/>${countryList.country_nm}
	                    	</c:forEach>
	                    </td>
	                  </tr>
	                  <tr>
	                    <td colspan="2">
	                    	<input type="checkbox" name="material1" id="material1" />재질
	                    </td>
	                    <td>
	                    	<c:forEach var="material1List" items="${material1List}">
	                      		<input type="checkbox" class="material1" name="material1" id="material1_code_idx" value="${material1List.material1_code_idx}" />${material1List.material1_nm}
	                 		</c:forEach>
	                    </td>
	                  </tr>
	                </tbody>
	              </table>
	              <input type="reset" class=""></button>
                  <button type="button" onClick="metaDataDetailSearchList();">검색</button>
              	</form>      
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!--  -->
            <div class="tab-pane" id="messages" role="tabpanel" style="display:block;">
              <!-- 리스트 출력~ 분류별 검색 입력 창 -->
              <form id="metaDataSearchImageListForm" name="metaDataSearchImageListForm" method="post" class="form-horizontal">
	              <div class="st_wrap st_mv_wrap search_input_wrap">
	                <div class="search_left">
		                  리스트 출력
		                  <select class="form-select" id="perPageNum" name="perPageNum">
		                      <option value="10">10</option>
		                      <option value="15">15</option>
		                      <option value="20">20</option>
		                  </select>
		                  결과내 재검색 <input type="checkbox" id="research_word" name="research_word"/>
		                  <input type="hidden" id="researched_word" name="researched_word"/>
		                  <input class="form-control" list="datalistOptions" placeholder="검색어를 입력해 주세요." id="search_word" name="search_word" />
		                  <input type="hidden" id="searched_word" name="searched_word"/>
		                  <button type="button" onClick="metaDataSearchImageList();">검색</button>
		                  <button type="button" data-bs-toggle="modal" data-bs-target="#TagModal-1">상세검색</button>
	<!--                 </div> -->
	<!--                 <div class="search_right"> -->
	<!--                   <select class="form-select"> -->
	<!--                     <option disabled="" selected="">자료 전체</option> -->
	<!--                     <option>더미1</option> -->
	<!--                     <option>더미2</option> -->
	<!--                     <option>더미3</option> -->
	<!--                   </select> -->
	<!--                   <select class="form-select"> -->
	<!--                     <option disabled="" selected="">정렬</option> -->
	<!--                     <option>더미1</option> -->
	<!--                     <option>더미2</option> -->
	<!--                     <option>더미3</option> -->
	<!--                   </select> -->
	<!--                   <button>분류별검색</button> -->
	                </div>
            	  </div>	
              </form>
              <!--  -->
              <div class="search_btn_wrap">
                <div class="search_btn_left">
                  <button>전체선택</button><button>선택해지</button>
                  <button>항목 추가 및 삭제</button>
                </div>
                <div class="search_btn_right"><button>사용자 지정양식 인쇄</button><button>목록 인쇄</button></div>
              </div>
              <!-- 관심사료 모달창 -->
              <div id="Like2Modal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" style="display: none" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                      <p>선택 자료를 관심자료 등록 하시겠습니까?</p>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-primary waves-effect waves-light">확인</button>
                      <button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal">취소</button>
                    </div>
                  </div>
                </div>
              </div>
              <!--  -->
              <div class="mb-0">
                <!--  -->
<!--                 <div class="st_wrap st_mv_wrap"> -->
<!--                    -->
<!--                   <div class="img-btn"> -->
<!--                     리스트 출력 갯수 : -->
<!--                     <select class="form-select st_select img-select"> -->
<!--                       <option disabled="" selected="">선택</option> -->
<!--                       <option>더미1</option> -->
<!--                       <option>더미2</option> -->
<!--                       <option>더미3</option> -->
<!--                     </select> -->
<!--                     <button>업로드</button> -->
<!--                     <button>다운로드</button> -->
<!--                     <button>전체선택</button> -->
<!--                     <button>선택해지</button> -->
<!--                     <button>선택삭제</button> -->
<!--                     <button>엑셀파일</button> -->
<!--                   </div> -->
<!--                 </div> -->
                <!--  -->
                <div class="tab-content" id="pills-tabContent">
                                          <!-- 이미지 설명 등록모달  -->
                          <div
                            class="modal fade bs-example-modal-xll"
                            tabindex="-1"
                            aria-labelledby="myExtraLargeModalLabel"
                            style="display: none"
                            aria-hidden="true"
                          >
                            <div class="modal-dialog modal-xl">
                              <div class="modal-content pro-modal-content">
                                <div class="modal-header mv-modal-header">
                                  <!-- <h5 class="modal-title" id="myModalLabel">Default Modal</h5> -->
                                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body mv-modal-body">
                                  <!-- 이미지 설명 모달 내용 -->
                                  <div class="mb-0 move-wrap pro-wrap">
                                    <div class="st_wrap">
                                      <label class="col-md-2 col-form-label st_title">이미지 설명 등록 및 수정</label>
                                    </div>
                                    <div class="card-body">
                                      <input type="text" />
                                    </div>
                                  </div>
                                  <button class="btn btn-secondary btn_save">저장</button>
                                </div>
                              </div>
                            </div>
                          </div>
                          <!--  -->
                   <!--  -->
                  <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
                    <table class="table mb-0">
                      <thead>
                        <tr class="tr_bgc">
                          <th>선택</th>
                          <th>번호</th>
                          <th>이미지명</th>
                          <th>파일정보</th>
                          <th>파일경로</th>
                          <th>대표이미지</th>
                          <th>대국민서비스</th>
                          <th>기능</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td><input type="checkbox" /></td>
                          <td>1</td>
                          <td>이미지명</td>
                          <td>000x000</td>
                          <td>파일경로</td>
                          <td>
                            <input type="checkbox" />
                          </td>
                          <td>
                            <input type="checkbox" />
                          </td>
                          <td>
                            <button>원본보기</button>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                  <!--  -->
                  <div class="tab-pane fade active show" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
                    <div class="container text-center">
                      <div class="row row-cols-auto img-row">
                        
                        <c:forEach var="metaDataSearchImageList" items="${metaDataSearchImageList}">
	                        <div class="col img-col">
	                          <div class="img-col-header">
	                             <input type="checkbox" name="group_seqList" class="check_temp" name="" id="" value="${metaDataSearchImageList.image_idx}">
	                            ${metaDataSearchImageList.image_nm}
	                          </div>
	                          <div class="img-col-img-wrap">
	                            <a href="#">
	                              <div class="img-hover-info">
	                                <h4>이미지 설명</h4>
	                                <p>설명없음</p>
	                              </div>
	                              <img src="${metaDataSearchImageList.image_path}" alt="이미지" />
	                            </a>
	                          </div>
	                          <div class="img-col-info">
	                            <dl onclick="imageQuickView('${metaDataSearchImageList.image_idx}');">
	                              <dt>명칭:</dt>
	                              <dd>${metaDataSearchImageList.item_nm}</dd>
	                            </dl>
	                            <dl>
	                              <dt>시간:</dt>
	                              <dd>${metaDataSearchImageList.reg_date}</dd>
	                            </dl>
	                            <dl>
	                              <dt>사이즈:</dt>
	                              <dd>${metaDataSearchImageList.image_width}×${metaDataSearchImageList.image_height}</dd>
	                            </dl>
	                            <dl>
	                              <dt>태그:</dt>
	                              <dd>
	                                <button class="img-tag"><a href="#">${metaDataSearchImageList.tag_nm}</a></button>
	                              </dd>
	                            </dl>
	                            <dl>
	                              <dt><input type="checkbox" name="" id="" /></dt>
	                              <dd>대표</dd>
	                              <dt><input type="checkbox" name="" id="" /></dt>
	                              <dd>대국민 서비스</dd>
	                            </dl>
	                            <dl>
	                              <button class="img-info_btn" data-bs-toggle="modal" data-bs-target=".bs-example-modal-xll">설명등록</button>
	                              <button class="img-info_btn">원문보기</button>
	                            </dl>
	                          </div>
	                        </div>
	                        <!--  -->
						</c:forEach>
                      </div>
                    </div>
                  </div>

                </div>
              </div>
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
              <!-- 숫자 버튼  -->
<!--               <nav aria-label="Page navigation example"> -->
<!--                 <ul class="pagination"> -->
<!--                   <li class="page-item"> -->
<!--                     <a class="page-link" href="#" aria-label="Previous"> -->
<!--                       <i class="mdi mdi-chevron-left"></i> -->
<!--                     </a> -->
<!--                   </li> -->
<!--                   <li class="page-item"><a class="page-link" href="#">1</a></li> -->
<!--                   <li class="page-item"><a class="page-link" href="#">2</a></li> -->
<!--                   <li class="page-item"><a class="page-link" href="#">3</a></li> -->
<!--                   <li class="page-item"> -->
<!--                     <a class="page-link" href="#" aria-label="Next"> -->
<!--                       <i class="mdi mdi-chevron-right"></i> -->
<!--                     </a> -->
<!--                   </li> -->
<!--                 </ul> -->
<!--               </nav> -->
              <!-- 그룹 수정 모달 -->
              <div id="GroupModal-2" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" style="display: none" aria-hidden="true">
                <div class="modal-dialog user-modal">
                  <div class="modal-content">
                    <div class="modal-header mv-modal-header">
                      <!-- <h5 class="modal-title" id="myModalLabel">Default Modal</h5> -->
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body mv-modal-body">
                      <!-- 그룹 수정 모달 내용 -->
                      <div class="mb-0 user-wrap">
                        <div class="st_wrap">
                          <label class="col-md-2 col-form-label st_title">그룹 수정</label>
                        </div>
                        <div class="card-body">
                          <div class="table-responsive">
                            <table class="table mb-0">
                              <tbody>
                                <tr>
                                  <td>그룹명</td>
                                  <td>
                                    <input type="text" />
                                  </td>
                                </tr>
                                <tr>
                                  <td>비고</td>
                                  <td>
                                    <input type="text" />
                                  </td>
                                </tr>
                                <tr>
                                  <td>관리자 여부</td>
                                  <td><input type="checkbox" />관리자 <input type="checkbox" />일반</td>
                                </tr>
                              </tbody>
                            </table>
                            <button class="btn btn-secondary btn_save">저장</button>
                          </div>
                        </div>
                      </div>
                      <!--  -->
                    </div>
                  </div>
                </div>
              </div>
              <!--  -->
            </div>
          </div>
          <!--  -->
          <script type="text/javascript">
	          var totalQty = 0;
	          var currentQty = 0;
	          <c:forEach var="metaDataSearchList2" items="${metaDataSearchImageList2}" varStatus="varStatus">
	          	<c:if test="${!empty metaDataSearchList2.qty}"> 
	          		totalQty += ${metaDataSearchList2.qty};
	          	</c:if>
	          	<c:if test="${!empty metaDataSearchList2.current_qty}"> 
	          	 	currentQty += ${metaDataSearchList2.current_qty};
	          	</c:if>
	          </c:forEach>
	          $('#totalNum').html("| 총건수 : "+${perPageNum});
			  $('#totalQty').html("| 총수량 : "+totalQty);
			  $('#currentQty').html("| 현수량 : "+currentQty+" |");
			
	            <%-- 페이지 이동 --%>
	    		function goPage(value) {
	    			var perPageNum = $('#perPageNum').val();
	    			var search_word = $('#search_word').val();
	    			var page = value;
	    			var research_word;
	    			var searched_word;
	    			if($('#researched_word').val() == 'checked'){
	    				research_word = 'on';
	    				searched_word = $('#searched_word').val();
	    				researched_word = $('#researched_word').val(); 
	    			}
	    			/* 상세검색 */
	    			var search_type = $('#search_type_temp').val();
	    			var search_type2 = $('#search_type2_temp').val();
	    			var search_type3 = $('#search_type3_temp').val();
	    			var detail_search_word1 = $('#detail_search_word1_temp').val();
	    			var detail_search_word2 = $('#detail_search_word2_temp').val();
	    			var detail_search_word3 = $('#detail_search_word3_temp').val();
	    			var searchOperator1 = $('#searchOperator1_temp').val();
	    			var searchOperator2 = $('#searchOperator2_temp').val();
	    			var search_range = $('#search_range_temp').val();
	    			var start_item_no = $('#start_item_no_temp').val();
	    			var end_item_no = $('#end_item_no_temp').val();
	    			var country = [];
	    			var material1 = [];
	    			
	    			if($('#country_temp').val() != ''){
	    				 country = $('#country_temp').val();
	    			}
	       			if($('#material1_temp').val() != ''){
		       			 material1 = $('#material1_temp').val();
		   			}
	    			$.ajax({
	    				type : 'POST',                 
	    				url : '/metaDataSearchImageListAjax.do',   
	    				data:{
	    					perPageNum : perPageNum,
							searched_word : searched_word,
							research_word : research_word,
	    					search_word : search_word,
	   						search_type : search_type,
	   						search_type2 : search_type2,
	   						search_type3 : search_type3,
	   						detail_search_word1 : detail_search_word1,
	   						detail_search_word2 : detail_search_word2,
	   						detail_search_word3 : detail_search_word3,
	   						pSrchfAndOr1 : searchOperator1,
	   						pSrchfAndOr2 : searchOperator2,
	   						search_range : search_range,	
	   						start_item_no : start_item_no,
	   						end_item_no : end_item_no,
	   						country : country,
	   						material1 : material1,
	    					page : page
	    				},
	    				dataType : "html",           
	    				contentType : "application/x-www-form-urlencoded;charset=UTF-8",
	    				error : function() {        
	    					alert('통신실패!');
	    				},
	    				success : function(data) {  
	    					$('#tab-content').empty().append(data);
							$('#perPageNum').val(perPageNum);
							$('#searched_word').val(searched_word);
							$('#search_word').val(search_word);
							$('#researched_word').val(researched_word);
							$('#search_type_temp').val(search_type);
							$('#search_type2_temp').val(search_type2);
							$('#search_type3_temp').val(search_type3);
							$('#detail_search_word1_temp').val(detail_search_word1);
							$('#detail_search_word2_temp').val(detail_search_word2);
							$('#detail_search_word3_temp').val(detail_search_word3);
							$('#searchOperator1_temp').val(searchOperator1);
							$('#searchOperator2_temp').val(searchOperator2);
							$('#search_range_temp').val(search_range);
							$('#start_item_no_temp').val(start_item_no);
							$('#end_item_no_temp').val(end_item_no);
							$('#country_temp').val(country);
							$('#material1_temp').val(material1);
	    				}
	    			});
	    		}
	    		
	    		<%-- 조건 검색 --%>
	    		function metaDataSearchImageList(){
	    			var perPageNum = $('#perPageNum').val();
	    			var search_word = $('#search_word').val();
	    			var prevsearched_word;
					 
			        if($("#research_word").is(":checked")){
			        	researched_word = 'checked';
			        	prevsearched_word = $('#searched_word').val();
			        	prevsearch_word = $('#search_word').val();
			        }else{
			        	researched_word = '';
			        }		     
	    				    			
	    			// 태그 조건 검색			
	    			var queryString = $("form[name=metaDataSearchImageListForm]").serialize();

	    				$.ajax({
	    					type : 'post',
	    					url : '/metaDataSearchImageListAjax.do',
	    					data : queryString,
	    					dataType : 'html',
	    					contentType : "application/x-www-form-urlencoded;charset=UTF-8",
	    					error: function(xhr, status, error){
	    						alert(error);
	    					},
	    					success : function(data){
	    						$('#tab-content').empty().append(data);
	    						$('#perPageNum').val(perPageNum);
	    						
	    						$('#search_word').val(search_word);
	    						if(researched_word != 'checked'){					
	    							$('#searched_word').val(search_word);
	    						}else{
	    							$('#searched_word').val(prevsearched_word);
	    							$('#search_word').val(prevsearch_word);
	    						}
	    						$('#simple_view_wrap').empty();  
	    						$('#researched_word').val(researched_word);
	    					}
	    				});
	    		}
	    		
	    		<%-- 상세 검색 --%>
	    		function metaDataDetailSearchList(){
					var search_type = $('#search_type').val();
					var search_type2 = $('#search_type2').val();
					var search_type3 = $('#search_type3').val();
	    			var detail_search_word1 = $('#detail_search_word1').val();
	    			var detail_search_word2 = $('#detail_search_word2').val();
	    			var detail_search_word3 = $('#detail_search_word3').val();
	    			var searchOperator1 = $('#searchOperator1').val();
	    			var searchOperator2 = $('#searchOperator2').val();
	    			var search_range = $('#search_range').val();
	    			var start_item_no = $('#start_item_no').val();
	    			var end_item_no = $('#end_item_no').val();
	    			var country = [];
	    			var material1 = [];
	    			$('.country:checked').each(function(i){
	    				country.push($(this).val());
	    			});
	    			$('.material1:checked').each(function(i){
	    				material1.push($(this).val());
	    			});
	    			
	    				$.ajax({
	    					type : 'post',
	    					url : '/metaDataSearchImageListAjax.do',
	        				data:{
	       						search_type : search_type,
	       						search_type2 : search_type2,
	       						search_type3 : search_type3,
	       						detail_search_word1 : detail_search_word1,
	       						detail_search_word2 : detail_search_word2,
	       						detail_search_word3 : detail_search_word3,
	       						pSrchfAndOr1 : searchOperator1,
	       						pSrchfAndOr2 : searchOperator2,
	       						search_range : search_range,	
	       						start_item_no : start_item_no,
	       						end_item_no : end_item_no,
	       						country : country,
	       						material1 : material1
	        				},
	    					dataType : 'html',
	    					contentType : "application/x-www-form-urlencoded;charset=UTF-8",
	    					error: function(xhr, status, error){
	    						alert(error);
	    					},
	    					success : function(data){   						
	    						$('#metaDataDetailSearchListCloseBtn').click();
	    						$('#tab-content').empty().append(data);
	    						$('#simple_view_wrap').empty();   	
	    						$('#search_type_temp').val(search_type);
	    						$('#search_type2_temp').val(search_type2);
	    						$('#search_type3_temp').val(search_type3);
	    						$('#detail_search_word1_temp').val(detail_search_word1);
	    						$('#detail_search_word2_temp').val(detail_search_word2);
	    						$('#detail_search_word3_temp').val(detail_search_word3);
	    						$('#searchOperator1_temp').val(searchOperator1);
	    						$('#searchOperator2_temp').val(searchOperator2);
	    						$('#search_range_temp').val(search_range);
	    						$('#start_item_no_temp').val(start_item_no);
	    						$('#end_item_no_temp').val(end_item_no);
	    						$('#country_temp').val(country);
	    						$('#material1_temp').val(material1);
	    					}
	    				});
	    		}
	    		function metaDataSearchListExcelList() {
	    				var $form = $('#metaDataSearchListForm');

	    				$form.attr("action", "/metaDataSearchListExcelDownload.do");
	    				$form.submit();
	    		}
	    		 
	 			$('#searchOperator1').on("change", function(){
					$('#keyword2').css("display", "flex");
					
				})
				$('#searchOperator2').on("change", function(){
					$('#keyword3').css("display", "flex");
				})
    		</script>