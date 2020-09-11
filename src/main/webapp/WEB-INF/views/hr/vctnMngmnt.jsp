<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Vanilla ERP - 휴가관리</title>
<!-- 헤더 -->
<c:import url="/header"></c:import>

<!-- Fullcalendar css -->
<link rel="stylesheet" type="text/css"
	href="resources/script/fullcalendar/main.css" />
<style type="text/css">

.vacation_title {
	font-size: 11pt;
	font: bold;
	display: inline-block;
	margin-left: 10%;
}

.vacTotal_table thead {
	background-color: #00305A;
	color: white;
}

.vacTotal_table {
	font-size: 11pt;
	font: bold;
	min-width: 250px;
	border: 1px solid #000000;
	border-collapse: collapse;
	margin-left: 10%;
	text-align: center;
}

.vacation_table {
	border-collapse: collapse;
	text-align: center;
	vertical-align: center;
	font-size: 11pt;
	display: table;
	border: 1px solid #000000;
	min-width: 250px;
	margin-top: 18%;
	margin-left: 10%;
}

.vacation_table thead {
	background-color: #00305A;
	color: white;
}

.rightDiv {
	width: 82%;
	height: 100%;
	display: inline-block;
}

.leftDiv {
	display: inline-block;
	width: 18%;
	height: 100%;
	margin-left: 0px;
}

.vacation_btn {

	margin-bottom : 1%;
	background-color: #00305A;
	color: white;
}

.vctn_insert_btn{
	margin-bottom : 1%;
	background-color: #00305A;
	color: white;
}

.con_con {
	margin: 5px;
}

.app {
	color: black;
	font-size: 15px;
	border: 1px solid black;
	margin-left: 356px;
	line-height: 30px;
}

.applicant, .approval {
	display: inline-block;
	text-align: center;
	min-width: 100px;
}

.applicant  {
	border-right: 1px solid black;
}


.vctn_Title {
	min-width: 400px;
	min-height: 20px;
}

.vctn_File {
	min-width: 355px;
	min-height: 20px;
}

.vacTerm {
	min-width: 410px;
	min-height: 20px;
	margin-top: 4px;
}

.vacApproval, .searchApp {
	min-width: 200px;
	min-height: 20px;
	margin-top: 4px;
	margin-right: 4px;
}

.vctn_Select {
	min-width: 200px;
	min-height: 30px;
	margin-top: 4px;
}

.vacCon {
	min-width: 550px;
	min-height: 250px;
	margin-top: 8px;
	text-align: top;
}

.vacFile {
	min-width: 400px;
	min-height: 20px;
	margin-top: 5px;
}

.searchFile {
	margin-left: 10px;
	min-width: 30px;
	min-height: 15px;
}

.vacation_table_Div {
	margin-top: 10px;
}

.vac_calendar {
	width: calc(100% - 60px) ;
	height: calc(100% - 60px) ;
	font-size: 12pt;
}
.vctn_Con {
	min-width: 510px;
	min-height: 200px;
}

.vctn_con, .vctn_con_title_txt, .vctn_con_con, 
.vctn_Title, .vctn_date, .vctn_Approval, .vctn_Select, 
.vctn_Con, .vctn_File, .searchFile {
	margin: 5px;
}
</style>

<!-- Fullcalendar Script -->
<script type="text/javascript"
	src="resources/script/fullcalendar/main.js"></script>
<script type="text/javascript"
	src="resources/script/fullcalendar/locales-all.js"></script>
<script type="text/javascript">
	
	var calendar = null;

	$(document)
			.ready(
					function() {
						
						reloadgetindvdlvctnKindList();
						
						
						var data = [ {
							title : '회사창립일',
							start : '2020-06-01',
							color : 'yellow', // 기타 옵션들
							textColor : 'black',
							
						}]
						
						var d = new Date();
						var calendarEl = document.getElementById('vac_calendar');
						var all = "";
						var calendar = new FullCalendar.Calendar(
								calendarEl,
								{
									customButtons : {
										prev : {
											text : 'Prev',
											click : function() {
												// 이전이벤트
												calendar.prev();
												//추가이벤트
											}
										},
										next : {
											text : 'Next',
											click : function() {
												// 다음이벤트
												calendar.next();
												//추가이벤트
											}
										},
										
										myCustomButton2 : {
											text : '개인',
											click : function() {
												var newEvents = [ {
													title : "",
													start : "",
													end : "",
													color : '#aae9d3', // 기타 옵션들
													textColor : 'white',

												}];
												
												all += newEvents;
												//기존이벤트 제거
												var old = calendar
														.getEventSources();
												for ( var i in old) {
													old[i].remove();
												}

												//신규이벤트 추가
												calendar.addEventSource();
												//새로 그리기
												calendar.refetchEvents();
											}
										},
										myCustomButton3 : {
											text : '부서',
											click : function() {
												var newEvents = [ {
													title : "부서계획1",
													start : "2020-07-10",
													end : "2020-07-15",
													color : '#ff6d6d', // 기타 옵션들
													textColor : 'white',

												}];
												all += newEvents;
												//기존이벤트 제거
												var old = calendar
														.getEventSources();
												for ( var i in old) {
													old[i].remove();
												}

												//신규이벤트 추가
												calendar
														.addEventSource(newEvents);
												//새로 그리기
												calendar.refetchEvents();
											}
										},
										

									},
									headerToolbar : {
										left : 'prev,next today',
										center : 'title',
										right : 'myCustomButton3 myCustomButton2 dayGridMonth,timeGridWeek,timeGridDay,listMonth'
									},
									defaultDate : d.getFullYear() + "-"
											+ (d.getMonth() + 1) + "-"
											+ d.getDate(),
									locale : "ko",
									editable : false,
									height : 600,
									events : data,
									eventClick : function(info) { // 이벤트 클릭
										alert(info.event.title);
									},
									dateClick : function(info) {
										alert('Clicked on: ' + info.dateStr);
									}
									
									
								});
						calendar.render();
						
						document.getElementById('now_date').valueAsDate = new Date();
						
					
						 $(".vacation_btn").on("click", function() {
								var html ="";
								html += "<form action=\"#\" id=\"vctn_info\" method=\"post\">";
								html += "<input type=\"hidden\" class=\"vctn_no\" name=\"vctnNo\"/>";
								html += "<div class=\"vctn_con_con\">";
								html += "<div class=\"vctn_con\"><div class=\"vctn_con_title_txt\">";
								html += "제목 : <input type=\"text\" class=\"vctn_Title\" name=\"vctnTitle\"/><br/>"; 
								html += "기간설정 : <input type=\"date\" class=\"vctnStartDay\"name=\"vctnStartDay\" /> ~ <input type=\"date\" class=\"vctnEndDay\" name=\"vctnEndDay\"/><br/>";
								html += "신청자 :<input type=\"search\" class=\"vctn_Approval\"name=\"sEmplyNo\" value=\"${sEmplyNo}\" /><br/>"; 
								html += "휴가종류선택 :<input class=\"vctn_Select\" name=\"vctnKindNo\" type=\"text\" ><input class=\"btn\" type=\"button\" value=\"검색\">";
								html += "<input type=\"text\" class=\"vctn_Con\" name=\"vctnInfrmtn\"><br/>";
								html += "</div></div>";
								html += "</div>";
								html += "</form>";
								// vctnkindList();
								
								makeTwoBtnPopup(1, "휴가신청서", html, true, 600, 600, function() {
									
									$("#popup1 .btn").on("click",function(){
										
										var html2 = "";
										
										html2 += "<form action=\"#\" id=\"actionFormss\" method=\"post\">";
										html2 += "<input type=\"hidden\" name=\"pagem\" id=\"pagem\" value=\"1\" />";
										html2 += "<div class=\"tab1\">";
										html2 += "<table class=\"bord\" id=\"bad\" border=\"1px\">";
										html2 += "<thead>";
										html2 += "<tr>";
										html2 += "<th>휴가종류번호</th>";
										html2 += "<th>휴가명</th>";
										html2 += "</tr>";
										html2 += "</thead>";
										html2 += "<tbody>";
										html2 += "<tr>";
										html2 += "<td name=\"vctnKindNo\" id=\"vctnNo\"></td>";
										html2 += "<td name=\"kindName\" id=\"kindNm\"></td>";
										html2 += "</tr>";
										html2 += "</tbody>";
										html2 += "</table>";
										html2 += "</div>";
									    html2 += "</form>";
									    
														
										
									    makeOneBtnPopup(2, "휴가종류선택", html2, true, 600, 600, function(){
												reloadvctnKindList();
											$(".bord tbody").on("click","tr", function() {
												
												console.log($(this).attr("name"));
												$("#popupWrap1 [name='vctnKindNo']").val($(this).attr("name"));
						          				
												closePopup(2);
												
											});
									    
										}, "취소", function() {
										closePopup(2);
								    	});
							    	});
								}, "결재", function() {
								
									var params = $("#vctn_info").serialize();
									console.log(params);
									// ajax 기본형식 
									// post 형식의 방식으로 보낼거다(던지는놈)
									$.ajax({ // post방식
										type : "post",  //전송 방식 get방식과 post방식 따로따로 다르기때문에 type가 중요함
										url : "vctnInsertAjax",  // 주소 
										dataType : "json",  // 데이터형태 ajax는 jsom형태를 많이 사용함 (별도의 가공이 필요없기 때문에)
										data : params,  // 보낼데이터 -> 보낼데이터는 있을 수 도 있고 없을 수 도 있음
										success : function(res) { // 성공 시 다음 함수를 실행하며, 돌아오는 값을 res란 이름으로 받는다.
											if(res.result =="success"){
												closePopup(1);
											} else {
												alert("오류가 발생하였습니다.");
											}
										},
										error : function(request, status, error){ // 실행 중 에러 발생 시 
											console.log("txt : " + request, responseText); // 반환 텍스트
											console.log("error : " + error); // 에러 내용 
										}
									});
									
								}, "닫기", function() {
									closePopup(1);
							});
						});// vacation_btn end
						$(".vctn_insert_btn").on("click", function() {
							 var html1 = "";
						
						html1 += "<form action=\"#\" id=\"actionForms\" method=\"post\">";
						html1 += "<div class=\"pa\">";
						html1 += "<div class=\"ptxt\">휴가종류번호</div>";
						html1 += "<input class=\"remark1\" name=\"vctnKindNo\" id=\"vctnKindNo\" type=\"text\" >";
						html1 += "</div>";
						html1 += "<div class=\"pa\">";
						html1 += "<div class=\"ptxt\">휴가종류</div>";
						html1 += "<input class=\"remark1\" name=\"kindName\" id=\"kindName\" type=\"text\" >";
						html1 += "</div>";
						html1 += "</form>";
						 
						makeTwoBtnPopup(3, "휴가등록", html1, true, 600, 300, null, "등록", function() {
							
								
								var params = $("#actionForms").serialize();
								console.log(params);
								// ajax 기본형식 
								// post 형식의 방식으로 보낼거다(던지는놈)
								$.ajax({ // post방식
									type : "post",  //전송 방식 get방식과 post방식 따로따로 다르기때문에 type가 중요함
									url : "vctnWriteAjax",  // 주소 
									dataType : "json",  // 데이터형태 ajax는 jsom형태를 많이 사용함 (별도의 가공이 필요없기 때문에)
									data : params,  // 보낼데이터 -> 보낼데이터는 있을 수 도 있고 없을 수 도 있음
									success : function(res) { // 성공 시 다음 함수를 실행하며, 돌아오는 값을 res란 이름으로 받는다.
										if(res.result =="success"){
											closePopup(3);
										} else {
											alert("오류가 발생하였습니다.");
										}
									},
									error : function(request, status, error){ // 실행 중 에러 발생 시 
										console.log("txt : " + request, responseText); // 반환 텍스트
										console.log("error : " + error); // 에러 내용 
									}
								});
					
						}, "취소", function() {
							closePopup(3);
						});
						
					});//insertBtn end
							
						 var html3 = "";
							
							html3 += "<form action=\"#\" id=\"actionForms2\" method=\"post\">";
							html3 += "<div class=\"vacation_table_Div\">";
							html3 += "<table class=\"vacTotal_table\" border=\"2\">";
							html3 += "<thead>";
							html3 += "<tr>";
							html3 += "<th>총</th>";
							html3 += "<th>사용연차</th>";
							html3 += "<th>잔여연차</th>";
							html3 += "</tr>";
							html3 += "</thead>";
							html3 += "<tbody>";
							html3 += "<tr>";
							html3 += "<td name=\"CHONG\"></td>";
							html3 += "<td name=\"USEDAY\"></td>";
							html3 += "<td name=\"REMAINDER\"></td>";
							html3 += "</tr>";
							html3 += "</tbody>";
							html3 += "</table>";
							html3 += "</div>";
							html3 += "</form>";
					
							reloaduseVctnList();
						 
					}); // document end
					
					
	
	
	
function reloadList() {
	var params = $("#prsnlForm").serialize();
	$.ajax({
		type : "post", //전송방식
		url : "prsnlApntmntsAjax", //주소
		dataType : "json", //데이터형태
		data : params, //보낼 데이터
		success : function(res) {//성공적으로 넘어왔을때 해당 함수를 실행하고, 돌아오는 값은 res란 이름으로 받는다. res에 result, pb, list가 들어있음.
			if (res.result = "success") {
				redrawList(res.list);
				redrawPaging(res.pb);
			} else {
				alert("조회중 문제가 발생하였습니다.")
			}

		},
		error : function(request, status, error) {//실행 중 에러 발생 시 경우 해당 함수를 실행하겠다.
			console.log("txt : " + request.responseText); //반환 텍스트
			console.log("error : " + error); //에러 내용
		}

	});
}//reloadList end

function reloadvctnKindList() {
	var params = $("#actionFormss").serialize();
	console.log(params);
	$.ajax({
		type : "post", //전송방식
		url : "vctnKindListAjax", //주소
		dataType : "json", //데이터형태
		data : params, //보낼데이터
		success : function(res) { //성공시 다음 함수를 실행하며, 돌아오는 값을 res라는 이름으로 받는다.
			if(res.result == "success"){
				redrawvctnKindList(res.vctn);
			}else {
				alert("조회중 문제가 발생하였습니다.");
			}
		
		},
		error : function(request, status, error) { // 실행 중 에러 발생 시
			console.log("text : "+request.responseText); //반환텍스트
			console.log("error : "+error); //에러내용				
		}
	});		
}
function redrawvctnKindList(vctn) {
	if(vctn.length == 0) {
		var html = "";
		html += "<tr>";
		html += "<td colspan=\"5\">조회결과가 없습니다.</td>";
		html += "<tr>";
		
		$(".bord tbody").html(html);
	}else{
		var html = "";
		
		for(var i = 0 ; i < vctn.length ; i++){
			 html += "<tr name=\"" + vctn[i].VCTN_KIND_NO + "\">";
	         html +=  "<td>" + vctn[i].VCTN_KIND_NO + "</td>";
	         html +=  "<td>" + vctn[i].KIND_NAME + "</td>";
	         html += "</tr>";
		}
		$(".bord tbody").html(html);
	}
}

function reloadgetindvdlvctnKindList() {
	var params = $("#actionForms1").serialize();
	console.log(params);
	$.ajax({
		type : "post", //전송방식
		url : "indvdlvctnKindListAjax", //주소
		dataType : "json", //데이터형태
		data : params, //보낼데이터
		success : function(res) { //성공시 다음 함수를 실행하며, 돌아오는 값을 res라는 이름으로 받는다.
			if(res.result == "success"){
				console.log(res.list);
				var old = calendar
				.getEventSources();
				for ( var i in old) {
					old[i].remove();
			}
			//신규이벤트 추가
				calendar.addEventSource(res.list);
			//새로 그리기
				calendar.refetchEvents();
			}else {
				alert("조회중 문제가 발생하였습니다.");
			}
		
		},
		error : function(request, status, error) { // 실행 중 에러 발생 시
			console.log("text : "+request.responseText); //반환텍스트
			console.log("error : "+error); //에러내용				
		}
	});		
}

function reloaduseVctnList() {
	var params = $("#actionForms2").serialize();
	console.log(params);
	$.ajax({
		type : "post", //전송방식
		url : "useVctnListAjax", //주소
		dataType : "json", //데이터형태
		data : params, //보낼데이터
		success : function(res) { //성공시 다음 함수를 실행하며, 돌아오는 값을 res라는 이름으로 받는다.
			if(res.result == "success"){
				redrawuseVctnList(res.vctn);
			}else {
				alert("조회중 문제가 발생하였습니다.");
			}
		
		},
		error : function(request, status, error) { // 실행 중 에러 발생 시
			console.log("text : "+request.responseText); //반환텍스트
			console.log("error : "+error); //에러내용				
		}
	});		
}

function redrawuseVctnList(vctn) {
	if(vctn.length == 0) {
		var html = "";
		html += "<tr>";
		html += "<td colspan=\"3\">조회결과가 없습니다.</td>";
		html += "<tr>";
		
		$(".vacTotal_table tbody").html(html);
	}else{
		var html = "";
		
		for(var i = 0 ; i < vctn.length ; i++){
			 html += "<tr name=\"" + vctn[i].CHONG + "\">";
	         html +=  "<td>" + vctn[i].CHONG + "</td>";
	         html +=  "<td>" + vctn[i].USEDAY + "</td>";
	         html +=  "<td>" + vctn[i].REMAINDER + "</td>";
	         html += "</tr>";
		}
		$(".vacTotal_table tbody").html(html);
	}
}

</script>


</head>
<body>
	<!-- 탑/레프트 -->
	<c:import url="/topLeft">
		<%-- 현재 페이지 해당 메뉴번호 지정 --%>
		<c:param name="menuNo" value="51"></c:param>
	</c:import>
	<!-- 구현내용 -->
	<div class="title_wrap">
		<div class="title_table">
			<div class="title_txt">휴가관리</div>
		</div>
	</div>
	<div class="contents_area">
		<!-- 내용은 여기에 구현하세요. -->
		<div class="leftDiv">
			<div class="vacation_title">[휴가통계] <input type="date" id="now_date"></div>
			
			 <div class="vacation_table_Div">
				<table class="vacTotal_table" border="2">
					 <thead>
						<tr>
							<th>총</th>
							<th>사용연차</th>
							<th>잔여연차</th>
						</tr>
					</thead>
					<tbody>
						<!-- <tr>
						</tr> -->
					</tbody> 
				</table>
			</div>
			
			<%-- <!-- vacation_table_Div -->
			<div class="vacation_table_Div">
				<table class="vacation_table" border="2">
					<colgroup>
						<!-- 가로사이즈조절 -->
						<col width="30px" />
						<col width="70px" />
						<col width="70px" />
					</colgroup>
					<thead>
						<tr>
							<th>No.</th>
							<th>휴가종류</th>
							<th>사용일자</th>
						</tr>
					</thead>
					<tbody>
						<tr>
						</tr>
					</tbody>
				</table>
			</div> --%>
		</div>
	
	
	<div class="rightDiv">
		<input class="vacation_btn" id="vacation_btn" type="button" value="휴가신청서" />
		<input type="hidden" class="vctn_insert_btn" id="vctn_insert_btn" type="button" value="휴가종류등록" />
		
		<div class="vac_calendar" id="vac_calendar"></div>
	</div>

	<!-- 팝업 -->
	 <!-- <div class="popup_wrap" style="display: none">
		<div class="popup_bg"></div>
		<div class="popup">
			<div class="con">
				<div class="con_title">
					<div class="con_title_txt">휴가신청서</div>
				</div>
				<br />
				<div class="app">
					<div class="applicant">신청자</div>
					<div class="approval">결재자</div>
				</div>
				<div class="con_con">
					제목 : <input type="text" class="vacTitle" value="" /><br/>
					기간설정: <input type="date" /> ~ <input type="date" /><br/>
					결재권자 : <input type="search" class="vacApproval" /> <input type="button"	value="검색"> <br /> 
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
					 <input type="text" class="vacCon"> 
					 첨부파일 : <input type="text" class="vacFile" /> <input type="button"class="searchFile" value="첨부파일" />
				</div>
			</div>
			<div class="bottom_bar">
				<div class="popup_btn">
					<div class="popup_btn_txt">결재</div>
				</div>
				<div class="popup_btn">
					<div class="popup_btn_txt" id="close">닫기</div>
				</div>
			</div>
		</div>
	</div> --> 
</div>

	<!--팝업종료  -->
	<!-- 구현끝 -->
	<!-- 바텀 -->
	<c:import url="/bottom"></c:import>
</body>
</html>