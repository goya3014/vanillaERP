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

.select {
	vertical-align: top;
	display:inline-block;
	height: 30px;
	width : 100px;
	margin-left : 10px;
	border: 1px solid lightgray;
	color:#515151;
	outline-color: #d5e4f1;
	cursor: pointer;
	
}

.delBtn {
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

.searchBtn1,.searchBtn2{
	vertical-align: top;
	display:inline-block;
	height: 25px;
	width : 50px;
	margin-left : 10px;
	border: 1px solid lightgray;
	color:#515151;
	outline-color: #d5e4f1;	
	cursor: pointer;
}

.board2 {
	width: 100%;
	border-collapse: collapse;
	text-align: center;
	vertical-align: center;
	font-size: 11pt;
}

.board2 thead {
	/* background-color: #004078; */
	background: linear-gradient(#004B8D, #00305A);
	color: white;
}

.board2 tr {
	height: 0px;
}

.board2 .gong {
	background-color: #e7e7e7;
}

.board2 td {
	border-bottom: 1px solid lightgray;
	cursor: pointer;
}

.board2 th,.board2 td {
	height : 30px;
}

.board2 tbody tr:hover {
	background-color: #dae2f1;	
}

.board3 {
	width: 100%;
	border-collapse: collapse;
	text-align: center;
	vertical-align: center;
	font-size: 11pt;
}

.board3 thead {
	/* background-color: #004078; */
	background: linear-gradient(#004B8D, #00305A);
	color: white;
}

.board3 tr {
	height: 0px;
}

.board3 .gong {
	background-color: #e7e7e7;
}

.board3 td {
	border-bottom: 1px solid lightgray;
	cursor: pointer;
}

.board3 th,.board3 td {
	height : 30px;
}

.board3 tbody tr:hover {
	background-color: #dae2f1;	
}

.csfnum,.csf,.kpinum,.kpi,.sul,.indct,.indctnm {
	font-size : 15px;
	margin-bottom : 5px;
}

.csfnumtxt,.indtnumtxt{
	width : 30px;
	height : 25px;
	margin-bottom : 5px;	
}

.csftxt,.kpitxt,.unittxt,.indtnmtxt {
	width : 80%;
	height : 25px;
	margin-bottom : 5px;
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
		 
				
		var content = "";
		content += "<div class=\"csfnum\">- CSF번호 <input type=\"text\" class=\"csfnumtxt\" id=\"csfNo\" name=\"csfNo\"><input type=\"button\" value=\"조회\" class=\"searchBtn1\"></div>"
		content += "<div class=\"csf\">- CSF명 <input type=\"text\" class=\"csftxt\" id=\"csfName\" name=\"csfName\"></div>"
		content += "<div class=\"kpinum\">- KPI번호 : ${kpiNext}번</div>"
		content += "<div class=\"kpi\">- KPI명 <input type=\"text\" class=\"kpitxt\" id=\"kpiName\"></div>"
		content += "<div class=\"sul\">- 설명 </div><textarea rows=\"5\" cols=\"75\" id=\"explnTn\"></textarea>"
		content += "<div class=\"indct\">- 지표번호 <input type=\"text\" class=\"indtnumtxt\" id=\"indctorNo\" name=\"indctorNo\"><input type=\"button\" value=\"조회\" class=\"searchBtn2\"></div>"
		content += "<div class=\"indctnm\">- 지표명 <input type=\"text\" class=\"indtnmtxt\" id=\"indctorName\" name=\"indctorName\"></div>"

		console.log(content);
		
	    makeTwoBtnPopup(1, "KPI 등록", content, true, 600, 520, function(){
					//2번째 팝업 화면 생긴 뒤 일어날 동작들
					
			$(".searchBtn1").on("click", function search(){
				
			 	var content = "";
			 	content += "<form action=\"#\" id=\"actionForm2\" method=\"post\">"
			 	content += "<div class=\"board2Wrap\" id=\"board2Wrap\">"
				content += "<table class=\"board2\">"
				content += "<colgroup>"
				content += "<col width=\"40%\"/>"
				content += "<col width=\"*\"/>"
				content += "</colgroup>"
				content += "<thead>"	 	
				content += "<tr>"
				content += "<th>CSF 번호</th>"
				content += "<th>CSF 명<th>"
				content += "<tr>"
				content += "</thead>"
				content += "<tbody>"
				content += "<tr>"
				content += "<td>1</td>"
				content += "<td>재무</td>"					
				content += "</tr>"
				content += "</tbody>"			
				content += "</table>"
				content += "</div>"	
				
			 	function reloadList2(){
			 		console.log("ok");
			 	   var params = $("#actionForm2").serialize();
			 	   
			 	   $.ajax({ //겟
			 	      type : "post", 
			 	      url : "kpicsfListAjax", //호출 
			 	      dataType : "json",  
			 	      data : params,
			 	      success : function(res) { //석세스일때 넘어오는 값을 res로 받겠다 
			 	         if(res.result == "success"){
			 	        	 
			 	            redrawList2(res.list);
			 	          	 	            
			 	         } else {
			 	            alert("오류가 발생하였습니다.");
			 	         }
			 	      },
			 	      error : function(request, status, error) { 
			 	         console.log("text : " + request.responseText); //반환텍스트 
			 	         console.log("error : " + error); //에러 내용 
			 	      } 
			 	   });//kpicsfListAjax end
			 	   
			 	}//reloadList2

			 	function redrawList2(list){
			 	      if(list.length==0) {//가져온 데이터가 없다.
			 	         var html = "";
			 	      html += "<tr class=\"nothing\">";
			 	      html += "<td colspan=\"2\">조회 결과가 없습니다.</td>";
			 	      html += "</tr>";
			 	      
			 	      $(".board2 tbody").html(html);
			 	      } else {
			 	         var html="";
			 	         
			 	         for(var i = 0; i < list.length; i++){
			 	            html += "<tr name=\"" + list[i].CSF_NO + "\">";
			 	            html += "<td>" + list[i].CSF_NO + "</td>";
			 	            html += "<td>" + list[i].CSF_NAME + "</td>";
			 	            html += "</tr>";
			 	            
			 	         }
			 	         
			 	         $(".board2 tbody").html(html);

			 	      }
			 	}//redrawList2 end
			 	
	makeOneBtnPopup(2, "CSF 번호 조회", content, true, 500, 450, function(){
		
		$("#board2Wrap").slimScroll({
			width: "460px",
			height: "300px"
		});
					
					reloadList2();
			 	
					$(".board2 tbody").on("click", "tr", function(){
					//is : css상태값 is("[name]") = name이라는 속성이 있느냐 있으면 true?
						
		 				$("#csfNo").val($(this).attr("name"));
		 				$("[name='csfNo']").val($(this).attr("name"));

		 				
		 				var params = $("#actionForm").serialize();
		 				
		 		         $.ajax({ //겟방식? 포스트방식?
		 		            type : "post", //전송방식 (포스트로 보내겠다)
		 		            url : "csfNameAjax", //주소 
		 		            dataType : "json",  //데이터형태 - 일반적으로 아작스는 json많이 씀. 바로 매칭 돼서. 별도 가공 불필요.
		 		            //겟방식 / 포스트방식 따라 따로따로 동작할 수 있는 함수 이따 배울 것 
		 		            data : params, //보낼 데이터 - 상황에 따라 없을 수 있음 
		 		            success : function(res) { //성공적으로 넘어갔을때 이 함수 실행하며, 돌아오는 값을 res란 이름으로 받는다.
		 		               if(res.result == "success"){
		 		            	   	console.log(res.csfName);
		 		            	 	$("#csfName").val(res.csfName.CSF_NAME);
		 		            	 	$("#csfNo").val(res.csfName.CSF_NO);
		 		                  
		
		 		               } else {
		 		                  alert("오류가 발생하였습니다.");
		 		               }
		 		            },
		 		            error : function(request, status, error) { //값이 돌아오지 않는 등 실행 중 에러 발생 시 이 함수 실행
		 		               console.log("text : " + request.responseText); //반환텍스트 
		 		               console.log("error : " + error); //에러 내용 
		 		            } //{ name: "이재희", 키: 값, ...} 중괄호, 키, 값으로 이루어진 전송 규격 = json
		 		         });//csfNameAjax 
		 				
		 				closePopup(2);
					});
					
				
					},"닫기", function() {
						closePopup(2);
				}); //function board2 tbody click, 두번째 팝업 end  
			 				
		});	//searchBtn1 end
		
		$(".searchBtn2").on("click", function search(){
			
		 	var content = "";
		 	content += "<form action=\"#\" id=\"actionForm3\" method=\"post\">"
		 	content += "<div class=\"board3Wrap\" id=\"board3Wrap\">"
			content += "<table class=\"board3\">"
			content += "<colgroup>"
			content += "<col width=\"40%\"/>"
			content += "<col width=\"*\"/>"
			content += "</colgroup>"
			content += "<thead>"	 	
			content += "<tr>"
			content += "<th>지표번호</th>"
			content += "<th>지표명<th>"
			content += "<tr>"
			content += "</thead>"
			content += "<tbody>"
			content += "<tr>"
			content += "<td>1</td>"
			content += "<td>재무</td>"					
			content += "</tr>"
			content += "</tbody>"			
			content += "</table>"
			content += "</div>"
			
		 	function reloadList3(){
		 		console.log("ok");
		 	   var params = $("#actionForm3").serialize();
		 	   
		 	   $.ajax({ //겟
		 	      type : "post", 
		 	      url : "kpiindctorListAjax", //호출 
		 	      dataType : "json",  
		 	      data : params,
		 	      success : function(res) { //석세스일때 넘어오는 값을 res로 받겠다 
		 	         if(res.result == "success"){
		 	        	 
		 	            redrawList3(res.list);
		 	          	 	            
		 	         } else {
		 	            alert("오류가 발생하였습니다.");
		 	         }
		 	      },
		 	      error : function(request, status, error) { 
		 	         console.log("text : " + request.responseText); //반환텍스트 
		 	         console.log("error : " + error); //에러 내용 
		 	      } 
		 	   });//kpiindctorListAjax end
		 	   
		 	}//reloadList3

		 	function redrawList3(list){
		 	      if(list.length==0) {//가져온 데이터가 없다.
		 	         var html = "";
		 	      html += "<tr class=\"nothing\">";
		 	      html += "<td colspan=\"2\">조회 결과가 없습니다.</td>";
		 	      html += "</tr>";
		 	      
		 	      $(".board3 tbody").html(html);
		 	      } else {
		 	         var html="";
		 	         
		 	         for(var i = 0; i < list.length; i++){
		 	            html += "<tr name=\"" + list[i].INDCTOR_NO + "\">";
		 	            html += "<td>" + list[i].INDCTOR_NO + "</td>";
		 	            html += "<td>" + list[i].INDCTOR_NAME + "</td>";
		 	            html += "</tr>";
		 	            
		 	         }
		 	         
		 	         $(".board3 tbody").html(html);

		 	      }
		 	}//redrawList3 end 
		
	makeOneBtnPopup(3, "지표번호 조회", content, true, 500, 450, function(){
			
			$("#board3Wrap").slimScroll({
				width: "460px",
				height: "300px"
			});
				
				reloadList3();
		 	
				$(".board3 tbody").on("click", "tr", function(){
				//is : css상태값 is("[name]") = name이라는 속성이 있느냐 있으면 true?
					
	 				$("#indctorNo").val($(this).attr("name"));
	 				$("[name='indctorNo']").val($(this).attr("name"));

	 				
	 				var params = $("#actionForm").serialize();
	 				
	 		         $.ajax({ //겟방식? 포스트방식?
	 		            type : "post", //전송방식 (포스트로 보내겠다)
	 		            url : "indctorNameAjax", //주소 
	 		            dataType : "json",  //데이터형태 - 일반적으로 아작스는 json많이 씀. 바로 매칭 돼서. 별도 가공 불필요.
	 		            //겟방식 / 포스트방식 따라 따로따로 동작할 수 있는 함수 이따 배울 것 
	 		            data : params, //보낼 데이터 - 상황에 따라 없을 수 있음 
	 		            success : function(res) { //성공적으로 넘어갔을때 이 함수 실행하며, 돌아오는 값을 res란 이름으로 받는다.
	 		               if(res.result == "success"){
	 		            	   	console.log(res.indctorName);
	 		            	 	$("#indctorName").val(res.indctorName.INDCTOR_NAME);
	 		            	 	$("#indctorNo").val(res.indctorName.INDCTOR_NO);
	 		                  
	 		               } else {
	 		                  alert("오류가 발생하였습니다.");
	 		               }
	 		            },
	 		            error : function(request, status, error) { //값이 돌아오지 않는 등 실행 중 에러 발생 시 이 함수 실행
	 		               console.log("text : " + request.responseText); //반환텍스트 
	 		               console.log("error : " + error); //에러 내용 
	 		            } //{ name: "이재희", 키: 값, ...} 중괄호, 키, 값으로 이루어진 전송 규격 = json
	 		         });//indctorNameAjax 
	 				
	 				closePopup(3);
				});
		
				},"닫기", function() {
					closePopup(3);
			}); //function board3 tbody click, 세번째 팝업 end
			
		});//searchBtn2 end
	   
		}, "저장", function() {
			console.log("start");
			
			$("#kpiNo2").val($("#kpiNo").val());
			$("#kpiName2").val($("#kpiName").val());
			$("#explnTn2").val($("#explnTn").val());

			var params = $("#actionForm").serialize();
			
	         $.ajax({ //겟방식? 포스트방식?
	            type : "post", //전송방식 (포스트로 보내겠다)
	            url : "kpiWriteAjax", //주소 
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
	         });//kpiWriteAjax 
			
			closePopup(1);
	         
		}, "닫기", function() {
			closePopup(1);
		});//첫번째 팝업 end
		
}); //add Btn end
	
	 $(".delBtn").on("click", function(){
	        var cnt = $("input[name='chk2']:checked").length;
	        
	        if(cnt == 0){
	            alert("선택된 글이 없습니다.");
	        }
	        else{
	        	
	        	var params = $("#actionForm").serialize();
	        	
	            $.ajax ({
	                type: "post",
	                url: "kpidelAjax", //반복해서 딜리트문을 실행하도록 
	                dataType:"json",
	                data: params,
	                success: function(res){
	                    if(res.result == "success") {
	                        makeAlert(1, "알림", "삭제 되었습니다.", null, function() {
	                        	reloadList();
	                        });
	                    }
	                    else{
	                        alert("삭제 중 문제가 발생 했습니다.");
	                    }
	                },
	                error : function(request, status, error) { //값이 돌아오지 않는 등 실행 중 에러 발생 시 이 함수 실행
	 	               console.log("text : " + request.responseText); //반환텍스트 
	 	               console.log("error : " + error); //에러 내용 
	 	            }
	            });		            
	        };
	        
	});//delbtn end

	
});//document end

//메인
function reloadList(){
	   var params = $("#actionForm").serialize();
	   
	   $.ajax({ //겟
	      type : "post", 
	      url : "kpiListAjax", //호출 
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
	   });//csfListAjax
	   
	}//reloadList

	function redrawList(list){
	      if(list.length==0) {//가져온 데이터가 없다.
	         var html = "";
	      html += "<tr class=\"nothing\">";
	      html += "<td colspan=\"8\">조회 결과가 없습니다.</td>";
	      html += "</tr>";
	      
	      $(".board tbody").html(html);
	      } else {
	         var html="";
	         
	         for(var i = 0; i < list.length; i++){
	            html += "<tr name=\"" + list[i].KPI_NO + "\">";
	            html += "<td><input type=\"checkbox\" name=\"chk2\" value=\"" + list[i].KPI_NO + "\"></td>";
	            html += "<td>" + list[i].CSF_NO + "</td>";
	            html += "<td>" + list[i].CSF_NAME + "</td>";
	            html += "<td>" + list[i].KPI_NO + "</td>";
	            html += "<td>" + list[i].KPI_NAME + "</td>";
	            html += "<td>" + list[i].EXPLNTN + "</td>";
	            html += "<td>" + list[i].INDCTOR_NO + "</td>";
	            html += "<td>" + list[i].INDCTOR_NAME + "</td>";
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
	      html += "<div name = \"" + ($("#page").val() * 1 - 1)  + "\" class=\"pagingD\" id=\"before\"></div>";
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
	<c:param name="menuNo" value="47"></c:param>
</c:import>
<!-- 구현내용 -->
<div class="title_wrap">
	<div class="title_table">
		<div class="title_txt">KPI 관리</div>
	</div>
</div>
<div class="contents_area">
	<!-- 내용은 여기에 구현하세요. -->
	
<form action='#' id="actionForm3" method="post">
	<input type="hidden" id="indctorNo" name="indctorNo" value="${sIndctorNo}" />
	<input type="hidden" id="indctorName" name="indctorName" value="${sIndctorName}" />
</form> 
<form action='#' id="actionForm2" method="post">
	<input type="hidden" id="csfNo" name="csfNo" value="${sCsfNo}" />
	<input type="hidden" id="csfName" name="csfName" value="${sCsfName}" />
</form> 
<form action='#' id="actionForm" method="post">
	<div class="deletekpidiv"></div>
	<input type="hidden" id="page" name="page" value="1" />
	<input type="hidden" id="csfNo" name="csfNo" value="${sCsfNo}" />
	<input type="hidden" id="csfName" name="csfName" value="${sCsfName}" />
	<input type="hidden" id="kpiNo2" name="kpiNo" value="${sKpiNo}" />
	<input type="hidden" id="kpiName2" name="kpiName" value="${sKpiName}" />
	<input type="hidden" id="explnTn2" name="explnTn" value="${sExplnTn}" />
	<input type="hidden" id="indctorNo" name="indctorNo" value="${sIndctorNo}" />
	<input type="hidden" id="indctorName" name="indctorName" value="${sIndctorName}" />

<div class="main">	
	<div class="main_top">
	<input type="button" value="등록" class="addBtn">
	<input type="button" value="삭제" class="delBtn">
	</div>
		<table class="board">
			<colgroup>
				<col width="5%" />
				<col width="5%" />
				<col width="15%" />
				<col width="5%" />
				<col width="15%" />
				<col width="*" />
				<col width="5%" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th></th>
					<th>CSF 번호</th>
					<th>CSF 명</th>
					<th>KPI 번호</th>
					<th>KPI 명</th>
					<th>설명</th>
					<th>지표번호</th>
					<th>지표명</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td></td>
					<td>1</td>
					<td>기업가치</td>
					<td>1</td>
					<td>EVA</td>
					<td>설명</td>
					<td>설명</td>
					<td>설명</td>
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
	</div> 	
</form>
</div>
<!-- 구현끝 -->
<!-- 바텀 -->
<c:import url="/bottom"></c:import>
</body>
</html>