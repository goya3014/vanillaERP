<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Vanilla ERP Employee Card</title>
<!-- 헤더 -->
<c:import url="/header"></c:import>


<style type="text/css">


.newBtn, .cancelBtn, .addnumBtn {
	border: 1px solid lightgray;
	color:#515151;
 	outline-color: #d5e4f1;
	height:30px;
	width: 50px;
 	margin-bottom:10px;
 	outline-color: #d5e4f1;
	cursor: pointer;
}

.cancelBtn {
	margin-left: 10px;
}

.newBtn {
	margin-left: 7%;
	margin-top: 15px;;
}

.addnumBtn {
	margin-top: 10px;
	height: 45px;
	width: 120px;
}


.board2 {
	width: 100%;
	border-collapse: collapse;
	text-align: left;
	vertical-align: center;
	display:inline-block;	
	font-size: 11pt;
}


.board2 tr {
	height: 80px;
}

.pic {
	background-color: lightgray;
	width: 180px;
	height: 230px;
	margin: 0px auto;
	background-image: url("resources/images/common/no_image.png");
	background-repeat: no-repeat;
 	background-size: 170px 175px;
	background-position: 50% 50%;
	cursor: pointer;
	margin-bottom: 5px;
}

.center {
	text-align: center;
} 

.gong {
	height: 35px !important;
}

.gong td:nth-child(2) {
	color: red;	
} 

.text, .text2, .select {
	height: 40px;
	width: 80%;
}

.select {
	width: 40%
}

.fix {
	display:table-cell;
	vertical-align: middle;
	height: 44px !important;
	width: 100% !important;
}

.gender {
 	text-indent: 20px;
}

input::placeholder {
  color: #c5c5c5;
  font-style: italic;
}

[disabled="disabled"] {
	background-color: #aeaeae;
	color: #e8e8e8;
	border: 0px;
}

#add {
	width: 42%;
	margin-right: 15px;
}

#addnum {
	width: 15%;
	margin-right: 15px ;	
}

#detailAdd {
	width: 85%;
}

</style>

<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#postcodify").postcodifyPopUp();
	        
	$("#postcodify").postcodify({
		insertPostcode5 : "#addnum",
		insertAddress : "#add",
		insertDetails : "#add",
		insertExtraInfo : "#detailAdd",
		hideOldAddresses : false
	});
	
	$(".pic").on("click",function(){
		$("#picFile").click();
	});//사진 업로드 
	
	$("#picFile").on("change", function() {
		var fileForm = $("#fileForm");
		fileForm.ajaxForm({ 
			success: function(responseText, statusText){
				if(responseText.result =="SUCCESS"){
					$(".pic").css("background-image", "url('resources/upload/" + responseText.fileName[0] + "')");
					$(".pic").css("background-size", "100% 100%");
					$("#picName").val(responseText.fileName[0]);
					console.log($("#picName").val());
				} else {
					makeAlert(1, "알림", "저장이 실패하였습니다.", null);
				} 
			}, //ajax error
			error : function(request, status, error) { //값이 돌아오지 않는 등 실행 중 에러 발생 시 이 함수 실행
				makeAlert(1, "알림", "저장중 문제가 발생하였습니다.", null);
				console.log("text : " + request.responseText); //반환텍스트 
				console.log("error : " + error); //에러 내용 
			}
		});//ajaxForm 할당 
		
		fileForm.submit();
	});
	
	
	$(".newBtn").on("click",function(){
		
		var cnt2 = 0;
		var temp = 0;
		
		$(".text").each(function() {
			
			if($(this).val() == "") {
				console.log(temp);
				console.log($(this).val());
				cnt2++;
			}
			temp++;
		});
		
		if(!$("input:radio[name='solun']").is(":checked")) {
			console.log("01");
			cnt2++;
		}
		
		if(!$("input:radio[name='gender']").is(':checked')) {
			console.log("02");
			cnt2++;
		}

		if($("select option:selected").val()=="선택") {
			console.log("03");
			cnt2++;
		} 
		
		if(cnt2 > 0){
			makeAlert(1, "알림", "필수 입력사항을 입력해 주세요.", null);
		} else if($("[name='clphnNo']").val() == $("[name='spareNo']").val()) {
			makeAlert(1, "알림", "예비번호는 휴대전화 외의 번호를 기입해주세요.", null);
		} else {
			
			var params = $("#actionForm").serialize(); //제이쿼리로 해결
						
			$.ajax({ //겟방식? 포스트방식?
				type : "post", //전송방식 (포스트로 보내겠다)
				url : "empUpdateAjax", //주소 호출 (값이랑 보내는)
				dataType : "json",  //데이터형태 - 일반적으로 아작스는 json많이 씀. 바로 매칭 돼서. 별도 가공 불필요.
				//겟방식 / 포스트방식 따라 따로따로 동작할 수 있는 함수 이따 배울 것 
				data : params, //보낼 데이터 - 상황에 따라 없을 수 있음 
				success : function(res) { //성공적으로 넘어갔을때 이 함수 실행하며, 돌아오는 값을 res란 이름으로 받는다.
					console.log(res.result);
						if(res.result == "success"){
							
							console.log($("#picname").val());
							makeAlert(1, "알림", "등록되었습니다.", true, function(){
								$("#backForm").submit();
							});

						} else if(res.result == "fail") {
							makeAlert(1, "알림", "동일한 이메일이 있습니다. 이메일을 수정하세요.", null);
						} else if(res.result == "fail2") {
							makeAlert(1, "알림", "수정 중 오류가 발생하였습니다", null);
						}
					},
				error : function(request, status, error) { //값이 돌아오지 않는 등 실행 중 에러 발생 시 이 함수 실행
									
					console.log("text : " + request.responseText); //반환텍스트 
					console.log("error : " + error); //에러 내용 
				} //{ name: "이재희", 키: 값, ...} 중괄호, 키, 값으로 이루어진 전송 규격 = json
			});//ajax
			
			
		}
	});

	$(".cancelBtn").on("click",function(){
		makeAlert(1, "알림", "정말 취소하시겠습니까?", true, function(){
			history.back();
		});
	});
	
	
});//document ready end


</script>


</head>
<body>
<!-- 탑/레프트 -->
<c:import url="/topLeft">
<%-- 현재 페이지 해당 메뉴번호 지정 --%>
	<c:param name="menuNo" value="41"></c:param> <%-- gnb --%>
</c:import>
<!-- 구현내용 -->
<div class="title_wrap">
	<div class="title_table">
		<div class="title_txt">인사카드관리 수정</div>
	</div>
</div>
<div class="contents_area">
	<!-- 내용은 여기에 구현하세요. -->
	
<form action="emplyCardRead" id="backForm" method="post">
	<input type="hidden" name="sEmplyNo" id="sEmplyNo" value="${sEmplyNo}">
	<input type="hidden" name="page" id="page" value="${param.page}"/>
	<input type="hidden" name="sAthrtyNo" id="sAthrtyNo" value="${sAthrtyNo}">
	<input type="hidden" name="searchTxt" class="search" value="${param.searchTxt}">
	<input type="hidden" name="checkEmplyNo" id="checkEmplyNo" value="${param.checkEmplyNo}"/>	
</form>
	
<form id="fileForm" name="fileForm" action="fileUploadAjax" method="post" enctype="multipart/form-data">
    <input type="file" name="picFile" id="picFile" style="display:none;" accept="image/*"/>
</form>


<div class="tbl1">
<form action="#" id="actionForm">
	<input type="hidden" name="checkEmplyNo" id="checkEmplyNo" value="${param.checkEmplyNo}"/>
	<input type="hidden" id="picName" name="picName" value="${data.PHTGR}"/>
	<input type="button" value="완료" class="newBtn">
	<input type="button" value="취소" class="cancelBtn">
	<table class="board2">
		<colgroup>
			<col width="500px"/>
			<col width="250px" />
			<col width="550px"/>
			<col width="250px"/>
			<col width="550px"/>
		</colgroup>
		<tbody>
			<tr class="gong">
				<td rowspan="4" class="center">
				<div class="pic" style="background-image:url('resources/upload/${data.PHTGR}'); background-size: 100% 100%;"></div>
				사원번호 ${data.EMPLY_NO}</td> <!-- 사진 넣는 div:pic -->
				<td colspan="4">* 표시는 필수 입력사항입니다.</td>
			</tr>
			<tr>
				<td>이름* </td>
				<td> <input type="text" class="text" name="eName" value="${data.EMPLY_NAME}"></td>
				<td> </td>
				<td></td>
			</tr>
			<tr>
				<td>생년월일* </td>
				<td><input type="number" class="text" placeholder="20200625" name="eBirth" value="${data.BIRTH}"></td>
				<td><div class="fix">
				<c:choose>
					<c:when test="${data.SOLAR_LUNAR eq 0}">
						<input type="radio" name="solun" value="0" checked="checked"/>양력 <input type="radio" name="solun" value="1"/>음력
					</c:when>
					<c:when test="${data.SOLAR_LUNAR eq 1}">
						<input type="radio" name="solun" value="0"/>양력 <input type="radio" name="solun" value="1" checked="checked"/>음력
					</c:when>
				</c:choose>
				</div></td>
				<td class="gender">성별* 
				<c:choose>
					<c:when test="${data.GNDER eq 1}">
					<input type="radio" name="gender" value="1" checked="checked"/>여 <input type="radio" name="gender" value="0"/>남
					</c:when>
					<c:when test="${data.GNDER eq 0}">
					<input type="radio" name="gender" value="1"/>여 <input type="radio" name="gender" value="0" checked="checked"/>남
					</c:when>
				</c:choose>	
				</td>
			</tr>
			<tr>
				<td>주소* </td>
				<td colspan="2"><div class="fix"><input type="text" class="text postcodify_address" id="add" name="adrs" value="${data.ADRS}">
				<input type="text" class="text postcodify_postcode" id="addnum" name="pstcd" value="${data.PSTCD}">
				<input type="button" value="우편번호 찾기" class="addnumBtn" id="postcodify"></div></td>
				<td>최종학력* 
					<select class="select" name="edctn">
						<c:choose>
							<c:when test="${data.EDCTN eq 0}">
								<option>선택</option>
								<option value="0" selected="selected">고졸</option>
								<option value="1">대졸(2,3년제)</option>
								<option value="2">대졸(4년제)</option>
								<option value="3">대학원졸</option>
							</c:when>
							<c:when test="${data.EDCTN eq 1}">
								<option>선택</option>
								<option value="0">고졸</option>
								<option value="1" selected="selected">대졸(2,3년제)</option>
								<option value="2">대졸(4년제)</option>
								<option value="3">대학원졸</option>
							</c:when>
							<c:when test="${data.EDCTN eq 2}">
								<option>선택</option>
								<option value="0">고졸</option>
								<option value="1">대졸(2,3년제)</option>
								<option value="2" selected="selected">대졸(4년제)</option>
								<option value="3">대학원졸</option>
							</c:when>
							<c:when test="${data.EDCTN eq 3}">
								<option>선택</option>
								<option value="0">고졸</option>
								<option value="1">대졸(2,3년제)</option>
								<option value="2">대졸(4년제)</option>
								<option value="3" selected="selected">대학원졸</option>
							</c:when>
						</c:choose>
						
					</select>
				</td>
			</tr>
			
			<tr>
				<td rowspan="4"></td>
				<td colspan="4"><input type="text" class="text postcodify_details" id="detailAdd" name="dtlAdrs" placeholder="상세주소" value="${data.DTL_ADRS}"></td>
			</tr>
			<tr>
				<td>휴대전화* </td>
				<td><input type="number" class="text" placeholder="01012345678" name="clphnNo" value="${data.CLPHN_NO}"></td>
				<td>예비번호 </td>
				<td><input type="number" class="text2" placeholder="01023456789" name="spareNo" value="${data.SPARE_NO}"></td>
			</tr>
			<tr>
				<td>이메일* </td>
				<td><input type="text" class="text" name="email" value="${data.EMAIL}"></td>
				<td> </td>
				<td></td>
			</tr>
		</tbody>
	</table>
	</form>
			</div>
		</div>



<c:import url="/bottom"></c:import>
</body>
</html>