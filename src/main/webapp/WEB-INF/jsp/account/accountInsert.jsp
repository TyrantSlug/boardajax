<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>


$(document).ready(function(){

	function updateDropdown(dropdownType, selectedValue) {
	    $.ajax({
	        url: "/account/selectCombo.do",
	        type: "POST",
	        data: { 
	            dropdownType: dropdownType,
	            code: selectedValue
	        },
	        dataType: "json",
	        success: function(data) {
	            var dropdown = $("#" + dropdownType);
	            dropdown.empty();
	            dropdown.append("<option value=''>선택</option>");
	            $.each(data, function(index, item) {
	                dropdown.append("<option value='" + item.code + "'>" + item.comKor + "</option>");
	            });
	        }
	    });
	}

	$("#profitCost").change(function() {
	    var selectedValue = $(this).val();
	    if(selectedValue != "") {
	        updateDropdown("bigGroup", selectedValue);
 	        $("#middleGroup, #smallGroup, #comment1").empty().append("<option value=''>해당없음</option>");

	    }
	});

	$("#bigGroup").change(function() {
	    var selectedValue = $(this).val();
	    if(selectedValue != "") {
	        updateDropdown("middleGroup", selectedValue);
 	        $("#smallGroup, #comment1").empty().append("<option value=''>해당없음</option>"); 

	    }
	});
	
	$("#middleGroup").change(function() {
	    var selectedValue = $(this).val();
	    if(selectedValue != "") {
	        updateDropdown("smallGroup", selectedValue);
 	        $("#comment1").empty().append("<option value=''>해당없음</option>");

	    }
	});
	
 	$("#smallGroup").change(function() {
	    var selectedValue = $(this).val();
	    if(selectedValue != "") {
	        updateDropdown("comment1", selectedValue);
	    }
	}); 
 	
 	$("#insertAccount").click(function() {
 		var sessionId = "${sessionScope.user}";
  		var transactionMoney = $("#transactionMoney").val();
 		var transactionMoneyPattern = /^(?=.*[0-9]).{1,12}$/;
 		
 		if ($("#profitCost").val() == "") {
 	        alert("수익/비용을 선택해 주세요.");
 	        return;
 	    } else if ($("#bigGroup").val() == "") {
 	        alert("관을 선택해 주세요.");
 	        return;
 	    } else if ($("#middleGroup").val() == "" ) { 
 	        alert("항을 선택해 주세요.");
 	        return;
 	    }
 		
 	    if (transactionMoney == "") {
 	        alert("금액을 입력해주세요.");
 	        return;
 	    } else if (!transactionMoney.match(transactionMoneyPattern)) {
 	        alert("금액은 11자리 이하의 정수만 입력할 수 있습니다.");
 	        return;
 	    } else if ($("#transactionDate").val() == "") {
 	        alert("거래일자를 입력해 주세요.");
 	        return;
 	    }
 		
   		var formData = {
 		        profitCost: $("#profitCost").val(),
 		        bigGroup: $("#bigGroup").val(),
 		        middleGroup: $("#middleGroup").val(),
 		        smallGroup: $("#smallGroup").val(),
 		        detailGroup: $("#comment1").val(),
 		        comments: $("#comment").val(),
 		        transactionMoney: transactionMoney,
 		        transactionDate: $("#transactionDate").val(),
 		        writer: sessionId
 		    };  

 	 	 $.ajax({
 	        url: "/account/insertAccount.do",
 	        type: "POST",
 	        contentType: 'application/json',
 	        data: JSON.stringify(formData),
 	        dataType: "json",
 	        success: function(response) {
 	            if (response.result === "success") {
 	                alert('데이터가 성공적으로 저장되었습니다.'); 
 	                var id = response.accountSeq;
 	                location.href = '/account/accountUpdate.do?id=' + id; 
 	            } else {
 	                alert('데이터 저장에 실패하였습니다.');
 	            }
 	        },
 	        error: function(error) {
 	            alert('서버 오류가 발생하였습니다.');
 	        }
 	    }); 


 	}); 
});


</script>

<!-- 비용 START -->
<div class="container" style="margin-top: 50px">
	<div class="col-sm-12"><label for="disabledInput" class="col-sm-12 control-label"></label></div>
	<div class="col-sm-12"><label for="disabledInput" class="col-sm-12 control-label"></label></div>
	<div class="col-sm-12"><label for="disabledInput" class="col-sm-12 control-label"></label></div>
	<div class="col-sm-12"><label for="disabledInput" class="col-sm-12 control-label"></label></div>



	<div class="col-sm-11" id="costDiv">
		<div>
			<div class="col-sm-11">
			 		<div class="col-sm-12">
				      <div class="col-sm-3">
						<select class="form-control" id="profitCost" name="profitCost" title="비용">
				        	<option value="">선택</option>
				         	<c:forEach var="list" items="${resultMap}" varStatus="cnt">
					        	<option value="${list.code}">${list.comKor}</option>
				        	</c:forEach> 
				        </select>
				      </div>

				      <div class="col-sm-3">
						<select class="form-control" id="bigGroup"  name="bigGroup" title="관">
				        	<option value="">선택</option>				        
				        </select>
				      </div>

				      <div class="col-sm-3">
						<select class="form-control" id="middleGroup" name="middleGroup"  title="항">
					        	<option value="0">해당없음</option>
				        </select>
				      </div>

				      <div class="col-sm-3">
						<select class="form-control" id="smallGroup" name="smallGroup" title="목">
					        	<option value="0">해당없음</option>
				        </select>
				      </div>
			 		</div>

			 		<div class="col-sm-12">  <label for="disabledInput" class="col-sm-12 control-label"> </label></div>
			 		<div class="col-sm-12">
			 			  <div class="col-sm-3">
								<select class="form-control" id="comment1" name="comment1" title="과">
							        	<option value="0">해당없음</option>
						        </select>
					      </div>
				      <div class="col-sm-9">
				      		<input class="form-control " id="comment" name="comment" type="text" value="" placeholder="비용 상세 입력" title="비용 상세">
				      </div>
			 		</div>

				<div class="col-sm-12">  <label for="disabledInput" class="col-sm-12 control-label"> </label></div>
			 		<div class="col-sm-12">
			 		  <label for="disabledInput" class="col-sm-1 control-label"><font size="1px">금액</font></label>
				      <div class="col-sm-3">
				        	<input class="form-control" id="transactionMoney" name="transactionMoney" type="text" value="" title="금액">  
				      </div>
			 		  <label for="disabledInput" class="col-sm-1 control-label"><font size="1px">거래일자</font></label>
				      <div class="col-sm-3">
				       	 <input class="form-contro datepicker col-sm-2" id="transactionDate" name="transactionDate" type="text" value="" style="width: 80%" title="거래일자">
				      </div>
			 		</div>
					
					<div class="col-sm-12"><label for="disabledInput" class="col-sm-12 control-label"></label></div>
					<div class="col-sm-12"><label for="disabledInput" class="col-sm-12 control-label"></label></div>
			 
			 		<button type="button" id="insertAccount" class="btn btn-primary">등록</button>
			  		<button type="button" id="#" class="btn btn-warning" onclick="location.href='/account/accountList.do'">취소</button>
		 		
			 </div>
		</div>
	</div>
</div>

<!-- 비용 END -->