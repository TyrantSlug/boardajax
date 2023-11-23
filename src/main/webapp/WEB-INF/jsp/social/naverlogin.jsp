<%--  <%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>네이버 로그인</title>
  <link rel="stylesheet" href="./style.css" />
</head>
<body>
  <div class="container">
    <h1>Naver Login API 사용하기</h1>
    <div class="login-area">
      <div id="message">
        로그인 버튼을 눌러 로그인 해주세요.
      </div>
      <div id="button_area">
        <div id="naverIdLogin"></div>
      </div>
    </div>
  </div>
  <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
  <script type="text/javascript">

  const naverLogin = new naver.LoginWithNaverId(
   {
    clientId: "VXjYInITwpfPtDZDVliJ",
    callbackUrl: "http://localhost:8081/social/naverlogin.do",
    loginButton: {color: "green", type: 2, height: 40}
    }
   );


    naverLogin.init();
    naverLogin.getLoginStatus(function (status) {
      if (status) {
          const nickName=naverLogin.user.getNickName();

          if(nickName===null||nickName===undefined ){
            alert("별명이 필요합니다. 정보제공을 동의해주세요.");
            naverLogin.reprompt();
            return ;  
         }else{
          setLoginStatus();
         }
    }
    });
    console.log(naverLogin);

    function setLoginStatus(){
        // message_area 변수를 함수 내부에서 정의
   //     window.location.href = "http://localhost:8081/account/accountList.do";
         const message_area = document.getElementById('message');

        const nickname = naverLogin.user.nickname || "N/A";

        console.log("Nickname:", nickname);
        
    
        message_area.innerHTML = "<h3> Login 성공 </h3>" +
                         "<div>user Nickname : " + nickname + "</div>";


        const button_area=document.getElementById('button_area');
        button_area.innerHTML="<button id='btn_logout'>로그아웃</button>";

        const logout=document.getElementById('btn_logout');
        logout.addEventListener('click', (e) => {
            naverLogin.logout();
            location.replace("http://localhost:8081/social/naverlogin.do");
        }); 
    }

  </script>
</html>   --%>