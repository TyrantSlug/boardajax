<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jstl-c" prefix="c"%>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script type="text/javascript">

 const naverLogin = new naver.LoginWithNaverId({
    clientId: "VXjYInITwpfPtDZDVliJ", // 여기에는 당신의 Client ID를 입력하십시오.
    callbackUrl: "http://localhost:8081/social/naverlogin.do" // 콜백 URL을 여기에 입력하십시오.
});

naverLogin.init();

//페이지 로드 시 네이버 로그인 상태 체크
naverLogin.getLoginStatus(function(status) {
    if (status) {
        const nickname = naverLogin.user.getNickName() || "N/A";
    }
}); 

$(document).ready(function() {
    $("#logout").click(logout);
});

 function logout() {
	 
	naverLogin.logout();
	 
    $.ajax({
        url: "/login/logout.do", 
        type: "POST",
        success: function(response) {
            if (response.result === "success") {
                alert('로그아웃되었습니다.');
                window.location.href = '/login/login.do';
            } else {
                alert('로그아웃실패');
            }
        },
        error: function(error) {
            alert('로그아웃에 실패하였습니다. 다시 시도해주세요.');
        }
    });
} 

</script>

<nav class="navbar navbar-inverse">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#myNavbar">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/account/accountList.do"> <img
				width="35px;"
				src='<c:url value="/images/egovframework/common/lime.jpg" />'>
			</a>
		</div>
		
		<div class="collapse navbar-collapse navbar-right" id="myNavbar">
			<ul class="nav navbar-nav">

		 		 <li class="active"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><c:out value="${sessionScope.user}" default="회계관리"/></a>
	        	<ul class="dropdown-menu">
		          <li><a href="/account/accountList.do">회계정보</a></li>
		        </ul>
	        </li> 
			</ul>

			<ul class="nav navbar-nav ">
				<li class="dropdown active"><span><font size="2px"
						color="white"> <br /> 님 로그인
					</font></span></li>
				<!-- <li class="active"><a href="/login/logout.do"><span class="glyphicon glyphicon-log-in"></span> LogOut</a></li> -->
				<li class="active"><a href="#" id="logout"><span
						class="glyphicon glyphicon-log-in"></span> LogOut</a></li>
			</ul>
		</div>

	</div>
</nav>


