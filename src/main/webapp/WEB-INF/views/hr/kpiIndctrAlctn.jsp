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

.bsm,.bsd {
	font-size : 18px;
	text-indent: 5px;
	font-weight : bold;
	text-shadow: 1px 1px 2px #c0c0c0;
	line-height: 30px;
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

.addBtn1 {
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

.searchBtn1{
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

.kpino,.kpiname,.indcno,.indcname,.msr,.bscno,.bscstd,.goal,.prfrmnc{
	font-size : 15px;
	margin-bottom : 5px;
}

.kpinumtxt,.bscNotxt{
	width : 30px;
	height : 25px;
	margin-bottom : 5px;	
}

.kpitxt{
	width : 80%;
	height : 25px;
	margin-bottom : 5px;
}

.prfrmnctxt,.goaltxt {
	width : 20%;
	height : 25px;
	margin-bottom : 5px;
}

.scroll { 
	height : 98%;
	overflow : auto;
}

</style>   
<script type="text/javascript">

$(document).ready(function() {
	 	
	reloadList();
	
	 $(".paging").on("click", "div", function(){
	      $("#page").val($(this).attr("name"));
	      reloadList();
	   });//paging
	   
	   
  $(".addBtn1").on("click", function(){
		 
				
		var content = "";
		content += "<div class=\"kpino\">- KPI번호 <input type=\"text\" class=\"kpinumtxt\" id=\"kpiNo\" name=\"kpiNo\"><input type=\"button\" value=\"조회\" class=\"searchBtn1\"></div>"
		content += "<div class=\"kpiname\">- KPI명 <input type=\"text\" class=\"kpitxt\" id=\"kpiName\" name=\"kpiName\"></div>"
		content += "<div class=\"indcno\">- 지표번호 : <span class=\"indcnotxt\" id=\"indctorNo\" name=\"indctorNo\"></span></div>"
		content += "<div class=\"indcname\">- 지표명 : <span class=\"indcnametxt\" id=\"indctorName\" name=\"indctorName\"></span></div>"
		content += "<div class=\"msr\">- 지표단위 : <span class=\"msrtxt\" id=\"msR\" name=\"msR\"></span></div>"
		content += "<div class=\"bscstd\">- BSC기준번호 : ${yyyy}번</div>"
		content += "<div class=\"bscno\">- BSC번호 : ${bscNext}번</div>"
		content += "<div class=\"goal\">- 목표 <input type=\"text\" class=\"goaltxt\" id=\"goalValue\" name=\"goalValue\"></div>"

		console.log(content);
		
	    makeTwoBtnPopup(1, "KPI 등록", content, true, 500, 450, function(){
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
				content += "<th>KPI번호</th>"
				content += "<th>KPI명<th>"
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
			 	      url : "kpiIndcListAjax", //호출 
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
			 	            html += "<tr name=\"" + list[i].KPI_NO + "\">";
			 	            html += "<td>" + list[i].KPI_NO + "</td>";
			 	            html += "<td>" + list[i].KPI_NAME + "</td>";
			 	            html += "</tr>";
			 	            
			 	         }
			 	         
			 	         $(".board2 tbody").html(html);

			 	      }
			 	}//redrawList2 end
			 			
		makeOneBtnPopup(2, "KPI번호 조회", content, true, 500, 400, function(){
			
			$("#board2Wrap").slimScroll({
				width: "460px",
				height: "230px"
			});
					
					reloadList2();

					$(".board2 tbody").on("click", "tr", function(){
					//is : css상태값 is("[name]") = name이라는 속성이 있느냐 있으면 true?
						
		 				$("#kpiNo").val($(this).attr("name"));
		 				$("[name='kpiNo']").val($(this).attr("name"));

		 				
		 				var params = $("#actionForm").serialize();
		 				
		 		         $.ajax({ //겟방식? 포스트방식?
		 		            type : "post", //전송방식 (포스트로 보내겠다)
		 		            url : "kpiIndcNameAjax", //주소 
		 		            dataType : "json",  //데이터형태 - 일반적으로 아작스는 json많이 씀. 바로 매칭 돼서. 별도 가공 불필요.
		 		            //겟방식 / 포스트방식 따라 따로따로 동작할 수 있는 함수 이따 배울 것 
		 		            data : params, //보낼 데이터 - 상황에 따라 없을 수 있음 
		 		            success : function(res) { //성공적으로 넘어갔을때 이 함수 실행하며, 돌아오는 값을 res란 이름으로 받는다.
		 		               if(res.result == "success"){
		 		            	   	console.log(res.kpiName);
		 		            	 	$("#kpiName").val(res.kpiName.KPI_NAME);
		 		            	 	$("#kpiNo").val(res.kpiName.KPI_NO);
		 		            	 	
		 		            	 	//span
		 		            	 	console.log("res.kpiname.indctor_name : " + res.kpiName.INDCTOR_NAME);
		 		            	 	$(".indcnotxt").text(res.kpiName.INDCTOR_NO);
		 		            	 	$(".indcnametxt").text(res.kpiName.INDCTOR_NAME);
		 		            	 	$(".msrtxt").text(res.kpiName.MSR);
		 		                  
		
		 		               } else {
		 		                  alert("오류가 발생하였습니다.");
		 		               }
		 		            },
		 		            error : function(request, status, error) { //값이 돌아오지 않는 등 실행 중 에러 발생 시 이 함수 실행
		 		               console.log("text : " + request.responseText); //반환텍스트 
		 		               console.log("error : " + error); //에러 내용 
		 		            } //{ name: "이재희", 키: 값, ...} 중괄호, 키, 값으로 이루어진 전송 규격 = json
		 		         });//kpiIndcNameAjax 
		 				
		 				closePopup(2);
					});//function board2 tbody click end
					
		
					
			},"닫기", function() {
				closePopup(2); 
			});// makeOneBtnPopup end
		}); //searchBtn1 end			

			 				
	    }, "저장", function() {
			
			
			$("#kpiNo2").val($("#kpiNo").val());
			$("#bscNo2").val($("#bscNo").val());
			$("#goalValue2").val($("#goalValue").val());

			var params = $("#actionForm").serialize();
			
	         $.ajax({ //겟방식? 포스트방식?
	            type : "post", //전송방식 (포스트로 보내겠다)
	            url : "goalWriteAjax", //주소 
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
			}); // makeTwoBtnPopup end

});//addBtn1 end 
		
	$(".board tbody").on("click", "tr", function(){
		
	//is : css상태값 is("[name]") = name이라는 속성이 있느냐 있으면 true?
		
			$("#bscNo").val($(this).attr("name"));
			$("[name='bscNo']").val($(this).attr("name"));
		
 		
 		var params = $("#actionForm").serialize();
 		console.log("start");
         $.ajax({ //겟방식? 포스트방식?
            type : "post", //전송방식 (포스트로 보내겠다)
            url : "popupNameAjax", //주소 
            dataType : "json",  //데이터형태 - 일반적으로 아작스는 json많이 씀. 바로 매칭 돼서. 별도 가공 불필요.
            //겟방식 / 포스트방식 따라 따로따로 동작할 수 있는 함수 이따 배울 것 
            data : params, //보낼 데이터 - 상황에 따라 없을 수 있음 
            success : function(res) { //성공적으로 넘어갔을때 이 함수 실행하며, 돌아오는 값을 res란 이름으로 받는다.
               if(res.result == "success"){
            	   
            	     //span
            		$(".kpitxt").text(res.kpiName.KPI_NAME);
	            	$(".kpinumtxt").text(res.kpiName.KPI_NO);
            	 	
            	 	console.log("res.kpiname.indctor_name : " + res.kpiName.INDCTOR_NAME);

            	 	$(".indcnotxt").text(res.kpiName.INDCTOR_NO);
            	 	$(".indcnametxt").text(res.kpiName.INDCTOR_NAME);
            	 	$(".msrtxt").text(res.kpiName.MSR);
            	 	$(".bscstdtxt").text(res.kpiName.STNDRD_BSC_NO);
            	 	$(".bscnotxt").text(res.kpiName.BSC_NO);
            	 	$(".goaltxt").text(res.kpiName.GOAL_VALUE);
               		}	
               

        		 	var content = "";
        			content += "<div class=\"kpino\">- KPI번호 : <span class=\"kpinumtxt\" id=\"kpiNo\" name=\"kpiNo\">" + res.kpiName.KPI_NO + "</span></div>"
        			content += "<div class=\"kpiname\">- KPI명 : <span class=\"kpitxt\" id=\"kpiName\" name=\"kpiName\">" + res.kpiName.KPI_NAME + "</span></div>"
        			content += "<div class=\"indcno\">- 지표번호 : <span class=\"indcnotxt\" id=\"indctorNo\" name=\"indctorNo\">" + res.kpiName.INDCTOR_NO + "</span></div>"
        			content += "<div class=\"indcname\">- 지표명 : <span class=\"indcnametxt\" id=\"indctorName\" name=\"indctorName\">" + res.kpiName.INDCTOR_NAME + "</span></div>"
        			content += "<div class=\"msr\">- 지표단위 : <span class=\"msrtxt\" id=\"msR\" name=\"msR\">" + res.kpiName.MSR + "</span></div>"
        			content += "<div class=\"bscstd\">- BSC기준번호 : <span class=\"bscstdtxt\" id=\"stndrdBscNo\" name=\"stndrdBscNo\">" + res.kpiName.STNDRD_BSC_NO + "</span></div>"
        			content += "<div class=\"bscno\">- BSC번호 : <span class=\"bscnotxt\" id=\"bscNo\" name=\"bscNo\">" + res.kpiName.BSC_NO + "</span></div>"
        			content += "<div class=\"goal\">- 목표 : <span class=\"goaltxt\" id=\"goalValue\" name=\"goalValue\">" + res.kpiName.GOAL_VALUE + res.kpiName.MSR + "</span></div>"
        			content += "<div class=\"prfrmnc\">- 실적 : <input type= \"text\" class=\"prfrmnctxt\" id=\"prfrmncValue\" name=\"prfrmncValue\" value=\"" + res.kpiName.PRFRMNC_VALUE + "\">" + res.kpiName.MSR 

        	makeTwoBtnPopup(3, "실적등록", content, true, 500, 600, null, "저장", function(){ 
        		
        				 if($.trim($("#prfrmncValue").val()) == ""){
        	         			alert("실적을 입력해주세요.");
        	      			} else if($.trim($("#prfrmncValue").val()) !=="") {
        	      				
        	      				$("#prfrmncValue2").val($("#prfrmncValue").val());
       		           		         
        		         var params = $("#actionForm").serialize(); //제이쿼리로 해결
        		         
        		         $.ajax({ //겟방식? 포스트방식?
        		            type : "post", //전송방식 (포스트로 보내겠다)
        		            url : "prfrmncUpdateAjax", //주소 
        		            dataType : "json",  //데이터형태 - 일반적으로 아작스는 json많이 씀. 바로 매칭 돼서. 별도 가공 불필요.
        		            //겟방식 / 포스트방식 따라 따로따로 동작할 수 있는 함수 이따 배울 것 
        		            data : params, //보낼 데이터 - 상황에 따라 없을 수 있음 
        		            success : function(res) {
        		            	if(res.result == "success"){//성공적으로 넘어갔을때 이 함수 실행하며, 돌아오는 값을 res란 이름으로 받는다.
        		        	    	$("#actionForm").val("");
        	                    
        	            	   		reloadList();
        	            	   		closePopup(3);
        	                  
        	              	 } else if(res.result == "fail"){
        	                  	alert("오류가 발생하였습니다.");
        	               		} 
        		         	},
        		           
        		            error : function(request, status, error) { //값이 돌아오지 않는 등 실행 중 에러 발생 시 이 함수 실행
        		               console.log("text : " + request.responseText); //반환텍스트 
        		               console.log("error : " + error); //에러 내용 
        		            } //{ name: "이재희", 키: 값, ...} 중괄호, 키, 값으로 이루어진 전송 규격 = json
        		            
        		         });//prfrmncUpdateAjax end        				
        		    
        	      
			
        	      }}, "닫기", function() {
					closePopup(3);
					}); // makeTwoBtnPopup end
			
   		 	},
	 		error : function(request, status, error) { //값이 돌아오지 않는 등 실행 중 에러 발생 시 이 함수 실행
        		console.log("text : " + request.responseText); //반환텍스트 
       			 console.log("error : " + error); //에러 내용 
      											//{ name: "이재희", 키: 값, ...} 중괄호, 키, 값으로 이루어진 전송 규격 = json
  				}
		});//popupNameAjax

	});//board tbody end 

});//document end

//메인
function reloadList(){
	   var params = $("#actionForm").serialize();
	   console.log("start");
	   
	   $.ajax({ //겟
	      type : "post", 
	      url : "kpihdListAjax", //호출 
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
	            html += "<tr name=\"" + list[i].BSC_NO + "\">";
	            html += "<td>" + list[i].KPI_NO + "</td>";
	            html += "<td>" + list[i].KPI_NAME + "</td>";
	            html += "<td>" + list[i].INDCTOR_NO + "</td>";
	            html += "<td>" + list[i].INDCTOR_NAME + "</td>";
	            html += "<td>" + list[i].STNDRD_BSC_NO + "</td>";
	            html += "<td>" + list[i].BSC_NO + "</td>";
	            html += "<td>" + list[i].GOAL_VALUE + list[i].MSR +"</td>";
	            html += "<td>" + list[i].PRFRMNC_VALUE + list[i].MSR +"</td>";
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
	<c:param name="menuNo" value="54"></c:param>
</c:import>
<!-- 구현내용 -->
<div class="title_wrap">
	<div class="title_table">
		<div class="title_txt">KPI지표 할당</div>
	</div>
</div>
<div class="contents_area">
	<!-- 내용은 여기에 구현하세요. -->
	
<form action='#' id="actionForm2" method="post">
	<input type="hidden" id="kpiNo" name="kpiNo" />
	<input type="hidden" id="kpiName" name="kpiName" />
</form> 
<form action='#' id="actionForm" method="post">
	<input type="hidden" id="page" name="page" value="1" />
	<input type="hidden" id="kpiNo2" name="kpiNo"  />
	<input type="hidden" id="kpiName" name="kpiName"  />
	<input type="hidden" id="indctorNo" name="indctorNo"  />
	<input type="hidden" id="indctorName" name="indctorName" />
	<input type="hidden" id="msR" name="msR"  />
	<input type="hidden" id="bscNo2" name="bscNo" />
	<input type="hidden" id="goalValue2" name="goalValue" />
	<input type="hidden" id="prfrmncValue2" name="prfrmncValue"  />
	<input type="hidden" id="yyyy2" name="yyyy" value="${yyyy}"  />
	<input type="hidden" id="DprtmntNo" name="DprtmntNo" value="${sDprtmntNo}" />
	<input type="hidden" id="EmplyNo" name="EmplyNo" value="${sEmplyNo}" />

<div class="main">	
	<div class="main_top">
		<div class="bsm">- 부서명 : ${sDprtmntName} </div>
		<div class="bsd">- KPI <input type="button" value="등록" class="addBtn1"></div>
	</div>
		<table class="board">
			<colgroup>
				<col width="5%" />
				<col width="15%" />
				<col width="5%" />
				<col width="15%" />
				<col width="10%" />
				<col width="10%" />
				<col width="20%" />
				<col width="*%" />
			</colgroup>
			<thead>
				<tr>
					<th>KPI번호</th>
					<th>KPI명</th>
					<th>지표번호</th>
					<th>지표명</th>
					<th>BSC기준번호</th>
					<th>BSC번호</th>
					<th>목표</th>
					<th>실적</th>
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