<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>



$(document).ready(function(){
  
    var accountId = getParameterByName('id');

    if (accountId) {
        updateDropdown(); 
    } 

 	function getParameterByName(name) {
        var url = window.location.href;
        name = name.replace(/[\[\]]/g, "\\$&");
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    } 

    var dropdownUpdated = false; 

     function updateDropdown() {
        if (!dropdownUpdated) { 
            $.ajax({
                url: "/account/selectCombo2.do",
                type: "GET",
                data: { id: accountId },
                dataType: "json",
         
                success: function(data) {

                    $("#profitCost").val(data.data.profitCost);   
                    $("#comment").val(data.data.comments);
                    $("#transactionMoney").val(data.data.transactionMoney);
                    var transactionDate = data.data.transactionDate.split(" ")[0];
                    $("#transactionDate").val(transactionDate);

                    updateDropdown2("bigGroup", data.data.profitCost, function() {
                    	$("#bigGroup").val(data.data.bigGroup)
                        updateDropdown2("middleGroup", data.data.bigGroup, function() {
                        	$("#middleGroup").val(data.data.middleGroup);
                            updateDropdown2("smallGroup", data.data.middleGroup, function() {
                            	$("#smallGroup").val(data.data.smallGroup);
                                updateDropdown2("comment1", data.data.smallGroup, function() {
                                	$("#comment1").val(data.data.detailGroup);  
                                	dropdownUpdated = true;
                                });
                            });
                        });
                    });
                },
                error: function(error) {
                    alert('서버 오류가 발생하였습니다.');
                }
            });
        }
    }
 

    function updateDropdown2(dropdownType, selectedValue, callback) {
       $.ajax({
           url: "/account/selectCombo.do",
           type: "POST",
           data: {
               dropdownType: dropdownType,
               code: selectedValue
           },
           dataType: "json",
           success: function (data) {
               var dropdown = $("#" + dropdownType);
               dropdown.empty();
               dropdown.append("<option value=''>선택</option>");
               $.each(data, function (index, item) {
                   dropdown.append("<option value='" + item.code + "'>" + item.comKor + "</option>");
               });

               if(callback) callback();
           }
       });
   }  
 
    
	$("#profitCost").change(function() {
	    var selectedValue = $(this).val();
	    if(selectedValue != "") {
	        updateDropdown2("bigGroup", selectedValue);
	        console.log(selectedValue);
 	        $("#middleGroup, #smallGroup, #comment1").empty().append("<option value=''>해당없음</option>");

	    }
	});

	$("#bigGroup").change(function() {
	    var selectedValue = $(this).val();
	    if(selectedValue != "") {
	        updateDropdown2("middleGroup", selectedValue);
	        console.log(selectedValue);
 	        $("#smallGroup, #comment1").empty().append("<option value=''>해당없음</option>"); 

	    }
	});
	
	$("#middleGroup").change(function() {
	    var selectedValue = $(this).val();
	    if(selectedValue != "") {
	        updateDropdown2("smallGroup", selectedValue);
	        console.log(selectedValue);
 	        $("#comment1").empty().append("<option value=''>해당없음</option>");

	    }
	});
	
 	$("#smallGroup").change(function() {
	    var selectedValue = $(this).val();
	    if(selectedValue != "") {
	        updateDropdown2("comment1", selectedValue);
	        console.log(selectedValue);
	    }
	});  
 	
 	$("#updateAccount").click(function() {
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
 		
 	    console.log(accountId);
 	    
   		var formData = {
 		        accountSeq: accountId,
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
 	        url: "/account/updateAccount.do",
 	        type: "PUT",
 	        contentType: 'application/json',
 	        data: JSON.stringify(formData),
 	        dataType: "json",
 	        success: function(response) {
 	            if (response.result === "success") {
 	                alert('데이터가 성공적으로 수정되었습니다.'); 
 	                location.href = '/account/accountList.do';
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
			 
			 		<button type="button" id="updateAccount" class="btn btn-primary">수정</button>
			  		<button type="button" id="#" class="btn btn-warning" onclick="location.href='/account/accountList.do'">취소</button>
		 		
			 </div>
		</div>
	</div>
</div>

<!-- 비용 END -->