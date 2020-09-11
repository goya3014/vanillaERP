<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Vanilla ERP Personal Document</title>
<!-- 헤더 -->
<c:import url="/header"></c:import>

<style type="text/css">

.updateBtn, .backBtn {
	border: 1px solid lightgray;
	color:#515151;
 	outline-color: #d5e4f1;
	height:30px;
	width: 50px;
 	margin-bottom:10px;
 	margin-right:10px;
 	outline-color: #d5e4f1;
	cursor: pointer;
}

.updateBtn {
	margin-top: 15px;
}

.backBtn {
	width: 70px;
}

.left {
	display:inline-block;
	width: 150px;
}

.right {
 	margin-bottom:10px;
	vertical-align: bottom;
	width: 250px;
	height: 50px;
	padding-left: 526px;
	display: inline-block;
}

.docWrap {
	padding: 15px;
	border: 1px solid gray;
	width: 900px;
	font-size: 12pt;
	color: black;
}

.board1, .board2, .board3 {
	width: 100%;
	border-collapse: collapse;
	text-align: center;
	vertical-align: center;
	display:inline-block;	
	font-size: 11pt;
	margin-bottom: 15px;
}

.board2, .board3 {
	margin-top: 5px; 	
}

.board1 tr td, .board2 tr td, .board3 tr td {
	border: 1px solid gray;
	height: 40px;
}

.board1 tr:nth-child(1) td:nth-child(1) {
	font-weight: bold;
	font-size: 13pt;
	border-top: 0px;
	border-left: 0px;
	border-bottom: 0px;
}

.text {
	height: 27px;
}

input::placeholder {
  color: #c5c5c5;
  font-style: italic;
}

#add {
	width: 620px;
}

#mini {
	width: 30px;
}

.date {
	width: 900px;	
	display:table;
	margin-top: 10px;
	margin-bottom: 20px;
}

.date > div {
	display: table-cell;
	vertical-align:middle;
	text-align: center;
}

.bottom {
	margin-left: 310px;
	margin-bottom: 40px;
	line-height: 200%;	
}

.stamp {
	display: none;
	width: 35px;
	height: 35px;
	background-image: url("resources/images/hr/stamp2.png");
	background-repeat: no-repeat;
	background-size: 35px 50px;
	background-position: 50% 50%;
	position: relative;
	top: 78px;
	left: 250px;
	z-index: 100;
	opacity: 0.9;
}

</style>

<script type="text/javascript">
$(document).ready(function() {
	
	$(".updateBtn").on("click",function(){
		$("#actionForm").attr("action","prsnlDcmntUpdate");
		$("#actionForm").submit();
	});//update
	
	$(".backBtn").on("click",function(){
		$("#actionForm").attr("action","prsnlDcmnt");
		$("#actionForm").submit();
	});//back
	
	if($("span").is(".fin")){
		console.log("fin ok");
		$(".stamp").css("display","inline-block");
	}
	
	

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
	<c:param name="menuNo" value="42"></c:param> <%-- gnb --%>
</c:import>
<!-- 구현내용 -->
<div class="title_wrap">
	<div class="title_table">
		<div class="title_txt">인사서류관리 개별조회</div>
	</div>
</div>
<div class="contents_area">
	<!-- 내용은 여기에 구현하세요. -->
<form action="#" id="actionForm" method="post">
	<input type="hidden" name="sEmplyNo" id="sEmplyNo" value="${sEmplyNo}">
	<input type="hidden" name="sAthrtyNo" id="sAthrtyNo" value="${sAthrtyNo}">
	<input type="hidden" name="checkDocNo" id="checkDocNo" value="${param.checkDocNo}"/>
	<input type="hidden" name="searchTxt" id="searchTxt" class="search" value="${param.searchTxt}"/>
</form>

	<div class="tbl1">
			<div class="left">
				<c:if test="${sAthrtyNo eq 1 or sAthrtyNo eq 2 or sAthrtyNo eq 4 or sAthrtyNo eq 5}">
					<c:if test="${cndtn.SIGN_DATE eq null or cndtn.CAUSE ne null}">
 						<input type="button" value="수정" class="updateBtn">
 					</c:if>
				</c:if>
 				<input type="button" value="뒤로가기" class="backBtn">
 				</div>
 				<div class="right">
 				
 					<table class="board2">
 						<colgroup>
 							<col width="100px">
 							<col width="150px">
 						</colgroup>
 						<tbody>
 							<tr>
 								<td>상 태 </td>
 								<td>
 								<c:choose>
 									<c:when test="${cndtn.SIGN_DATE eq null and cndtn.CAUSE eq null}">대 기</c:when> 
 									<c:when test="${cndtn.SIGN_DATE ne null and cndtn.CAUSE eq null}"><span class="fin">완 료</span></c:when>
 									<c:when test="${cndtn.SIGN_DATE ne null and cndtn.CAUSE ne null}">반 려</c:when>
 								</c:choose> 
 								</td>
 							</tr>
 						</tbody>
 					</table>
 				</div><br/>
 				
				<div class="docWrap">
				<table class="board1">
					<thead></thead>
					<tbody>
						<colgroup>
							<col width="500px">
							<col width="150px">
							<col width="250px">
						</colgroup>
						<tr>
							<td rowspan="3">${data.PRSNL_DCMNT_KIND}</td>
							<td>문서번호</td>
							<td>${data.PRSNL_DCMNT_NO}</td>
						</tr>
						<tr>
							<td>작성자</td>
							<td>${data.WRTR_NAME}</td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td>${data.WRT_DATE}</td>
						</tr>
					</tbody>
				</table><br/>
				<br/>
				1. 인적사항<br/> 
				<table class="board2">
					<colgroup>
						<col width="150px">
						<col width="300px">
						<col width="150px">
						<col width="300px">
					</colgroup>
					<tbody>
						<tr>
							<td>성명(한글)</td>
							<td>${data.EMPLY_NAME}</td>
							<td>생년월일</td>
							<td>${data.BIRTH}</td>
						</tr>
						<tr>
							<td>주소</td>
							<td colspan="3">${data.ADRS} ${data.DTL_ADRS}</td>
						</tr>
					</tbody>
				</table><br/>
				<br/>
				2. 재직사항 및 제출용도<br/>
				<table class="board3">
					<colgroup>
						<col width="150px">
						<col width="300px">
						<col width="150px">
						<col width="300px">
					</colgroup>
					<tbody>
						<tr>
							<td>근무부서</td>
							<td>${data.DPRTMNT_NAME}</td>
							<td>직위</td>
							<td>${data.PSTN_NAME}</td>
						</tr>
						<tr>
							<td>근무기간</td>
							<td colspan="3"> ${data.START_DAY_Y}년 ${data.START_DAY_M}월 ${data.START_DAY_D}일 부터 
							${data.END_DAY_Y}년 ${data.END_DAY_M}월 ${data.END_DAY_D}일 까지</td>
						</tr>
						<tr>
							<td>제출용도</td>
							<td colspan="3">${data.DCMNT_USE}</td>
						</tr>
					</tbody>
				</table><br/>
				<br/>
				<br/>
				<br/>
				<div class="date">
				<div>
				위의 기재사항이 사실과 다름없음을 증명합니다.<br/><br/><br/>
				${data.SYSDATE_Y}년 ${data.SYSDATE_M}월 ${data.SYSDATE_D}일
				</div>
				</div>
				<br/>
				<br/>
				<div class="bottom">
				<div class="stamp"></div><br/>
				회　　사　　명 : 꾸 아 꾸 아 컴 퍼 니 <br/> 
				대　　표　　자 : 김　　대　　표　(인)<br/>
				사업자등록번호 : 35468741-1519851<br/>
				주　　　　　소 : 경기 오산시 한산동 1147 검영빌라 4층 <br/>
				전　　　　　화 : 031-388-5785<br/>
				</div>
				</div><!-- docwrap -->
				
			</div>
		</div>

<!-- 구현끝 -->
<!-- 바텀 -->
<c:import url="/bottom"></c:import>
</body>
</html>