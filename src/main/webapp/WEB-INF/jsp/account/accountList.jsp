<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>  --%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		loadPageData(1);
	});

	function loadPageData(pageNo) {
		$
				.ajax({
					url : "/account/accountList2.do",
					type : "GET",
					data : {
						pageNo : pageNo
					},
					dataType : "json",
					success : function(response) {
						if (response.result === "success") {
							var tbody = $("table tbody");
							tbody.empty();
							console.log(response.paginationInfo);
							$
									.each(
											response.data,
											function(index, account) {
												var tr = $("<tr>");
												tr.append($("<td>").text(
														account.profitCost));
												tr.append($("<td>").text(
														account.bigGroup));
												tr.append($("<td>").text(
														account.middleGroup));
												tr.append($("<td>").text(
														account.smallGroup));
												tr.append($("<td>").text(
														account.detailGroup));
												tr
														.append($("<td>")
																.text(
																		account.transactionMoney));
												var dateStr = account.transactionDate ? account.transactionDate
														.substring(0, 10)
														: "";
												tr.append($("<td>").text(
														dateStr));
												tr.append($("<td>").text(
														account.writer));
												tbody.append(tr);

											});

							var paginationDiv = $(".paging");
							paginationDiv.empty();

							/*                     for (var i = 1; i <= response.paginationInfo.totalPageCount; i++) {
							 (function(page) {
							 var link = $("<button>").text(page).on('click', function() {
							 loadPageData(page);
							 });
							 paginationDiv.append(link);
							 })(i);
							 } */

							// 이전 버튼 추가
							var prevBtn = $("<button>").text("이전").on('click',
									function() {
										if (pageNo > 1) {
											loadPageData(pageNo - 1);
										}
									}).prop("disabled", pageNo === 1); // 첫 페이지라면 이전 버튼 비활성화
							paginationDiv.append(prevBtn);

							for (var i = 1; i <= response.paginationInfo.totalPageCount; i++) {
								(function(page) {
									var link = $("<button>").text(page).on(
											'click', function() {
												loadPageData(page);
											});
									if (page === pageNo) {
										link.css("font-weight", "bold"); // 현재 페이지 표시
									}
									paginationDiv.append(link);
								})(i);
							}

							// 다음 버튼 추가
							var nextBtn = $("<button>")
									.text("다음")
									.on(
											'click',
											function() {
												if (pageNo < response.paginationInfo.totalPageCount) {
													loadPageData(pageNo + 1);
												}
											})
									.prop(
											"disabled",
											pageNo === response.paginationInfo.totalPageCount); // 마지막 페이지라면 다음 버튼 비활성화
							paginationDiv.append(nextBtn);

						} else {
							alert('데이터를 불러오는데 실패했습니다.');
						}
					},
					error : function(error) {
						alert('서버 오류가 발생하였습니다.');
					}
				});
	}

	function linkPage(pageNo) {
		location.href = "/account/accountList2.do?pageNo=" + pageNo;
	}

	function excelDownload() {
		var table = $("table")[0];
		var uri = 'data:application/vnd.ms-excel;base64,', template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>', base64 = function(
				s) {
			return window.btoa(unescape(encodeURIComponent(s)));
		}, format = function(s, c) {
			return s.replace(/{(\w+)}/g, function(m, p) {
				return c[p];
			});
		};

		var ctx = {
			worksheet : name || 'Worksheet',
			table : table.innerHTML
		};

		var link = document.createElement('a');
		link.download = 'account_data.xls';
		link.href = uri + base64(format(template, ctx));
		link.click();
	}
	
	
	
	
	
	
	
</script>


<form name="sendForm" id="sendForm" method="post"
	onsubmit="return false;">
	<input type="hidden" id="situSeq" name="situSeq" value=""> <input
		type="hidden" id="mode" name="mode" value="Cre">

	<div id="wrap" class="col-md-offset-1 col-sm-10">
		<div align="center">
			<h2>회계정보리스트</h2>
		</div>
		<div class="form_box2 col-md-offset-7" align="right">
			<div class="right">
				<button class="btn btn-primary"
					onclick="location.href='/account/accountInsert.do'">등록</button>
				<button class="btn btn-primary"
					onclick="location.href='/account/excelDownload.do'">엑셀 다운</button>
				<button class="btn btn-primary" onclick="excelDownload()">엑셀
					다운2</button>


			</div>
		</div>

		<table class="table table-hover">
			<thead>
				<tr align="center">
					<th style="text-align: center;">수익/비용</th>
					<th style="text-align: center;">관</th>
					<th style="text-align: center;">항</th>
					<th style="text-align: center;">목</th>
					<th style="text-align: center;">과</th>
					<th style="text-align: center;">금액</th>
					<th style="text-align: center;">등록일</th>
					<th style="text-align: center;">작성자</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<p>
		<div style="text-align: center;" class="paging">
			<ui:pagination paginationInfo="${paginationInfo}" type="text"
				jsFunction="linkPage" />


			<%-- 	 		<ui:pagination paginationInfo="${paginationInfo}" type="text"
				jsFunction="linkPage"/>  --%>

		</div>
</form>


