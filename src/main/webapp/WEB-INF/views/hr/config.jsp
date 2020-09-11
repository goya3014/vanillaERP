<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Vanilla ERP Config</title>
<!-- 헤더 -->
<c:import url="/header"></c:import>

<style type="text/css">
#psrd {
	height: 18px;
	margin-right: 10px;
}

#psrd, .okBtn {
	vertical-align: top;
}
</style>

<script type="text/javascript">
$(document).ready(function(){
	$(".okBtn").on("click",function(){
		console.log($("#emplyCheckNo").val());
		console.log($("#psrd").val());
		//비밀번호 맞으면 myInfo로 넘어가기 
		 if(checkEmpty("#psrd")) {
			makeAlert(1, "로그인 안내", "비밀번호를 입력해 주세요.", true, function() {
				$("#psrd").focus();
			});
		} else {
			var params = $("#dataForm").serialize();
			
			$.ajax({
				type : "post",
				url : "loginPasswordAjax",
				dataType : "json",
				data : params,
				success : function(result) {
					if(result.res == "success") {
						console.log("success");
						
						$("#dataForm").attr("action","myinfo");
						$("#dataForm").submit();
						
						
					} else if(result.res == "fail") {
						makeAlert(1, "로그인 실패", "비밀번호가 틀렸습니다.", true, null);
					} else {
						makeAlert(1, "로그인 경고", "로그인 체크 중 문제가 발생하였습니다.", true, null);
					}
				},
				error : function(request, status, error) {
					console.log("status : " + request.status);
					console.log("text : " + request.responseText);
					console.log("error : " + error);
				}
			});//ajax
		}
		
	});//확인 버튼 눌렀을 때 
});//document ready end
</script>
</head>
<body>
<!-- 탑/레프트 -->
<c:import url="/topLeft">
<%-- 현재 페이지 해당 메뉴번호 지정 --%>
	<c:param name="menuNo" value=""></c:param>
</c:import>
<!-- 구현내용 -->
<div class="title_wrap">
	<div class="title_table">
		<div class="title_txt">나의 정보(본인인증)</div>
	</div>
</div>
<div class="contents_area">
	<!-- 내용은 여기에 구현하세요. -->
	
	비밀번호 확인*<br/>
	<form action="#" id="dataForm" method="post">
		<input type="hidden" name="checkEmplyNo" id="checkEmplyNo" value="${sEmplyNo}">
		<input type="password" name="psrd" id="psrd"> <input type="button" class="okBtn" value="확인">
	</form>
	
</div><!-- contents area -->
<!-- 구현끝 -->
<!-- 바텀 -->
<c:import url="/bottom"></c:import>
</body>
</html>