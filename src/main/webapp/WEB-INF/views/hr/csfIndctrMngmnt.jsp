<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CSF 지표 관리</title>
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
	display: inline-block;
	margin-bottom : 10px;
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

.searchBtn1 {
	vertical-align: top;
	display:inline-block;
	height: 30px;
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
	margin-top : 5px;
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

.num,.csf,.jum,.sul {
	font-size : 16px;
	margin-bottom : 5px;
}

.vnum {
	font-size : 16px;
	margin-bottom : 5px;
}

.vaddBtn {
	width : 15%;
	height : 30px;
	margin-left : 5px;
	font-size : 15px;
	cursor: pointer;
}

.vwpnttxt {
	margin-left : 5px;
	font-size : 15px;
	width : 80%;
	height : 30px;
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
		content += "<div class=\"num\">- CSF 번호 : ${csfNext}번</div>"
		content += "<div class=\"csf\">- CSF 명</div><textarea rows=\"2\" cols=\"50\" id=\"csfName\"></textarea>"
		content += "<div class=\"jum\">- 관점 명</div><textarea rows=\"2\" cols=\"40\" id=\"vwpntName\" name=\"vwpntName\"></textarea><input type=\"button\" value=\"조회\" class=\"searchBtn1\">"
		content += "<div class=\"sul\">- 설명</div><textarea rows=\"8\" cols=\"50\" id=\"explnTn\"></textarea>"
	             			
		makeTwoBtnPopup(3, "CSF 등록", content, true, 500, 500, function(){
			//2번째 팝업 화면 생긴 뒤 일어날 동작들
			
		$(".searchBtn1").on("click", function (){
			
			
	 	var content = "";
	 	content += "<form action=\"#\" id=\"actionForm2\" method=\"post\">"
	 	content += "<div class=\"vnum\">관점번호 : ${vwpntNext}번</div>"
	 	content += "<input type=\"text\" placeholder=\"관점명\" class=\"vwpnttxt\" name=\"vwpnttxt\"><input type=\"button\" value=\"등록\" class=\"vaddBtn\">"
	 	content += "<div class=\"board2Wrap\" id=\"board2Wrap\">"
	 	content += "<table class=\"board2\">"
	 	content += "<colgroup>"
	 	content += "<col width=\"40%\"/>"
	 	content += "<col width=\"*\"/>"
		content += "</colgroup>"
	 	content += "<thead>"	 	
	 	content += "<tr>"
	 	content += "<th>관점 번호</th>"
	 	content += "<th>관점 명<th>"
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
<<<<<<< HEAD
=======
	 	
>>>>>>> refs/heads/kimsangeun
	 	function reloadList2(){
	 		console.log("ok");
	 	   var params = $("#actionForm2").serialize();
	 	   
	 	   $.ajax({ //겟
	 	      type : "post", 
	 	      url : "vwpntListAjax", //호출 
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
	 	   });//vwpntListAjax end
	 	   
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
	 	            html += "<tr name=\"" + list[i].VWPNT_NO + "\">";
	 	            html += "<td>" + list[i].VWPNT_NO + "</td>";
	 	            html += "<td>" + list[i].VWPNT_NAME + "</td>";
	 	            html += "</tr>";
	 	            
	 	         }
	 	        
	 	         $(".board2 tbody").html(html);

	 	      }
	 	}//redrawList2
        
	makeOneBtnPopup(4, "관점 조회", content, true, 500, 500, function(){
		$("#board2Wrap").slimScroll({
			width: "460px",
			height: "280px"
		});
		reloadList2();
		
  	$(".vaddBtn").on("click",function(){
  		
  		$("#vwpntName2").val($("#vwpntName").val());
		
		var params = $("#actionForm2").serialize(); //제이쿼리로 해결
         
        $.ajax({ //겟방식? 포스트방식?
            type : "post", //전송방식 (포스트로 보내겠다)
            url : "vwpntWriteAjax", //주소 
            dataType : "json",  //데이터형태 - 일반적으로 아작스는 json많이 씀. 바로 매칭 돼서. 별도 가공 불필요.
            //겟방식 / 포스트방식 따라 따로따로 동작할 수 있는 함수 이따 배울 것 
            data : params, //보낼 데이터 - 상황에 따라 없을 수 있음 
            success : function(res) { //성공적으로 넘어갔을때 이 함수 실행하며, 돌아오는 값을 res란 이름으로 받는다.
               if(res.result == "success"){
            	   reloadList2();
               } else {
                  alert("오류가 발생하였습니다.");
               }
            },
            error : function(request, status, error) { //값이 돌아오지 않는 등 실행 중 에러 발생 시 이 함수 실행
               console.log("text : " + request.responseText); //반환텍스트 
               console.log("error : " + error); //에러 내용 
            } //{ name: "이재희", 키: 값, ...} 중괄호, 키, 값으로 이루어진 전송 규격 = json
         });//vwpntWriteAjax
         		
  	});//vaddBtn
				
 		$(".board2 tbody").on("click", "tr", function(){
			//is : css상태값 is("[name]") = name이라는 속성이 있느냐 있으면 true?
				
 				$("#vwpntNo").val($(this).attr("name"));
 				$("[name='vwpntNo']").val($(this).attr("name"));
				console.log($("#vwpntNo").val());
				console.log($("[name='vwpntNo']").val());

				
 				var params = $("#actionForm").serialize();
 				
 		         $.ajax({ //겟방식? 포스트방식?
 		            type : "post", //전송방식 (포스트로 보내겠다)
 		            url : "vwpntNameAjax", //주소 
 		            dataType : "json",  //데이터형태 - 일반적으로 아작스는 json많이 씀. 바로 매칭 돼서. 별도 가공 불필요.
 		            //겟방식 / 포스트방식 따라 따로따로 동작할 수 있는 함수 이따 배울 것 
 		            data : params, //보낼 데이터 - 상황에 따라 없을 수 있음 
 		            success : function(res) { //성공적으로 넘어갔을때 이 함수 실행하며, 돌아오는 값을 res란 이름으로 받는다.
 		               if(res.result == "success"){
 		            	   	console.log(res.vwpntName);
 		            	 	$("#vwpntName").val(res.vwpntName);
 		                  
 		               } else {
 		                  alert("오류가 발생하였습니다.");
 		               }
 		            },
 		            error : function(request, status, error) { //값이 돌아오지 않는 등 실행 중 에러 발생 시 이 함수 실행
 		               console.log("text : " + request.responseText); //반환텍스트 
 		               console.log("error : " + error); //에러 내용 
 		            } //{ name: "이재희", 키: 값, ...} 중괄호, 키, 값으로 이루어진 전송 규격 = json
 		         });//ajax 
 				
			closePopup(4);
			});	
	},		
 		 "닫기", function() {
			closePopup(4);
	      }); //function board2 tbody click, 첫번째 팝업 end  
		
	});//search Btn(관점 팝업) end 
		
		}, "저장", function() {
			console.log("start");
			
			$("#csfName2").val($("#csfName").val());
			$("#explnTn2").val($("#explnTn").val());
			
			console.log($("[name='vwpntNo']").val());
			console.log($("[name='csfName']").val());
			console.log($("[name='explnTn']").val());
			
			var params = $("#actionForm").serialize();
			
	         $.ajax({ //겟방식? 포스트방식?
	            type : "post", //전송방식 (포스트로 보내겠다)
	            url : "csfWriteAjax", //주소 
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
	         });//ajax 
	         
				/* $("#actionForm").attr("action","csfIndctrMngmnt");
				$("#actionForm").submit();
				$("#vwpntName").val($(this).attr("name")); */
			closePopup(3); 
				
	      }, "닫기", function() {
			closePopup(3); 
		});
	});//add btn end  
	
    $(".delBtn").on("click", function(){
		        var cnt = $("input[name='chk']:checked").length;
		        
		        if(cnt == 0){
		            alert("선택된 글이 없습니다.");
		        }
		        else{
		        	
		        	var params = $("#actionForm").serialize();
		        	
		            $.ajax ({
		                type: "post",
		                url: "csfdelAjax", //반복해서 딜리트문을 실행하도록 
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
		        
	   });//delte btn end
	
});//document end		
 	  
//메인
function reloadList(){
	   var params = $("#actionForm").serialize();
	   
	   $.ajax({ //겟
	      type : "post", 
	      url : "csfListAjax", //호출 
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
	      html += "<td colspan=\"5\">조회 결과가 없습니다.</td>";
	      html += "</tr>";
	      
	      $(".board tbody").html(html);
	      } else {
	         var html="";
	         
	         for(var i = 0; i < list.length; i++){
	            html += "<tr name=\"" + list[i].CSF_NO + "\">";
	            html += "<td><input type=\"checkbox\" name=\"chk\" value=\"" + list[i].CSF_NO + "\"></td>";
	            html += "<td>" + list[i].CSF_NO + "</td>";
	            html += "<td>" + list[i].CSF_NAME + "</td>";
	            html += "<td>" + list[i].VWPNT_NAME + "</td>";
	            html += "<td>" + list[i].EXPLNTN + "</td>";
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
	<c:param name="menuNo" value="46"></c:param>
</c:import>
<!-- 구현내용 -->
<div class="title_wrap">
	<div class="title_table">
		<div class="title_txt">CSF 지표 관리</div>
	</div>
</div>
<div class="contents_area">
	<!-- 내용은 여기에 구현하세요. -->
	
<form action='#' id="actionForm2" method="post">
	<input type="hidden" id ="vwpntNo"  name="vwpntNo"  />
	<input type="hidden" id="vwpntName2" name="vwpntName"  />
</form>
<form action="#" id="actionForm" method="post">
	<div class="deleteCsfdiv"></div>
	<input type="hidden" id="csfNo" name="csfNo" value="${sCsfNo}" />
	<input type="hidden" id="vwpntNo" name="vwpntNo"<%--  value="${sVwpntNo}"  --%>/>
	<input type="hidden" id="csfName2" name="csfName" <%-- value="${sCsfName}"  --%>/>
	<input type="hidden" id="vwpntName2" name="vwpntName" value="${sVwptnName}" />
	<input type="hidden" id="explnTn2" name="explnTn" <%-- value="${sExplnTn}"  --%>/>
	<input type="hidden" name="page" id="page" value="1" />
<div class="main">	
	<div class="main_top">
	<input type="button" value="등록" class="addBtn">
	<input type="button" value="삭제" class="delBtn">
	</div>
		<table class="board">
			<colgroup>
				<col width="5%" />
				<col width="10%" />
				<col width="20%" />
				<col width="20%" />
				<col width="*" />
			</colgroup>
			<thead>
				<tr>
					<th></th>
					<th>CSF 번호</th>
					<th>CSF 명</th>
					<th>관점</th>
					<th>설명</th>
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