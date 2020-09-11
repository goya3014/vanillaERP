<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Vanilla ERP - 휴가조회</title>
<!-- 헤더 -->
<c:import url="/header"></c:import>

<!-- Fullcalendar css -->
<link rel="stylesheet" type="text/css"
	href="resources/script/fullcalendar/main.css" />

<style type="text/css">
.add_vctn_btn {
	margin-left: 84%;
	display: inline-block;
	vertical-align: top;
}

.b_btn {
	margin-left: 90%;
	display: inline-block;
	vertical-align: top;
}

#b_btn {
	background-color: #00305A;
	color: white;
	vertical-align: top;
}

#add_vctn_btn {
	background-color: #00305A;
	color: white;
	vertical-align: top;
	margin-right: 10px;
}

#searchbtn, #getbtn, #btn {
	background-color: #00305A;
	color: white;
	vertical-align: top;
	margin-right: 10px;
}

.vacation_search thead {
	background-color: #00305A;
	color: white;
}

.vacation_search {
	border-collapse: collapse;
	text-align: center;
	vertical-align: center;
	font-size: 11pt;
	display: table;
	border: 2px solid #000000;
	width: 100%;
	vertical-align: top;
	margin-top: 10px;
    margin-bottom: 10px;
}

.vacSelect {
	min-width: 200px;
	min-height: 30px;
	margin-top: 4px;
}

.vacCon {
	min-width: 550px;
	min-height: 250px;
	margin-top: 8px;
}

.popup {
	background-color: white;
	width: 346px;
	height: 300px;
	position: absolute;
	top: calc(50% - 150px);
	left: calc(50% - 173px);
	box-shadow: 1px 0px 4px 0px rgba(0, 0, 0, 0.8);
	z-index: 100;
}

#srch_dpnt {
	vertical-align: top;
	margin-right: 10px;
}

#srch_year {
	vertical-align: top;
	margin-right: 10px;
}

#srch_txt {
	margin-right: 10px;
	vertical-align: top;
}

.vacation_search tbody > tr:hover {
	background-color: #D6D3CA;
}
.spList tbody > tr {
	text-align: center;
}

.spList {
	border-collapse: collapse;
}
</style>

<!-- Fullcalendar Script -->
<script type="text/javascript"
	src="resources/script/fullcalendar/main.js"></script>
<script type="text/javascript"
	src="resources/script/fullcalendar/locales-all.js"></script>
<script type="text/javascript">

$(document).ready(function() {
		 getListVctn();
		
		$("#add_vctn_btn").on("click", function() {
			if ($(".popup_wrap").css("display") == "none") {
				$(".popup_wrap").show();
			}
			$("#close").on("click", function() {
				$(".popup_wrap").hide();
			});
		});
		
		$("#getbtn").on("click", function() {
			$("#srch_txt").val("");
			$("#srch_dpnt").val(5);
			getListVctn();
		});
		
		$("#searchbtn").on("click", function() {
			getListVctn();
		});
		
		$(".vcScroll").slimScroll({
			height: 700
		});
		
	$(".vacation_search tbody").on("click", "tr", function() {
		$("#emplyNo").val($(this).attr("name"));
		
		var params = $("#actionForm").serialize();
		$.ajax({
			type : "post", //전송방식
			url : "getSpListAjax", //주소
			dataType : "json",
			data: params,//데이터형태
			success : function(res){
				if(res.result == "success"){
					var html = "";
					
					html += "<div id=\"vctnScroll\">";
					html += "<table class=\"spList\" border=\"1\">";
					html += "<colgroup>";
					html += "<col width=\"200px\">";
					html += "<col width=\"200px\">";
					html += "<col width=\"200px\">";
					html += "</colgroup>";
					html += "<thead><tr><th>휴가종류</th><th>휴가 시작일</th><th>휴가 종료일</th></tr></thead>";
					html += "<tbody></tbody></table></div>"
					
					makeOneBtnPopup(1, "상세조회", html, true, 600, 600, function() {
						$("#vctnScroll").slimScroll({
							height: 300
						});
						
						var html = "";
						for(var i = 0; i < res.list.length; i++) {
							html += "<tr name=\"" + res.list[i].EMPLY_NO + "\">";
							html += "<td>" + res.list[i].KIND_NAME + "</td>"; //자바스크립트에서 LIST는 배열처럼 쓰임 
							html += "<td>" + res.list[i].VCTN_START_DAY + "</td>";
							html += "<td>" + res.list[i].VCTN_END_DAY + "</td>";
							html += "</tr>";
						}
						$(".spList tbody").html(html);
							
						
						
					}, "닫기", function() {
						closePopup(1);
					});	
					
				}else{
					alert("조회중 문제가 발생하였습니다.")
				}
					
			},
			error: function(request, status, error){//실행 중 에러 발생 시 경우 해당 함수를 실행하겠다.
				console.log("txt : " + request.responseText); //반환 텍스트
				console.log("error : " + error); //에러 내용
			} 
		});//ajax end
		
	});//상세보기	
		
		
});//document ready end
	
	
function getListVctn() {
	var params = $("#actionForm2").serialize();
	
		$.ajax({
			type : "post", //전송방식
			url : "getListVctnAjax", //주소
			dataType : "json",
			data: params,//데이터형태
			success : function(res){
				if(res.result == "success"){
					
						var html = "";
					for(var i = 0; i < res.list.length; i++) {
						var month = res.list[i].MONTHS;
						var unusedday = 0;
						
						if (month < 0) {
							unusedday = 0;
						}
						else if(month >= 0 && month < 12){
							unusedday = month;
						}else if(month >= 12 && month < 36) {
							unusedday = 15;
						}else {
							unusedday = 15 + (Math.floor((month/12)) - 2)
						}
						
						unusedday -= res.list[i].VCTN_USE_DAYS;
						
						html += "<tr name=\"" + res.list[i].EMPLY_NO + "\">";
						html += "<td>" + res.list[i].EMPLY_NO + "</td>"; //자바스크립트에서 LIST는 배열처럼 쓰임
						html += "<td>" + res.list[i].EMPLY_NAME + "</td>";
						html += "<td>" + res.list[i].PSTN_NAME + "</td>";
						html += "<td>" + res.list[i].VCTN_USE_DAYS + "</td>";
						html += "<td>" + unusedday + "</td>";
						html += "<td>" + res.list[i].DPRTMNT_NAME + "</td>";
						html += "</tr>";
						
						
					}
					$(".vacation_search tbody").html(html);
					
				}else{
					alert("조회중 문제가 발생하였습니다.")
				}
					
			},
			error: function(request, status, error){//실행 중 에러 발생 시 경우 해당 함수를 실행하겠다.
				console.log("txt : " + request.responseText); //반환 텍스트
				console.log("error : " + error); //에러 내용
			} 
		});//ajax end
		
	}//getListVctn end
	


</script>


</head>
<body>
	<!-- <div class="popup_wrap" style="display: none">
		<div class="popup_bg"></div>
		<div class="popup" id="popup">
			<div class="con">
				<div class="con_title">
					<div class="con_title_txt">휴가부여</div>
				</div>
				<br />

				<div class="con_con">
					휴가종류선택 : <select class="vacSelect">
								<option>선택해주세요.</option>
								<option>연차휴가</option>
								<option>연차휴가(오전)</option>
								<option>연차휴가(오후)</option>
								<option>보상휴가</option>
								<option>보상휴가(오전)</option>
								<option>보상휴가(오후)</option>
								<option>경조휴가</option>
								<option>병가</option>
								<option>보건(생리)휴가</option>
								<option>출산휴가</option>
								<option>인정휴가</option>
								<option>인정휴가(오전)</option>
								<option>인정휴가(오후)</option>
								<option>청원휴가</option>
								<option>산재휴가</option>
							   </select>  
					  부여개수 : <input type="text" /> 개
				</div>
				<div class="bottom_bar">
					<div class="popup_btn">
						<div class="popup_btn_txt">저장</div>
					</div>
					<div class="popup_btn">
						<div class="popup_btn_txt">결재</div>
					</div>
					<div class="popup_btn">
						<div class="popup_btn_txt" id="close">닫기</div>
					</div>
				</div>
			</div>
		</div>
	</div> -->
	<!--팝업종료  -->
	<!-- 탑/레프트 -->
	<c:import url="/topLeft">
		<%-- 현재 페이지 해당 메뉴번호 지정 --%>
		<c:param name="menuNo" value="52"></c:param>
	</c:import>
	<!-- 구현내용 -->
	<div class="title_wrap">
		<div class="title_table">
			<div class="title_txt">휴가조회</div>
		</div>
	</div>
	<div class="contents_area">
		<!-- 내용은 여기에 구현하세요. -->
		<form action="#" id="actionForm2">
		<select id="srch_dpnt" name="srch_dpnt">
			<option value="5">경영관리부</option>
			<option value="4">인사부</option>
			<option value="3">영업부</option>
		</select>
		<input type="search" placeholder="직원명을 검색해주세요." id="srch_txt" name="srch_txt"/> <input type="button" value="검색" id="searchbtn" /><input type="button" value="조회" id="getbtn" />
		</form>
	<!-- 	<div class="btn"> -->
			<!-- 	<input type="button" value="휴가부여" id="add_vctn_btn" /> -->
				
		<!-- </div> -->
		<br /> <br />
		<form action="#" id="actionForm">
		<input type="hidden" id="emplyNo" name="emplyNo"/>
		</form>
		<div class="vcScroll">
		<table class="vacation_search" border="1">
			<thead>
				<tr>
					<th>사원번호</th>
					<th>성명</th>
					<th>직급</th>
					<th>사용 연차수</th>
					<th>잔여 연차수</th>
					<th>부서명</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		</div>
		</div>
	<!-- 구현끝 -->
	<!-- 바텀 -->
	<c:import url="/bottom"></c:import>
</body>
</html>