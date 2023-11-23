<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script
	src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"
	charset="utf-8"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {

						//이메일 인증

						var emailChecked = false;
						var phoneChecked = false;

						$("#mail-Check-Btn")
								.click(
										function() {

											var email = $('#email').val();
											var checkInput = $('.mail-check-input');

											// 이메일 유효성 검사
											var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
											if (!email.match(emailPattern)) {
												alert('올바른 이메일 형식을 입력해주세요.');
												return;
											}

											$.ajax({
												type : 'GET',
												url : "/user/emailCheck.do",
												data : {
													email : email
												},
												success : function(data) {
													console
															.log("data :"
																	+ data);
													checkInput.attr('disabled',
															false);
													code = data;
													alert('인증번호가 전송되었습니다.');
												}

											});
										});

						$('.mail-check-input').blur(function() {
							const inputCode = $(this).val();
							const $resultMsg = $('#mail-check-warn');

							if (inputCode === code) {
								$resultMsg.html('인증번호가 일치합니다.');
								$resultMsg.css('color', 'green');
								$('#mail-Check-Btn').attr('disabled', true);
								$('#email').attr('readonly', true); // Email 입력 필드를 읽기 전용으로 설정
								
								emailChecked = true;
							} else {
								$resultMsg.html('인증번호가 일치하지 않습니다.');
								$resultMsg.css('color', 'red');
								
								emailChecked = false;
							}
						});

						// 휴대폰 인증

						$("#phone-Check-Btn").click(function() {

							var phone = $('#phone').val();
							var checkInput = $('.phone-check-input');

							// 휴대폰 유효성 검사
							var phonePattern = /^\d{11}$/;
							if (!phone.match(phonePattern)) {
								alert('올바른 휴대폰번호 형식을 입력해주세요.');
								return;
							}

							$.ajax({
								type : 'GET',
								url : "/user/message.do",
								data : {
									phone : phone
								},
								success : function(data) {
									console.log("data :" + data);
									checkInput.attr('disabled', false);
									code = data;
									alert('인증번호가 전송되었습니다.');
								}

							});
						});

						$('.phone-check-input').blur(function() {
							const inputCode = $(this).val();
							const $resultMsg = $('#phone-check-warn');

							if (inputCode === code) {
								$resultMsg.html('인증번호가 일치합니다.');
								$resultMsg.css('color', 'green');
								$('#phone-Check-Btn').attr('disabled', true);
								$('#phone').attr('readonly', true); //  입력 필드를 읽기 전용으로 설정
								
								phoneChecked = true;
							} else {
								$resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
								$resultMsg.css('color', 'red');
								
								phoneChecked = false;
							}
						});

						var isIdChecked = false; // 중복체크를 위한 중복 체크 상태와 아이디 저장하는 변수
						var checkedUserId = '';

						$("#idcked").click(function() {
							var userId = $("#memId").val();
							if (!userId || /\s/.test(userId)) {
								alert('아이디에 공백을 포함할 수 없습니다.');
								return;
							}
							$.ajax({
								url : "/user/idCheck.do",
								type : 'POST',
								data : {
									"userId" : userId
								},
								success : function(response) {
									if (response === "1") {
										alert('이미 사용 중인 아이디입니다.');
										isIdChecked = false;
									} else if (response === "0") {
										alert('사용 가능한 아이디입니다.');
										isIdChecked = true; // 중복 체크 통과
										checkedUserId = userId; // 중복 체크를 통과한 아이디 저장
									}
								},
								error : function() {
									alert('서버 오류');
								}
							});
						});

						
						//주소

						
						
						$("#saveBtn")
								.click(
										function() {
											var userId = $("#memId").val();
											var password = $("#pwd").val();
											var passwordConfirm = $("#pwdck")
													.val();
											var username = $("#memName").val();

											if (userId.length < 6) {
												alert('아이디는 6글자 이상이어야 합니다.');
												return;
											}

											var passwordPattern = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).{6,12}$/;
											if (!password
													.match(passwordPattern)) {
												alert('비밀번호는 6~12글자 사이이며, 영문, 숫자, 특수문자를 포함해야 합니다.');
												return;
											}

											if (password !== passwordConfirm) {
												alert('패스워드가 일치하지 않습니다.');
												return;
											}

											if (!username
													|| /\s/.test(username)) {
												alert('이름에 공백을 포함할 수 없습니다.');
												return;
											}

											if (!isIdChecked
													|| checkedUserId !== userId) {
												alert('아이디 중복 체크를 해주세요.');
												return;
											}

											var frontNum = $(
													"#residentNumFront").val();
											var backNum = $("#residentNumBack")
													.val();
											var fullNum = frontNum + '-'
													+ backNum;

											// 주민번호 정규식 검사
											var regExp = /^\d{2}([0]\d|[1][0-2])([0][1-9]|[1-2]\d|[3][0-1])[-]*[1-4]\d{6}$/;

											if (!regExp.test(fullNum)) {
												alert('주민번호를 확인해주세요.');
												return;
											}

											// 현재 연도 가져오기
											var currentYear = new Date()
													.getFullYear();

											// 주민번호 앞자리의 앞 두 자리를 연도로 사용
											var birthYear = parseInt(frontNum
													.substr(0, 2), 10);

											// 1900년대와 2000년대 구분
											if (backNum.charAt(0) == "1"
													|| backNum.charAt(0) == "2") {
												birthYear += 1900;
											} else if (backNum.charAt(0) == "3"
													|| backNum.charAt(0) == "4") {
												birthYear += 2000;
											}

											// 나이 계산
											var age = currentYear - birthYear;

											// 성별 판별
											var gender;
											if (backNum.charAt(0) == "1"
													|| backNum.charAt(0) == "3") {
												gender = "남자";
											} else if (backNum.charAt(0) == "2"
													|| backNum.charAt(0) == "4") {
												gender = "여자";
											} else {
												alert('올바르지 않은 주민번호입니다.');
												return;
											}

											var email = $("#email").val();
											var phone = $("#phone").val();
											var address = $("#address").val();

											// 이메일 유효성 검사
											var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
											if (!email.match(emailPattern)) {
												alert('올바른 이메일 형식을 입력해주세요.');
												return;
											}

											if (!emailChecked) {
												alert('이메일 인증을 완료해주세요.');
												return;
											}

											// 핸드폰 번호 유효성 검사
											var phonePattern = /^\d{11}$/;
											if (!phone.match(phonePattern)) {
												alert('올바른 핸드폰 번호 형식을 입력해주세요. (ex: 01012345678)');
												return;
											}

											if (!phoneChecked) {
												alert('휴대전화 번호 인증을 완료해주세요.');
												return;
											}

											// 주소 유효성 검사 (여기서는 간단한 길이만 체크)
											if (address.length < 5) {
												alert('올바른 주소를 입력해주세요.');
												return;
											}

											var formData = {
												userId : userId,
												pwd : password,
												userName : username,
												residentNum : frontNum + '-'
														+ backNum,
												age : age,
												gender : gender,
												email : email,
												phoneNum : phone,
												address : address
											};

											$
													.ajax({
														url : "/user/createUser.do",
														type : 'POST',
														contentType : 'application/json',
														data : JSON
																.stringify(formData),
														dataType : 'json',
														success : function(
																response) {
															if (response.result === "success") {
																alert('회원가입 성공');
																window.location.href = '/login/login.do';
															} else {
																alert('회원가입 실패: '
																		+ response.message);
															}
														},
														error : function() {
															alert('서버 오류');
														}
													});
										});

					});
	
	

	function goPopup() {
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://business.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
		var pop = window.open("/user/jusoPopup.do", "pop",
				"width=570,height=420, scrollbars=yes, resizable=yes");

	}
	/** API 서비스 제공항목 확대 (2017.02) **/
	function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail,
			roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,
			detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn,
			buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {

		// 도로명 주소, 상세 주소, 그리고 도로명 주소의 나머지 부분을 연결하여 전체 주소를 만듭니다.
		var fullAddress = roadAddrPart1 + " " + addrDetail + " "
				+ roadAddrPart2;

		// ID를 사용하여 'address' input 요소에 직접 접근하여 값을 설정합니다.
		document.getElementById("address").value = fullAddress;
	}
	

	
</script>

<div class="container" style="margin-top: 50px">

	<form class="form-horizontal" id="sendForm">
		<div class="form-group">
			<label class="col-sm-2 control-label">ID</label>
			<div class="col-sm-4">
				<input class="form-control" id="memId" name="memId" type="text"
					value="" title="ID">
			</div>

			<div class="container">
				<button type="button" id="idcked" class="btn btn-default"
					style="display: block;">ID 중복 체크</button>
			</div>

		</div>

		<div class="form-group">
			<label for="disabledInput " class="col-sm-2 control-label">패스워드</label>
			<div class="col-sm-4">
				<input class="form-control" id="pwd" name="" type="password"
					title="패스워드">
			</div>
			<label for="disabledInput " class="col-sm-2 control-label">패스워드
				확인</label>
			<div class="col-sm-4">
				<input class="form-control" id="pwdck" name="" type="password"
					title="패스워드 확인">
			</div>
		</div>

		<div class="form-group">
			<label for="disabledInput" class="col-sm-2 control-label">이름</label>
			<div class="col-sm-4">
				<input class="form-control" id="memName" name="memName" type="text"
					value="" title="이름">
			</div>
		</div>

		<div class="form-group">
			<label class="col-sm-2 control-label">주민번호</label>
			<div class="col-sm-4">
				<input class="form-control" id="residentNumFront"
					name="residentNumFront" type="text" maxlength="6"
					placeholder="앞 6자리">
			</div>
			<div class="col-sm-4">
				<input class="form-control" id="residentNumBack"
					name="residentNumBack" type="password" maxlength="7"
					placeholder="뒷 7자리">
			</div>
		</div>



		<!-- 이메일 인증 -->
		<div class="form-group">
			<label class="col-sm-2 control-label">이메일</label>
			<div class="col-sm-6">
				<input class="form-control" id="email" name="email" type="email"
					placeholder="이메일 주소 입력">
			</div>
			<div class="col-sm-4">
				<button type="button" id="mail-Check-Btn" class="btn btn-default">인증번호
					보내기</button>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">이메일 인증번호 입력</label>
			<div class="col-sm-6">
				<input class="form-control mail-check-input"
					placeholder="인증번호 6자리를 입력해주세요" disabled="disabled" maxlength="6">
			</div>
			<div class="col-sm-4">
				<span id="mail-check-warn"></span>
			</div>
		</div>

		<!-- 휴대전화 인증 -->
		<div class="form-group">
			<label class="col-sm-2 control-label">휴대전화</label>
			<div class="col-sm-6">
				<input class="form-control" id="phone" name="phone" type="tel"
					placeholder="휴대전화번호 입력  ex)01012345678">
			</div>
			<div class="col-sm-2">
				<button type="button" id="phone-Check-Btn" class="btn btn-default">인증번호
					보내기</button>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">휴대폰 인증번호 입력</label>
			<div class="col-sm-6">
				<input class="form-control phone-check-input"
					placeholder="인증번호 6자리를 입력해주세요" disabled="disabled" maxlength="6">
			</div>
			<div class="col-sm-4">
				<span id="phone-check-warn"></span>
			</div>
		</div>

		<!-- 주소 -->
		<div class="form-group">
			<label class="col-sm-2 control-label">주소</label>
			<div class="col-sm-8">
				<input class="form-control" id="address" name="address"
					disabled="disabled" type="text" placeholder="주소 입력">
			</div>
			<div class="col-sm-2">
				<button type="button" id="addressSearchBtn" class="btn btn-default"
					onclick="goPopup()">주소검색</button>

			</div>
		</div>

		<!-- 소셜 로그인 -->
		<div class="form-group">
			<label class="col-sm-2 control-label">소셜 로그인</label>
			<div class="col-sm-10" id="naverIdLogin"></div>
		</div>


		<div class="col-md-offset-4">
			<button type="button" id="saveBtn" class="btn btn-primary">저장</button>
			<button type="button" id="#" class="btn btn-danger"
				onclick="location.href='/login/login.do'">취소</button>
		</div>
	</form>