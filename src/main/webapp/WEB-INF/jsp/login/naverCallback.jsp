<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script src="/js/jquery.min.js"></script> <!-- jQuery 추가 -->

<script>
    $(document).ready(function() {
        const naverLogin = new naver.LoginWithNaverId({
            clientId: "VXjYInITwpfPtDZDVliJ",
            callbackUrl: "http://localhost:8081/login/naverCallback.do",
            isPopup: false
        });

        naverLogin.init();

        naverLogin.getLoginStatus(function(status) {
            if (status) {
                const nickName = naverLogin.user.getNickName();
                if (nickName === null || nickName === undefined) {
                    alert("별명이 필요합니다. 정보제공을 동의해주세요.");
                    naverLogin.reprompt();
                    return;
                } else {
                    setLoginStatus();
                }
            } else {
                alert("네이버 로그인에 실패했습니다.");
            }
        });

        function setLoginStatus() {
            const nickname = naverLogin.user.nickname || "N/A";
            $.ajax({
                url: "/login/setNicknameInSession.do",
                type: "POST",
                data: { nickname: nickname },
                success: function(response) {
                    if(response === "success") {
                        alert("로그인에 성공했습니다.");
                        window.location.href = '/account/accountList.do';
                    } else {
                        alert("닉네임을 세션에 저장하는 데 실패했습니다.");
                    }
                },
                error: function(error) {
                    alert('서버 에러. 다시 시도해주세요.');
                }
            });
        }
    });
</script>
