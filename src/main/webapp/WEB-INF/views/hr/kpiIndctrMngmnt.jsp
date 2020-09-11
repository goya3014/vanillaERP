<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KPI 지표 관리</title>
<!-- 헤더 -->
<c:import url="/header"></c:import>
<style type="text/css">
.main {
	display: inline-block;
	position: absolute;
	left : 20px;
	top: 20px;
	vertical-align: top;
	width : 90%;
	min-width: 800px;
}

.main_top {
	vertical-align: top;
	display:inline-block;
	margin-bottom : 10px;
}

.addBtn {
	vertical-align: top;
	display:inline-block;
	height: 30px;
	width : 80px;
	margin-left : 10px;
	border: 1px solid lightgray;
	color:#515151;
	outline-color: #d5e4f1;	
	cursor: pointer;
}

.kpinum,.kpi,.sul {
	font-size : 15px;
	margin-bottom : 5px;
}

.kpitxt{
	width : 80%;
	height : 25px;
	margin-bottom : 5px;
	margin-left : 5px;
}

.dantxt {
	width : 30%;
	height : 25px;
	margin-bottom : 5px;
	margin-left : 5px;
}


</style>   
<script type="text/javascript">

$(document).ready(function() {
	 	
	reloadList();
	
	 $(".paging").on("click", "div", function(){
	      $("#page").val($(this).attr("class"));
	      reloadList();
	   });//paging
	   
	   
	 $(".addBtn").on("click", function(){
		 var nextNum;
		 var content = "";

		 var params = $("#actionForm").serialize();
		 $.ajax({ //겟
		      type : "post", 
		      url : "indctorNumAjax", //호출 
		      dataType : "json",  
		      data : params,
		      success : function(res) { //석세스일때 넘어오는 값을 res로 받겠다 
		         if(res.result == "success"){
		        	 
		        	 	//번호 불러오기 성공하면-
		       			nextNum = res.indctorNext;
		       			console.log(res.indctorNext);
		       			console.log("nextNum: " + nextNum);
		       			
		       			content += "<div class=\"kpinum\">- 지표번호 : " + nextNum + "번</div>"
		       			content += "<div class=\"kpi\">- 지표명 <input type=\"text\" class=\"kpitxt\" id=\"indctorName\"></div>"
		       			content += "<div class=\"sul\">- 지표단위<input type=\"text\" class=\"dantxt\" id=\"msR\"></div>"

		       			console.log(content);
		       			
		       			//애드 누르면 뜨는 팝업 
		       		    makeTwoBtnPopup(1, "지표 등록", content, true, 600, 300, null,
		       						//2번째 팝업 화면 생긴 뒤 일어날 동작들

		       		  		"저장", function() {
		       				console.log("start");

		       				$("#indctorNo2").val($("#indctorNo").val());
		       				$("#indctorName2").val($("#indctorName").val());
		       				$("#msR2").val($("#msR").val());

							//저장아작스 
		       				var params = $("#actionForm").serialize();
		       				
		       		         $.ajax({ //겟방식? 포스트방식?
		       		            type : "post", //전송방식 (포스트로 보내겠다)
		       		            url : "indctorWriteAjax", //주소 
		       		            dataType : "json",  //데이터형태 - 일반적으로 아작스는 json많이 씀. 바로 매칭 돼서. 별도 가공 불필요.
		       		            //겟방식 / 포스트방식 따라 따로따로 동작할 수 있는 함수 이따 배울 것 
		       		            data : params, //보낼 데이터 - 상황에 따라 없을 수 있음 
		       		            success : function(res) { //성공적으로 넘어갔을때 이 함수 실행하며, 돌아오는 값을 res란 이름으로 받는다.
		       		               if(res.result == "success"){
		       		            	    $("#actionForm").val("");
		       		                    
		       		            	    reloadList();
		       		                  
		       		               } else {
		       		                  alert("오류가 발생하였습니다.");
		       		               }
		       		            },
		       		            error : function(request, status, error) { //값이 돌아오지 않는 등 실행 중 에러 발생 시 이 함수 실행
		       		               console.log("text : " + request.responseText); //반환텍스트 
		       		               console.log("error : " + error); //에러 내용 
		       		            } //{ name: "이재희", 키: 값, ...} 중괄호, 키, 값으로 이루어진 전송 규격 = json
		       		         });//indctorWriteAjax 
		       				
		       				closePopup(1);
		       		         
		       			}, "닫기", function() {
		       				closePopup(1);
		       			});//popup end
		       		    
		         } else {
		            alert("오류가 발생하였습니다.");
		         }
		      },
		      error : function(request, status, error) { 
		         console.log("text : " + request.responseText); //반환텍스트 
		         console.log("error : " + error); //에러 내용 
		      } 
		   });//indctorNumAjax
		   		
	}); //add Btn end
});//document end


//메인
function reloadList(){
	   var params = $("#actionForm").serialize();
	   
	   $.ajax({ //겟
	      type : "post", 
	      url : "indctorListAjax", //호출 
	      dataType : "json",  
	      data : params,
	      success : function(res) { //석세스일때 넘어오는 값을 res로 받겠다 
	         if(res.result == "success"){
	       
	            redrawList(res.list);
	            redrawPaging(res.pb);
	            
	         } else {
	            alert("오류가 발생하였습니다.");
	         }
	      },
	      error : function(request, status, error) { 
	         console.log("text : " + request.responseText); //반환텍스트 
	         console.log("error : " + error); //에러 내용 
	      } 
	   });//indctorListAjax
	   
	}//reloadList

	function redrawList(list){
	      if(list.length==0) {//가져온 데이터가 없다.
	         var html = "";
	      html += "<tr class=\"nothing\">";
	      html += "<td colspan=\"3\">조회 결과가 없습니다.</td>";
	      html += "</tr>";
	      
	      $(".board tbody").html(html);
	      } else {
	         var html="";
	         
	         for(var i = 0; i < list.length; i++){
	            html += "<tr name=\"" + list[i].INDCTOR_NO + "\">";
	            html += "<td>" + list[i].INDCTOR_NO + "</td>";
	            html += "<td>" + list[i].INDCTOR_NAME + "</td>";
	            html += "<td>" + list[i].MSR + "</td>";
	            html += "</tr>";
	            
	         }
	         
	         $(".board tbody").html(html);

	      }
	}//redrawList

	function redrawPaging(pb){
	   
	   var html = "<div name = \"1\" class=\"pagingD\" id=\"first\"></div>";
	   
	   if($("#page").val() == "1"){
	      html += "<div name = \"1\" class=\"pagingD\" id=\"before\"></div>";
	   } else {
	      html += "<div name = \"" + ($("#page").val() * 1 - 1) + "\" class=\"pagingD\" id=\"before\"></div>";
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
	   	   	   
	}//redrawPaging
	
</script>
</head>
<body>
<!-- 탑/레프트 -->
<c:import url="/topLeft">
<%-- 현재 페이지 해당 메뉴번호 지정 --%>
	<c:param name="menuNo" value="48"></c:param>
</c:import>
<!-- 구현내용 -->
<div class="title_wrap">
	<div class="title_table">
		<div class="title_txt">KPI지표 관리</div>
	</div>
</div>
<div class="contents_area">
	<!-- 내용은 여기에 구현하세요. -->
	
<form action='#' id="actionForm" method="post">
	<input type="hidden" id="page" name="page" value="1" />
	<input type="hidden" id="indctorNo2" name="indctorNo" value="${sIndctorNo}" />
	<input type="hidden" id="indctorName2" name="indctorName" value="${sIndctorName}" />
	<input type="hidden" id="msR2" name="msR" value="${sMsR}" />

	<div class="main">	
		<div class="main_top">
		<input type="button" value="등록" class="addBtn">
		</div>
		<table class="board">
			<colgroup>
				<col width="20%" />
				<col width="*%" />
				<col width="30%" />
			</colgroup>
			<thead>
				<tr>
					<th>지표번호</th>
					<th>지표명</th>
					<th>지표단위</th>
				</tr>
			</thead>
			<tbody>
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
	</div> 	

</form>
</div>
<!-- 구현끝 -->
<!-- 바텀 -->
<c:import url="/bottom"></c:import>
</body>
</html>