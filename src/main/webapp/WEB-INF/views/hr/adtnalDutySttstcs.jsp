<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Vanilla ERP - 추가근무통계</title>
<!-- 헤더 -->
<c:import url="/header"></c:import>
<style type="text/css">
.endmonth, .srchBtn {
	vertical-align: top;
	height:29px;
	width:75px;
	border: 1px solid lightgray;
 	margin-bottom:10px;
 	color:#515151;
 	outline-color: #d5e4f1;
	float: right;
	cursor: pointer;
	text-align: center;
	padding:0px;
}
.endmonth {
	height: 29px;
	width: 130px;
}

#stnd {
	display: inline-block;
	float: right;
	margin-right: 10px;
}

#stndWrap {
	display: table;
	height: 29px;
}

#stndCon {
	display: table-cell;
	vertical-align: middle;
	text-align: center;
	font-size: 12pt;
	height: 29px;
}
.tbl1 {
	margin-top: 60px;
}

.chart2 {
	width: 100%;
    border-collapse: collapse;
    text-align: center;
    font-size: 11pt;
}

.chart2 tr {
	height: 40px;
}

.chart_mon {
	color: white;
	font-size: 11pt;
	background-color: #004078;
	background: linear-gradient(#004B8D, #00305A);
}
.chart_con {
	color: white;
	font-size: 11pt;
	background-color: #004078;
	background: linear-gradient(#004B8D, #00305A);
	text-align: left;
	text-indent: 5px;
}

.chart_con2 {
	border: 1px solid lightgrey;
}
</style>

<!-- highcharts Script -->
<script src="resources/script/highcharts/highcharts.js"></script>
<script src="resources/script/highcharts/modules/data.js"></script>
<script src="resources/script/highcharts/modules/exporting.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	var d = new Date();
	if((d.getMonth() + 1) < 10){
	$(".endmonth").val(d.getFullYear() + "-" + "0" + (d.getMonth() + 1));
	}else {
	$(".endmonth").val(d.getFullYear() + "-" + (d.getMonth() + 1));
	}
	
	getData();

	$(".srchBtn").on("click", function(){
		getData();
	});//searchBtn end
	
	
	
	
	
	
	
});//document ready end

function getData() {
	
	var temp = $(".endmonth").val();
	temp = temp.split("-");
	
	if(temp[1] == 1 || temp[1] == 2) {
		temp[0] = temp[0] - 1;
		temp[1] = (temp[1] * 1) + 10;
		temp = temp[0] + "-" + temp[1];
		console.log(temp);
		$(".stmonth").val(temp);
	}else {
		temp[1] = temp[1] - 2;
		if(temp[1] < 10) {
			temp[1] = "0" + temp[1];
		}
		temp = temp[0] + "-" + temp[1];
		$(".stmonth").val(temp);
	}
	
	
	
	var params =  $("#actionForm").serialize();
	$.ajax({
		type : "post",
		url : "getChartAjax",
		dataType : "json",
		data : params,
		success : function(result) {
		
		var html = "";

		for(var i = 0; i < result.list.length; i++){
			html += "<tr>";
			html += "<th>" + result.list[i].MON + "</th>";
			html += "<td>" + result.list[i].DATA + "</td>";
			html += "<td>" + result.list[i].DATA2 + "</td>";
			html += "<td>" + result.list[i].DATA3 + "</td>";
			html += "</tr>";
		}
			
		$("tbody").html(html);
		
		makeChart();
		},
		error : function(request,status,error) {
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}
function makeChart() {
	$('#container').highcharts({
		  data: {
		        table: 'datatable'
		    },
		    chart: {
		        type: 'column'
		    },
		    title: {
                text: ''
            },
        colors: ['#5CB3FF', '#D462FF', '#FBB917'],
        xAxis: {
            /* labels: {
                formatter: function() {
                    return this.value; // clean, unformatted number for year
                }
            } */
        },
        yAxis: {
        	title: {
                text: ''
            },
            labels: {
                formatter: function() {
                    return this.value +'분';
                }
            }
        },
        tooltip: {
            pointFormat: '{series.name} <b>{point.y:,.0f}분</b>'
        },
        plotOptions: {
            area: {
                pointStart: 1,
                marker: {
                    enabled: false,
                    symbol: 'circle',
                    radius: 2,
                    states: {
                        hover: {
                            enabled: true
                        }
                    }
                }
            }
        },
    });
	
	/* $("tspan").each(function(){
		if($(this).html() == "Highcharts.com") {
			$(this).remove();
		}
	}); */
}
</script>
</head>
<body>
<!-- 탑/레프트 -->
<c:import url="/topLeft">
<%-- 현재 페이지 해당 메뉴번호 지정 --%>
	<c:param name="menuNo" value="40"></c:param>
</c:import>
<!-- 구현내용 -->
<div class="title_wrap">
	<div class="title_table">
		<div class="title_txt">추가근무통계</div>
	</div>
</div>
<div class="contents_area">
	<!-- 내용은 여기에 구현하세요. -->
	<form action="#" id="actionForm">
	<input type="button" value="검색" class="srchBtn">
	<input type="month" class="endmonth" name="endmonth" />
	<input type="hidden" class="stmonth" name="stmonth"/> 
	<div id="stnd"><div id="stndWrap"><div id="stndCon">기준연월 : </div></div></div>
	</form>
	<div id="container" style="min-width: 700px; height: 500px; margin: 0 auto"></div>
<table id="datatable">
        <thead>
            <tr>
                <th></th>
                <th>총 근무시간</th>
                <th>야근시간</th>
                <th>주말근무시간</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
			<div class="tbl1">
				<table class="chart2">
					<colgroup>
						<col width="15%" />
						<col width="20%" />
						<col width="20%" />
						<col width="20%" />
						<col width="20%" />
					</colgroup>
					<thead>
						<tr>
							<th class="chart_mon"></th>
							<th class="chart_mon">총 근무시간(분)</th>
							<th class="chart_mon">야근시간(분)</th>
							<th class="chart_mon">주말근무시간(분)</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
</div>
<!-- 구현끝 -->
<!-- 바텀 -->
<c:import url="/bottom"></c:import>
</body>
</html>