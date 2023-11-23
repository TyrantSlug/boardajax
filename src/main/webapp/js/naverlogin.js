/**
 * 
 *//*

$(document).ready(function() {
    // 네이버 로그인 설정
    const naverLogin = new naver.LoginWithNaverId({
        clientId: "VXjYInITwpfPtDZDVliJ",
        callbackUrl: "http://localhost:8081/account/accountList.do",
        isPopup: false,
        loginButton: {color: "green", type: 2, height: 40}
    });
    naverLogin.init();

    // 페이지 로드 시 네이버 로그인 상태 체크
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
        }
    });

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

    // 소셜 로그인 이벤트 리스너
    $("#naverIdLogin").click(function() {
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
            }
        });
    });

    function setLoginStatus(){
        const button_area = document.getElementById('button_area');
        const nickname = naverLogin.user.nickname || "N/A";
        console.log("Nickname:", nickname);
        
        $.ajax({
            url: "/login/setNicknameInSession.do",
            type: "POST",
            data: { nickname: nickname },
            success: function(response) {
                if(response === "success") {
                    // 성공적으로 세션에 저장되었을 때
                    alert("로그인에 성공했습니다.");
                   // window.location.href = '/account/accountList.do';
                } else {
                    alert("닉네임을 세션에 저장하는 데 실패했습니다.");
                }
            },
            error: function(error) {
                alert('서버 에러. 다시 시도해주세요.');
            }
        });

        button_area.innerHTML += "<h3> Login 성공 </h3>" +
            "<div>user Nickname : " + nickname + "</div>" +
            "<button id='btn_logout'>로그아웃</button>";

        const logout = document.getElementById('btn_logout');
        logout.addEventListener('click', (e) => {
            naverLogin.logout();
            location.replace("http://localhost:8081/social/naverlogin.do");
        });
    }

});*/

$(document).ready(function() {
    // 네이버 로그인 설정
    const naverLogin = new naver.LoginWithNaverId({
        clientId: "VXjYInITwpfPtDZDVliJ",
        callbackUrl: "http://localhost:8081/account/accountList.do",
        isPopup: false,
        loginButton: {color: "green", type: 2, height: 40}
    });
    naverLogin.init();

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

    // 소셜 로그인 이벤트 리스너
    $("#naverIdLogin").click(function() {
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
            }
        });
    });

    function setLoginStatus(){
        console.log("setLoginStatus called.");  // 로그 추가
        const button_area = document.getElementById('button_area');
        const nickname = naverLogin.user.nickname || "N/A";
        console.log("Nickname:", nickname);
        
        console.log("Starting AJAX request.");  // AJAX 요청 시작 로그 추가
        $.ajax({
            url: "/login/setNicknameInSession.do",
            type: "POST",
            data: { nickname: nickname },
            success: function(response) {
                if(response === "success") {
                    // 성공적으로 세션에 저장되었을 때
                    alert("로그인에 성공했습니다.");
                   // window.location.href = '/account/accountList.do';
                } else {
                    alert("닉네임을 세션에 저장하는 데 실패했습니다.");
                }
            },
            error: function(error) {
                alert('서버 에러. 다시 시도해주세요.');
            }
        });
        console.log("AJAX request sent.");  // AJAX 요청 발송 로그 추가

        button_area.innerHTML += "<h3> Login 성공 </h3>" +
            "<div>user Nickname : " + nickname + "</div>" +
            "<button id='btn_logout'>로그아웃</button>";

        const logout = document.getElementById('btn_logout');
        logout.addEventListener('click', (e) => {
            naverLogin.logout();
            location.replace("http://localhost:8081/social/naverlogin.do");
        });
    }
});
