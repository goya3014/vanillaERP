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

</style>

<script type="text/javascript">
$(document).ready(function() {
	
	if("${param.searchTxt}" != ""){
		$("#searchTxt").val("${param.searchTxt}");
	}
	
	loadList();

	$(".searchBtn").on("click",function(){
		$("#page").val("1");
		loadList();
	});//searchBtn click
	
	
	$(".writeBtn").on("click",function(){
		$("#actionForm").attr("action","emplyCardAdd");
		$("#actionForm").submit();
	});//writeBtn click
	
	$(".board tbody").on("click", "tr", function(){
		//is : css상태값 is("[name]") = name이라는 속성이 있느냐 있으면 true?
		if($(this).is("[name]")) {
			$("#checkEmplyNo").val($(this).attr("name"));
			
			$("#actionForm").attr("action", "emplyCardRead");
			$("#actionForm").submit();
		}
	});
	
	$(".paging").on("click", "div", function(){
		$("#page").val($(this).attr("name"));  //페이지 누를 때마다 페이지 value 바꿔주는 것
		loadList();
	});//paging
	

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

function loadList(){
	var params = $("#actionForm").serialize();
	
	$.ajax({ //겟
		type : "post", 
		url : "empListAjax", //호출 
		dataType : "json",  
		data : params,
		success : function(res) { //success일때 넘어오는 값을 res로 받겠다 
			if(res.result == "success"){
				/* location.href = "bMain"; */
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
	if(list.length==0) {//가져온 데이터가 없다.
		var html = "";
		html += "<tr class=\"nothing\">";
		html += "<td colspan=\"7\" class=\"nothing\">조회 결과가 없습니다.</td>";
		html += "</tr>";
	
		$(".board tbody").html(html);
	
	} else {
		var html="";
		
		for(var i = 0; i < list.length; i++){
		
			html += "<tr name=\"" + list[i].E_NO + "\">";
			html += "<td>" + list[i].EMPLY_NAME + "</td>";
			html += "<td>" + list[i].EMPLY_NO + "</td>";
			html += "<td>" + list[i].GNDER + "</td>";
			html += "<td>" + list[i].CLPHN_NO+ "</td>";
			
			if(list[i].DPRTMNT_NAME == undefined) {
				html += "<td>미정</td>";
			} else {
				html += "<td>" + list[i].DPRTMNT_NAME + "</td>";
			}
			if(list[i].PSTN_NAME == undefined) {
				html += "<td>미정</td>";
			} else {
				html += "<td>" + list[i].PSTN_NAME + "</td>";
			}
			html += "<td>" + list[i].EMAIL + "</td>";
			html += "</tr>";
			
		
		$(".board tbody").html(html);
		
		}
	}
}//drawList end

function drawPaging(pb){
	
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
	<c:param name="menuNo" value="41"></c:param> <%-- gnb --%>
</c:import>
<!-- 구현내용 -->
<div class="title_wrap">
	<div class="title_table">
		<div class="title_txt">인사카드관리 조회</div>
	</div>
</div>
<div class="contents_area">
	<!-- 내용은 여기에 구현하세요. -->
<form action="#" id="actionForm" method="post">
	<input type="hidden" name="sEmplyNo" id="sEmplyNo" value="${sEmplyNo}">
	<input type="hidden" name="sAthrtyNo" id="sAthrtyNo" value="${sAthrtyNo}">
	<input type="hidden" name="sDprtmntNo" id="sDprtmntNo" value="${sDprtmntNo}">
	<input type="hidden" name="checkEmplyNo" id="checkEmplyNo" />
	<input type="hidden" name="page" id="page" value="1"/>
	<input type="text" name="searchTxt" id="searchTxt" class="search"/><input type="button" class="searchBtn">
	<c:if test="${sAthrtyNo eq 1 or sAthrtyNo eq 2 or sAthrtyNo eq 4 or sAthrtyNo eq 5}">
	<input type="button" value="신규등록" class="writeBtn">
	</c:if>
</form>

	<div class="tbl1">
		<table class="board">
			<colgroup>
				<col width="10%"/>
				<col width="20%" />
				<col width="5%"/>
				<col width="20%" />
				<col width="10%" />
				<col width="10%" />
				<col width="25%"/>
			</colgroup>
			<thead>
				<tr>
					<th>이름</th>
					<th>사원번호</th>
					<th>성별</th>
					<th>휴대전화</th>
					<th>부서</th>
					<th>직급</th>
					<th>이메일</th>
				</tr>
			</thead>
			<tbody>
				
			</tbody>
		</table>
		<div class="paging">
		</div>
	</div><!-- tb1 -->
</div><!-- contents area -->
<!-- 구현끝 -->
<!-- 바텀 -->
<c:import url="/bottom"></c:import>
</body>
</html>