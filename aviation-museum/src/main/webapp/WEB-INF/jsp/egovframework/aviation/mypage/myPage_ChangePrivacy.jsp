<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
  <!-- 개인정보 변경 탭 -->
            <div class="tab-pane" id="settings" role="tabpanel" style="display:block;">
              <div class="mb-0">
              	<form action="/userConfirmAjax.do" method="post" name="userConfirmForm">  
              		<input type="hidden" name="member_id" value="${sessionScope.userSessionId}">
	                <div class="id_check_wrap">
	                  <div class="id_check_main_text">계정확인</div>
	                  <div class="id_check_text_wrap">			             
		                    <dl>
		                      <dt>사용자ID</dt>
		                      <dd>${sessionScope.userSessionId}</dd>
		                    </dl>
		                    <dl>
		                      <dt>사용자명</dt>
		                      <dd>${sessionScope.userSessionNm}</dd>
		                    </dl>
		                    <dl>
		                      <dt>계정 등록일</dt>
		                      <dd>${sessionScope.userSessionRegDate}</dd>
		                    </dl>
		                    <dl>
		                      <dt>비밀번호<span>*</span></dt>
		                      <dd><input type="password" placeholder="비밀번호 입력" name="member_pw" id="member_pw"></dd>
		                    </dl>
	                  </div>
	                  <button type="button" id="userConfirmBtn">저장</button>
	                </div>
                 </form>             
            </div>
          </div>
          <script>
	
	          $('input[type="password"]').keydown(function() {
	          	  if (event.keyCode === 13) {
	          	    event.preventDefault();
	          	  };
	          });
          </script>