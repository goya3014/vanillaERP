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

.updateBtn, .deleteBtn, .cancelBtn, .addnumBtn {
	border: 1px solid lightgray;
 	color:#515151;
 	outline-color: #d5e4f1;
	height:30px;
	width: 50px;
 	outline-color: #d5e4f1;
	cursor: pointer;
}

.topBtn {
	display: inline-block;
	margin-left: 7%;
	margin-top: 15px;
	margin-bottom:10px;
	
	
}

.topBtn > [type='button'] {
	margin-right: 7px;
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
	background-image: url("images/temp.jpg");
	background-repeat: no-repeat;
	background-size: 190px 230px;
	background-position: 50% 50%;	
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

.text, .select {
	height: 40px;
	width: 80%;
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
<script type="text/javascript">
$(document).ready(function() {
	
	$(".updateBtn").on("click",function(){
		$("#actionForm").attr("action","emplyCardUpdate");
		$("#actionForm").submit();
	}); //updateBtn
	
	$(".cancelBtn").on("click",function(){
		$("#actionForm").attr("action","emplyCard");
		$("#actionForm").submit();
	}); //cancelBtn
	
	/* makeAlert(1, "Information", "정보내용!!!", null);
	makeOneBtnPopup(2, "팝업제목", "이거슨내용임", true, 400, 500, null, "확인용", function() {
		closePopup(2);
	});
	makeTwoBtnPopup(3, "팝업제목2", "이거슨내용임22", true, 400, 500, null, "바꾸기", function() {
		popupBtnChange(4, 1, "바꿔!", function() {
			popupContentsChange(4, "내용도바꿔~", null);
		});
	}, "확인용", function() {
		closePopup(3);
	}); */
	
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
		<div class="title_txt">인사카드관리 개별조회</div>
	</div>
</div>
<div class="contents_area">
	<!-- 내용은 여기에 구현하세요. -->
	
<form action="#" id="actionForm" method="post">
	<input type="hidden" name="sEmplyNo" id="sEmplyNo" value="${sEmplyNo}">
	<input type="hidden" name="page" id="page" value="${param.page}"/>
	<input type="hidden" name="sAthrtyNo" id="sAthrtyNo" value="${sAthrtyNo}">
	<input type="hidden" name="searchTxt" id = "searchTxt" class="search" value="${param.searchTxt}">
	<input type="hidden" name="checkEmplyNo" id="checkEmplyNo" value="${param.checkEmplyNo}"/>	
</form>

<div class="tbl1">
	<div class="topBtn">
		<c:if test="${sAthrtyNo eq 1 or sAthrtyNo eq 2 or sAthrtyNo eq 4 or sAthrtyNo eq 5}">
				<input type="button" value="수정" class="updateBtn">
		</c:if>
				<input type="button" value="뒤로" class="cancelBtn">
	</div>
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
							<div class="pic" style="background-image:url('resources/upload/${data.PHTGR}'); background-size: 100% 100%;">
							</div>사원번호 ${data.EMPLY_NO}</td>
							<td colspan="4"></td>
						</tr>
						<tr>
							<td>이름* </td>
							<td><span>${data.EMPLY_NAME}</span></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td>생년월일* </td>
							<td><span>${data.BIRTH}</span> (<span>${data.SOLAR_LUNAR}</span>)</td>
							<td>성별* </td>
							<td><span>${data.GNDER}</span> </td>
						</tr>
						<tr>
							<td>주소* </td>
							<td><div class="fix"><span>${data.ADRS}</span></div></td>
							<td>우편번호*</td>
							<td><span>${data.PSTCD}</span></td>
						</tr>
						<tr>
							<td rowspan="5"></td>
							<td>상세주소*</td>
							<td colspan="3"><span>${data.DTL_ADRS}</span></td>
						</tr>
						<tr>
							<td>휴대전화* </td>
							<td><span>${data.CLPHN_NO}</span></td>
							<td>예비번호 </td>
							<td><span>${data.SPARE_NO}</span></td>
						</tr>
						<tr>
							<td>이메일* </td>
							<td><span>${data.EMAIL}</span></td>
							<td>최종학력* </td>
							<td><span>${data.EDCTN}</span>
							</td>
						</tr>
						<tr>
							<td>부서 </td>
							<td>${data.DPRTMNT_NAME}</td>
							<td>직급 </td>
							<td>${data.PSTN_NAME}</td>
						</tr>
						<tr>
							<td>입사일자 </td>
							<td><span>${data.START_DAY}</span></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				
			</div>
		</div>
			



<c:import url="/bottom"></c:import>
</body>
</html>