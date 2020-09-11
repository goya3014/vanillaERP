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

.newBtn, .backBtn {
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

.backBtn {
	margin-top: 15px;
}

.newBtn {
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

#adrs, #dtlAdrs {
	width: 150px;
}

#pstcd {
	width: 40px;
}

#sysdateY, #sysdateM, #sysdateD {
	width: 40px;
}

#dcmntUse {
	width: 650px;
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

.changeBtn, .adrsChangeCancelBtn, .adrsChangeBtn, .addnumBtn {
	margin-left: 5px;
}
</style>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$(".newBtn").on("click",function(){
		console.log($("#selectEmply").val());
		var params = $("#actionForm2").serialize(); //제이쿼리로 해결
		
		$.ajax({ //겟방식? 포스트방식?
			type : "post", //전송방식 (포스트로 보내겠다)
			url : "pdWriteAjax", //주소 호출 (값이랑 보내는)
			dataType : "json",  //데이터형태 - 일반적으로 아작스는 json많이 씀. 바로 매칭 돼서. 별도 가공 불필요.
			//겟방식 / 포스트방식 따라 따로따로 동작할 수 있는 함수 이따 배울 것 
			data : params, //보낼 데이터 - 상황에 따라 없을 수 있음 
			success : function(res) { //성공적으로 넘어갔을때 이 함수 실행하며, 돌아오는 값을 res란 이름으로 받는다.
				console.log(res.result);
			
					if(res.result == "success"){
						
						$("#actionForm").attr("action","prsnlDcmnt");
						$("#actionForm").submit();
						
					} else {
						
						makeAlert(1, "알림", "등록 중 오류가 발생하였습니다", null);
					} 
					
				},
			error : function(request, status, error) { //값이 돌아오지 않는 등 실행 중 에러 발생 시 이 함수 실행
								
				console.log("text : " + request.responseText); //반환텍스트 
				console.log("error : " + error); //에러 내용 
			} //{ name: "이재희", 키: 값, ...} 중괄호, 키, 값으로 이루어진 전송 규격 = json
			
		});//인사서류 신규등록 아작스 
		
	});//update
	
	$(".backBtn").on("click",function(){
		$("#actionForm").attr("action","prsnlDcmnt");
		$("#actionForm").submit();
	});//back
	
	//주소 수정
	$(".change").on("click",".changeBtn",function(){
		
		var html = "";
		html += "<input type=\"text\" class=\"text postcodify_address\" name=\"adrs\" id=\"adrs\" value=\"${data.ADRS}\">"
		html += "(상세) <input type=\"text\" class=\"text postcodify_details\" name=\"dtlAdrs\" id=\"dtlAdrs\" value=\"${data.DTL_ADRS}\">" 
		html += "(우편번호) <input type=\"text\" class=\"text postcodify_postcode\" name=\"pstcd\" id=\"pstcd\" value=\"${data.PSTCD}\">"
		html += "<input type=\"button\" value=\"우편번호 찾기\" class=\"addnumBtn\" id=\"postcodify\">"
		html += "<input type=\"button\" class=\"adrsChangeBtn\" value=\"완료\">"
		html += "<input type=\"button\" class=\"adrsChangeCancelBtn\" value=\"취소\">" 
		
		$(".change").html(html);
		
		$("#postcodify").postcodifyPopUp();
	    
		$("#postcodify").postcodify({
			insertPostcode5 : "#addnum",
			insertAddress : "#add",
			insertDetails : "#add",
			insertExtraInfo : "#detailAdd",
			hideOldAddresses : false
		});//우편번호 찾기 
		
		$(".adrsChangeCancelBtn").on("click",function(){
			var html = "";
			html += "${data.ADRS} ${data.DTL_ADRS} (${data.PSTCD})"
			html += "<input type=\"button\" value=\"수정\" class=\"changeBtn\">"
			
			$(".change").html(html);
		});//주소 수정 취소 

		 $(".adrsChangeBtn").on("click",function(){
			
			if("${data.ADRS}" == $("#adrs").val() && "${data.DTL_ADRS}" == $("#dtlAdrs").val() && "${data.PSTCD}" == $("#pstcd").val()){
				var html = "";
				html += "${data.ADRS} &nbsp ${data.DTL_ADRS} &nbsp (${data.PSTCD})"
				html += "<input type=\"button\" value=\"수정\" class=\"changeBtn\">"
				
				$(".change").html(html);
			} else {
			
				//수정 update 아작스 후 수정된 주소 받기  
				var params = $("#actionForm2").serialize(); //제이쿼리로 해결
							
				$.ajax({ //겟방식? 포스트방식?
					type : "post", //전송방식 (포스트로 보내겠다)
					url : "adrsUpdateAjax", //주소 호출 (값이랑 보내는)
					dataType : "json",  //데이터형태 - 일반적으로 아작스는 json많이 씀. 바로 매칭 돼서. 별도 가공 불필요.
					//겟방식 / 포스트방식 따라 따로따로 동작할 수 있는 함수 이따 배울 것 
					data : params, //보낼 데이터 - 상황에 따라 없을 수 있음 
					success : function(res) { //성공적으로 넘어갔을때 이 함수 실행하며, 돌아오는 값을 res란 이름으로 받는다.
						console.log(res.result);
					
							if(res.result == "success"){
								
								
								getAdrs(res.one);
									
								function getAdrs(list){
									console.log(list.ADRS);
									var html = "";
									html += list.ADRS + list.DTL_ADRS + "(" + list.PSTCD + ")";
									html += "<input type=\"button\" value=\"수정\" class=\"changeBtn\">";
									
									$(".change").html(html);
								}
								
							} else {
								
								makeAlert(1, "알림", "수정 중 오류가 발생하였습니다", null);
							} 
							
						},
					error : function(request, status, error) { //값이 돌아오지 않는 등 실행 중 에러 발생 시 이 함수 실행
										
						console.log("text : " + request.responseText); //반환텍스트 
						console.log("error : " + error); //에러 내용 
					} //{ name: "이재희", 키: 값, ...} 중괄호, 키, 값으로 이루어진 전송 규격 = json
				});//인사서류 신규등록에 앞서 주소 수정 아작스 
				
				
				
				
			}
		
		});//주소 수정 완료  
		
		
	});//change 
	
	

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
		<div class="title_txt">인사서류관리 신규등록(${param.docKind})</div>
	</div>
</div>
<div class="contents_area">
	<!-- 내용은 여기에 구현하세요. -->
<form action="#" id="actionForm" method="post">
	<input type="hidden" name="sEmplyNo" id="sEmplyNo" value="${sEmplyNo}">
	<input type="hidden" name="sAthrtyNo" id="sAthrtyNo" value="${sAthrtyNo}">
	<%-- <input type="hidden" name="checkDocNo" id="checkDocNo" value="${param.checkDocNo}"/> --%>
</form>

<form action="#" id="actionForm2" method="post">
	<input type="hidden" name="sEmplyNo" id="sEmplyNo" value="${sEmplyNo}">
	<input type="hidden" name="checkDocNo" id="checkDocNo" value="${nextNo.NEXT_PD_NO}">
	<input type="hidden" name="selectEmply" id="selectEmply" value="${data.E_NO}">
	<input type="hidden" name="draftDocKind" id="draftDocKind" value="${param.docKind}">


	<div class="tbl1">
			<div class="left">
				<c:if test="${sAthrtyNo eq 1 or sAthrtyNo eq 2 or sAthrtyNo eq 4 or sAthrtyNo eq 5}">
 					<input type="button" value="결재신청" class="newBtn">
				</c:if>
 				<input type="button" value="취소" class="backBtn">
 				</div>
 				<br/>
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
							<td rowspan="3">
								<c:choose>
									<c:when test="${param.docKind eq '재직증명서'}">재 직 증 명 서<input type="hidden" name="docKind" id="docKind" value="0"></c:when>
									<c:when test="${param.docKind eq '경력증명서'}">경 력 증 명 서<input type="hidden" name="docKind" id="docKind" value="1"></c:when>
									<c:when test="${param.docKind eq '퇴직증명서'}">퇴 직 증 명 서<input type="hidden" name="docKind" id="docKind" value="2"></c:when>
								</c:choose>
							</td>
							<td>문서번호</td>
							<td name="docNo09" id="docNo09">${nextNo.NEXT_PD_NO_TC}</td>
						</tr>
						<tr>
							<td>작성자</td>
							<td name="writer" id="writer">${sEmplyName}</td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td name="sysdt" id="sysdt">${data.SYS}</td>
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
							<td colspan="3" class="change">${data.ADRS} ${data.DTL_ADRS} (${data.PSTCD})
							<input type="button" value="수정" class="changeBtn"></td>
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
							<c:choose>
								<c:when test="${data.END_DAY eq null}">${data.SYSDATE_Y}년 ${data.SYSDATE_M}월  ${data.SYSDATE_D}일 까지</c:when>
								<c:otherwise>${data.END_DAY_Y}년 ${data.END_DAY_M}월 ${data.END_DAY_D}일 까지</c:otherwise>
							</c:choose>
							
							</td>
						</tr>
						<tr>
							<td>제출용도</td>
							<td colspan="3"><input class="text" type="text" name="dcmntUse" id="dcmntUse"></td>
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
				회　　사　　명 : 꾸 아 꾸 아 컴 퍼 니 <br/> 
				대　　표　　자 : 김　　대　　표　(인)<br/>
				사업자등록번호 : 35468741-1519851<br/>
				주　　　　　소 : 경기 오산시 한산동 1147 검영빌라 4층 <br/>
				전　　　　　화 : 031-388-5785<br/>
				</div>
				
			</div><!-- docWrap -->
			
		</div><!-- tb1 -->
				
				</form>
				
				
</div> <!-- contents area -->
		
		

<!-- 구현끝 -->
<!-- 바텀 -->
<c:import url="/bottom"></c:import>
</body>
</html>