<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
    
            <!-- 분류체계코드 탭-->
            <div class="tab-pane" id="code-tap-2" role="tabpane" style="display:block;">
              <div class="user_control_wrap mb-0">
                <!-- 왼쪽 -->
                <div class="user_control_letf col-xl-6">
                  <div class="user_control_card_wrap card">
                    <div class="table-responsive">
                      <table class="table mb-0">
                        <thead>
                          <tr class="tr_bgc">
                            <th colspan="8">ICAO</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr class="setting_thead">
                            <th>명칭</th>
                            <th>코드</th>
                            <th>순서</th>
                            <th>수정일</th>
                            <th>수정자</th>
                            <th>사용여부</th>
                            <th>수정</th>
                            <th>순서</th>
                          </tr>
 						  <c:forEach var="icaoList" items="${icaoList }" varStatus="varStatus">  
	                          <tr>
	                            <td>${icaoList.icao_nm}</td>
	                            <td>${icaoList.icao_code}</td>
	                            <td>${icaoList.seq}</td>
	                            <td>${icaoList.mod_date}</td>
	                            <td>${icaoList.mod_user}</td>
	                            <td><button class="custom_btn btn_preferences_user_enabled">${icaoList.enabled}</button></td>
	                            <td><button class="custom_btn btn_edit" type="button" data-bs-toggle="modal" data-bs-target="#code_modify_modal-1" onclick="modFormBtn('icao', '${icaoList.icao_code_idx}', '${icaoList.icao_nm}', '${icaoList.enabled}')">수정</button></td>
	                            <td>
	                            	<c:choose>
			                            <c:when test="${varStatus.first}">  
			                             	<button class="custom_btn btn_arrow" type="button" onClick="updateSeq(0,${icaoList.seq},'up','icao')">▲</button>
		                            	</c:when>
		                            	<c:otherwise>
		                            		<button class="custom_btn btn_arrow" type="button" onClick="updateSeq(${icaoList.icao_code_idx},${icaoList.seq},'up','icao')">▲</button>
		                            	</c:otherwise>
	                            	</c:choose>
		                              
		                            <c:choose>
			                            <c:when test="${varStatus.last}">  
			                              <button class="custom_btn btn_arrow" type="button" onClick="updateSeq(0,${icaoList.seq},'down','icao')">▼</button>
		                            	</c:when>
		                            	<c:otherwise>
		                            		<button class="custom_btn btn_arrow" type="button" onClick="updateSeq(${icaoList.icao_code_idx},${icaoList.seq},'down','icao')">▼</button>
		                            	</c:otherwise>
	                            	</c:choose>
	                            </td>
	                          </tr>
	                       </c:forEach>   
                        </tbody>
                      </table>
                    </div>
                  </div>
                  <button class="custom_btn btn_code_upload" data-bs-toggle="modal" data-bs-target="#code_insert_modal-1" onclick="insFormBtn('icao')">코드등록</button>
                </div>
                <!-- 오른쪽 -->
                <div class="user_control_right col-xl-6">
                  <div class="user_control_card_wrap card">
                    <div class="table-responsive">
                      <table class="table mb-0">
                        <thead>
                          <tr class="tr_bgc">
                            <th colspan="8">대분류</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr class="setting_thead">
                            <th>명칭</th>
                            <th>코드</th>
                            <th>순서</th>
                            <th>수정일</th>
                            <th>수정자</th>
                            <th>사용여부</th>
                            <th>수정</th>
                            <th>순서</th>
                          </tr>
 						  <c:forEach var="class1List" items="${class1List }" varStatus="varStatus">  
	                          <tr>
	                            <td>${class1List.class1_nm}</td>
	                            <td>${class1List.class1_code}</td>
	                            <td>${class1List.seq}</td>
	                            <td>${class1List.mod_date}</td>
	                            <td>${class1List.mod_user}</td>
	                            <td><button class="custom_btn btn_preferences_user_enabled">${class1List.enabled}</button></td>
	                            <td><button class="custom_btn btn_edit" type="button" data-bs-toggle="modal" data-bs-target="#code_modify_modal-1" onclick="modFormBtn('class1', '${class1List.class1_code_idx}', '${class1List.class1_nm}', '${class1List.enabled}')">수정</button></td>
	                            <td>
	                            	<c:choose>
			                            <c:when test="${varStatus.first}">  
			                             	<button class="custom_btn btn_arrow" type="button" onClick="updateSeq(0,${class1List.seq},'up','class1')">▲</button>
		                            	</c:when>
		                            	<c:otherwise>
		                            		<button class="custom_btn btn_arrow" type="button" onClick="updateSeq(${class1List.class1_code_idx},${class1List.seq},'up','class1')">▲</button>
		                            	</c:otherwise>
	                            	</c:choose>
		                              
		                            <c:choose>
			                            <c:when test="${varStatus.last}">  
			                              <button class="custom_btn btn_arrow" type="button" onClick="updateSeq(0,${class1List.seq},'down','class1')">▼</button>
		                            	</c:when>
		                            	<c:otherwise>
		                            		<button class="custom_btn btn_arrow" type="button" onClick="updateSeq(${class1List.class1_code_idx},${class1List.seq},'down','class1')">▼</button>
		                            	</c:otherwise>
	                            	</c:choose>
	                            </td>
	                          </tr>
	                       </c:forEach>                     
                        </tbody>
                      </table>
                    </div>
                  </div>
                  <button class="custom_btn btn_code_upload" data-bs-toggle="modal" data-bs-target="#code_insert_modal-1" onclick="insFormBtn('class1')">코드등록</button>
                </div>
              </div>
              <!--  -->
              <div class="user_control_wrap mb-0">
                <!-- 왼쪽 -->
                <div class="user_control_letf col-xl-6">
                  <div class="user_control_card_wrap card">
                    <div class="table-responsive">
                      <table class="table mb-0">
                        <thead>
                          <tr class="tr_bgc">
                            <th colspan="8">중분류</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr class="setting_thead">
                            <th>명칭</th>
                            <th>코드</th>
                            <th>순서</th>
                            <th>수정일</th>
                            <th>수정자</th>
                            <th>사용여부</th>
                            <th>수정</th>
                            <th>순서</th>
                          </tr>
 						  <c:forEach var="class2List" items="${class2List }" varStatus="varStatus">  
	                          <tr>
	                            <td>${class2List.class2_nm}</td>
	                            <td>${class2List.class2_code}</td>
	                            <td>${class2List.seq}</td>
	                            <td>${class2List.mod_date}</td>
	                            <td>${class2List.mod_user}</td>
	                            <td><button class="custom_btn btn_preferences_user_enabled">${class2List.enabled}</button></td>
	                            <td><button class="custom_btn btn_edit" type="button" data-bs-toggle="modal" data-bs-target="#code_modify_modal-1" onclick="modFormBtn('class2', '${class2List.class2_code_idx}', '${class2List.class2_nm}', '${class2List.enabled}')">수정</button></td>
	                            <td>
	                            	<c:choose>
			                            <c:when test="${varStatus.first}">  
			                             	<button class="custom_btn btn_arrow" type="button" onClick="updateSeq(0,${class2List.seq},'up','class2')">▲</button>
		                            	</c:when>
		                            	<c:otherwise>
		                            		<button class="custom_btn btn_arrow" type="button" onClick="updateSeq(${class2List.class2_code_idx},${class2List.seq},'up','class2')">▲</button>
		                            	</c:otherwise>
	                            	</c:choose>
		                              
		                            <c:choose>
			                            <c:when test="${varStatus.last}">  
			                              <button class="custom_btn btn_arrow" type="button" onClick="updateSeq(0,${class2List.seq},'down','class2')">▼</button>
		                            	</c:when>
		                            	<c:otherwise>
		                            		<button class="custom_btn btn_arrow" type="button" onClick="updateSeq(${class2List.class2_code_idx},${class2List.seq},'down','class2')">▼</button>
		                            	</c:otherwise>
	                            	</c:choose>
	                            </td>
	                          </tr>
	                       </c:forEach> 
                        </tbody>
                      </table>
                    </div>
                  </div>
                  <button class="custom_btn btn_code_upload" data-bs-toggle="modal" data-bs-target="#code_insert_modal-1" onclick="insFormBtn('class2')">코드등록</button>
                </div>
                <!-- 오른쪽 -->
                <div class="user_control_right col-xl-6">
                  <div class="user_control_card_wrap card">
                    <div class="table-responsive">
                      <table class="table mb-0">
                        <thead>
                          <tr class="tr_bgc">
                            <th colspan="8">소분류</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr class="setting_thead">
                            <th>명칭</th>
                            <th>코드</th>
                            <th>순서</th>
                            <th>수정일</th>
                            <th>수정자</th>
                            <th>사용여부</th>
                            <th>수정</th>
                            <th>순서</th>
                          </tr>
 						  <c:forEach var="class3List" items="${class3List }" varStatus="varStatus">  
	                          <tr>
	                            <td>${class3List.class3_nm}</td>
	                            <td>${class3List.class3_code}</td>
	                            <td>${class3List.seq}</td>
	                            <td>${class3List.mod_date}</td>
	                            <td>${class3List.mod_user}</td>
	                            <td><button class="custom_btn btn_preferences_user_enabled">${class3List.enabled}</button></td>
	                            <td><button class="custom_btn btn_edit" type="button" data-bs-toggle="modal" data-bs-target="#code_modify_modal-1" onclick="modFormBtn('class3', '${class3List.class3_code_idx}', '${class3List.class3_nm}', '${class3List.enabled}')">수정</button></td>
	                            <td>
	                            	<c:choose>
			                            <c:when test="${varStatus.first}">  
			                             	<button class="custom_btn btn_arrow" type="button" onClick="updateSeq(0,${class3List.seq},'up','class3')">▲</button>
		                            	</c:when>
		                            	<c:otherwise>
		                            		<button class="custom_btn btn_arrow" type="button" onClick="updateSeq(${class3List.class3_code_idx},${class3List.seq},'up','class3')">▲</button>
		                            	</c:otherwise>
	                            	</c:choose>
		                              
		                            <c:choose>
			                            <c:when test="${varStatus.last}">  
			                              <button class="custom_btn btn_arrow" type="button" onClick="updateSeq(0,${class3List.seq},'down','class3')">▼</button>
		                            	</c:when>
		                            	<c:otherwise>
		                            		<button class="custom_btn btn_arrow" type="button" onClick="updateSeq(${class3List.class3_code_idx},${class3List.seq},'down','class3')">▼</button>
		                            	</c:otherwise>
	                            	</c:choose>
	                            </td>
	                          </tr>
	                       </c:forEach> 
                        </tbody>
                      </table>
                    </div>
                  </div>
                  <button class="custom_btn btn_code_upload" data-bs-toggle="modal" data-bs-target="#code_insert_modal-1" onclick="insFormBtn('class3')">코드등록</button>
                </div>
              </div>
            </div>
            
            <!-- 코드등록 모달창 -->
            <div id="code_insert_modal-1" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" style="display: none" aria-hidden="true">
              <div class="modal-dialog user-modal">
                <div class="modal-content">
                  <div class="modal-header mv-modal-header">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="codeInsClose"></button>
                  </div>
                  <div class="modal-body mv-modal-body">
                    <div class="mb-0 user-wrap">
                      <div class="st_wrap">
                        <label class="col-md-2 col-form-label st_title">코드 등록</label>
                      </div>
                      <div class="card-body">
                        <div class="table-responsive">
	                        <form action="" method="post" name="codeInsForm">
	                        	<input type="hidden" name="" id="insType"/>
		                          <table class="table mb-0">
		                            <tbody>
		                              <tr>
		                                <td>코드</td>
		                                <td>
		                                  <input type="text" name="" id="insCode" oninput="codeInsInputChange();"/>
		                                  <button type="button" id="codeInsCheck" codeInsCheck="">중복체크</button>
		                                </td>
		                              </tr>
		                              <tr>
		                                <td>명칭</td>
		                                <td>
		                                  <input type="text" name="" id="insNm"/>
		                                </td>
		                              </tr>
		                              <tr>
		                                <td>사용여부</td>
		                                <td>
		                                	 <input type="checkbox" name="enabled" value="Y" id="insCodeEnabledY">사용
			                                 <input type="checkbox" name="enabled" value="N" id="insCodeEnabledN">미사용
			                            </td>
		                              </tr>
		                            </tbody>
		                          </table>
		                          <button class="btn btn-secondary btn_save" type="button" id="insBtn">저장</button>
	                      	</form>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
            <!-- 코드수정 모달창 -->
            <div id="code_modify_modal-1" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" style="display: none" aria-hidden="true">
              <div class="modal-dialog user-modal">
                <div class="modal-content">
                  <div class="modal-header mv-modal-header">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="codeModClose"></button>
                  </div>
                  <div class="modal-body mv-modal-body">
                    <div class="mb-0 user-wrap">
                      <div class="st_wrap">
                        <label class="col-md-2 col-form-label st_title">코드 수정</label>
                      </div>
                      <div class="card-body">
                        <div class="table-responsive">
                           <form action="" method="post" name="codeModForm">
                         	  <input type="hidden" name="" id="modType"/>
                        	  <input type="hidden" name="" id="modIdx"/>
	                          <table class="table mb-0">
	                            <tbody>
	                              <tr>
	                                <td>명칭</td>
	                                <td>
	                                  <input type="text" name="" id="modNm"/>
	                                </td>
	                              </tr>
	                              <tr>
	                                <td>사용여부</td>
	                                <td>
	                                	 <input type="checkbox" name="enabled" value="Y" id="modCodeEnabledY">사용
		                                 <input type="checkbox" name="enabled" value="N" id="modCodeEnabledN">미사용
	                                </td>
	                              </tr>
	                            </tbody>
	                          </table>
	                          <button class="btn btn-secondary btn_save" type="button" id="modBtn">저장</button>
                          </form>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <script>
				<%-- 코드 사용 여부 체크박스 단일선택 --%>
				$('input[type="checkbox"][name="enabled"]').click(function(){
					  if($(this).prop('checked')){
					 
					     $('input[type="checkbox"][name="enabled"]').prop('checked',false);
					 
					     $(this).prop('checked',true);
					 
					    }
					  
				});
	    		$('input[type="text"]').keydown(function() {
		  			  if (event.keyCode === 13) {
		  			    event.preventDefault();
		  			  };
	  			});
            </script>