<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Vanilla ERP BSC</title>
<!-- 헤더 -->
<c:import url="/header"></c:import>

<style type="text/css">
.board tbody tr:hover {
	background-color: white !important;	
}

.board td {
	cursor: auto !important;
}

.writeBtn {
	width:93px;
}

.search {
	margin-bottom:10px;	
}

.searchBtn {
	cursor: pointer;
}

.title_txt {
	cursor: pointer;
}

.nothing {
	cursor: auto !important;
}

.nothing:hover {
	background-color: white;
}

/* 복붙 */

.main {
	display: inline-block;
	position: absolute;
	left : 20px;
	top: 20px;
	vertical-align: top;
	width : 96%;
	min-width: 800px;
}

.main_top {
	vertical-align: top;
}

.select {
	vertical-align: top;
	display:inline-block;
	height: 30px;
	width : 100px;
	margin-left : 10px;
	margin-bottom : 10px;
	border: 1px solid lightgray;
	color:#515151;
	outline-color: #d5e4f1;
	cursor: pointer;
	
}

.checkBtn {
	vertical-align: top;
	display:inline-block;
	height: 30px;
	width : 80px;
	margin-left : 10px;
	margin-bottom : 10px;
	border: 1px solid lightgray;
	color:#515151;
	outline-color: #d5e4f1;	
	cursor: pointer;
}

#redO {
	width:30px;
	height:30px;
	background-color: red;
	border-radius: 70%
}

#orangeO {
	width:30px;
	height:30px;
	background-color: #ff7f27;
	border-radius: 70%
}

#blueO {
	width:30px;
	height:30px;
	background-color: blue;
	border-radius: 70%
}

#greenO {
	width:30px;
	height:30px;
	background-color: green;
	border-radius: 70%
}

</style>

<script type="text/javascript">
$(document).ready(function() {
	
		console.log("Ver.47"); 
	$("#selectYear").val($("#selectYearR option:first").val());
	console.log("selectYear length: " + $("#selectYear").length);
	if($("#selectYear").length){
		loadList();
	}	
		
	$(".paging").on("click", "div", function(){
		$("#page").val($(this).attr("name"));  //페이지 누를 때마다 페이지 value 바꿔주는 것
		loadList();
	});//paging
	
	$("#selectYearR").change(function(){
		$("#selectYear").val($(this).val());
		$("#dprtmntNoR").val($("#dprtmntNoR option:first").val());
		$("#dprtmntNo").val($("#dprtmntNoR option:first").val());
		loadList();
	});

	$("#dprtmntNoR").change(function(){
		$("#dprtmntNo").val($("#dprtmntNoR option:selected").val());
		loadList();
	});

	

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
/* 
function makeSelect(list,list2){ //셀렉트 목록 만들기 
		console.log("makeSelect start");
		console.log("list.length : " + list.length);
		console.log("list2.length : " + list2.length); 
		
	var html = "";
	for(var i=0;i<list.length;i++){
		html += "<option value=\"" + list[i].STNDRD_BSC_NO + "\">" + list[i].STNDRD_YEAR + "년도</option>";
		console.log("stndrdyear" + list[i].STNDRD_YEAR);
	}

	$("#selectYearR").html(html);

	var html2 = "";
	var htmlString = "";
	for(var i=0;i<list2.length;i++){
		if(i != list.length - 1){
			htmlString += i + ",";
		} else {
			htmlString += i;
		}	
		html2 += "<option value=\"" + list2[i].DPRTMNT_NO + "\">" + list2[i].DPRTMNT_NAME + "</option>";
		console.log("DPRTMNT_NAME" + list2[i].DPRTMNT_NAME);
	}

	$("#dprtmntNoR").html(html2);

	html2 = "<option value=\"" + htmlString + "\">전체실적</option>";

	$("#dprtmntNoR").prepend(html);
	
} //makeSelect end */

function loadList(){
	
	var params = $("#actionForm").serialize();
	console.log("actionForm을 params에 serialize 완료");
	console.log("dprtmntNo: " + $("#dprtmntNo").val());
	console.log("dprtmntNoR: " + $("#dprtmntNoR").val());
	console.log("selectYearR: " + $("#selectYearR").val());
	console.log("selectYear: " + $("#selectYear").val());
	
	$.ajax({ //겟
		type : "post", 
		url : "bscListAjax", //호출 
		dataType : "json",  
		data : params,
		success : function(res) { //success일때 넘어오는 값을 res로 받겠다 
			if(res.result == "success"){
				drawList(res.list);
				drawPaging(res.pb);
			} else {
				alert("오류가 발생하였습니다.");
			}
		},
		error : function(request, status, error) { 
			console.log("text : " + request.responseText); //반환텍스트 
			console.log("error : " + error); //에러 내용 
		} 
	});//ajax
	
}//loadList end

function drawList(list){
	console.log("drawList 시작");
	console.log(list);
	
	if(list.length==0) {//가져온 데이터가 없다.
		var html = "";
		html += "<tr class=\"nothing\">";
		html += "<td colspan=\"7\" class=\"nothing\">조회 결과가 없습니다.</td>";
		html += "</tr>";
	
		$(".board tbody").html(html);
	
	} else {
		var html="";
		for(var i = 0; i < list.length; i++){
			console.log("for문 시작");
			console.log("csfNo: " + list[i].CSF_NO);
			html += "<tr class=\"" + list[i].CSF_NO + "\">";
			html += "<td>" + list[i].CSF_NO + "</td>";
			html += "<td>" + list[i].CSF_NAME + "</td>";
			html += "<td>" + list[i].KPI_NO + "</td>";
			html += "<td>" + list[i].KPI_NAME+ "</td>";
			html += "<td>" + list[i].GOAL_VALUE + list[i].MSR + "</td>";
			html += "<td>" + list[i].PRFRMNC_VALUE + list[i].MSR + "</td>";
			html += "<td>" + list[i].ACHVMNT_RATE + "</td>";
			if(parseInt(list[i].ACHVMNT_RATE) >= 75) {
				html += "<td><div id=\"blueO\"></div></td>";
			}else if(parseInt(list[i].ACHVMNT_RATE) >= 50){
				html += "<td><div id=\"greenO\"></div></td>";
			}else if(parseInt(list[i].ACHVMNT_RATE) >= 25){
				html += "<td><div id=\"orangeO\"></div></td>";
			}else{
				html += "<td><div id=\"redO\"></div></td>";
			}
			html += "</tr>";
		}
		$(".board tbody").html(html);
	}
}//drawList end

function drawPaging(pb){
	console.log("drawPaging 시작");
	
	
	var html = "<div name=\"1\" class=\"pagingD\" id=\"first\"></div>";
	
	if($("#page").val() == "1"){
		html += "<div name=\"1\" class=\"pagingD\" id=\"before\"></div>";
	} else {
		html += "<div name=\"" + ($("#page").val() * 1 - 1) + "\" class=\"pagingD\" id=\"before\"></div>";
	}
	
	for(var i = pb.startPcount ; i <= pb.endPcount ; i++){
		if(i == $("#page").val()) {
			html += "<div name = \"" + i + "\" class=\"pagingD\"><b>" + i + "</b></div>";
		} else {
			html += "<div name = \"" + i + "\" class=\"pagingD\">" + i + "</div>";
		}
	}
	
	if($("#page").val() == pb.maxPcount){
		html += "<div name = \"" + pb.maxPcount + "\" class=\"pagingD\" id=\"next\"></div>";
	} else {
		html += "<div name = \"" + ($("#page").val() * 1 + 1) + "\" class=\"pagingD\" id=\"next\"></div>";		
	}
	
	html += "<div name = \"" + pb.maxPcount + "\" class=\"pagingD\" id=\"last\"></div>";
	
	$(".paging").html(html);
	
	
} //drawPaging end

</script>
</head>
<body>
<!-- 탑/레프트 -->
<c:import url="/topLeft">
<%-- 현재 페이지 해당 메뉴번호 지정 --%>
	<c:param name="menuNo" value="45"></c:param> <%-- gnb --%>
</c:import>
<!-- 구현내용 -->
<div class="title_wrap">
	<div class="title_table">
		<div class="title_txt">BSC 성과 지표</div>
	</div>
</div>
<div class="contents_area">
	<!-- 내용은 여기에 구현하세요. -->
<div class="main">	
<form action="#" id="actionForm" method="post">
	<input type="hidden" name="page" id="page" value="1"/>
	<input type="hidden" name="selectYear" id="selectYear" value="" >
	<input type="hidden" name="dprtmntNo" id="dprtmntNo" value="0">
	
	<input type="hidden" name="sEmplyNo" id="sEmplyNo" value="${sEmplyNo}">
	<input type="hidden" name="sAthrtyNo" id="sAthrtyNo" value="${sAthrtyNo}">

</form>
		<div class="main_top">
		<select class="select" id="selectYearR">
			<c:forEach var="data" items="${list}"> 
				<option value="${data.STNDRD_BSC_NO}">${data.STNDRD_YEAR}년도</option>
			</c:forEach>
		</select> 
		<select class="select" id="dprtmntNoR">
			<option value="0">전체실적</option>
			<c:forEach var="data2" items="${list2}"> 
				<option value="${data2.DPRTMNT_NO}">${data2.DPRTMNT_NAME}</option>
			</c:forEach>
		</select> 
	</div><!-- main top -->
		<table class="board">
			<colgroup>
				<col width="7%" />
				<col width="20%" />
				<col width="7%" />
				<col width="30%" />
				<col width="11%" />
				<col width="11%" />
				<col width="7%" />
				<col width="*" />
			</colgroup>
			<thead>
				<tr>
					<th>CSF 번호</th>
					<th>CSF 명</th>
					<th>KPI 번호</th>
					<th>KPI 명</th>
					<th>목표</th>
					<th>실적</th>
					<th colspan="2">달성률</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td rowspan="2">1</td>
					<td rowspan="2">기업가치</td>
					<td>1</td>
					<td>EVA</td>
					<td>XXX억</td>
					<td>XXX억</td>
					<td>XX%</td>
					<td><div id="orangeO"></div></td>
				</tr>
				<tr>
					<td>2</td>
					<td>목표시장 매출 증가율</td>
					<td>XXX억</td>
					<td>XXX억</td>
					<td>XX%</td>
					<td><div id="redO"></div></td>
				</tr>
			</tbody>			
		</table>

	
				<div class="paging">
					<div class="pagingD" id="first"></div>
					<div class="pagingD" id="before"></div>
					<div class="pagingD"><b>1</b></div>
					<div class="pagingD">2</div>
					<div class="pagingD">3</div>
					<div class="pagingD">4</div>
					<div class="pagingD">5</div>
					<div class="pagingD" id="next"></div>
					<div class="pagingD" id="last"></div>
				</div>
		
	</div> <!-- main -->
</div><!-- contents area -->
<!-- 구현끝 -->
<!-- 바텀 -->
<c:import url="/bottom"></c:import>
</body>
</html>