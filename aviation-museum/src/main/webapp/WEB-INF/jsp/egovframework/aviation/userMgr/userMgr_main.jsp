<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>사용자&그룹 관리 | 국립항공박물관</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta content="Premium Multipurpose Admin & Dashboard Template" name="description" />
    <meta content="Themesbrand" name="author" />
    <!-- App favicon -->

    <!-- Bootstrap Css -->
    <link href="<c:url value='/assets/css/bootstrap.min.css'/>" id="bootstrap-style" rel="stylesheet" type="text/css" />
    <!-- Icons Css -->
    <link href="<c:url value='/assets/css/icons.min.css'/>" rel="stylesheet" type="text/css" />
    <!-- App Css-->
    <link href="<c:url value='/assets/css/app.min.css'/>" id="app-style" rel="stylesheet" type="text/css" />
    <!-- 커스텀 css -->
    <link href="<c:url value='/assets/css/custom.css'/>" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="<c:url value='/assets/css/custom_user.css'/>"/>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<script type="text/javascript">
	
		// 체크박스 전체선택 전체해제
		function agreeAllCheck(){
			var val = true;
	
			if(!$('#allCheck').is(":checked")){
				val = false;
			}
			
			var elems = document.getElementsByClassName("check_temp");
			for(var i=0; elems.length>i; i++){
				elems[i].checked = val;
			}
		}
		
		$(function() {
			// 첫 페이지
			$('#userMgr').attr('aria-selected', 'true').addClass('active');
			
			$.ajax({
				type : 'POST',                
				url : '/usermgr/userListAjax.do',    
				dataType : "html",           
				contentType : "application/x-www-form-urlencoded;charset=UTF-8",
				error : function() {          
					alert('통신실패!');
				},
				success : function(data) {  
					$('#tab-content').empty().append(data);
				}
			});
			
			// 사용자 관리 tab operation
			$('#userMgr').click(function() {
				$.ajax({
					type : 'POST',                
					url : '/usermgr/userListAjax.do',    
					dataType : "html",           
					contentType : "application/x-www-form-urlencoded;charset=UTF-8",
					error : function() {          
						alert('통신실패!');
					},
					success : function(data) {  
						$('#tab-content').empty().append(data);
					}
				});
			});
			
			// 그룹 관리 tab operation
			$('#groupMgr').click(function() {
				$.ajax({
					type : 'POST',                 
					url : '/groupListAjax.do',   				
					dataType : "html",           
					contentType : "application/x-www-form-urlencoded;charset=UTF-8",
					error : function() {        
						alert('통신실패!');
					},
					success : function(data) {  
						$('#tab-content').empty().append(data);
					}
				});
			});
			
		});
	
		// 사용자 등록
		$(document).on('click', '#userInsBtn', function(){

			var queryString = $("form[name=userinsertform]").serialize();
			var check_submit = confirm('사용자를 등록하시겠습니까?');

			if (userInsValidation()) {
				if(check_submit){
					$.ajax({
						type : 'post',
						url : '/userinsert.do',
						data : queryString,
						dataType : 'json',
						contentType : "application/x-www-form-urlencoded;charset=UTF-8",
						error: function(xhr, status, error){
							alert(error);
						},
						success : function(success){
							alert('사용자가 등록되었습니다.');
							
							$.ajax({
								type : 'POST',                 
								url : '/usermgr/userListAjax.do',   
								dataType : "html",           
								contentType : "application/x-www-form-urlencoded;charset=UTF-8",
								error : function() {        
									alert('통신실패!');
								},
								success : function(data) {  
									$('#tab-content').empty().append(data);
									$('body').attr('class','').attr('style','');
									$('.modal-backdrop').remove();
								}
							});
						}
					});
				}
			}
		});
	
		// 사용자 등록 중복체크 버튼
		function duplicateCheck() {				
				var insUserId = $('#insUserId').val();				
					
				if (!Boolean(insUserId)) {
					alert("사용자ID를 입력해주세요.");
					$("#insUserId").focus();
					return false;
				}
				var queryString = $("form[name=userinsertform]").serialize();
				
				$.ajax({
					type : 'POST',                 
					url : '/duplicateCheck.do',   
					data: queryString,
					dataType : "json",           
					contentType : "application/x-www-form-urlencoded;charset=UTF-8",
					error : function() {        
						alert('통신실패!');
					},
					success : function(data) {
						console.log(data);
						$.each(data, function(index, item) { // 데이터 =item
							if(item.result == "success"){								
								alert('존재하는 아이디입니다.');
							}else{
								alert('사용가능한 아이디입니다.');

							}
						});
					}
				});
		}
		
		// 사용자 수정 팝업 버튼
		function userModPopup(value) {
				var member_idx = value;
				$.ajax({
					type : 'POST',                 
					url : '/userModPopupAjax.do',   
					data:{
						member_idx : member_idx
					},
					dataType : "json",           
					contentType : "application/x-www-form-urlencoded;charset=UTF-8",
					error : function() {        
						alert('통신실패!');
					},
					success : function(data) {  
						console.log(data);
							
						$.each(data, function(index, item) { // 데이터 =item
							
							$('#modUserIdx').val(value);
							$('#modUserId').val(item.member_id);
							$('#modUserNm').val(item.member_nm);
							$('#modUserGroupidx').val(item.group_idx);
							$('#modUserRemark').val(item.remark);
							if(item.enabled == 'Y'){
								$('#modUserEnabledY').prop('checked',true);
								$('#modUserEnabledN').prop('checked',false);
							}else{
								$('#modUserEnabledN').prop('checked',true);
								$('#modUserEnabledY').prop('checked',false);
							}
						});
					}
				});
		}
		
		// 사용자 수정
		$(document).on('click', '#userModBtn', function(){

			var queryString = $("form[name=userupdateform]").serialize();
			var check_submit = confirm('사용자를 수정하시겠습니까?');

			if (userModValidation()) {
				if(check_submit){
					$.ajax({
						type : 'post',
						url : '/userupdate.do',
						data : queryString,
						dataType : 'json',
						contentType : "application/x-www-form-urlencoded;charset=UTF-8",
						error: function(xhr, status, error){
							alert(error);
						},
						success : function(success){
							alert('사용자가 수정되었습니다.');
							
							$.ajax({
								type : 'POST',                 
								url : '/usermgr/userListAjax.do',   
								dataType : "html",           
								contentType : "application/x-www-form-urlencoded;charset=UTF-8",
								error : function() {        
									alert('통신실패!');
								},
								success : function(data) {  
									$('#tab-content').empty().append(data);
									$('body').attr('class','').attr('style','');
									$('.modal-backdrop').remove();
								}
							});
						}
					});
				}
			}
		});
		
		// 사용자 선택 미사용
		$(document).on('click', '#userListEnabledBtn', function(){

			if(!$('input:checkbox[name="user_seqList"]').is(':checked')){
				alert("선택하신 사용자가 없습니다.");
				return false;
			}
			var user_seqList = [];
			
			$('.check_temp:checked').each(function(i){
				user_seqList.push($(this).val());
			});
			console.log(user_seqList);
			 
			var $this = $(this);
			var answer = confirm('선택하신 사용자를 미사용 처리하시겠습니까?');
			if(answer){
				$.ajax({
					type : 'POST',                 
					url : '/userListEnabled.do',   
					dataType : "json",         
					data:{
						user_seqList : user_seqList
					},
					contentType : "application/x-www-form-urlencoded;charset=UTF-8",
					error : function() {          
						alert('통신실패!');
					},
					success : function(success) {   
						alert("사용자가 미사용 처리되었습니다.");
						
						$.ajax({
							type : 'POST',                 
							url : '/usermgr/userListAjax.do',   
							dataType : "html",           
							contentType : "application/x-www-form-urlencoded;charset=UTF-8",
							error : function() {        
								alert('통신실패!');
							},
							success : function(data) {  
								$('#tab-content').empty().append(data);
								$('body').attr('class','').attr('style','');
								$('.modal-backdrop').remove();
							}
						});
					}
				});
			}
		});
		// 그룹 등록
		$(document).on('click', '#groupInsBtn', function(){

			var queryString = $("form[name=groupinsertform]").serialize();
			var check_submit = confirm('그룹을 등록하시겠습니까?');

			if (groupInsValidation()) {
				if(check_submit){
					$.ajax({
						type : 'post',
						url : '/groupinsert.do',
						data : queryString,
						dataType : 'json',
						contentType : "application/x-www-form-urlencoded;charset=UTF-8",
						error: function(xhr, status, error){
							alert(error);
						},
						success : function(success){
							alert('그룹이 등록되었습니다.');
							
							$.ajax({
								type : 'POST',                 
								url : '/groupListAjax.do',   
								dataType : "html",           
								contentType : "application/x-www-form-urlencoded;charset=UTF-8",
								error : function() {        
									alert('통신실패!');
								},
								success : function(data) {  
									$('#tab-content').empty().append(data);
									$('body').attr('class','').attr('style','');
									$('.modal-backdrop').remove();
								}
							});
						}
					});
				}
			}
		});
		
		// 그룹 삭제
		$(document).on('click', '#groupDelBtn', function(){

			if(!$('input:checkbox[name="group_seqList"]').is(':checked')){
				alert("선택하신 그룹이 없습니다.");
				return false;
			}
			var group_seqList = [];
			
			$('.check_temp:checked').each(function(i){
				group_seqList.push($(this).val());
			});
			console.log(group_seqList);
			 
			var $this = $(this);
			var answer = confirm('선택하신 그룹을 삭제하시겠습니까?');
			if(answer){
				$.ajax({
					type : 'POST',                 
					url : '/groupdelete.do',   
					dataType : "json",         
					data:{
						group_seqList : group_seqList
					},
					contentType : "application/x-www-form-urlencoded;charset=UTF-8",
					error : function() {          
						alert('통신실패!');
					},
					success : function(success) {   
						alert("그룹이 삭제되었습니다.");
						
						$.ajax({
							type : 'POST',                 
							url : '/groupListAjax.do',   
							dataType : "html",           
							contentType : "application/x-www-form-urlencoded;charset=UTF-8",
							error : function() {        
								alert('통신실패!');
							},
							success : function(data) {  
								$('#tab-content').empty().append(data);
							}
						});
					}
				});
			}
		});
		
		// 그룹 수정 팝업 버튼
		function groupModPopup(value) {
				var group_idx = value;
				$.ajax({
					type : 'POST',                 
					url : '/groupModPopupAjax.do',   
					data:{
						group_idx : group_idx
					},
					dataType : "json",           
					contentType : "application/x-www-form-urlencoded;charset=UTF-8",
					error : function() {        
						alert('통신실패!');
					},
					success : function(data) {  
						console.log(data);

						$.each(data, function(index, item) { // 데이터 =item
							console.log(item.group_idx);
							console.log(item.group_nm);
							console.log(item.remark);
							console.log(item.admin);
							
							$('#modGroupIdx').val(value);
							$('#modGroupNm').val(item.group_nm);
							$('#modGroupRemark').val(item.remark);
							
							if(item.admin == 'Y'){
								$('#modGroupY').prop('checked',true);
								$('#modGroupN').prop('checked',false);
							}else{
								$('#modGroupN').prop('checked',true);
								$('#modGroupY').prop('checked',false);
							}
						});
					}
				});
		}
		
		// 그룹 수정
		$(document).on('click', '#groupModBtn', function(){

			var queryString = $("form[name=groupupdateform]").serialize();
			var check_submit = confirm('그룹을 수정하시겠습니까?');

			if (groupModValidation()) {
				if(check_submit){
					$.ajax({
						type : 'post',
						url : '/groupupdate.do',
						data : queryString,
						dataType : 'json',
						contentType : "application/x-www-form-urlencoded;charset=UTF-8",
						error: function(xhr, status, error){
							alert(error);
						},
						success : function(success){
							alert('그룹이 수정되었습니다.');
							
							$.ajax({
								type : 'POST',                 
								url : '/groupListAjax.do',   
								dataType : "html",           
								contentType : "application/x-www-form-urlencoded;charset=UTF-8",
								error : function() {        
									alert('통신실패!');
								},
								success : function(data) {  
									$('#tab-content').empty().append(data);
									$('body').attr('class','').attr('style','');
									$('.modal-backdrop').remove();
								}
							});
						}
					});
				}
			}
		});
	</script>
</head>
<body data-sidebar="dark">
  <!-- <body data-layout="horizontal"> -->

    <!-- Begin page -->
    <div id="layout-wrapper">
      <header id="page-topbar" class="isvertical-topbar">
        <div class="navbar-header">
          <div class="d-flex">
            <!-- LOGO -->
            <div class="navbar-brand-box">
              <a href="index.html" class="logo logo-dark">
                <span class="logo-sm">
                  <img src="assets/images/logo-dark-sm.png" alt="" height="22" />
                </span>
                <span class="logo-lg">
                  <img src="assets/images/logo-dark-sm.png" alt="" height="22" />
                </span>
              </a>

              <a href="index.html" class="logo logo-light">
                <span class="logo-lg">
                  <img src="assets/images/logo-light.png" alt="" height="22" />
                </span>
                <span class="logo-sm">
                  <img src="assets/images/logo-light-sm.png" alt="" height="22" />
                </span>
              </a>
            </div>

            <button type="button" class="btn btn-sm px-3 font-size-16 header-item vertical-menu-btn topnav-hamburger">
              <span class="hamburger-icon open">
                <span></span>
                <span></span>
                <span></span>
              </span>
            </button>

            <div class="d-none d-sm-block ms-3 align-self-center">
              <!-- <h4 class="page-title">자료 신규등록</h4> -->
              <div class="dropdown">
                <button type="button" class="btn header-item" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  <i class="icon-sm" data-eva="search-outline"></i>
                </button>
                <div class="dropdown-menu dropdown-menu-end dropdown-menu-md p-0">
                  <form class="p-2">
                    <div class="search-box">
                      <div class="position-relative">
                        <input type="text" class="form-control bg-light border-0" placeholder="Search..." />
                        <i class="search-icon" data-eva="search-outline" data-eva-height="26" data-eva-width="26"></i>
                      </div>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>

          <div class="d-flex">
            <!-- <div class="dropdown">
              <button type="button" class="btn header-item" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="icon-sm" data-eva="search-outline"></i>
              </button>
              <div class="dropdown-menu dropdown-menu-end dropdown-menu-md p-0">
                <form class="p-2">
                  <div class="search-box">
                    <div class="position-relative">
                      <input type="text" class="form-control bg-light border-0" placeholder="Search..." />
                      <i class="search-icon" data-eva="search-outline" data-eva-height="26" data-eva-width="26"></i>
                    </div>
                  </div>
                </form>
              </div>
            </div> -->

            <div class="dropdown d-inline-block language-switch">
              <!-- <button type="button" class="btn header-item" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <img class="header-lang-img" src="assets/images/flags/us.jpg" alt="Header Language" height="16" />
              </button> -->
              <div class="dropdown-menu dropdown-menu-end">
                <!-- item-->
                <a href="javascript:void(0);" class="dropdown-item notify-item language" data-lang="eng">
                  <img src="assets/images/flags/us.jpg" alt="user-image" class="me-1" height="12" /> <span class="align-middle">English</span>
                </a>

                <!-- item-->
                <a href="javascript:void(0);" class="dropdown-item notify-item language" data-lang="sp">
                  <img src="assets/images/flags/spain.jpg" alt="user-image" class="me-1" height="12" /> <span class="align-middle">Spanish</span>
                </a>

                <!-- item-->
                <a href="javascript:void(0);" class="dropdown-item notify-item language" data-lang="gr">
                  <img src="assets/images/flags/germany.jpg" alt="user-image" class="me-1" height="12" /> <span class="align-middle">German</span>
                </a>

                <!-- item-->
                <a href="javascript:void(0);" class="dropdown-item notify-item language" data-lang="it">
                  <img src="assets/images/flags/italy.jpg" alt="user-image" class="me-1" height="12" /> <span class="align-middle">Italian</span>
                </a>

                <!-- item-->
                <a href="javascript:void(0);" class="dropdown-item notify-item language" data-lang="ru">
                  <img src="assets/images/flags/russia.jpg" alt="user-image" class="me-1" height="12" /> <span class="align-middle">Russian</span>
                </a>
              </div>
            </div>

            <div class="dropdown d-none d-lg-inline-block">
              <!-- <button type="button" class="btn header-item noti-icon" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="icon-sm" data-eva="grid-outline"></i>
              </button> -->
              <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end p-0">
                <div class="p-3">
                  <div class="row align-items-center">
                    <div class="col">
                      <h5 class="m-0 font-size-15">Web Apps</h5>
                    </div>
                    <div class="col-auto">
                      <a href="#!" class="small fw-semibold text-decoration-underline"> View All</a>
                    </div>
                  </div>
                </div>
                <div class="px-lg-2 pb-2">
                  <div class="row g-0">
                    <div class="col">
                      <a class="dropdown-icon-item" href="#!">
                        <img src="assets/images/brands/github.png" alt="Github" />
                        <span>GitHub</span>
                      </a>
                    </div>
                    <div class="col">
                      <a class="dropdown-icon-item" href="#!">
                        <img src="assets/images/brands/bitbucket.png" alt="bitbucket" />
                        <span>Bitbucket</span>
                      </a>
                    </div>
                    <div class="col">
                      <a class="dropdown-icon-item" href="#!">
                        <img src="assets/images/brands/dribbble.png" alt="dribbble" />
                        <span>Dribbble</span>
                      </a>
                    </div>
                  </div>

                  <div class="row g-0">
                    <div class="col">
                      <a class="dropdown-icon-item" href="#!">
                        <img src="assets/images/brands/dropbox.png" alt="dropbox" />
                        <span>Dropbox</span>
                      </a>
                    </div>
                    <div class="col">
                      <a class="dropdown-icon-item" href="#!">
                        <img src="assets/images/brands/mail_chimp.png" alt="mail_chimp" />
                        <span>Mail Chimp</span>
                      </a>
                    </div>
                    <div class="col">
                      <a class="dropdown-icon-item" href="#!">
                        <img src="assets/images/brands/slack.png" alt="slack" />
                        <span>Slack</span>
                      </a>
                    </div>
                  </div>
                </div>
              </div>
            </div>


            <div class="dropdown d-inline-block">
              <!-- <button
                type="button"
                class="btn header-item noti-icon"
                id="page-header-notifications-dropdown-v"
                data-bs-toggle="dropdown"
                aria-haspopup="true"
                aria-expanded="false"
              >
                <i class="icon-sm" data-eva="bell-outline"></i>
                <span class="noti-dot bg-danger rounded-pill">4</span>
              </button> -->
              <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end p-0" aria-labelledby="page-header-notifications-dropdown-v">
                <div class="p-3">
                  <div class="row align-items-center">
                    <div class="col">
                      <h5 class="m-0 font-size-15">Notifications</h5>
                    </div>
                    <div class="col-auto">
                      <a href="#!" class="small fw-semibold text-decoration-underline"> Mark all as read</a>
                    </div>
                  </div>
                </div>
                <div data-simplebar style="max-height: 250px">
                  <a href="#!" class="text-reset notification-item">
                    <div class="d-flex">
                      <div class="flex-shrink-0 me-3">
                        <img src="assets/images/users/avatar-3.jpg" class="rounded-circle avatar-sm" alt="user-pic" />
                      </div>
                      <div class="flex-grow-1">
                        <h6 class="mb-1">James Lemire</h6>
                        <div class="font-size-13 text-muted">
                          <p class="mb-1">It will seem like simplified English.</p>
                          <p class="mb-0"><i class="mdi mdi-clock-outline"></i> <span>1 hour ago</span></p>
                        </div>
                      </div>
                    </div>
                  </a>
                  <a href="#!" class="text-reset notification-item">
                    <div class="d-flex">
                      <div class="flex-shrink-0 avatar-sm me-3">
                        <span class="avatar-title bg-primary rounded-circle font-size-16">
                          <i class="bx bx-cart"></i>
                        </span>
                      </div>
                      <div class="flex-grow-1">
                        <h6 class="mb-1">Your order is placed</h6>
                        <div class="font-size-13 text-muted">
                          <p class="mb-1">If several languages coalesce the grammar</p>
                          <p class="mb-0"><i class="mdi mdi-clock-outline"></i> <span>3 min ago</span></p>
                        </div>
                      </div>
                    </div>
                  </a>
                  <a href="#!" class="text-reset notification-item">
                    <div class="d-flex">
                      <div class="flex-shrink-0 avatar-sm me-3">
                        <span class="avatar-title bg-success rounded-circle font-size-16">
                          <i class="bx bx-badge-check"></i>
                        </span>
                      </div>
                      <div class="flex-grow-1">
                        <h6 class="mb-1">Your item is shipped</h6>
                        <div class="font-size-13 text-muted">
                          <p class="mb-1">If several languages coalesce the grammar</p>
                          <p class="mb-0"><i class="mdi mdi-clock-outline"></i> <span>3 min ago</span></p>
                        </div>
                      </div>
                    </div>
                  </a>

                  <a href="#!" class="text-reset notification-item">
                    <div class="d-flex">
                      <div class="flex-shrink-0 me-3">
                        <img src="assets/images/users/avatar-6.jpg" class="rounded-circle avatar-sm" alt="user-pic" />
                      </div>
                      <div class="flex-grow-1">
                        <h6 class="mb-1">Salena Layfield</h6>
                        <div class="font-size-13 text-muted">
                          <p class="mb-1">As a skeptical Cambridge friend of mine occidental.</p>
                          <p class="mb-0"><i class="mdi mdi-clock-outline"></i> <span>1 hour ago</span></p>
                        </div>
                      </div>
                    </div>
                  </a>
                </div>
                <div class="p-2 border-top d-grid">
                  <a class="btn btn-sm btn-link font-size-14 btn-block text-center" href="javascript:void(0)">
                    <i class="uil-arrow-circle-right me-1"></i> <span>View More..</span>
                  </a>
                </div>
              </div>
            </div>

            <div class="dropdown d-inline-block">
              <button type="button" class="btn header-item noti-icon right-bar-toggle" id="right-bar-toggle-v">
                <i class="icon-sm" data-eva="settings-outline"></i>
              </button>
            </div>

            <div class="dropdown d-inline-block">
              <!-- <button
                type="button"
                class="btn header-item user text-start d-flex align-items-center"
                id="page-header-user-dropdown-v"
                data-bs-toggle="dropdown"
                aria-haspopup="true"
                aria-expanded="false"
              >
                <img class="rounded-circle header-profile-user" src="assets/images/users/avatar-1.jpg" alt="Header Avatar" />
              </button> -->
              <div class="dropdown-menu dropdown-menu-end pt-0">
                <div class="p-3 border-bottom">
                  <h6 class="mb-0">Jennifer Bennett</h6>
                  <p class="mb-0 font-size-11 text-muted">jennifer.bennett@email.com</p>
                </div>
                <a class="dropdown-item" href="contacts-profile.html"
                  ><i class="mdi mdi-account-circle text-muted font-size-16 align-middle me-1"></i> <span class="align-middle">Profile</span></a
                >
                <a class="dropdown-item" href="apps-chat.html"
                  ><i class="mdi mdi-message-text-outline text-muted font-size-16 align-middle me-1"></i> <span class="align-middle">Messages</span></a
                >
                <a class="dropdown-item" href="pages-faqs.html"
                  ><i class="mdi mdi-lifebuoy text-muted font-size-16 align-middle me-1"></i> <span class="align-middle">Help</span></a
                >
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#"
                  ><i class="mdi mdi-wallet text-muted font-size-16 align-middle me-1"></i> <span class="align-middle">Balance : <b>$6951.02</b></span></a>
                <a class="dropdown-item d-flex align-items-center" href="#"
                  ><i class="mdi mdi-cog-outline text-muted font-size-16 align-middle me-1"></i> <span class="align-middle">Settings</span
                  ><span class="badge badge-soft-success ms-auto">New</span></a
                >
                <a class="dropdown-item" href="auth-lock-screen.html"
                  ><i class="mdi mdi-lock text-muted font-size-16 align-middle me-1"></i> <span class="align-middle">Lock screen</span></a
                >
                <a class="dropdown-item" href="auth-logout.html"
                  ><i class="mdi mdi-logout text-muted font-size-16 align-middle me-1"></i> <span class="align-middle">Logout</span></a
                >
              </div>
            </div>
          </div>
        </div>
      </header>
      <!-- ========== Left Sidebar Start ========== -->
      <div class="main_left_menu vertical-menu">
        <!-- LOGO -->
        <div class="navbar-brand-box">
          <a href="index.html" class="logo logo-dark">
            <span class="logo-sm">
              <img src="assets/custom_img/intro-logo.png" alt="" height="22" />
            </span>
            <span class="logo-lg">
              <img src="assets/custom_img/intro-logo.png" alt="" height="22" />
            </span>
          </a>

          <a href="index.html" class="logo logo-light">
            <span class="logo-lg">
              <img src="assets/custom_img/intro-logo.png" alt="" height="22" />
            </span>
            <span class="logo-sm">
              <img src="assets/images/logo-light-sm.png" alt="" height="22" />
            </span>
          </a>
        </div>

        <!-- <button type="button" class="btn btn-sm px-3 header-item vertical-menu-btn topnav-hamburger">
          <span class="hamburger-icon">
            <span></span>
            <span></span>
            <span></span>
          </span>
        </button> -->

        <div data-simplebar class="sidebar-menu-scroll">
          <!--- Sidemenu -->
          <div class="left_menu" id="sidebar-menu">
            <!-- Left Menu Start -->
            <ul class="metismenu list-unstyled" id="side-menu">
              <li class="dash_text menu-title" data-key="t-menu">Dashboard</li>

              <li>
                <a href="javascript: void(0);">
                  <span class="menu-item" data-key="t-dashboards">자료 검색</span>
                  <span class="badge rounded-pill bg-primary"></span>
                </a>
                <ul class="sub-menu" aria-expanded="false">
                  <li><a href="index.html" data-key="t-ecommerce">자료 정보조회</a></li>
                  <li><a href="dashboard-saas.html" data-key="t-saas">자료 검색</a></li>
                  <li><a href="dashboard-crypto.html" data-key="t-crypto">My페이지</a></li>
                </ul>
              </li>

              <!-- <li class="menu-title" data-key="t-applications">Applications</li> -->

              <!-- <li>
                <a href="apps-calendar.html">
                  <i class="icon nav-icon" data-eva="calendar-outline"></i>
                  <span class="menu-item" data-key="t-calendar">Calendar</span>
                </a>
              </li> -->

              <!-- <li>
                <a href="apps-chat.html">
                  <i class="icon nav-icon" data-eva="message-circle-outline"></i>
                  <span class="menu-item" data-key="t-chat">Chat</span>
                  <span class="badge rounded-pill badge-soft-danger" data-key="t-hot">Hot</span>
                </a>
              </li>

              <li>
                <a href="apps-file-manager.html">
                  <i class="icon nav-icon" data-eva="archive-outline"></i>
                  <span class="menu-item" data-key="t-filemanager">File Manager</span>
                </a>
              </li> -->

              <li>
                <a href="javascript: void(0);" class="has-arrow">
                  <span class="menu-item" data-key="t-ecommerce">자료 통계</span>
                </a>
                <ul class="sub-menu" aria-expanded="false">
                  <li><a href="ecommerce-products.html" data-key="t-products">통계</a></li>
                  <li><a href="ecommerce-product-detail.html" data-key="t-product-detail">이미지 통계</a></li>
                  <li><a href="ecommerce-orders.html" data-key="t-orders">사용자 지정양식</a></li>
                  <li><a href="ecommerce-customers.html" data-key="t-customers">고정양식</a></li>
                </ul>
              </li>

              <li>
                <a href="javascript: void(0);" class="has-arrow">
                  <span class="menu-item" data-key="t-ecommerce">자료 관리</span>
                </a>
                <ul class="sub-menu" aria-expanded="false">
                  <li><a href="ecommerce-products.html" data-key="t-products">자료 정보수정</a></li>
                  <li><a href="ecommerce-product-detail.html" data-key="t-product-detail">이미지 수정</a></li>
                  <li><a href="ecommerce-orders.html" data-key="t-orders">등록자료 자동등록</a></li>
                </ul>
              </li>

              <li>
                <a href="javascript: void(0);" class="has-arrow">
                  <span class="menu-item" data-key="t-ecommerce">자료 공개</span>
                </a>
                <ul class="sub-menu" aria-expanded="false">
                  <li><a href="ecommerce-products.html" data-key="t-products">공개자료 정보조회</a></li>
                  <li><a href="ecommerce-product-detail.html" data-key="t-product-detail">공개자료 자동등록</a></li>
                  <li><a href="ecommerce-orders.html" data-key="t-orders">자료 공개설정</a></li>
                </ul>
              </li>

              <li>
                <a href="javascript: void(0);" class="has-arrow">
                  <span class="menu-item" data-key="t-ecommerce">자료 등록</span>
                </a>
                <ul class="sub-menu" aria-expanded="false">
                  <li><a href="ecommerce-products.html" data-key="t-products">자료 신규등록</a></li>
                  <li><a href="ecommerce-product-detail.html" data-key="t-product-detail">이미지 신규등록</a></li>
                  <li><a href="ecommerce-orders.html" data-key="t-orders">가등록품 정보조회</a></li>
                  <li><a href="ecommerce-customers.html" data-key="t-customers">가등록품 정보검색</a></li>
                  <li><a href="ecommerce-cart.html" data-key="t-cart">가등록품 통계</a></li>
                  <li><a href="ecommerce-checkout.html" data-key="t-checkout">가등록품 고정양식</a></li>
                  <li><a href="ecommerce-shops.html" data-key="t-shops">자료관리 전환(가등록→등록)</a></li>
                  <li><a href="ecommerce-add-product.html" data-key="t-add-product">자료 자동등록</a></li>
                </ul>
              </li>

              <li>
                <a href="javascript: void(0);" class="has-arrow">
                  <span class="menu-item" data-key="t-ecommerce">사용자 관리</span>
                </a>
                <ul class="sub-menu" aria-expanded="false">
                  <li><a href="ecommerce-products.html" data-key="t-products">사용자 등록</a></li>
                  <li><a href="ecommerce-product-detail.html" data-key="t-product-detail">사용자 권한관리</a></li>
                </ul>
              </li>

              <li>
                <a href="javascript: void(0);" class="has-arrow">
                  <span class="menu-item" data-key="t-ecommerce">환경설정</span>
                </a>
                <ul class="sub-menu" aria-expanded="false">
                  <li><a href="ecommerce-products.html" data-key="t-products">화면설정</a></li>
                  <li><a href="ecommerce-product-detail.html" data-key="t-product-detail">코드관리</a></li>
                  <li><a href="ecommerce-orders.html" data-key="t-orders">로그관리</a></li>
                  <li><a href="ecommerce-customers.html" data-key="t-customers">사전관리</a></li>
                  <li><a href="ecommerce-cart.html" data-key="t-cart">승인관리</a></li>
                </ul>
              </li>

              <li>
                <a href="javascript: void(0);" class="has-arrow">
                  <span class="menu-item" data-key="t-ecommerce">고객센터</span>
                </a>
                <ul class="sub-menu" aria-expanded="false">
                  <li><a href="ecommerce-products.html" data-key="t-products">공지사항</a></li>
                  <li><a href="ecommerce-orders.html" data-key="t-orders">FAQ</a></li>
                  <li><a href="ecommerce-customers.html" data-key="t-customers">오류신고센터</a></li>
                  <li><a href="ecommerce-cart.html" data-key="t-cart">개선사항</a></li>
                </ul>
              </li>
              <!-- 메뉴 끝 -->
            </ul>
          </div>
          <!-- Sidebar -->

          <!-- <div class="p-3 px-4 sidebar-footer">
            <p class="mb-1 main-title">
              <script>
                document.write(new Date().getFullYear())
              </script>
              &copy; Borex.
            </p>
            <p class="mb-0">Design & Develop by Themesbrand</p>
          </div> -->
        </div>
      </div>
      <!-- Left Sidebar End -->
      <header class="ishorizontal-topbar">
        <div class="navbar-header">
          <div class="d-flex">
            <!-- LOGO -->
            <div class="navbar-brand-box">
              <a href="index.html" class="logo logo-dark">
                <span class="logo-sm">
                  <img src="assets/images/logo-dark-sm.png" alt="" height="22" />
                </span>
                <span class="logo-lg">
                  <img src="assets/images/logo-dark.png" alt="" height="22" />
                </span>
              </a>

              <a href="index.html" class="logo logo-light">
                <span class="logo-sm">
                  <img src="assets/images/logo-light-sm.png" alt="" height="22" />
                </span>
                <span class="logo-lg">
                  <img src="assets/images/logo-light.png" alt="" height="22" />
                </span>
              </a>
            </div>

            <button type="button" class="btn btn-sm px-3 font-size-16 d-lg-none header-item" data-bs-toggle="collapse" data-bs-target="#topnav-menu-content">
              <i class="fa fa-fw fa-bars"></i>
            </button>

            <div class="d-none d-sm-block ms-2 align-self-center">
              <h4 class="page-title">Dashboard</h4>
            </div>
          </div>

          <div class="d-flex">
            <div class="dropdown">
              <button type="button" class="btn header-item" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="icon-sm" data-eva="search-outline"></i>
              </button>
              <div class="dropdown-menu dropdown-menu-end dropdown-menu-md p-0">
                <form class="p-2">
                  <div class="search-box">
                    <div class="position-relative">
                      <input type="text" class="form-control bg-light border-0" placeholder="Search..." />
                      <i class="search-icon" data-eva="search-outline" data-eva-height="26" data-eva-width="26"></i>
                    </div>
                  </div>
                </form>
              </div>
            </div>

            <div class="dropdown d-none d-lg-inline-block">
              <button type="button" class="btn header-item noti-icon" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="icon-sm" data-eva="grid-outline"></i>
              </button>
              <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end p-0">
                <div class="p-3">
                  <div class="row align-items-center">
                    <div class="col">
                      <h5 class="m-0 font-size-15">Web Apps</h5>
                    </div>
                    <div class="col-auto">
                      <a href="#!" class="small fw-semibold text-decoration-underline"> View All</a>
                    </div>
                  </div>
                </div>
                <div class="px-lg-2 pb-2">
                  <div class="row g-0">
                    <div class="col">
                      <a class="dropdown-icon-item" href="#!">
                        <img src="assets/images/brands/github.png" alt="Github" />
                        <span>GitHub</span>
                      </a>
                    </div>
                    <div class="col">
                      <a class="dropdown-icon-item" href="#!">
                        <img src="assets/images/brands/bitbucket.png" alt="bitbucket" />
                        <span>Bitbucket</span>
                      </a>
                    </div>
                    <div class="col">
                      <a class="dropdown-icon-item" href="#!">
                        <img src="assets/images/brands/dribbble.png" alt="dribbble" />
                        <span>Dribbble</span>
                      </a>
                    </div>
                  </div>

                  <div class="row g-0">
                    <div class="col">
                      <a class="dropdown-icon-item" href="#!">
                        <img src="assets/images/brands/dropbox.png" alt="dropbox" />
                        <span>Dropbox</span>
                      </a>
                    </div>
                    <div class="col">
                      <a class="dropdown-icon-item" href="#!">
                        <img src="assets/images/brands/mail_chimp.png" alt="mail_chimp" />
                        <span>Mail Chimp</span>
                      </a>
                    </div>
                    <div class="col">
                      <a class="dropdown-icon-item" href="#!">
                        <img src="assets/images/brands/slack.png" alt="slack" />
                        <span>Slack</span>
                      </a>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="dropdown d-inline-block">
              <button
                type="button"
                class="btn header-item noti-icon"
                id="page-header-notifications-dropdown"
                data-bs-toggle="dropdown"
                aria-haspopup="true"
                aria-expanded="false"
              >
                <i class="icon-sm" data-eva="bell-outline"></i>
                <span class="noti-dot bg-danger rounded-pill">4</span>
              </button>
              <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end p-0" aria-labelledby="page-header-notifications-dropdown">
                <div class="p-3">
                  <div class="row align-items-center">
                    <div class="col">
                      <h5 class="m-0 font-size-15">Notifications</h5>
                    </div>
                    <div class="col-auto">
                      <a href="#!" class="small fw-semibold text-decoration-underline"> Mark all as read</a>
                    </div>
                  </div>
                </div>
                <div data-simplebar style="max-height: 250px">
                  <a href="#!" class="text-reset notification-item">
                    <div class="d-flex">
                      <div class="flex-shrink-0 me-3">
                        <img src="assets/images/users/avatar-3.jpg" class="rounded-circle avatar-sm" alt="user-pic" />
                      </div>
                      <div class="flex-grow-1">
                        <h6 class="mb-1">James Lemire</h6>
                        <div class="font-size-13 text-muted">
                          <p class="mb-1">It will seem like simplified English.</p>
                          <p class="mb-0"><i class="mdi mdi-clock-outline"></i> <span>1 hours ago</span></p>
                        </div>
                      </div>
                    </div>
                  </a>
                  <a href="#!" class="text-reset notification-item">
                    <div class="d-flex">
                      <div class="flex-shrink-0 avatar-sm me-3">
                        <span class="avatar-title bg-primary rounded-circle font-size-16">
                          <i class="bx bx-cart"></i>
                        </span>
                      </div>
                      <div class="flex-grow-1">
                        <h6 class="mb-1">Your order is placed</h6>
                        <div class="font-size-13 text-muted">
                          <p class="mb-1">If several languages coalesce the grammar</p>
                          <p class="mb-0"><i class="mdi mdi-clock-outline"></i> <span>3 min ago</span></p>
                        </div>
                      </div>
                    </div>
                  </a>
                  <a href="#!" class="text-reset notification-item">
                    <div class="d-flex">
                      <div class="flex-shrink-0 avatar-sm me-3">
                        <span class="avatar-title bg-success rounded-circle font-size-16">
                          <i class="bx bx-badge-check"></i>
                        </span>
                      </div>
                      <div class="flex-grow-1">
                        <h6 class="mb-1">Your item is shipped</h6>
                        <div class="font-size-13 text-muted">
                          <p class="mb-1">If several languages coalesce the grammar</p>
                          <p class="mb-0"><i class="mdi mdi-clock-outline"></i> <span>3 min ago</span></p>
                        </div>
                      </div>
                    </div>
                  </a>

                  <a href="#!" class="text-reset notification-item">
                    <div class="d-flex">
                      <div class="flex-shrink-0 me-3">
                        <img src="assets/images/users/avatar-6.jpg" class="rounded-circle avatar-sm" alt="user-pic" />
                      </div>
                      <div class="flex-grow-1">
                        <h6 class="mb-1">Salena Layfield</h6>
                        <div class="font-size-13 text-muted">
                          <p class="mb-1">As a skeptical Cambridge friend of mine occidental.</p>
                          <p class="mb-0"><i class="mdi mdi-clock-outline"></i> <span>1 hours ago</span></p>
                        </div>
                      </div>
                    </div>
                  </a>
                </div>
                <div class="p-2 border-top d-grid">
                  <a class="btn btn-sm btn-link font-size-14 btn-block text-center" href="javascript:void(0)">
                    <i class="uil-arrow-circle-right me-1"></i> <span>View More..</span>
                  </a>
                </div>
              </div>
            </div>

            <div class="dropdown d-inline-block">
              <button type="button" class="btn header-item noti-icon right-bar-toggle" id="right-bar-toggle">
                <i class="icon-sm" data-eva="settings-outline"></i>
              </button>
            </div>

            <div class="dropdown d-inline-block">
              <button
                type="button"
                class="btn header-item user text-start d-flex align-items-center"
                id="page-header-user-dropdown"
                data-bs-toggle="dropdown"
                aria-haspopup="true"
                aria-expanded="false"
              >
                <img class="rounded-circle header-profile-user" src="assets/images/users/avatar-1.jpg" alt="Header Avatar" />
              </button>
              <div class="dropdown-menu dropdown-menu-end pt-0">
                <div class="p-3 border-bottom">
                  <h6 class="mb-0">Jennifer Bennett</h6>
                  <p class="mb-0 font-size-11 text-muted">jennifer.bennett@email.com</p>
                </div>
                <a class="dropdown-item" href="contacts-profile.html"
                  ><i class="mdi mdi-account-circle text-muted font-size-16 align-middle me-1"></i> <span class="align-middle">Profile</span></a
                >
                <a class="dropdown-item" href="apps-chat.html"
                  ><i class="mdi mdi-message-text-outline text-muted font-size-16 align-middle me-1"></i> <span class="align-middle">Messages</span></a
                >
                <a class="dropdown-item" href="pages-faqs.html"
                  ><i class="mdi mdi-lifebuoy text-muted font-size-16 align-middle me-1"></i> <span class="align-middle">Help</span></a
                >
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#"
                  ><i class="mdi mdi-wallet text-muted font-size-16 align-middle me-1"></i> <span class="align-middle">Balance : <b>$6951.02</b></span></a
                >
                <a class="dropdown-item d-flex align-items-center" href="#"
                  ><i class="mdi mdi-cog-outline text-muted font-size-16 align-middle me-1"></i> <span class="align-middle">Settings</span
                  ><span class="badge badge-soft-success ms-auto">New</span></a
                >
                <a class="dropdown-item" href="auth-lock-screen.html"
                  ><i class="mdi mdi-lock text-muted font-size-16 align-middle me-1"></i> <span class="align-middle">Lock screen</span></a
                >
                <a class="dropdown-item" href="auth-logout.html"
                  ><i class="mdi mdi-logout text-muted font-size-16 align-middle me-1"></i> <span class="align-middle">Logout</span></a
                >
              </div>
            </div>
          </div>
        </div>
        <div class="topnav">
          <div class="container-fluid">
            <nav class="navbar navbar-light navbar-expand-lg topnav-menu">
              <div class="collapse navbar-collapse" id="topnav-menu-content">
                <ul class="navbar-nav">
                  <li class="nav-item dropdown">
                    <a
                      class="nav-link dropdown-toggle arrow-none"
                      href="#"
                      id="topnav-dashboard"
                      role="button"
                      data-toggle="dropdown"
                      aria-haspopup="true"
                      aria-expanded="false"
                    >
                      <i class="icon nav-icon" data-eva="grid-outline"></i>
                      <span data-key="t-dashboards">Dashboards</span>
                      <div class="arrow-down"></div>
                    </a>
                    <div class="dropdown-menu" aria-labelledby="topnav-dashboard">
                      <a href="index.html" class="dropdown-item" data-key="t-ecommerce">Ecommerce</a>
                      <a href="dashboard-saas.html" class="dropdown-item" data-key="t-saas">Saas</a>
                      <a href="dashboard-crypto.html" class="dropdown-item" data-key="t-crypto">Crypto</a>
                    </div>
                  </li>

                  <li class="nav-item dropdown">
                    <a
                      class="nav-link dropdown-toggle arrow-none"
                      href="#"
                      id="topnav-uielement"
                      role="button"
                      data-toggle="dropdown"
                      aria-haspopup="true"
                      aria-expanded="false"
                    >
                      <i class="icon nav-icon" data-eva="cube-outline"></i>
                      <span data-key="t-elements">Elements</span>
                      <div class="arrow-down"></div>
                    </a>

                    <div class="dropdown-menu mega-dropdown-menu px-2 dropdown-mega-menu-xl" aria-labelledby="topnav-uielement">
                      <div class="ps-2 p-lg-0">
                        <div class="row">
                          <div class="col-lg-12">
                            <div>
                              <div class="menu-title">Elements</div>
                              <div class="row g-0">
                                <div class="col-lg-4">
                                  <div>
                                    <a href="ui-alerts.html" class="dropdown-item" data-key="t-alerts">Alerts</a>
                                    <a href="ui-buttons.html" class="dropdown-item" data-key="t-buttons">Buttons</a>
                                    <a href="ui-cards.html" class="dropdown-item" data-key="t-cards">Cards</a>
                                    <a href="ui-carousel.html" class="dropdown-item" data-key="t-carousel">Carousel</a>
                                    <a href="ui-dropdowns.html" class="dropdown-item" data-key="t-dropdowns">Dropdowns</a>
                                    <a href="ui-grid.html" class="dropdown-item" data-key="t-grid">Grid</a>
                                    <a href="ui-images.html" class="dropdown-item" data-key="t-images">Images</a>
                                  </div>
                                </div>
                                <div class="col-lg-4">
                                  <div>
                                    <a href="ui-lightbox.html" class="dropdown-item" data-key="t-lightbox">Lightbox</a>
                                    <a href="ui-modals.html" class="dropdown-item" data-key="t-modals">Modals</a>
                                    <a href="ui-offcanvas.html" class="dropdown-item" data-key="t-offcanvas">Offcanvas</a>
                                    <a href="ui-rangeslider.html" class="dropdown-item" data-key="t-range-slider">Range Slider</a>
                                    <a href="ui-progressbars.html" class="dropdown-item" data-key="t-progress-bars">Progress Bars</a>
                                    <a href="ui-sweet-alert.html" class="dropdown-item" data-key="t-sweet-alert">Sweet-Alert</a>
                                    <a href="ui-tabs-accordions.html" class="dropdown-item" data-key="t-tabs-accordions">Tabs & Accordions</a>
                                  </div>
                                </div>
                                <div class="col-lg-4">
                                  <div>
                                    <a href="ui-typography.html" class="dropdown-item" data-key="t-typography">Typography</a>
                                    <a href="ui-video.html" class="dropdown-item" data-key="t-video">Video</a>
                                    <a href="ui-general.html" class="dropdown-item" data-key="t-general">General</a>
                                    <a href="ui-colors.html" class="dropdown-item" data-key="t-colors">Colors</a>
                                    <a href="ui-rating.html" class="dropdown-item" data-key="t-rating">Rating</a>
                                    <a href="ui-notifications.html" class="dropdown-item" data-key="t-notifications">Notifications</a>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </li>

                  <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle arrow-none" href="#" id="topnav-pages" role="button">
                      <i class="icon nav-icon" data-eva="archive-outline"></i>
                      <span data-key="t-apps">Apps</span>
                      <div class="arrow-down"></div>
                    </a>
                    <div class="dropdown-menu" aria-labelledby="topnav-pages">
                      <a href="apps-calendar.html" class="dropdown-item" data-key="t-calendar">Calendar</a>
                      <a href="apps-chat.html" class="dropdown-item" data-key="t-chat">Chat</a>
                      <a href="apps-file-manager.html" class="dropdown-item" data-key="t-filemanager">File Manager</a>

                      <div class="dropdown">
                        <a class="dropdown-item dropdown-toggle arrow-none" href="#" id="topnav-ecommerce" role="button">
                          <span data-key="t-ecommerce">Ecommerce</span>
                          <div class="arrow-down"></div>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="topnav-ecommerce">
                          <a href="ecommerce-products.html" class="dropdown-item" data-key="t-products">Products</a>
                          <a href="ecommerce-product-detail.html" class="dropdown-item" data-key="t-product-detail">Product Detail</a>
                          <a href="ecommerce-orders.html" class="dropdown-item" data-key="t-orders">Orders</a>
                          <a href="ecommerce-customers.html" class="dropdown-item" data-key="t-customers">Customers</a>
                          <a href="ecommerce-cart.html" class="dropdown-item" data-key="t-cart">Cart</a>
                          <a href="ecommerce-checkout.html" class="dropdown-item" data-key="t-checkout">Checkout</a>
                          <a href="ecommerce-shops.html" class="dropdown-item" data-key="t-shops">Shops</a>
                          <a href="ecommerce-add-product.html" class="dropdown-item" data-key="t-add-product">Add Product</a>
                        </div>
                      </div>

                      <div class="dropdown">
                        <a class="dropdown-item dropdown-toggle arrow-none" href="#" id="topnav-email" role="button">
                          <span data-key="t-email">Email</span>
                          <div class="arrow-down"></div>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="topnav-email">
                          <a href="email-inbox.html" class="dropdown-item" data-key="t-inbox">Inbox</a>
                          <a href="email-read.html" class="dropdown-item" data-key="t-read-email">Read Email</a>
                          <div class="dropdown">
                            <a class="dropdown-item dropdown-toggle arrow-none" href="#" id="topnav-email-templates" role="button">
                              <span data-key="t-email-templates">Templates</span>
                              <div class="arrow-down"></div>
                            </a>
                            <div class="dropdown-menu" aria-labelledby="topnav-email-templates">
                              <a href="email-template-basic.html" class="dropdown-item" data-key="t-basic-action">Basic Action</a>
                              <a href="email-template-alert.html" class="dropdown-item" data-key="t-alert-email">Alert Email</a>
                              <a href="email-template-billing.html" class="dropdown-item" data-key="t-bill-email">Billing Email</a>
                            </div>
                          </div>
                        </div>
                      </div>

                      <div class="dropdown">
                        <a class="dropdown-item dropdown-toggle arrow-none" href="#" id="topnav-invoices" role="button">
                          <span data-key="t-invoices">Invoices</span>
                          <div class="arrow-down"></div>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="topnav-invoices">
                          <a href="invoices-list.html" class="dropdown-item" data-key="t-invoice-list">Invoice List</a>
                          <a href="invoices-detail.html" class="dropdown-item" data-key="t-invoice-detail">Invoice Detail</a>
                        </div>
                      </div>

                      <div class="dropdown">
                        <a class="dropdown-item dropdown-toggle arrow-none" href="#" id="topnav-projects" role="button">
                          <span data-key="t-projects">Projects</span>
                          <div class="arrow-down"></div>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="topnav-projects">
                          <a href="projects-grid.html" class="dropdown-item" data-key="t-p-grid">Projects Grid</a>
                          <a href="projects-list.html" class="dropdown-item" data-key="t-p-list">Projects List</a>
                          <a href="projects-create.html" class="dropdown-item" data-key="t-create-new">Create New</a>
                        </div>
                      </div>

                      <div class="dropdown">
                        <a class="dropdown-item dropdown-toggle arrow-none" href="#" id="topnav-contact" role="button">
                          <span data-key="t-contacts">Contacts</span>
                          <div class="arrow-down"></div>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="topnav-contact">
                          <a href="contacts-grid.html" class="dropdown-item" data-key="t-user-grid">User Grid</a>
                          <a href="contacts-list.html" class="dropdown-item" data-key="t-user-list">User List</a>
                          <a href="contacts-profile.html" class="dropdown-item" data-key="t-user-profile">Profile</a>
                        </div>
                      </div>
                    </div>
                  </li>

                  <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle arrow-none" href="#" id="topnav-components" role="button">
                      <i class="icon nav-icon" data-eva="layers-outline"></i>
                      <span data-key="t-components">Components</span>
                      <div class="arrow-down"></div>
                    </a>
                    <div class="dropdown-menu" aria-labelledby="topnav-components">
                      <div class="dropdown">
                        <a class="dropdown-item dropdown-toggle arrow-none" href="#" id="topnav-form" role="button">
                          <span data-key="t-forms">Forms</span>
                          <div class="arrow-down"></div>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="topnav-form">
                          <a href="form-elements.html" class="dropdown-item" data-key="t-form-elements">Form Elements</a>
                          <a href="form-layouts.html" class="dropdown-item" data-key="t-form-layouts">Form Layouts</a>
                          <a href="form-validation.html" class="dropdown-item" data-key="t-form-validation">Form Validation</a>
                          <a href="form-advanced.html" class="dropdown-item" data-key="t-form-advanced">Form Advanced</a>
                          <a href="form-editors.html" class="dropdown-item" data-key="t-form-editors">Form Editors</a>
                          <a href="form-uploads.html" class="dropdown-item" data-key="t-form-upload">Form File Upload</a>
                          <a href="form-wizard.html" class="dropdown-item" data-key="t-form-wizard">Form Wizard</a>
                          <a href="form-mask.html" class="dropdown-item" data-key="t-form-mask">Form Mask</a>
                        </div>
                      </div>
                      <div class="dropdown">
                        <a class="dropdown-item dropdown-toggle arrow-none" href="#" id="topnav-table" role="button">
                          <span data-key="t-tables">Tables</span>
                          <div class="arrow-down"></div>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="topnav-table">
                          <a href="tables-basic.html" class="dropdown-item" data-key="t-basic-tables">Basic Tables</a>
                          <a href="tables-advanced.html" class="dropdown-item" data-key="t-advanced-tables">Advance Tables</a>
                        </div>
                      </div>

                      <div class="dropdown">
                        <a class="dropdown-item dropdown-toggle arrow-none" href="#" id="topnav-charts" role="button">
                          <span data-key="t-charts">Charts</span>
                          <div class="arrow-down"></div>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="topnav-charts">
                          <div class="dropdown">
                            <a class="dropdown-item dropdown-toggle arrow-none" href="#" id="topnav-apex-charts" role="button">
                              <span data-key="t-apex-charts">Apex Charts</span>
                              <div class="arrow-down"></div>
                            </a>
                            <div class="dropdown-menu" aria-labelledby="topnav-apex-charts">
                              <a href="charts-line.html" class="dropdown-item" data-key="t-line">Line</a>
                              <a href="charts-area.html" class="dropdown-item" data-key="t-area">Area</a>
                              <a href="charts-column.html" class="dropdown-item" data-key="t-column">Column</a>
                              <a href="charts-bar.html" class="dropdown-item" data-key="t-bar">Bar</a>
                              <a href="charts-mixed.html" class="dropdown-item" data-key="t-mixed">Mixed</a>
                              <a href="charts-timeline.html" class="dropdown-item" data-key="t-timeline">Timeline</a>
                              <a href="charts-candlestick.html" class="dropdown-item" data-key="t-candlestick">Candlestick</a>
                              <a href="charts-boxplot.html" class="dropdown-item" data-key="t-boxplot">Boxplot</a>
                              <a href="charts-bubble.html" class="dropdown-item" data-key="t-bubble">Bubble</a>
                              <a href="charts-scatter.html" class="dropdown-item" data-key="t-scatter">Scatter</a>
                              <a href="charts-heatmap.html" class="dropdown-item" data-key="t-heatmap">Heatmap</a>
                              <a href="charts-treemap.html" class="dropdown-item" data-key="t-treemap">Treemap</a>
                              <a href="charts-pie.html" class="dropdown-item" data-key="t-pie">Pie</a>
                              <a href="charts-radialbar.html" class="dropdown-item" data-key="t-radialbar">Radialbar</a>
                              <a href="charts-radar.html" class="dropdown-item" data-key="t-radar">Radar</a>
                              <a href="charts-polararea.html" class="dropdown-item" data-key="t-polararea">Polararea</a>
                            </div>
                          </div>
                          <a href="charts-echart.html" class="dropdown-item" data-key="t-e-charts">E Charts</a>
                          <a href="charts-chartjs.html" class="dropdown-item" data-key="t-chartjs-charts">Chartjs Charts</a>
                          <a href="charts-tui.html" class="dropdown-item" data-key="t-ui-charts">Toast UI Charts</a>
                        </div>
                      </div>

                      <div class="dropdown">
                        <a class="dropdown-item dropdown-toggle arrow-none" href="#" id="topnav-icons" role="button">
                          <span data-key="t-icons">Icons</span>
                          <div class="arrow-down"></div>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="topnav-icons">
                          <a href="icons-evaicons.html" class="dropdown-item" data-key="t-evaicons">Eva Icons</a>
                          <a href="icons-boxicons.html" class="dropdown-item" data-key="t-boxicons">Boxicons</a>
                          <a href="icons-materialdesign.html" class="dropdown-item" data-key="t-material-design">Material Design</a>
                          <a href="icons-fontawesome.html" class="dropdown-item" data-key="t-font-awesome">Font Awesome 5</a>
                        </div>
                      </div>
                      <div class="dropdown">
                        <a class="dropdown-item dropdown-toggle arrow-none" href="#" id="topnav-map" role="button">
                          <span data-key="t-maps">Maps</span>
                          <div class="arrow-down"></div>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="topnav-map">
                          <a href="maps-google.html" class="dropdown-item" data-key="t-google">Google</a>
                          <a href="maps-vector.html" class="dropdown-item" data-key="t-vector">Vector</a>
                          <a href="maps-leaflet.html" class="dropdown-item" data-key="t-leaflet">Leaflet</a>
                        </div>
                      </div>
                    </div>
                  </li>

                  <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle arrow-none" href="#" id="topnav-more" role="button">
                      <i class="icon nav-icon" data-eva="file-text-outline"></i>
                      <span data-key="t-pages">Pages</span>
                      <div class="arrow-down"></div>
                    </a>
                    <div class="dropdown-menu" aria-labelledby="topnav-more">
                      <div class="dropdown">
                        <a class="dropdown-item dropdown-toggle arrow-none" href="#" id="topnav-authentication" role="button">
                          <span data-key="t-authentication">Authentication</span>
                          <div class="arrow-down"></div>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="topnav-authentication">
                          <a href="auth-login.html" class="dropdown-item" data-key="t-login">Login</a>
                          <a href="auth-register.html" class="dropdown-item" data-key="t-register">Register</a>
                          <a href="auth-recoverpw.html" class="dropdown-item" data-key="t-recover-password">Recover Password</a>
                          <a href="auth-lock-screen.html" class="dropdown-item" data-key="t-lock-screen">Lock Screen</a>
                          <a href="auth-logout.html" class="dropdown-item" data-key="t-logout">Logout</a>
                          <a href="auth-confirm-mail.html" class="dropdown-item" data-key="t-confirm-mail">Confirm Mail</a>
                          <a href="auth-email-verification.html" class="dropdown-item" data-key="t-email-verification">Email Verification</a>
                          <a href="auth-two-step-verification.html" class="dropdown-item" data-key="t-two-step-verification">Two Step Verification</a>
                        </div>
                      </div>

                      <div class="dropdown">
                        <a class="dropdown-item dropdown-toggle arrow-none" href="#" id="topnav-utility" role="button">
                          <span data-key="t-utility">Utility</span>
                          <div class="arrow-down"></div>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="topnav-utility">
                          <a href="pages-starter.html" class="dropdown-item" data-key="t-starter-page">Starter Page</a>
                          <a href="pages-maintenance.html" class="dropdown-item" data-key="t-maintenance">Maintenance</a>
                          <a href="pages-comingsoon.html" class="dropdown-item" data-key="t-coming-soon">Coming Soon</a>
                          <a href="pages-timeline.html" class="dropdown-item" data-key="t-timeline">Timeline</a>
                          <a href="pages-faqs.html" class="dropdown-item" data-key="t-faqs">FAQs</a>
                          <a href="pages-pricing.html" class="dropdown-item" data-key="t-pricing">Pricing</a>
                          <a href="pages-404.html" class="dropdown-item" data-key="t-error-404">Error 404</a>
                          <a href="pages-500.html" class="dropdown-item" data-key="t-error-500">Error 500</a>
                        </div>
                      </div>

                      <a href="layouts-horizontal.html" class="dropdown-item" data-key="t-horizontal">Horizontal</a>
                    </div>
                  </li>
                </ul>
              </div>
            </nav>
          </div>
        </div>
      </header>
      <!-- ============================================================== -->
      <div class="main-content">
        <!-- 자료등록 시작 -->
        <div class="page-content">
          <!-- 자료구분 셀렉트 -->
          <div class="tap_text">
            <h2>사용자 관리</h2>
            <p>사용자관리 > <span>사용자 등록</span></p>
          </div>
          <div class="fr_wrap">
            <div class="mb-3 row fr_1">

          </div>
          <!--  -->
          <!-- 퀵메뉴 -->
          <div class="accordion" id="accordionExample">

            <div class="accordion-item">
              <h2 class="accordion-header" id="headingOne">
                <button
                  class="accordion-button fw-medium"
                  type="button"
                  data-bs-toggle="collapse"
                  data-bs-target="#collapseOne"
                  aria-expanded="true"
                  aria-controls="collapseOne"
                >
                  퀵메뉴
                </button>
              </h2>
              <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                <div class="accordion-body">
                  <div class="text-muted">
                    <strong class="text-dark">
                      <ul>
                        <li><a href="#">저장</a></li>
                        <li><a href="#">자료 등록하기</a></li>
                        <li><a href="#">자료 정보 가져오기</a></li>
                        <li><a href="#">자료 정보 일괄 변경</a></li>
                        <li><a href="#">자료 정보 삭제 신청</a></li>
                        <li><a href="#">자료 번호 삽입</a></li>
                      </ul>
                  </div>
                </div>
              </div>
            </div>
            <div class="accordion-item">
              <h2 class="accordion-header" id="headingTwo">
                <button
                  class="accordion-button fw-medium collapsed"
                  type="button"
                  data-bs-toggle="collapse"
                  data-bs-target="#collapseTwo"
                  aria-expanded="false"
                  aria-controls="collapseTwo"
                >
                  고정메뉴
                </button>
              </h2>
              <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                <div class="accordion-body">
                  <div class="text-muted">
                    <strong class="text-dark">
                      <ul>
                        <li><a href="#">연표</a></li>
                        <li><a href="#">연호</a></li>
                        <li><a href="#">용어</a></li>
                        <li><a href="#">분류체계</a></li>
                      </ul>
                  </div>
                </div>
              </div>
            </div>
            <div class="accordion-item">
              <h2 class="accordion-header" id="headingThree">
                <button
                  class="accordion-button fw-medium collapsed"
                  type="button"
                  data-bs-toggle="collapse"
                  data-bs-target="#collapseThree"
                  aria-expanded="false"
                  aria-controls="collapseThree"
                >
                  등록메뉴얼
                </button>
              </h2>
              <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
                </div>
              </div>
            </div>
          </xdiv>
            <!--  -->
          </div>
          <!-- 내용물 -->
          <ul class="nav nav-tabs" role="tablist">
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" role="tab" href="javascript():;" id="userMgr">
                    <span class="d-block d-sm-none"><i class="far fa-user"></i></span>
                    <span class="d-none d-sm-block">사용자 관리</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" role="tab" href="javascript():;" id="groupMgr">
                    <span class="d-block d-sm-none"><i class="far fa-envelope"></i></span>
                    <span class="d-none d-sm-block">그룹 관리</span>
                </a>
            </li>
        </ul>
        <div class="user_top_wrap">
          <span>검색</span>
          <select class="form-select st_select">
            <option disabled selected>전체</option>
            <option>더미1</option>
            <option>더미2</option>
            <option>더미3</option>
          </select>
            <input type="text">
            <button>조회</button>
          </div>
        <!-- Tab panes -->
        <div class="tab-content p-3 text-muted" id="tab-content">
            <!--  -->
            <!-- 기본사항 끝 -->
            <!--  -->
            <!-- 이동 사항 -->


                </div>
          <!--  -->
            </div>
        <!-- End Page-content -->
        <footer class="footer">
          <div class="container-fluid">
            <div class="row">
              <div class="col-sm-12">
                <script>
                  document.write(new Date().getFullYear())
                </script>
                &copy; Borex. Design & Develop by Themesbrand
              </div>
            </div>
          </div>
        </footer>
      </div>
      <!-- end main content-->
    </div>
    <!-- END layout-wrapper -->

    <!-- Right Sidebar -->
    <div class="right-bar">
      <div data-simplebar class="h-100">
        <div class="rightbar-title d-flex align-items-center bg-dark p-3">
          <h5 class="m-0 me-2 text-white">Theme Customizer</h5>

          <a href="javascript:void(0);" class="right-bar-toggle-close ms-auto">
            <i class="mdi mdi-close noti-icon"></i>
          </a>
        </div>

        <!-- Settings -->
        <hr class="m-0" />

        <div class="p-4">
          <h6 class="mb-3">Layout</h6>
          <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="layout" id="layout-vertical" value="vertical" />
            <label class="form-check-label" for="layout-vertical">Vertical</label>
          </div>
          <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="layout" id="layout-horizontal" value="horizontal" />
            <label class="form-check-label" for="layout-horizontal">Horizontal</label>
          </div>

          <h6 class="mt-4 mb-3">Layout Mode</h6>

          <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="layout-mode" id="layout-mode-light" value="light" />
            <label class="form-check-label" for="layout-mode-light">Light</label>
          </div>
          <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="layout-mode" id="layout-mode-dark" value="dark" />
            <label class="form-check-label" for="layout-mode-dark">Dark</label>
          </div>

          <h6 class="mt-4 mb-3">Layout Width</h6>

          <div class="form-check form-check-inline">
            <input
              class="form-check-input"
              type="radio"
              name="layout-width"
              id="layout-width-fluid"
              value="fluid"
              onchange="document.body.setAttribute('data-layout-size', 'fluid')"
            />
            <label class="form-check-label" for="layout-width-fluid">Fluid</label>
          </div>
          <div class="form-check form-check-inline">
            <input
              class="form-check-input"
              type="radio"
              name="layout-width"
              id="layout-width-boxed"
              value="boxed"
              onchange="document.body.setAttribute('data-layout-size', 'boxed')"
            />
            <label class="form-check-label" for="layout-width-boxed">Boxed</label>
          </div>

          <h6 class="mt-4 mb-3">Layout Position</h6>

          <div class="form-check form-check-inline">
            <input
              class="form-check-input"
              type="radio"
              name="layout-position"
              id="layout-position-fixed"
              value="fixed"
              onchange="document.body.setAttribute('data-layout-scrollable', 'false')"
            />
            <label class="form-check-label" for="layout-position-fixed">Fixed</label>
          </div>
          <div class="form-check form-check-inline">
            <input
              class="form-check-input"
              type="radio"
              name="layout-position"
              id="layout-position-scrollable"
              value="scrollable"
              onchange="document.body.setAttribute('data-layout-scrollable', 'true')"
            />
            <label class="form-check-label" for="layout-position-scrollable">Scrollable</label>
          </div>

          <h6 class="mt-4 mb-3">Topbar Color</h6>

          <div class="form-check form-check-inline">
            <input
              class="form-check-input"
              type="radio"
              name="topbar-color"
              id="topbar-color-light"
              value="light"
              onchange="document.body.setAttribute('data-topbar', 'light')"
            />
            <label class="form-check-label" for="topbar-color-light">Light</label>
          </div>
          <div class="form-check form-check-inline">
            <input
              class="form-check-input"
              type="radio"
              name="topbar-color"
              id="topbar-color-dark"
              value="dark"
              onchange="document.body.setAttribute('data-topbar', 'dark')"
            />
            <label class="form-check-label" for="topbar-color-dark">Dark</label>
          </div>

          <div id="sidebar-setting">
            <h6 class="mt-4 mb-3 sidebar-setting">Sidebar Size</h6>

            <div class="form-check sidebar-setting">
              <input
                class="form-check-input"
                type="radio"
                name="sidebar-size"
                id="sidebar-size-default"
                value="default"
                onchange="document.body.setAttribute('data-sidebar-size', 'lg')"
              />
              <label class="form-check-label" for="sidebar-size-default">Default</label>
            </div>
            <div class="form-check sidebar-setting">
              <input
                class="form-check-input"
                type="radio"
                name="sidebar-size"
                id="sidebar-size-compact"
                value="compact"
                onchange="document.body.setAttribute('data-sidebar-size', 'md')"
              />
              <label class="form-check-label" for="sidebar-size-compact">Compact</label>
            </div>
            <div class="form-check sidebar-setting">
              <input
                class="form-check-input"
                type="radio"
                name="sidebar-size"
                id="sidebar-size-small"
                value="small"
                onchange="document.body.setAttribute('data-sidebar-size', 'sm')"
              />
              <label class="form-check-label" for="sidebar-size-small">Small (Icon View)</label>
            </div>

            <h6 class="mt-4 mb-3 sidebar-setting">Sidebar Color</h6>

            <div class="form-check sidebar-setting">
              <input
                class="form-check-input"
                type="radio"
                name="sidebar-color"
                id="sidebar-color-light"
                value="light"
                onchange="document.body.setAttribute('data-sidebar', 'light')"
              />
              <label class="form-check-label" for="sidebar-color-light">Light</label>
            </div>
            <div class="form-check sidebar-setting">
              <input
                class="form-check-input"
                type="radio"
                name="sidebar-color"
                id="sidebar-color-dark"
                value="dark"
                onchange="document.body.setAttribute('data-sidebar', 'dark')"
              />
              <label class="form-check-label" for="sidebar-color-dark">Dark</label>
            </div>
            <div class="form-check sidebar-setting">
              <input
                class="form-check-input"
                type="radio"
                name="sidebar-color"
                id="sidebar-color-brand"
                value="brand"
                onchange="document.body.setAttribute('data-sidebar', 'brand')"
              />
              <label class="form-check-label" for="sidebar-color-brand">Brand</label>
            </div>
          </div>

          <h6 class="mt-4 mb-3">Direction</h6>

          <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="layout-direction" id="layout-direction-ltr" value="ltr" />
            <label class="form-check-label" for="layout-direction-ltr">LTR</label>
          </div>
          <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="layout-direction" id="layout-direction-rtl" value="rtl" />
            <label class="form-check-label" for="layout-direction-rtl">RTL</label>
          </div>
        </div>
      </div>
      <!-- end slimscroll-menu-->
    </div>
    <!-- /Right-bar -->

    <!-- Right bar overlay-->
    <div class="rightbar-overlay"></div>

    <!-- chat offcanvas -->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasActivity" aria-labelledby="offcanvasActivityLabel">
      <div class="offcanvas-header border-bottom">
        <h5 id="offcanvasActivityLabel">Offcanvas right</h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
      </div>
      <div class="offcanvas-body">...</div>
    </div>


    <!-- JAVASCRIPT -->
    <script src="<c:url value='/assets/libs/bootstrap/js/bootstrap.bundle.min.js'/>" defer></script>
    <script src="<c:url value='/assets/libs/metismenujs/metismenujs.min.js'/>" defer></script>
    <script src="<c:url value='/assets/libs/simplebar/simplebar.min.js'/>" defer></script>
    <script src="<c:url value='/assets/libs/eva-icons/eva.min.js'/>" defer></script>
    <!-- apexcharts -->
    <script src="<c:url value='/assets/libs/apexcharts/apexcharts.min.js'/>" defer></script>
    <script src="<c:url value='/assets/js/pages/dashboard.init.js'/>" defer></script>
    <script src="<c:url value='/assets/js/app.js'/>" defer></script>
    <!--  -->
    <script src="<c:url value='/assets/js/pages/ecommerce-product-detail.init.js'/>" defer></script>
    
<!-- <div class="user_lists_Area" id="user_lists_Area"></div> -->

<!-- <form id="userForm" name="userForm" method="post"> -->
<!-- 	<input type="hidden" 	id="umember_id"				name="member_id" 			value="dd" /> -->
<!-- 	<input type="hidden" 	id="umember_nm" 			name="member_nm" 			value="dd" /> -->
<!-- <!-- 	<input type="hidden" 	id="ugroup_idx" 			name="group_idx"	 		value="" /> --> 
<!-- </form> -->
</body>
</html>