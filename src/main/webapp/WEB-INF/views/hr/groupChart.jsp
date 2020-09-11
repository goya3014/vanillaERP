<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조직도</title>
<!-- 헤더 -->
<c:import url="/header"></c:import>
<!-- css  -->
<link rel="stylesheet" href="resources/css/jquery/jstree.style.min.css" />
<!-- group chart  -->
<link rel="stylesheet" href="resources/css/hr/groupChart.css" />


<!-- jstree JQuery -->
<script type="text/javascript" src="resources/script/jquery/jstree.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	
	
   $("#jstree").jstree({ 
      "core" : {
         "check_callback": true,
         "multiple" : false,
         "animation" : 0,
         "expand_selected_onload" : true,
         "restore_focus" : true
      },
      "types" : {
         "corp" : {
            "valid_children" : ["group"]
         },
         "group" : {
            "valid_children" : ["group"]
         }
      },
      "plugins" : [
         "contextmenu", "dnd", "search",
         "state", "types", "wholerow"
      ]
   });
   reloadChart();
   
   $("#jstree").on('select_node.jstree', function (e, data) {
      $("#topDptNo").val(data.node.id);
      $("#addGroupForm #topDptNo").val(data.node.id);
      $("#delGroupForm #DptNo").val(data.node.id);
      $("#empchartForm #DptNo").val(data.node.id);
   }).on('refresh.jstree', function(e, data) {
      var treeData = data.instance._model.data;
      
      var key = Object.keys(treeData);
       
      for(var i = 0 ; i < key.length ; i++) {
         if(treeData[key[i]].parent == "#" || treeData[key[i]].parent == "0") {
            $("#jstree").jstree().open_node(treeData[key[i]].id);
         }
      }
   }); //document ready end
   
    // addbtn 클릭시 오른쪽에 등록 Div
    $("#group_addbtn").on ("click", function () {
       if($("#add_group_Div").css("display") == "none") {
    	   $("#rightDiv div").hide();
          $("#add_group_Div").show();
       } else {
          $("#add_group_Div").hide();
       }
    });
    
    // addgroupBtn 클릭시 , 조건 : 상위 조직 클릭
	$("#addgroupBtn").on("click", function () {
		if($("#topDptNo").val() == "") {
			makeAlert(1, "알림", "상위부서를 선택해주세요.", true, null);
		} else if ($.trim($(".dprtmnt_name").val())==""){
			makeAlert(1, "알림", "부서명을 입력해주세요.", true, null);
		} else {
			makeAlert(1, "알림" , "부서가 등록되었습니다", true);
	    	groupwrite();
		}
	}); 
    
    // groupBtn 취소
	$("#cangroupBtn").on("click", function () {
		$("#rightDiv div").hide();
	});
    
    //delbtn 클릭시 div
    $("#group_delbtn").on ("click", function () {
       if($("#del_group_Div").css("display") == "none") {
    	  $("#rightDiv div").hide();
          $("#del_group_Div").show();
       } else {
          $("#del_group_Div").hide();
       }
    });
    
    //delBtn 삭제 
    $("#delgroupBtn").on("click", function () {
    	if($("#DptNo").val() == "") {
			makeAlert(1, "알림", "삭제할 부서가 선택되지 않았습니다.", true, null);
		} else {
    	var html = "";
    	html += "<div class=\"delpopup\">부서를 삭제하시겠습니까?</div>";
    	
    	makeTwoBtnPopup(1, "삭제", html, false, 450, 300, null,"확인", function(){
    	groupdelete();
    	makeAlert(2, "알림" , "삭제되었습니다", true); 
    	closePopup(1);
    	}, "닫기", function(){
    		
    	closePopup(1);
    	});
    	}
    	
    });
    
    $("#delcangroupBtn").on("click", function () {
    	  $("#rightDiv div").hide();
	});
   
    
    $("#group_infobtn").on("click", function () {
    	if($("#DptNo").val() == "") {
			makeAlert(1, "알림", "부서를 선택해주세요", true, null);
    	} else {
    			$(".popup_wrap").show();
				emplyChart();
    		}
	});
    
	$(".popupcloseBtn").on("click", function () {
		$(".popup_wrap").hide();
	});
	
	$(".emptable").on("click","tr", function () {
		if($(this).is ("[name]")){
		/* 인사기록카드 주소  	$(".popup_wrap2").show(); */
		}
	});
	
 
});
/* 조회  */
function reloadChart() {
   var params =$("#chartForm").serialize();
   
   $.ajax ({
      type : "post",
      url : "getgroupChartAjax",
      dataType : "json",
      data : params,
      success : function(suc) {
         $("#jstree").jstree(true).settings.core.data = suc.groupChart;
         
         $("#jstree").jstree(true).deselect_all();
         
         $("#jstree").jstree(true).refresh();
         
      },
      error : function(request, status, error) {
         console.log("status : " + request.status);
         console.log("text : " + request.responseText);
         console.log("error : " + error);
      }
   });
}

/* 추가  */
function groupwrite() {
	if($("#addGroupForm #topDptNo").val() == 0){
		$("#addGroupForm #topDptNo").val("");
	}
	
	var params =$("#addGroupForm").serialize();
	
	$.ajax ({
		type : "post",
		url : "insertGroupAjax",
		dataType : "json",
		data : params,
		success : function(suc) {
			if(suc.result == "success"){
				reloadChart();
				$("#addGroupForm #dprtmnt_name").val("");
				$("#rightDiv div").hide();
			}
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
} 


/* 삭제 */
function groupdelete() {
	var params =$("#delGroupForm").serialize();
	$.ajax ({
		type : "post",
		url : "deleteGroupAjax",
		dataType : "json",
		data : params,
		success : function(suc) {
			if($("#DptNo").val() == ""){
				makeAlert(1, "알림", "삭제할 부서를 선택해주세요.", true, null);
			}else if (suc.result == "success"){
				reloadChart();
				$("#rightDiv div").hide();
				console.log(suc.result);
			}else if(suc.result =="fail"){
				alert("사원이나 하위부서가 있는 부서은 삭제할 수 없습니다.")
				console.log(suc.result);
			}else {
				alert("삭제중 문제가 발생하였습니다.")
			}
		},
		error : function(request, status, error) {
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

/* 사원 조회 */ 
function emplyChart() {
   var params =$("#empchartForm").serialize();
   
   $.ajax ({
      type : "post",
      url : "getemplyAjax",
      dataType : "json",
      data : params,
      success : function(suc) {
		if(suc.result ="success"){
			redrawemplyChart(suc.list);
			redrawPaging(suc.pb);
		} else {
			alert("조회중 문제가 방생하였습니다.");
			console.log(suc.result);
		}
	},
	error : function(request, status, error) {
		console.log("text : " + request.responseText);
		console.log("error : " + error);
     		}
   });
}


function redrawemplyChart(list) {
	
	if (list.length==0) {
		var html = "";
		html +="<tr>";
		html +="<td colspan=\"3\">조회 결과가 없습니다.</td>";
		html +="</tr>";
		
		$(".emptable tbody").html(html);
	} else {
		var html = "";

		for (var i = 0; i < list.length; i++){
			html += "<tr name=\"" + list[i].NAME + "\">";
			html += "<td>" +list[i].NAME + "</td>";
			html += "<td>" +list[i].JNAME + "</td>";
			html += "<td>" +list[i].PHONE + "</td>";
			html += "</tr>";
		}
		$(".emptable tbody").html(html);
	}
}

function redrawPaging(pb){ //페이징
	var html = "<span name=\"1\">처음</span>&nbsp;";
	
	if($("#page").val()=="1"){
		html += "<span name=\"1\">이전</span>&nbsp;";
	} else {
		html += "<span name=\"" + ($("#page").val()* 1 - 1) + "\">이전</span>&nbsp;";
	}
	
	for(var i = pb.startPcount ; i <= pb.endPcount ; i++){
		if(i == $("#page").val()){
			html += "<span name=\"" + i + "\"><b>" + i + "</b></span>&nbsp;";
		} else {
			html += "<span name=\"" + i + "\">" + i + "</span>&nbsp;";
		}
	}
	if($("#page").val()==pb.maxPcount){
		html += "<span name=\"" + pb.maxPcount + "\">다음</span>&nbsp;";
	} else {
		html += "<span name=\"" + ($("#page").val()* 1 + 1) + "\">다음</span>&nbsp;";
	}
	
	html += "<span name=\"" + pb.maxPcount + "\">마지막</span>";
	
	
	$(".paging_area").html(html);
};

</script>
</head>
<body>
<!-- 탑/레프트 -->
<c:import url="/topLeft">
<%-- 현재 페이지 해당 메뉴번호 지정 --%>
   <c:param name="menuNo" value="49"></c:param>
</c:import>
<!-- 구현내용 -->

<div class="title_wrap">
   <div class="title_table">
      <div class="title_txt">조직도</div>
   </div>
</div>
<div class="contents_area">

<div class="jstreeDiv"> 
   <div class="btnDiv">
		<c:if test="${athrtyNo eq 2}">
			<input class="group_addbtn" id="group_addbtn" type="button" value="부서등록"/>
			<input class="group_delbtn" id="group_delbtn" type="button" value="부서삭제"/>
		</c:if> 
			<input class="group_infobtn" id="group_infobtn" type="button" value="사원조회"/>
	</div>
      
      <div id="jstree" class="jstree">
         <ul>
            <li>Vanilla
               <ul>
                  <li>경영관리</li>
                  <li>영업관리
                     <ul>
                        <li>영업1팀</li>
                        <li>영업2팀</li>
                     </ul>
                  </li>
                  <li>인사관리</li>
               </ul>
            </li>
            <li> 임직원 </li>
         </ul>
      </div> 
</div>

<!-- 팝업으로 사원 목록 보여주기 -->
<!-- 사원 조회 구현 -->

<div class="popup_wrap" style="display:none" > 
<div class="popup_bg"></div>
	<div class="popup">
		<div class="con">
			<div class="con_title"><div class="con_title_txt"> 사원 목록 </div></div>
			<div class="con_con"> 
				 <form action="#" method="post" id="empchartForm">
				   <input type="hidden" id="DptNo" name="DptNo" />
				   <input type="hidden" id="empNo" name="empNo" />
				   <input type="hidden" id="empname" name="empname" />
				   <input type="hidden" id="jname" name="jname"/>
				   <input type="hidden" id="phone" name="phone"  />
				   <input type="hidden" name="page" id="page" value="1" /> 
				</form>
				
					<table class="emptable">
						<colgroup>
							<col width= "150px"/>
							<col width= "150px"/>
							<col width= "150px"/>
						</colgroup>
						<thead>
							<tr>
								<th>이름</th>
								<th>직급</th>
								<th>연락처</th>
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
			</div>
		</div>
		<div class="bottom_bar">
			<div class="popup_btn"><div class="popupcloseBtn">닫기</div></div>
		</div>
	</div>
</div>

<!-- rightDiv -->
<div class="rightDiv" id="rightDiv"> 
	<!-- 조직 등록Div -->
	<div class="add_group_Div" id="add_group_Div" style="display:none">
		<form action="#" id="addGroupForm" method="post"> 
			<!-- 상위부서 : 현재 클릭하고 있는 부서 밑에 하위부서 만듬 -->
			<input type="hidden" id="topDptNo" name="topDptNo" />
			<input type="text" placeholder="Group name" id="dprtmnt_name" class="dprtmnt_name" name="dprtmnt_name"/>
			<input type="button" id="addgroupBtn" class="addgroupBtn" value="등록"/>
			<input type="button" id="cangroupBtn" class="cangroupBtn" value="취소"/>
		</form>
	</div>
	
	<!-- 조직 삭제 Div -->
	<div class="del_group_Div" id="del_group_Div" style="display:none">
		<form action="#" id="delGroupForm" method="post"> 
			<!-- 선택 , 입력칸--> 
			<input type="hidden" id="DptNo" name="DptNo" />
		</form>
		<span class="delBtnDiv">
			<input type="button" id ="delgroupBtn" class="delgroupBtn" value="삭제"/>
			<input type="button" id="delcangroupBtn" class="delcangroupBtn" value="취소"/>
		</span>
	</div>
         
</div> 
<!-- 권한 설정 등록/ 삭제 -->



</div>
<c:import url="/bottom"></c:import>
</body>
</html>