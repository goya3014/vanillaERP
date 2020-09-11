<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Vanilla ERP - 인사발령</title>
<!-- 헤더 -->
<c:import url="/header"></c:import>

<style type="text/css">
.prsnlA_table thead {
	background-color: #00305A;
	color: white;
}

.prsnlA_table {
	border-collapse: collapse;
	text-align: center;
	vertical-align: center;
	font-size: 11pt;
	display: table;
	border: 2px solid #000000;
	width: 100%;
	margin-top: 10px;
}

#search_btn, #add_btn, #rgstrtn_btn {
	background-color: #00305A;
	color: white;
}

.btn {
	margin-left: 74%;
	display: inline-block;
	vertical-align: top;
}

.bottom_btn {
	margin-left: 95%;
	display: inline-block;
}

#bottom_btn {
	background-color: #00305A;
	color: white;
	margin-left: 16px;
	margin-top: 10px;
	cursor: pointer;
}

#rtdate {
    width: 130px;
    height: 25px;
}

#srchTxt {
	margin-left: 10px;
	vertical-align: top;
	width: 250px;
    height: 20px;
}

#srch {
    width: 50px;
    height: 25px;
}
#search_btn {
	margin-left: 10px;
	vertical-align: top;
	cursor: pointer;
}
#rgstrtn_btn {
	margin-left: 10px;
	vertical-align: top;
	cursor: pointer;
}

#add_btn {
	margin-left: 10px;
	vertical-align: top;
	cursor: pointer;
}

.paging_area{
	font-size: 13pt;
	margin-left: 43%;
    margin-top: 1%;
}

.empnoDiv, .empnameDiv, .conDiv, .apntmnts_sel_Div, .movedprtmnt_Div, 
.startDateDiv, .moveDateDiv, .decisionDiv,.apntmntsgubunDiv, .apntmnts_sel_Div {
	display: inline-block;
	font-size: 14pt;
	margin:15px;
}

#empsrchBtn {
	margin-left: 3%;
}

#drwnameDiv, #drwempnoDiv, #drwempjDiv, #drwempbDiv {
	font-size: 14pt;
	display: inline-block;
}

#empsrchBtn {
	background-color: #00305A;
	color: white;
}

#jinsertBtn, #binsertBtn{
	background-color: #00305A;
	color: white;
	margin-left: 20%;
}

.empsrchTable, .bstntTable {
	border-collapse: collapse;
	text-align: center;
	vertical-align: center;
	font-size: 11pt;
	display: table;
	border: 2px solid #000000;
	width: 100%;
	margin-top: 10px;
}

.bstntTable thead {
	background-color: #00305A;
	color: white;
}

.empsrchTable thead {
	background-color: #00305A;
	color: white;
}

.jnameGbn, .dnameGbn {
    width: 100px;
    height: 30px;
    font-size: 15px;
}

#line {
	border-bottom: 1px solid black;
}
</style>

<script type="text/javascript">

$(document).ready(function() {
	var jno = "";
	var dno = "";
	
	/* 팝업 1 */
	$("#rgstrtn_btn").on("click", function() {
		var html1 =""; 
		html1 +="<form action=\"#\" id=\"prsnlRgstrtnForm\" method=\"post\">";
		html1 += "<input type=\"hidden\" id=\"empNo2\" name=\"empNo2\"method=\"post\">";
		html1 += "<input type=\"hidden\" id=\"end_day\" name=\"end_day\"method=\"post\">";
		html1 +="<input type=\"button\" id=\"empsrchBtn\" value=\"사원조회\"> </br>";
		html1 += "<div class=\"empnameDiv\" > 사원명 : </div> <div id=\"drwnameDiv\"></div> </br>";
		html1 += "<div class=\"empnoDiv\" > 사원번호 : </div> <div id=\"drwempnoDiv\"></div> </br>";
		/* select 수정해야됨  */
		
		html1 += "<div class=\"apntmnts_sel_Div\">직급 :</div> <select class=\"jnameGbn\" name=\"jnameGbn\" id=\"jnameGbn\"><option>-</option></select>";
		html1 += "<div id=\"drwempjDiv\"></div></br>";
		/* 부서는 사원 목록 팝업 띄운것 처럼 자기가 속해있는 부서 빼고  */    
		html1 += "<div class=\"movedprtmnt_Div\"> 부서 :</div> <select class=\"dnameGbn\" name=\"dnameGbn\" id=\"dnameGbn\"><option>-</option></select> </br>";
		html1 += "<div class=\"startDateDiv\">발령일자 : <input type=\"date\" id=\"rtdate\" name=\"rtdate\" /></div>";
		html1 += "</form>" ;
		
	
		makeTwoBtnPopup(1, "인사발령", html1, true, 600, 600, function () {
			/* 직급 */
			$.ajax({
				type : "post",
				url : "popupPstnListAjax",
				dataType : "json", 
				success : function(res){
					if (res.result = "success"){
						redrawoptionjList(res.list);
					} else {
						alert ("조회중 문제가 발생하였습니다.")
					}
				},
				error : function(request, status, error) {//실행 중 에러 발생 시 경우 해당 함수를 실행하겠다.
					console.log("txt : " + request.responseText); //반환 텍스트
					console.log("error : " + error); //에러 내용
				} //error
			});//ajax
			
			$.ajax({
				type : "post",
				url : "popupDprtmntListAjax",
				dataType : "json", 
				success : function(res){
					if (res.result = "success"){
						redrawoptiondList(res.list);
					} else {
						alert ("조회중 문제가 발생하였습니다.")
					}
				},
				error : function(request, status, error) {//실행 중 에러 발생 시 경우 해당 함수를 실행하겠다.
					console.log("txt : " + request.responseText); //반환 텍스트
					console.log("error : " + error); //에러 내용
				} //error
			});
			
			
			/* 팝업 2 */
			$("#empsrchBtn").on("click", function () {
				var html2 ="";
				html2 += "<form action=\"#\" id=\"empsrchForm\" method=\"post\">";
				html2 += "<input type=\"hidden\" id=\"empNo\" name=\"empNo\" />"
				html2 += "<input type=\"hidden\" id=\"empName\" name=\"empName\" />"
				html2 += "<input type=\"hidden\" id=\"jName\" name=\"jName\" />"
				html2 += "<input type=\"hidden\" id=\"jNo\" name=\"jNo\" />"
				html2 += "<input type=\"hidden\" id=\"dName\" name=\"dName\" />"
				html2 += "<div id=\"empsrchScroll\">";
				html2 += "<table class=\"empsrchTable\" \>";
				html2 += "<colgroup> <col width=\"150\"/> <col width=\"150\"/> <col width=\"150\"/> <col width=\"150px\"/> </colgroup>";
				html2 += "<thead> <tr> <th>사원명</th> <th>사원번호</th> <th>직급</th> <th>부서</th> </tr> </thead>";
				html2 += "<tbody> </tbody>";
				html2 += "</table>";
				html2 += "</div>";
				html2 += "</form>";
				
				makeOneBtnPopup(2, "사원목록", html2, true, 600, 600, function() {
					empsrchList();
					
					$("#popup2 .con_con #empsrchScroll").slimScroll({
						height : "450px"
					}); 
					
					/* 테이블에서 사원목록을 클릭했을 때 */			
					$("#popup2 .empsrchTable").on("click", "tr", function () {
						$("#empNo").val($(this).attr("name"));
						$("#empNo2").val($(this).attr("name"));
						
						var params = $("#empsrchForm").serialize();
						$.ajax({
							type : "post",
							url : "prsnempAjax",
							dataType : "json", 
							data: params,
							success : function(res){
								if (res.result = "success"){
									$("#drwnameDiv").text(res.data.EMPNAME);
								 	$("#drwempnoDiv").text(res.data.EMPNO);
								 	
								 	if(res.data.JNO != undefined) {
										$("#jnameGbn").val(res.data.JNO);
										jno = res.data.JNO;
								 	} else {
								 		$("#jnameGbn").val($("#jnameGbn option:first").val());
										jno = $("#jnameGbn option:first").val();
								 	}
									/* 부서 옵션 val */
									if(res.data.DNO != undefined) {
										$("#dnameGbn").val(res.data.DNO);
										dno = res.data.DNO;
									} else {
										$("#dnameGbn").val($("#dnameGbn option:first").val());
										dno = $("#dnameGbn option:first").val();
									}
								} else {
									alert ("조회중 문제가 발생하였습니다.")
								}
							},
							error : function(request, status, error) {//실행 중 에러 발생 시 경우 해당 함수를 실행하겠다.
								console.log("txt : " + request.responseText); //반환 텍스트
								console.log("error : " + error); //에러 내용
							} //error
						});//ajax
						closePopup(2);
					}); //fun 
				}, "닫기", function () {
					closePopup(2);
				}); 
			}); // 팝업 2

	/* 팝업3 */
	/* 데이터 생성할때  */
	$("#popup1 #binsertBtn").on("click", function() {
		 var html3 ="";
		html3 += "<form action=\"#\" id=\"empsrchForm\" method=\"post\">";
		html3 += "<input type=\"hidden\" id=\"dName\" name=\"dName\"/>";
		html3 += "</form>"; 
		pstnsrchList();
		
		
		makeOneBtnPopup(2, "부서목록", html3, true, 300, 300, function(){
			
				})
		}, "닫기", function () {
			closePopup(2);
		});
			
			
		 }, "결재", function () {
			//결재 누르면 등록 바로 되게 하기 //변경한 값이 없거나 날짜를 등록하지 않았을때 
		 	if($("#jnameGbn").val() == jno || $("#dnameGbn").val()==dno && $("rtdate").val()==null){
				makeAlert(1, "알림", "값이 변경되지 않았거나 입력이 되지 않았습니다.", true, null);
			} else { 
				
				$("#end_day").val($("#rtdate").val());
			var params = $("#prsnlRgstrtnForm").serialize();
			
			 $.ajax({ 
				type : "post", //전송방식
				url : "signinsertAjax", //주소
				dataType : "json", //데이터형태
				data: params, //보낼 데이터
				success : function(res){//성공적으로 넘어왔을때 해당 함수를 실행하겠다. 돌아오는 값은 res란 이름으로 받는다. 
					if(res.result == "success"){
						makeAlert(1, "알림", "인사발령 되었습니다.", true, null);
						closePopup(1);
						 reloadList();
					}else{
						alert("오류가 발생하였습니다.")
					}
						
				},
				error: function(request, status, error){//실행 중 에러 발생 시 경우 해당 함수를 실행하겠다.
					console.log("txt : " + request.responseText); //반환 텍스트
					console.log("error : " + error); //에러 내용
				} 
			});//ajax end	
			 
			}  
			
			
		},"닫기", function() {
		closePopup(1);
	}); 
}); //popup 1
	
			 
/* 조회 */
 
 	if ("${param.page}" != "") {
		$("#page").val("${param.page}");
	}
	if ("${param.srchTxt}" != "") {
		$("#search_btn").val("${param.srchTxt}");
	}
	if ("${param.srch}" != "") {
		$("#srch").val("${param.srch}");
	} 

	reloadList(); 
		
	$(".paging_area").on("click", "span", function(){
		$("#page").val($(this).attr("name"));
		reloadList();
	});

	$("#search_btn").on("click", function(){
		$("#page").val("1");
		reloadList();
	});
	
	$("[name='srchTxt']").on("keypress", function(event) {
		if (event.keyCode == 13) {
			$("#search_btn").click();
			return false;
		}
	}); 

}); //document end

/* 팝업에 사원 목록 */ 
function empsrchList() {
	var params =$("empsrchForm").serialize();
	$.ajax({
		type : "post", //전송방식
		url : "empsrchAjax", //주소
		dataType : "json", //데이터형태
		data : params, //보낼 데이터
		success : function(res) {//성공적으로 넘어왔을때 해당 함수를 실행하고, 돌아오는 값은 res란 이름으로 받는다. res에 result, pb, list가 들어있음.
			if (res.result = "success") {
				redrawempList(res.list); 
			} else {
				alert("조회중 문제가 발생하였습니다.")
			}

		},
		error : function(request, status, error) {//실행 중 에러 발생 시 경우 해당 함수를 실행하겠다.
			console.log("txt : " + request.responseText); //반환 텍스트
			console.log("error : " + error); //에러 내용
		}

	});
}//empsrchList end


/* 사원 list */
function redrawempList(list) {
	if(list.length == 0){//가져온 데이터가 없는 경우 여기도 내일 봐야됨
		var html = "";
		html += "<tr>"
		html += "<td colspan=\"4\">조회 결과가 없습니다.</td>"
		html += "</tr>"
		
		$(".empsrchTable tbody").html(html);
	}else{
		var html = "";
		
		for(var i = 0; i < list.length; i++){
			html += "<tr name=\"" + list[i].EMPNO + "\">";
			html += "<td id=\"line\">" + list[i].EMPNAME + "</td>" 
			html += "<td id=\"line\">" + list[i].EMPNO + "</td>"
			html += "<td id=\"line\">" + list[i].JNAME + "</td>"
			html += "<td id=\"line\">" + list[i].DNAME + "</td>"
			html += "</tr>";
		}
		$(".empsrchTable tbody").html(html);
	}
	
}//redrawList end


//직급 옵션 그리기 
function redrawoptionjList(list) {
	if(list.length == 0){//가져온 데이터가 없는 경우 여기도 내일 봐야됨
		var html = "";
		html += "<option>조회결과가 없습니다.</option>"
		
		$("#jnameGbn").html(html);
	}else{
		var html = "";
		
		for(var i = 0; i < list.length; i++){
			html +="<option value=\"" + list[i].JNO + "\">" + list[i].JNAME + "</option>"
		}
		
		$("#jnameGbn").html(html);
	}
	
}//redrawoptionjList end

//부서 옵션 
function redrawoptiondList(list) {
	if(list.lenght == 0) {
		var html = "";
		html += "<option>조회결과가 없습니다.</option>"
		
		$("#dnameGbn").html(html);
	}else{
		var html = "";
		
		for(var i = 0; i < list.length; i++){
			html +="<option value=\"" + list[i].DNO + "\">" + list[i].DNAME + "</option>"
		}
		
		$("#dnameGbn").html(html);	
	}
}



/* 팝업에서 부서 목록 띄우기  여기도*/
function pstnsrchList() {
	var params =$("empsrchForm").serialize();
	$.ajax({
		type : "post", //전송방식
		url : "pstnsrchAjax", //주소
		dataType : "json", //데이터형태
		data : params, //보낼 데이터
		success : function(res) {//성공적으로 넘어왔을때 해당 함수를 실행하고, 돌아오는 값은 res란 이름으로 받는다. res에 result, pb, list가 들어있음.
			if (res.result = "success") {
				redrawpstnList(res.list); //그려줘
			} else {
				alert("조회중 문제가 발생하였습니다.")
			}

		},
		error : function(request, status, error) {//실행 중 에러 발생 시 경우 해당 함수를 실행하겠다.
			console.log("txt : " + request.responseText); //반환 텍스트
			console.log("error : " + error); //에러 내용
		}

	});
}//end

/* 부서 리스트  여기 필요없을수도 있음*/
function redrawpstnList(list) {
	if(list.length == 0){//가져온 데이터가 없는 경우 여기도 내일 봐야됨
		var html = "";
		html += "<tr>"
		html += "<td colspan=\"1\">조회 결과가 없습니다.</td>"
		html += "</tr>"
		
		$(".bstntTable tbody").html(html);
	}else{
		var html = "";
		
		for(var i = 0; i < list.length; i++){
			html += "<tr name=\"" +   list[i].DPRTMNT_NAME  + "\">";
			html += "<td>" + list[i].DPRTMNT_NAME  + "</td>"
			html += "</tr>";
		}
		$(".bstntTable tbody").html(html);
	}
	
}//redrawpstnList end 
	
//인사발령 된 목록
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

//인사발령 List
function redrawList(list) {
	if(list.length == 0){//가져온 데이터가 없는 경우
		var html = "";
		html += "<tr>"
		html += "<td colspan=\"5\">조회 결과가 없습니다.</td>"
		html += "</tr>"
		
		$(".prsnlA_table tbody").html(html);
	}else{
		var html = "";
		
		for(var i = 0; i < list.length; i++){
			html += "<tr name=\"" + list[i].EMPNO + "\">";
			html += "<td>" + list[i].EMPNO + "</td>" 
			html += "<td>" + list[i].EMPNAME + "</td>"
			html += "<td>" + list[i].JNAME + "</td>"
			html += "<td>" + list[i].DNAME + "</td>"
			html += "<td>" + list[i].STARTDAY + "</td>"
			html += "</tr>";
		}
		$(".prsnlA_table tbody").html(html);
	}
	
}//redrawList end

/* 페이징 */
function redrawPaging(pb) {
	var html = "<span name=\"1\">처음</span>&nbsp;";
	
	if($("#page").val() == 1){
		html += "<span name=\"1\">이전</span>&nbsp;";
	}else{
		html += "<span name=\"" + ($("#page").val() * 1 - 1) + "\"이전</span>&nbsp;";
	}
	
	for(var i = pb.startPcount; i <= pb.endPcount; i++){
		if(i == $("#page").val()){
			html += "<span name=\"" + i + "\"><b>" + i + "</b></span>&nbsp;";
		}else{
			html += "<span name=\"" + i + "\">" + i + "</span>&nbsp;";
		}
	}
	
	if($("#page").val() == pb.maxPcount){
		html += "<span name=\"" + pb.maxPcount + "\">다음</span>&nbsp;";
	}else{
		html += "<span name=\"" + ($("#page").val() * 1 + 1) + "\"다음</span>&nbsp;";
	}
	
	html += "<span name=\"" + pb.maxPcount + "\">마지막</span>";
	
	$(".paging_area").html(html);
}

</script>

</head>

<body>

<!-- 탑/레프트 -->
<c:import url="/topLeft">
	<%-- 현재 페이지 해당 메뉴번호 지정 --%>
	<c:param name="menuNo" value="43"></c:param>
</c:import>
<!-- 구현내용 -->
<div class="title_wrap">
	<div class="title_table">
		<div class="title_txt">인사발령</div>
	</div>
</div>
<div class="contents_area">
	<!-- 내용은 여기에 구현하세요. -->
	<div class="srch">
		<form action="#" method="post" id="prsnlForm">
			<input type="hidden" id="empNo" name="empNo" />
			<input type="hidden" id="empName" name="empName" />
			<input type="hidden" id="jName" name="jName" />
			<input type="hidden" id="dName" name="dName" />
			<input type="hidden" name="page" id="page" value="1"/>
			<select name="srch" id="srch">
				<c:choose>
					<c:when test="${param.srch eq 0}">
						<option value="0" selected="selected">전체</option>
					</c:when>
					<c:otherwise>
						<option value="0">전체</option>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${param.srch eq 1}">
						<option value="1" selected="selected">사원번호</option>
					</c:when>
					<c:otherwise>
						<option value="1">사원번호</option>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${param.srch eq 2}">
						<option value="2" selected="selected">사원명</option>
					</c:when>
					<c:otherwise>
						<option value="2">사원명</option>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${param.srch eq 3}">
						<option value="3" selected="selected">부서명</option>
					</c:when>
					<c:otherwise>
						<option value="3">부서명</option>
					</c:otherwise>
				</c:choose>
			</select> 
		<input type="text" placeholder="검색어를 입력해주세요." name="srchTxt" id="srchTxt" /> 
		<input type="button" value="검색" id="search_btn" />
		<input type="button" value="등록" id="rgstrtn_btn" />
		</form>
	</div>


<table class="prsnlA_table" border="1">
<colgroup>
	<col width="150px"/>
	<col width="150px"/>
	<col width="150px"/>
	<col width="200px"/>
	<col width="200px"/>
</colgroup>
	<thead>
		<tr>
			<th>사원번호</th>
			<th>사원명</th>
			<th>직급</th>
			<th>부서명</th>
			<th>발령일</th>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>

<div class="paging_area">
	<span name="1">처음</span>
	<span name="1">이전</span>
	<span name="1">1</span>
	<span name="1">다음</span>
	<span name="1">마지막</span>
</div>
		
<div class="bottom_btn">
	<input type="button" value="저장" id="bottom_btn" />
</div>

</div>
	<!--팝업종료  -->

	<!-- 구현끝 -->
	<!-- 바텀 -->
	<c:import url="/bottom"></c:import>
</body>
</html>