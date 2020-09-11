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

.writeBtn {
	width:95px;
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

.search {
	margin-bottom:10px;	
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
		
		var content = "";
		
		content += "<form action=\"#\" id=\"actionForm2\" method=\"post\">"
		content += "<input type=\"hidden\" name=\"checkEmplyNo\" id=\"checkEmplyNo\">"
		content += "<div class=\"con_top\">"
		content += "<select class=\"select\" name=\"docKind\" id=\"docKind\">"
		content += "<option>종류 선택</option>"
		content += "<option val=\"0\">재직증명서</option>"
		content += "<option val=\"1\">경력증명서</option>"
		content += "<option val=\"2\">퇴직증명서</option>"
		content += "</select>" 
		content += "<div><div>요청자 성명</div></div>" 
		content += "<input type=\"text\" class=\"search\" id=\"forSearchTxt2\"><input type=\"button\" class=\"searchBtn\" id=\"searchBtn2\">" 
		content += "</div>"
		content += "<div class=\"scroll\">" 
		content += "</div></form>" 
		
		makeOneBtnPopup(2, "인사서류 신규등록", content, true, 800, 600, function(){
//			 * contentsEvent - 내용 추가이벤트(없을경우 null입력)

			//검색창 엔터치면 검색만 되게. 다른거 안먹게 (엔터치면 닫히길래)
			$("#searchTxt2").on("keypress",function(event){
				if(event.keyCode == 13) {
					$("#searchBtn2").click();
				return false;			
				}
			});//엔터방지 
			
			//테이블 스크롤
			/* $(".scroll").slimScroll({width: "100%"}, {height: "100%"}); */

			//css 주기
			$(".con_top").css("margin-top","10px");
			$(".con_top").css("margin-bottom","25px");
			
			$(".con_top > div").css("display","inline-table");
			$(".con_top > div").css("vertical-align","middle");
			$(".con_top > div").css("margin-left","10px");

			$(".con_top > div > div").css("display","table-cell");
			$(".con_top > div > div").css("vertical-align","middle");

			$(".select").css("height","28px");
			$(".select").css("border","1px solid lightgray");
			$(".select").css("outline-color","#d5e4f1");

			$(".scroll").css("font-size","10px");
			$(".scroll").css("height","385px");
			$(".scroll").css("width","760px");
			$(".scroll").css("overflow","auto");
			
			
			//문서 종류 선택하면 거기에 따라 리스트 불러올 것
			//문서 종류 선택하면
			$("#docKind").change(function(){
				console.log("선택");
				$("#forSearchTxt2").val("");
				$("#searchTxt2").val("");
				
				var ccontent = "<table class=\"board\" id=\"board2\">" 
				ccontent += "<colgroup>" 
				ccontent += "<col width=\"20%\"/>" 
				ccontent += "<col width=\"20%\" />"
				ccontent += "<col width=\"10%\"/>" 
				ccontent += "<col width=\"18%\" />" 
				ccontent += "<col width=\"10%\" />" 
				ccontent += "<col width=\"22%\"/>" 
				ccontent += "</colgroup>"
				ccontent += "<thead>" 
				ccontent += "<tr>" 
				ccontent += "<th>이름</th>" 
				ccontent += "<th>사원번호</th>" 
				ccontent += "<th>성별</th>" 
				ccontent += "<th>부서</th>"
				ccontent += "<th>직급</th>	" 
				ccontent += "<th>이메일</th>" 
				ccontent += "</tr>" 
				ccontent += "</thead>" 
				ccontent += "<tbody>" 
				ccontent += "</tbody>" 
				ccontent += "</table>"
				
				$(".scroll").html(ccontent);
				
				if($("#docKind option:selected").val() == "퇴직증명서"){ //퇴직자만
					
					//퇴직자리스트 
					loadList3();
					$("#board2").css("width","750px");
					
				} else { //재직자만 
					
					//재직자 리스트 받아오기 
					loadList2();
					$("#board2").css("width","750px");
					
				}
				
				//클릭이벤트:팝업화면 게시판 선택 클릭하면 정보가지고 화면 넘어가기 
				$("#board2 tbody").on("click", "tr", function(){
					/* if($("select option:selected").val()=="종류 선택") {
						makeAlert(3, "알림", "문서 종류를 선택해 주세요.", null);
					} else { */
						//is : css상태값 is("[name]") = name이라는 속성이 있느냐 있으면 true?
						if($(this).is("[name]")) {
							console.log("click");
							$("#checkEmplyNo").val($(this).attr("name"));
							
							//쓰는 화면으로 해당 emply 정보 넘길 아작스
							

							$("#actionForm2").attr("action", "prsnlDcmntWrite");
							$("#actionForm2").submit();
						}
					/* } */
				});//클릭이벤트
				
				//검색도 이안에다가 설정 
				//팝업화면 검색창 검색버튼
			$("#searchBtn2").on("click",function(){
				//오류남 (퇴사자 목록에서 검색하면 전체목록 검색됨) - docKind에 따라 리스트 따로 구분 
				//근데 실제 검색되지도 않음 (왜??? 이유찾기) - searchTxt2가 액션폼에 포함 안됐음 
				console.log("searchBtn2: in");
				console.log("#forSearchTxt2: " + $("#forSearchTxt2").val());
				
				$("#searchTxt2").val($("#forSearchTxt2").val());
				console.log("#searchTxt2: " + $("#searchTxt2").val());
				
				if($("#docKind option:selected").val() == "퇴직증명서"){ //퇴직자만
					//퇴직자리스트 
					loadList3();
					$("#board2").css("width","750px");
				} else { //재직자만 
					//재직자 리스트 받아오기 
					loadList2();
					$("#board2").css("width","750px");
					
				}
			});//searchBtn2 click
				
			});//문서 종류 선택 이벤트(선택해야 - 테이블 나오니까 - 테이블 클릭이벤트도 이 안에다 생성) 

			
			//재직자
			function loadList2(){
				console.log("ok2");
				var params = $("#actionForm").serialize();
				
				$.ajax({ //겟
					type : "post", 
					url : "empNpListAjax", //호출 
					dataType : "json",  
					data : params,
					success : function(res) { //success일때 넘어오는 값을 res로 받겠다 
						if(res.result == "success"){
							drawList2(res.list);
						} else {
							alert("오류가 발생하였습니다.");
						}
					},
					error : function(request, status, error) { 
						console.log("text : " + request.responseText); //반환텍스트 
						console.log("error : " + error); //에러 내용 
					} 
				});//loadlist2 ajax
				
			}//loadList2 end
			
			function drawList2(list){
				console.log("ok22");
				
				if(list.length==0) {//가져온 데이터가 없다.
					var html = "";
					html += "<tr class=\"nothing\">";
					html += "<td colspan=\"7\" class=\"nothing\">조회 결과가 없습니다.</td>";
					html += "</tr>";
				
					$("#board2 tbody").html(html);
				
				} else {
					var html="";
					
					for(var i = 0; i < list.length; i++){
					
						html += "<tr name=\"" + list[i].E_NO + "\">";
						html += "<td>" + list[i].EMPLY_NAME + "</td>";
						html += "<td>" + list[i].EMPLY_NO + "</td>";
						html += "<td>" + list[i].GNDER + "</td>";
						
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
						
						console.log($("#board2 tbody").val());
					$("#board2 tbody").html(html);
					
					}
				}
			}//drawList2 end
			
			//재직자
			function loadList3(){
				console.log("ok3");
				var params = $("#actionForm").serialize();
				
				$.ajax({ //겟
					type : "post", 
					url : "empOpListAjax", //호출 
					dataType : "json",  
					data : params,
					success : function(res) { //success일때 넘어오는 값을 res로 받겠다 
						if(res.result == "success"){
							drawList3(res.list);
						} else {
							alert("오류가 발생하였습니다.");
						}
					},
					error : function(request, status, error) { 
						console.log("text : " + request.responseText); //반환텍스트 
						console.log("error : " + error); //에러 내용 
					} 
				});//loadlist2 ajax
				
			}//loadList2 end
			
			function drawList3(list){
				console.log("ok33");
				
				if(list.length==0) {//가져온 데이터가 없다.
					var html = "";
					html += "<tr class=\"nothing\">";
					html += "<td colspan=\"7\" class=\"nothing\">조회 결과가 없습니다.</td>";
					html += "</tr>";
				
					$("#board2 tbody").html(html);
				
				} else {
					var html="";
					
					for(var i = 0; i < list.length; i++){
					
						html += "<tr name=\"" + list[i].E_NO + "\">";
						html += "<td>" + list[i].EMPLY_NAME + "</td>";
						html += "<td>" + list[i].EMPLY_NO + "</td>";
						html += "<td>" + list[i].GNDER + "</td>";
						
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
						
						console.log($("#board2 tbody").val());
					$("#board2 tbody").html(html);
					
					}
				}
			}//drawList3 end
			
			
			
			
			

		}, "닫기", function() {	
			closePopup(2);
		});//popup end
		
	});//writeBtn click / 신규등록 팝업. 종류/요청자 선택하기 
	
	
	//메인화면 게시판 선택 (팝업 게시판과 헷갈리지 않기) 
	$(".board tbody").on("click", "tr", function(){
			//is : css상태값 is("[name]") = name이라는 속성이 있느냐 있으면 true?
			if($(this).is("[name]")) {
				$("#checkDocNo").val($(this).attr("name"));
				
				$("#actionForm").attr("action", "prsnlDcmntRead");
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
		url : "pdListAjax", //호출 
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
		
			html += "<tr name=\"" + list[i].D_NO + "\">";
			html += "<td>" + list[i].PRSNL_DCMNT_KIND + "</td>";
			html += "<td>" + list[i].WRT_DATE + "</td>";
			html += "<td>" + list[i].EMPLY_NAME + "</td>";
			html += "<td>" + list[i].CONDITION + "</td>";
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
	<c:param name="menuNo" value="42"></c:param> <%-- gnb --%>
</c:import>
<!-- 구현내용 -->
<div class="title_wrap">
	<div class="title_table">
		<div class="title_txt">인사서류관리 조회</div>
	</div>
</div>
<div class="contents_area">
	<!-- 내용은 여기에 구현하세요. -->
<form action="#" id="actionForm" method="post">
	<input type="hidden" name="sEmplyNo" id="sEmplyNo" value="${sEmplyNo}">
	<input type="hidden" name="sAthrtyNo" id="sAthrtyNo" value="${sAthrtyNo}">
	<input type="hidden" name="checkDocNo" id="checkDocNo" >
	<input type="hidden" name="searchTxt2" id="searchTxt2" >
	<input type="hidden" name="page" id="page" value="1"/>
	<input type="text" name="searchTxt" id="searchTxt" class="search"/><input type="button" class="searchBtn">
	<c:if test="${sAthrtyNo eq 1 or sAthrtyNo eq 2 or sAthrtyNo eq 4 or sAthrtyNo eq 5}">
	<input type="button" value="신규등록" class="writeBtn">
	</c:if>
</form>

	<div class="tbl1">
				<table class="board">
					<thead>
						<tr>
							<th>종류</th>
							<th>작성일자</th>
							<th>요청자 성명</th>
							<th>진행상태</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>재직증명서</td>
							<td>20200315</td>
							<td>옹성우</td>
							<td>완료</td>
						</tr>
						<tr>
							<td>경력증명서</td>
							<td>20200420</td>
							<td>강하늘</td>
							<td>완료</td>
						</tr>
						<tr>
							<td>퇴직증명서</td>
							<td>20200625</td>
							<td>이민호</td>
							<td>대기</td>
						</tr>
					</tbody>
				</table>
				<div class="paging">
					<div class="pagingD" id="first"></div>
					<div class="pagingD" id="before"></div>
					<div class="pagingD"><b>1</b></div>
					<div class="pagingD" id="next"></div>
					<div class="pagingD" id="last"></div>
				</div>
			</div>
			
			
	</div><!-- tb1 -->
</div><!-- contents area -->
<!-- 구현끝 -->
<!-- 바텀 -->
<c:import url="/bottom"></c:import>
</body>
</html>