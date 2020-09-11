<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Vanilla ERP - 급여조회 페이지</title>
<!-- 헤더 -->
<c:import url="/header"></c:import>
<style type="text/css">
.drop_wrap {
	display: inline-block;
	margin-left: 30px;
}

#year {
	margin-right: 40px;
	margin-left: 40px
}

.Checkbox_wrap {
	display: inline-block;
	float: right;
	width: 400px;
}

.button_wrap {
	height: 45px;
	width: 300px;
	right: 20px;
	margin-left: 340px;
}

#all {
	margin-left: 20px
}

#years, #months {
	margin: 20px;
	height: 30px;
	width: 80px;
}

.tbl1 {
	height: 100%;
	width: 100%;
	margin-top: 50px;
}

.space1, .space2, .space3, .space4, .infom_wrap {
	display: inline-block;
	vertical-align: top;
	border: 1px solid black;
}

.space1, .space2, .space3, .space4{
	height : 600px;
}



.pay, .insen, .work, .tax {
	height : 600px;
	width: 255px;
	border-collapse: collapse;
	font-size: 11pt;
	text-align: center;
	vertical-align: top;
}

.infom_wrap {
	height: 380px;
	width: 250px;
	margin-left: 30px;
	margin-right: 50px;
}

.infom {
	height: 100%;
	width: 100%;
	border-collapse: collapse;
	font-size: 11pt;
	text-align: center;
}

.hap, .pay thead, .insen thead,.work thead, .tax thead {
	/* background-color: #004078; */
	height : 50px;
	background: linear-gradient(#004B8D, #00305A);
	color: white;
}
.hap{
	height : 10%;
	background: linear-gradient(#004B8D, #00305A);
	color: white;
}

.pay thead tr, .insen thead tr, .work thead tr, .tax thead tr, .infom thead tr {
	height: 50px;
}

.pay td, .insen td, .work td, .tax td {
	border: 1px solid lightgray;
	height: 50px;
}
.print{
	width: 51px;
	position: relative;
	left:1400px;
	margin: 0px;

}

#printbtn{
	display: inline-block;
	position :relative;
	width : 50px;
	height: 30px;
	right : 10px;
}
</style>
<script type="text/javascript">

reloadInfoList();
reloadIndPayList();
reloadIndInsenList();
reloadIndTaxList();


$(document).ready(function(){
	
	$(".silmscroll").slimScroll({
		height: "380px"
	});




});

function reloadInfoList(){
	
	
	$.ajax({
	type : "post", 
	url : "reloadInfoListAjax", 
	dataType : "json", //보내는 데이터형태
	success : function(res){ //성공시 다음의 함수를 실행하게되며 돌아오는 값을 res라는 이름으로 받는다
		if(res.result == "success"){
			redrawInfoList(res.list);
		}else {
			
			 makeAlert(1, "알림", "오류가 발생하였습니다.", null);
		}
		
						
	},			
	error : function(request, status, error){ // 실행도중 에러가 발생했을때
		console.log("txt : " + request.responseText); //반환 텍스트
		console.log("error : " + error); // 에러내용			
	}
	
});

}

function redrawInfoList(list){
	
	if(list.length == 0){//조회가 되지않았을때
		
		var html = "";
		
		html +="<tr>";
		html +="<td colspan =\"5\">조회결과가 없습니다.</td>";
		html +="</tr>"
		$(".infom tbody").html(html);
		} else {//조회되엇을때
		
		var html = "";
		
		for (var i = 0; i < list.length ; i++){
			
			html += "<tr>";
			html += "<td><pre> 이름  : " + list[i].EMPLY_NAME + "</pre></td>";
			html += "</tr>";
			html += "<tr>"
			html += "<td><pre> 부서 :  " + list[i].DPRTMNT_NAME + "</pre></td>";
			html += "</tr>"
			html += "<tr>"
			html += "<td><pre> 직책 : " +  list[i].PSTN_NAME + "</pre></td>";
			html += "</tr>"
			html += "<tr>"
			html += "<td><pre> 입사일  :" + list[i].START_DAY + "</pre></td>";
			html += "</tr>";
	}
 
		$(".infom tbody").html(html);
}

}

function reloadIndPayList(){
	
	$.ajax({
		type : "post", 
		url : "reloadIndPayListAjax", 
		dataType : "json", //보내는 데이터형태
		success : function(res){ //성공시 다음의 함수를 실행하게되며 돌아오는 값을 res라는 이름으로 받는다
			if(res.result == "success"){
				redrawIndPayList(res.list);
			}else {
				
				 makeAlert(1, "알림", "오류가 발생하였습니다.", null);
			}
			
							
		},			
		error : function(request, status, error){ // 실행도중 에러가 발생했을때
			console.log("txt : " + request.responseText); //반환 텍스트
			console.log("error : " + error); // 에러내용			
		}
		
	});

}

function redrawIndPayList(list){
	
	if(list.length == 0){//조회가 되지않았을때
		
		var html = "";
		
		html +="<tr>";
		html +="<td colspan =\"5\">조회결과가 없습니다.</td>";
		html +="</tr>"
			$(".tbl1").append(html);

		} else {//조회되엇을때
		
		var html = "";
		
		for (var i = 0; i < list.length ; i++){
			var html = "";
html+="	<div class=\"space1\">"                                 ;
html+="	<table class=\"pay\"> "                                 ;
html+="	<thead>"                                                ;
html+="	<tr> "                                                  ;
html+="	<th>기본급여</th> "                                     ;
html+="	</tr>  "                                                ;
html+="	<tbody>	 "                                              ;
	for (var i =0; i <5 ;i++ ){
html+="	<tr >  "                                                ;
html+="	<td><pre>"+ list[i].SLRY_DTLS_SPRTN_NAME+  " :  "   +  list[i].AMNT  +"원</pre></td>";
html+="	</tr> "                                                 ;
	}

html+="	<tr class=\"hap\"> "                                    ;
html+="	<td><pre>총 기본급여  :   "+list[1].S_HAP+ "원</pre></td> " ;
html+="	</tr>  "                                                ;
html+="	</tbody> "                                              ;
html+="	</table>   "                                            ;
html+="	</div>  "                                               ;
		}
		
$(".tbl1").append(html);
		
			
		
		}
}

function reloadIndInsenList(){
	
	$.ajax({
		type : "post", 
		url : "reloadIndInsenListAjax", 
		dataType : "json", //보내는 데이터형태
		success : function(res){ //성공시 다음의 함수를 실행하게되며 돌아오는 값을 res라는 이름으로 받는다
			if(res.result == "success"){
				redrawIndInsenList(res.list);
			}else {
				
				 makeAlert(1, "알림", "오류가 발생하였습니다.", null);
			}
			
							
		},			
		error : function(request, status, error){ // 실행도중 에러가 발생했을때
			console.log("txt : " + request.responseText); //반환 텍스트
			console.log("error : " + error); // 에러내용			
		}
		
	});

}
function redrawIndInsenList(list){
	
	if(list.length == 0){//조회가 되지않았을때
		
		var html = "";
		
		html +="<tr>";
		html +="<td colspan =\"5\">조회결과가 없습니다.</td>";
		html +="</tr>"
			$(".tbl1").append(html);

		} else {//조회되엇을때
		
		var html = "";
		
		for (var i = 0; i < list.length ; i++){
			var html = "";
html+="	<div class=\"space2\">"                                 ;
html+="	<table class=\"insen\"> "                                 ;
html+="	<thead>"                                                ;
html+="	<tr> "                                                  ;
html+="	<th>인센티브</th> "                                     ;
html+="	</tr>  "                                                ;
html+="	<tbody>	 "                                              ;
	for (var i =0; i <4 ;i++ ){
html+="	<tr >  "                                                ;
html+="	<td><pre>"+ list[i].SLRY_DTLS_SPRTN_NAME+  " :  "   +  list[i].AMNT  +"원</pre></td>";
html+="	</tr> "                                                 ;
	}

html+="	<tr >"    ;
html+="	<td></td> "  ;
html+="</tr>";

html+="	<tr class=\"hap\"> "                                    ;
html+="	<td><pre>총 인센티브  :   "+list[1].S_HAP+ "원</pre></td> " ;
html+="	</tr>  "                                                ;
html+="	</tbody> "                                              ;
html+="	</table>   "                                            ;
html+="	</div>  "                                               ;
		}
		
$(".tbl1").append(html);
		
			
		
		}
}


function reloadIndTaxList(){
	
	$.ajax({
		type : "post", 
		url : "reloadIndTaxListAjax", 
		dataType : "json", //보내는 데이터형태
		success : function(res){ //성공시 다음의 함수를 실행하게되며 돌아오는 값을 res라는 이름으로 받는다
			if(res.result == "success"){
				redrawIndTaxList(res.list);
			}else {
				
				 makeAlert(1, "알림", "오류가 발생하였습니다.", null);
			}
			
							
		},			
		error : function(request, status, error){ // 실행도중 에러가 발생했을때
			console.log("txt : " + request.responseText); //반환 텍스트
			console.log("error : " + error); // 에러내용			
		}
		
	});

}

function redrawIndTaxList(list){
	
	if(list.length == 0){//조회가 되지않았을때
		
		var html = "";
		
		html +="<tr>";
		html +="<td colspan =\"5\">조회결과가 없습니다.</td>";
		html +="</tr>"
			$(".tbl1").append(html);

		} else {//조회되엇을때
		
		var html = "";
		
		for (var i = 0; i < list.length ; i++){
			var html = "";
html+="	<div class=\"space3\">"                                 ;
html+="	<table class=\"tax\"> "                                 ;
html+="	<thead>"                                                ;
html+="	<tr> "                                                  ;
html+="	<th>공제내역</th> "                                     ;
html+="	</tr>  "                                                ;
html+="	<tbody>	 "                                              ;
	for (var i =0; i <5 ;i++ ){
html+="	<tr >  "                                                ;
html+="	<td><pre>"+ list[i].SLRY_DTLS_SPRTN_NAME+  " :  "   +  list[i].AMNT  +"원</pre></td>";
html+="	</tr> "                                                 ;
	}


html+="	<tr class=\"hap\"> "                                    ;
html+="	<td><pre>총 공제내역  :   "+list[1].S_HAP+ "원</pre></td> " ;
html+="	</tr>  "                                                ;
html+="	</tbody> "                                              ;
html+="	</table>   "                                            ;
html+="	</div>  "                                               ;
		}
		
$(".tbl1").append(html);
		
			
		
		}
}

function reloadIndWorkList(){
	
	$.ajax({
		type : "post", 
		url : "reloadIndWorkListAjax", 
		dataType : "json", //보내는 데이터형태
		success : function(res){ //성공시 다음의 함수를 실행하게되며 돌아오는 값을 res라는 이름으로 받는다
			if(res.result == "success"){
				redrawIndWorkList(res.list);
			}else {
				
				 makeAlert(1, "알림", "오류가 발생하였습니다.", null);
			}
			
							
		},			
		error : function(request, status, error){ // 실행도중 에러가 발생했을때
			console.log("txt : " + request.responseText); //반환 텍스트
			console.log("error : " + error); // 에러내용			
		}
		
	});

}

function redrawIndWorkList(list){
	
	if(list.length == 0){//조회가 되지않았을때
		
		var html = "";
		
		html +="<tr>";
		html +="<td colspan =\"5\">조회결과가 없습니다.</td>";
		html +="</tr>"
			$(".tbl1").append(html);

		} else {//조회되엇을때
		
		var html = "";
		
		for (var i = 0; i < list.length ; i++){
			var html = "";
html+="	<div class=\"space4\">"                                 ;
html+="	<table class=\"work\"> "                                 ;
html+="	<thead>"                                                ;
html+="	<tr> "                                                  ;
html+="	<th>근태내역</th> "                                     ;
html+="	</tr>  "                                                ;
html+="	<tbody>	 "                                              ;
	for (var i =0; i <5 ;i++ ){
html+="	<tr >  "                                                ;
html+="	<td><pre>"+ list[i].SLRY_DTLS_SPRTN_NAME+  " :  "   +  list[i].AMNT  +"원</pre></td>";
html+="	</tr> "                                                 ;
	}


html+="	<tr class=\"hap\"> "                                    ;
html+="	<td><pre> 실 금액  :   "+list[1].S_HAP+ "원</pre></td> " ;
html+="	</tr>  "                                                ;
html+="	</tbody> "                                              ;
html+="	</table>   "                                            ;
html+="	</div>  "                                               ;
		}
		
$(".tbl1").append(html);
		
			
		
		}
}

</script>
</head>
<body>
	<!-- 탑/레프트 -->
	<c:import url="/topLeft">
		<%-- 현재 페이지 해당 메뉴번호 지정 --%>
		<c:param name="menuNo" value="35"></c:param>
	</c:import>
	<!-- 구현내용 -->
	<div class="title_wrap">
		<div class="title_table">
			<div class="title_txt">급여 명세서</div>
		</div>
	</div>
	<div class="contents_area">
		<!-- 내용은 여기에 구현하세요. -->
		<form action="#" id="selectForm" method="post">
			<div class="drop_wrap">
				<select id="year">
					<option value="2020">2020</option>
				</select> <select id="month">
				
					<option value="7">7월</option>
				
				</select>
			</div>
		</form>
		<div class="Checkbox_wrap">
			<input type="checkbox" id="tax" value="공제내역" /><label for="tax"
				style="font-size: 13pt;">공제내역</label> 
		</div>

		<div class="button_wrap">
			<input type="button" value="전체급여" id="all" /><br /> <input
				type="button" value="연도별" id="years" /> <input type="button"
				value="월별" id="months" />
		</div>
		<div class="tbl1">
			<div class="infom_wrap">
				<div class="silmscroll">
					<table class="infom">

						<tbody>

						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="print"><input type="button" value="인쇄" id="printbtn"/></div>
		
	</div>
	<!-- 구현끝 -->
	<!-- 바텀 -->
	<c:import url="/bottom"></c:import>
</body>
</html>