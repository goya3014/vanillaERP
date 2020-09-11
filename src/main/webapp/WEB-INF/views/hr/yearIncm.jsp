<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Vanilla ERP - 샘플페이지</title>
<!-- 헤더 -->
<c:import url="/header"></c:import>
<style type="text/css">

.selection{
	width: 100%;
	height : 50px;
	vertical-align: top;
	margin-top:20px;
}
#year{
	display: inline-block;
	height : 50px;
	width : 100px;
	text-align: center;
	margin-left: 50px;
}
.space{
	height : 50px;
}

.board2 {
	width: 1100px;
	height: 600px;
	min-height:550px;
	max-height : 650px;
	border-collapse: collapse;
	text-align: center;
	font-size: 11pt;
	margin-left:250px;
}
.board2 thead{
	/* background-color: #004078; */
	background: linear-gradient(#004B8D, #00305A);
	color: white;

}

.board2 tr{
	height: 50px;
}

.board2 td {
	border: 1px solid lightgray;
	height: 50px;
}
</style>
<script type="text/javascript">

	ReloadincmList();

$(document).ready(function(){
	
	$("#selectYear").on("click","option",function(){
	
		
	});

	$(".silmscroll").slimscroll({
		
		height :"350px" 
	});
	
	
	
});

function ReloadincmList(){


	$.ajax({
		type : "post", 
		url : "IncmListAjax", 
		dataType : "json",
		success : function(res){ //성공시 다음의 함수를 실행하게되며 돌아오는 값을 res라는 이름으로 받는다
			if(res.result == "success"){
				RedrawincmList(res.list);
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

function RedrawincmList(list){
		if(list.length == 0){//조회가 되지않았을때
		
		var html = "";
		
		html +="<tr>";
		html +="<td colspan =\"5\">조회결과가 없습니다.</td>";
		html +="</tr>"
		$(".board2 tbody").html(html);
	} else {//조회되엇을때
		
		var html = "";
		
		for (var i = 0; i < list.length ; i++){
			
			html += "<tr name=\"" + list[i].INCM_NO + "\">";
			html += "<td>" + list[i].INCM_NO + "</td>";
			html += "<td>" +  list[i].EMPLY_NAME + "</td>";
			html += "<td>" + list[i].PSTN_NAME + "</td>";
			html += "<td>" + list[i].DPRTMNT_NAME + "</td>";
			html += "<td>" + list[i].AMNT + "</td>";
			html += "</tr>";
			
		}
	
		$(".board2 tbody").html(html);
	
	}
	
	
	
}


</script>
</head>
<body>
<!-- 탑/레프트 -->
<c:import url="/topLeft">
<%-- 현재 페이지 해당 메뉴번호 지정 --%>
	<c:param name="menuNo" value="36"></c:param>
</c:import>
<!-- 구현내용 -->
<div class="title_wrap">
	<div class="title_table">
		<div class="title_txt">연간 연봉표</div>
	</div>
</div>
<div class="contents_area">
	<!-- 내용은 여기에 구현하세요. -->
	<form action="#" id="selectForm" method="post">
		<div class="selection">
			<select id="selectYear">
				<option id="y20">2020</option>			
			</select>			
		<input type="hidden" value="2020" id="Year"/>	
		</div>		
		</form>	
		<div class="space"> </div>
	<div class="tbl1">
		<div class="silmscroll">
			<table class="board2">
				<colgroup>
					<col width="5%"/>
					<col width="20%" />
					<col width="20%" />
					<col width="15%" />
					<col width="*" />				
				</colgroup>
			<thead>
			<tr>
				<th>번호</th>	
				<th>이름</th>
				<th>직급</th>
				<th>부서</th>
				<th>연봉</th>
			</tr>
		</thead>
		
		<tbody>
		
		</tbody>

		</table>	
		</div>
	</div>
	









</div>
<!-- 구현끝 -->
<!-- 바텀 -->
<c:import url="/bottom"></c:import>
</body>
</html>