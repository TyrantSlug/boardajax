<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script
	src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"
	charset="utf-8"></script>
	
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- 추가: jQuery 라이브러리 -->

<script>
$(document).ready(function() {
	
	 $("#loginBtn").click(function() {
	        var userId = $("#memId").val();
	        var password = $("#memPassword").val();

	        var userData = {
	            userId: userId,
	            pwd: password
	        };

	        $.ajax({
	            url: "/login/login2.do",
	            type: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify(userData),
	            dataType: 'json',
	            success: function(response) {
	                if (response.result === "success") {
	                    alert('로그인 성공');
	                    window.location.href='/account/accountList.do';
	                } else {
	                    alert('로그인 실패: ' + response.message);
	                }
	            },
	            error: function() {
	                alert('서버 오류');
	            }
	        });
	    });
	
	
    const naverLogin = new naver.LoginWithNaverId({
        clientId: "VXjYInITwpfPtDZDVliJ",
        callbackUrl: "http://localhost:8081/login/naverCallback.do",
        isPopup: false,
        loginButton: {color: "green", type: 2, height: 40}
    });
    naverLogin.init();
    
    naverLogin.getLoginStatus(function(status) {
        if (status) {  // 로그인 상태가 맞다면
            window.location.href='/account/accountList.do';
        }
    });

    $("#naverIdLogin").click(function() {
        naverLogin.authorize();
    });
});
</script>


<form id="sendForm">

	<input type="hidden" id="platform" name="platform" value="">
	<div class="container col-md-offset-2 col-sm-6"
		style="margin-top: 100px;">
		<div class="input-group">
			<span class="input-group-addon"><i
				class="glyphicon glyphicon-user"></i></span> <input id="memId" type="text"
				class="form-control valiChk" name="memId" placeholder="id"
				title="ID">
		</div>
		<div class="input-group">
			<span class="input-group-addon"><i
				class="glyphicon glyphicon-lock"></i></span> <input id="memPassword"
				type="password" class="form-control valiChk" name="memPassword"
				placeholder="Password" title="Password">
		</div>
		<br /> <br>
		<div class="col-md-offset-4">
			<button type="button" id="loginBtn" class="btn btn-primary">로그인</button>
			<button type="button" id="#" class="btn btn-warning"
				onclick="location.href='/login/login.do'">취소</button>
			<button type="button" id="#" class="btn btn-info"
				onclick="location.href='/user/userInsert.do'">회원가입</button>
	
		</div>
		<br>
		<div id="button_area">
			<div id="naverIdLogin"></div>
		</div>
	</div>
</form>

<!-- <script src="/js/naverlogin.js"></script> -->
