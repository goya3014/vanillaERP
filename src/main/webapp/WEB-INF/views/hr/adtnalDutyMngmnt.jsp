<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Vanilla ERP - 추가근무관리</title>
<!-- 헤더 -->
<c:import url="/header"></c:import>
<!-- Fullcalendar css -->
<link rel="stylesheet" type="text/css" href="resources/script/fullcalendar/main.css" />
<style type="text/css">

.calendar1{
	width: calc(100% - 60px) ;
	height: calc(100% - 60px) ;
	font-size: 12pt;
}
	
.fc-button-group {
	display: none;
}

#prevBtn, #nextBtn, #personalBtn, #allBtn, #insertBtn, #searchBtn, #viewBtn {
	display: inline-block;
	vertical-align: top;
	width: 60px;
	height: 40px;
	background-color: #00305A;
	color: white;
	border-radius: 8px;
	font-weight: bold;
}


#personalBtn, #allBtn, #insertBtn, #searchBtn, #dprtSelect {
	float: right;
}

#personalBtn {
	margin-right: 10px;
}

#viewBtn {
	margin-left: 10px;
}

#prevBtn, #nextBtn, #viewBtn {
	float: left;
}

#dprtSelect {
	display: inline-block;
	vertical-align: top;
	width: 95px;
	height: 40px;
	font-size: 11pt;
}

.con_1 {
	display: inline-block;
	vertical-align: top;
	font-size: 12pt;
	margin-bottom: 20px;
	margin-right: 10px;
	
}
.con_2 {
	display: inline-block;
	vertical-align: top;
	font-size: 13pt;
	margin-bottom: 20px;
	margin-right: 38.68px;
	
}

.con_1_1, .con_1_2 {
	display: inline-block;
	vertical-align: top;
	font-size: 13pt;
	margin-bottom: 20px;
}
.con_1_2 {
	margin-left: 20px;
}

.con2 {
	display: inline-block;
	vertical-align: top;
	width: 100px;
	height: 30px;
	font-size: 11pt;
	
}
.con2_1 {
	display: inline-block;
	vertical-align: top;
	width: 100px;
	height: 30px;
	font-size: 11pt;
	
}
.con3 {
	display: inline-block;
	vertical-align: top;
	width: 140px;
	height: 30px;
	font-size: 11pt;
	margin-right: 10px;
	
}
.con4 {
	display: inline-block;
	vertical-align: top;
	width: 130px;
	height: 30px;
	font-size: 11pt;
	
}

#adtCon {
	white-space: pre-wrap;
	overflow: auto;
	overflow-y: scroll;
	font-size: 11pt;
}
</style>

<!-- Fullcalendar Script -->
<script type="text/javascript" src="resources/script/fullcalendar/main.js"></script>
<script type="text/javascript" src="resources/script/fullcalendar/locales-all.js"></script>
<script type="text/javascript">
var calendar = null;
var temp = null;
var temp2 = 0;
$(document).ready(function() {
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

	reloadList(); //처음에 개인 데이터만 보여줌
	console.log("사원번호는" + $("#sEmplyNo2").val());
	
	$("#prevBtn").on("click", function() {
		calendar.prev();
	});
	
	$("#nextBtn").on("click", function() {
		calendar.next();
	});
	
	$("#viewBtn").on("click", function() {
		if(temp2 != 0){
			calendar.changeView('dayGridMonth');
			temp2 = 0;
		}else {
			calendar.changeView('listWeek');
			temp2 = 1;
		}
	});
	
	$("#personalBtn").on("click", function() {
		$("#dprtSelect").val("");
		reloadList();
	
	});
	$("#allBtn").on("click", function() {
		$("#dprtSelect").val("");
		$("#sEmplyNo2").val("");
		reloadList();
	});

	$("#searchBtn").on("click", function() {
		$("#sEmplyNo2").val("");
		 reloadList();
	});
	
	$("#insertBtn").on("click", function() {
		
		var html="";
		
		html += "<form action=\"#\" id=\"actionForm\" method=\"post\">";
		html += "<div class=\"con_1\">사원정보:</div>";
		html += "<div class=\"con_1_1\">${sEmplyName}(${sDprtmntName} ${sPstnName})</div><br/>";
		html += "<div class=\"con_1\">근무유형:</div>";
		html += "<select class=\"con2\" name=\"adttype\">";
		html += "<option selected=\"selected\" value=\"0\">야근</option>";
		html += "<option value=\"1\">주말근무</option></select><br/>";
		html += "<div class=\"con_1\">시작일시:</div>";
		html += "<input type=\"date\" class=\"con3\" name=\"stdate\" id=\"stdate\" />";
		html +=	"<input type=\"time\" class=\"con4\" name=\"sttime\" id=\"sttime\" /><br/>";
		html += "<div class=\"con_1\">종료일시:</div>";
		html += "<input type=\"date\" class=\"con3\" name=\"eddate\" id=\"eddate\" />";
		html += "<input type=\"time\" class=\"con4\" name=\"edtime\" id=\"edtime\" /><br/>";
		html += "<div class=\"con_2\">장소:</div>";
		html += "<select class=\"con2_1\" name=\"adtplace\">";
		html += "<option selected=\"selected\" value=\"0\">내근</option>";
		html += "<option value=\"1\">외근</option></select><br/>";
		html += "<div class=\"con_1\">업무내용:</div>";
		html += "<textarea cols=\"50\" rows=\"13\" name=\"adtCon\" id=\"adtCon\"></textarea>";
		html += "<input type=\"hidden\" name=\"sEmplyNo\" value=\"${sEmplyNo}\" />"
		html += "</form>";
		
		//makeTwoBtnPopup에서 html을 넣어줌.
		makeTwoBtnPopup(1, "추가근무등록", html, true, 600, 600, null, "저장", function() {
			//팝업이벤트에서 저장구현
			/*사원번호, 시작일시, 종료일시, 추가근무유형, 장소, 내용 */
			 	var startDate = parseInt($("#stdate").val().replace("-", '').replace("-", ''));
				var endDate = parseInt($("#eddate").val().replace("-", '').replace("-", ''));
				var stTime = parseInt($("#sttime").val().replace(":", ''));
				var edTime = parseInt($("#edtime").val().replace(":", ''));	
			
			 	 if ($.trim($("#stdate").val()) == "") {
				alert("시작날짜를 입력하여 주세요.");
			}else if ($.trim($("#sttime").val()) == "") {
				alert("시작시간을 입력하여 주세요.");
			}else if ($.trim($("#eddate").val()) == "") {
				alert("종료날짜를 입력하여 주세요.");
			}else if ($.trim($("#edtime").val()) == "") {
				alert("종료시간을 입력하여 주세요.");
			}else if ($.trim($("#adtCon").val()) == "") {
				alert("업무내용을 입력하여 주세요.");
			}else if(endDate < startDate) { 
				alert("종료날짜가 시작날짜보다 과거입니다.");
            	$("#eddate").val("");
			}else if(endDate == startDate && edTime < stTime) {
            	alert("종료시간이 시작시간보다 과거입니다.");
            	$("#edtime").val("");
		            	
			}else if($(".con2").val() == 1) {
						
						if(dateCheck($("#stdate").val()) != "토" && dateCheck($("#stdate").val()) != "일") {
							
							alert("시작날짜가 평일입니다.");
							console.log(dateCheck($("#stdate").val()));
							$("#stdate").val("");
						}else if(dateCheck($("#eddate").val()) != "토" && dateCheck($("#eddate").val()) != "일") {
							
							console.log(dateCheck($("#eddate").val()));
							alert("종료날짜가 평일입니다.");
							$("#eddate").val("");
						}else {
							
							var params = $("#actionForm").serialize();
							
							$.ajax({
								type : "post", //전송방식
								url : "adtWriteAjax", //주소
								dataType : "json", //데이터형태
								data : params, //보낼 데이터
								success : function(res) {
									if (res.result == "success") {
										closePopup(1);
										alert("등록이 완료되었습니다.");		
										$("#stdate").val("");
										$("#sttime").val("");
										$("#eddate").val("");
										$("#edtime").val("");
										$("#adtCon").val("");
										
										reloadList();
									} else {
										alert("오류가 발생하였습니다.");
									}
								},//success end
								error : function(request, status, error) {//실행 중 에러 발생 시 경우 해당 함수를 실행하겠다.
									console.log("txt : " + request.responseText); //반환 텍스트
									console.log("error : " + error); //에러 내용
								}
							});//ajax end 
							
						}
					}else {
						var params = $("#actionForm").serialize();
						
						console.log(params);
						
						$.ajax({
							type : "post", //전송방식
							url : "adtWriteAjax", //주소
							dataType : "json", //데이터형태
							data : params, //보낼 데이터
							success : function(res) {
								if (res.result == "success") {
									closePopup(1);
									alert("등록이 완료되었습니다.");		
									$("#stdate").val("");
									$("#sttime").val("");
									$("#eddate").val("");
									$("#edtime").val("");
									$("#adtCon").val("");
									
										reloadList();
								} else {
									alert("오류가 발생하였습니다.");
								}
							},//success end
							error : function(request, status, error) {//실행 중 에러 발생 시 경우 해당 함수를 실행하겠다.
								console.log("txt : " + request.responseText); //반환 텍스트
								console.log("error : " + error); //에러 내용
							}
						});//ajax end 
						
					}
			
			//조회데이터기반 캘린더 리로드
		}, "닫기", function() {
			closePopup(1);
		});//makeTwoPopup end
	
	
	});//insertBtn end

	
	var d = new Date();
	var calendarEl = document.getElementById('calendar1');
	var all = "";
    calendar = new FullCalendar.Calendar(calendarEl, {
    	displayEventTime: false,
    	
    	headerToolbar: {
    		left: '',
            center: 'title',
            right: ''
		},
		defaultDate: d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate(),
		locale: "ko",
		editable: false,
		height: 600,
		//events: data,
		eventClick: function(info) { // 이벤트 클릭
			$("#aDutyNo").val(info.event.id);
		
			var params = $("#actionForm2").serialize();
			$.ajax({
				type : "post", //전송방식
				url : "getPUListAjax", //주소
				dataType : "json", //데이터형태
				data: params, //보낼 데이터
				success : function(res){
					if(res.result == "success"){
					
							if(res.list[0].TYPE == 0){
								res.list[0].TYPE = "야근";
								}else{
								res.list[0].TYPE = "주말근무";
									}
							
							if(res.list[0].PLACE == 0){
								res.list[0].PLACE = "내근";
								}else{
								res.list[0].PLACE = "외근";
									} 
							
							var html = "";
							/*이미 코어태그를 거쳐서 온거기 때문에 코어태그를 쓸 수 없음)  */
							html += "<div class=\"con_1\">사원정보:</div>";
							html += "<div class=\"con_1_1\">" + res.list[0].TITLE + "(" + res.list[0].DPRTMNT_NAME + " " +  res.list[0].PSTN_NAME + ")" + "</div><br/>";
							html += "<div class=\"con_1\">근무유형:</div>";
							html += "<div class=\"con_1_1\">" + res.list[0].TYPE + "</div><br/>";
							html += "<div class=\"con_1\">시작일시:</div>";
							html += "<div class=\"con_1_1\">" + res.list[0].START + " " + res.list[0].STARTTIME + "</div><br/>";
							html += "<div class=\"con_1\">종료일시:</div>";
							html += "<div class=\"con_1_1\">" + res.list[0].END +  " " + res.list[0].ENDTIME + "</div><br/>";
							html += "<div class=\"con_2\">장소:</div>";
							html += "<div class=\"con_1_1\">" + res.list[0].PLACE + "</div><br/>";
							html += "<div class=\"con_1\">업무내용:</div>";
							html += "<textarea cols=\"50\" rows=\"13\" name=\"adtCon\" id=\"adtCon\">" + res.list[0].CNTNT + "</textarea>";
							
						if("${sEmplyNo}" == res.list[0].EMPLY_NO) {

							makeThreeBtnPopup(1, "추가근무정보", html, false, 600, 600, null, "수정", function() {
								
								var params = $("#actionForm2").serialize();
								$.ajax({
									type : "post", //전송방식
									url : "getPUListAjax", //주소
									dataType : "json", //데이터형태
									data: params, //보낼 데이터
									success : function(res){
										if(res.result == "success"){
											/*select에 value를 주면 선택됨  */
											
											var html = "";
											
											html += "<form action=\"#\" id=\"actionForm3\" method=\"post\">";
											html += "<div class=\"con_1\">사원정보:</div>";
											html += "<div class=\"con_1_1\">" + res.list[0].TITLE + "(" + res.list[0].DPRTMNT_NAME + " " +  res.list[0].PSTN_NAME + ")" + "</div><br/>";
											html += "<div class=\"con_1\">근무유형:</div>";
											html += "<select class=\"con2\" name=\"adttype\">";
											html += "<option value=\"0\">야근</option>";
											html += "<option value=\"1\">주말근무</option></select><br/>";
											html += "<div class=\"con_1\">시작일시:</div>";
											html += "<input type=\"date\" class=\"con3\" name=\"stdate\" id=\"stdate\" value=\"" + res.list[0].START + "\"/>";
											html +=	"<input type=\"time\" class=\"con4\" name=\"sttime\" id=\"sttime\" value=\"" + res.list[0].STARTTIME + "\"/><br/>";
											html += "<div class=\"con_1\">종료일시:</div>";
											html += "<input type=\"date\" class=\"con3\" name=\"eddate\" id=\"eddate\" value=\"" + res.list[0].END + "\"/>";
											html += "<input type=\"time\" class=\"con4\" name=\"edtime\" id=\"edtime\" value=\"" + res.list[0].ENDTIME + "\"/><br/>";
											html += "<div class=\"con_2\">장소:</div>";
											html += "<select class=\"con2_1\" name=\"adtplace\">";
											html += "<option value=\"0\">내근</option>";
											html += "<option value=\"1\">외근</option></select><br/>";
											html += "<div class=\"con_1\">업무내용:</div>";
											html += "<textarea cols=\"50\" rows=\"13\" name=\"adtCon\" id=\"adtCon\">" + res.list[0].CNTNT + "</textarea>";
											html += "<input type=\"hidden\" id=\"aDutyNo\" name=\"aDutyNo\" />"
											html += "</form>";
											
											
											popupContentsChange(1, html, function() {
												$(".con2_1").val(res.list[0].PLACE);//장소
												$(".con2").val(res.list[0].TYPE);//근무유형
												$("#aDutyNo").val(res.list[0].ID);
											});
												
											
											popupBtnChange(1, 1, "저장", function() {
												console.log($("#aDutyNo").val());
												console.log($("#eddate").val());
												console.log($("#edtime").val());
												var startDate = parseInt($("#stdate").val().replace("-", '').replace("-", ''));
												var endDate = parseInt($("#eddate").val().replace("-", '').replace("-", ''));
												var stTime = parseInt($("#sttime").val().replace(":", ''));
												var edTime = parseInt($("#edtime").val().replace(":", ''));	
												
											
												//수정동작
												if ($.trim($("#stdate").val()) == "") {
													alert("시작날짜를 입력하여 주세요.");
												}else if ($.trim($("#sttime").val()) == "") {
													alert("시작시간을 입력하여 주세요.");
												}else if ($.trim($("#eddate").val()) == "") {
													alert("종료날짜를 입력하여 주세요.");
												}else if ($.trim($("#edtime").val()) == "") {
													alert("종료시간을 입력하여 주세요.");
												}else if ($.trim($("#adtCon").val()) == "") {
													alert("업무내용을 입력하여 주세요.");
												}else if(endDate < startDate) { 
													alert("종료날짜가 시작날짜보다 과거입니다.");
									            	$("#eddate").val("");
												}else if(endDate == startDate && edTime < stTime) {
									            	alert("종료시간이 시작시간보다 과거입니다.");
									            	$("#edtime").val("");
											            	
												}else if($(".con2").val() == 1){
													if(dateCheck($("#stdate").val()) != "토" && dateCheck($("#stdate").val()) != "일") {
														
														alert("시작날짜가 평일입니다.");
														console.log(dateCheck($("#stdate").val()));
														$("#stdate").val("");
													}else if(dateCheck($("#eddate").val()) != "토" && dateCheck($("#eddate").val()) != "일") {
														
														console.log(dateCheck($("#eddate").val()));
														alert("종료날짜가 평일입니다.");
														$("#eddate").val("");
													}else {
														
														var params = $("#actionForm3").serialize();
														$.ajax({
															type : "post", //전송방식
															url : "adtUpdateAjax", //주소
															dataType : "json", //데이터형태
															data: params, //보낼 데이터
															success : function(res){
																if(res.result == "success"){
																	alert("수정에 성공하였습니다.");
																	closePopup(1);
																	reloadList();
																}else{
																	alert("수정중 문제가 발생하였습니다.");
																	console.log("adtUpdate문제");
																	console.log(res.list);
																}
																	
															},
															error: function(request, status, error){//실행 중 에러 발생 시 경우 해당 함수를 실행하겠다.
																console.log("txt : " + request.responseText); //반환 텍스트
																console.log("error : " + error); //에러 내용
															} 
														});//ajax end
													}
													
												}else {
															var params = $("#actionForm3").serialize();
															$.ajax({
																type : "post", //전송방식
																url : "adtUpdateAjax", //주소
																dataType : "json", //데이터형태
																data: params, //보낼 데이터
																success : function(res){
																	if(res.result == "success"){
																		alert("수정에 성공하였습니다.");
																		closePopup(1);
																		reloadList();
																	}else{
																		alert("수정중 문제가 발생하였습니다.");
																		console.log("adtUpdate문제");
																		console.log(res.list);
																	}
																		
																},
																error: function(request, status, error){//실행 중 에러 발생 시 경우 해당 함수를 실행하겠다.
																	console.log("txt : " + request.responseText); //반환 텍스트
																	console.log("error : " + error); //에러 내용
																} 
															});//ajax end
														
														}
											});//popupBtnChange end
											
										}else{
											alert("수정중 문제가 발생하였습니다.");
											console.log("getPUList문제");
										}
											
									},
									error: function(request, status, error){//실행 중 에러 발생 시 경우 해당 함수를 실행하겠다.
										console.log("txt : " + request.responseText); //반환 텍스트
										console.log("error : " + error); //에러 내용
									} 
								});//ajax end
							}, "삭제", function() {
									
									
									if(confirm("정말로 삭제하시겠습니까?")) {
										var params = $("#actionForm2").serialize();
										
										$.ajax({
											type : "post", //전송방식
											url : "adtDeleteAjax", //주소
											dataType : "json", //데이터형태
											data: params, //보낼 데이터
											success : function(res){
												if(res.result == "success"){
													alert("삭제에 성공하였습니다.");
													closePopup(1);
													reloadList();
												}else{
													alert("삭제중 문제가 발생하였습니다.");
												}
													
											},
											error: function(request, status, error){//실행 중 에러 발생 시 경우 해당 함수를 실행하겠다.
												console.log("txt : " + request.responseText); //반환 텍스트
												console.log("error : " + error); //에러 내용
											} 
										});//ajax end
									}
									
								}, "닫기", function() {
									closePopup(1);
									
								});//make3Btnpopup end
							
							 }else {
								 makeOneBtnPopup(1, "추가근무정보", html, false, 600, 600, null, "닫기", function() {
										closePopup(1);
									});
								 
							 }				
			 		}else{
						alert("조회중 문제가 발생하였습니다.")
					}
						
				},
				error: function(request, status, error){//실행 중 에러 발생 시 경우 해당 함수를 실행하겠다.
					console.log("txt : " + request.responseText); //반환 텍스트
					console.log("error : " + error); //에러 내용
				} 
			});//ajax end 
		},
		dateClick: function(info) {
			/* alert('Clicked on: ' + info.dateStr); */ //날짜 클릭시 이벤트
		}
	});//var calendar end
	calendar.render();
});//document ready end

function reloadList() {
	var params = $("#actionForm4").serialize();
	$.ajax({
		type : "post", //전송방식
		url : "adtListAjax", //주소
		dataType : "json", //데이터형태
		data: params, //보낼 데이터
		success : function(res){
			if(res.result == "success"){
				$("#sEmplyNo2").val("${sEmplyNo}");
				//기존이벤트 제거
				var old = calendar.getEventSources();
				for(var i in old) {
					old[i].remove();
				}
				//신규이벤트 추가
				calendar.addEventSource(res.list);
				//새로 그리기
				calendar.refetchEvents();
			}else{
				alert("조회중 문제가 발생하였습니다.")
			}
				
		},
		error: function(request, status, error){//실행 중 에러 발생 시 경우 해당 함수를 실행하겠다.
			console.log("txt : " + request.responseText); //반환 텍스트
			console.log("error : " + error); //에러 내용
		} 
	});//ajax end
	
}//reloadList end

function dateCheck(day) {
	var week = ['일', '월', '화', '수', '목', '금', '토']
	var dayOfWeek = week[new Date(day).getDay()];
	return dayOfWeek;
}




/* function AuthorityCheck() {
	if("${sAthrtyNo}" == 4 || ${sAthrtyNo} == 9 ) {
	 $("#searchBtn").css("display", "none");
	}
	
} */
/*el tag를 스크립트에서 쓰려면 문자열로 묶어줘야함. 안그러면 스크립트 문법으로 인식함.  */

</script>
</head>
<body>
<!-- 탑/레프트 -->
<c:import url="/topLeft">
<%-- 현재 페이지 해당 메뉴번호 지정 --%>
	<c:param name="menuNo" value="39"></c:param>
</c:import>
<!-- 구현내용 -->
<div class="title_wrap">
	<div class="title_table">
		<div class="title_txt">추가근무관리</div>
	</div>
</div>
<div class="contents_area">
	<!-- 내용은 여기에 구현하세요. -->
	<input type="button" value="prev" id="prevBtn"/>
	<input type="button" value="next" id="nextBtn"/>
	<input type="button" value="view" id="viewBtn"/>
	<form action="#" id="actionForm4">
<c:if test="${athrytyType != 1}">
	<input type="button" value="검색" id="searchBtn"/>
	<select name="dprtSelect" id="dprtSelect">
		<option selected="selected"></option>
		<option value="1">영업</option>
		<option value="2">인사</option>
		<option value="3">경영관리</option>
	</select>
	<input type="button" value="전사" id="allBtn"/>
</c:if>
	<input type="hidden" id="sEmplyNo2" name="sEmplyNo2" value="${sEmplyNo}"/>
	</form>
	<input type="button" value="개인" id="personalBtn"/>
	<input type="button" value="등록" id="insertBtn"/>	
	<div class="calendar1" id="calendar1"></div>
	<form action="#" id="actionForm2">
	<input type="hidden" id="sEmplyNo" name="sEmplyNo" value="${sEmplyNo}" />
	<input type="hidden" name="aDutyNo" id="aDutyNo" />
	</form>
			
			
</div>
<!-- 구현끝 -->
<!-- 바텀 -->
<c:import url="/bottom"></c:import>
</body>
</html>