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
</head>
<body>
<!-- 탑/레프트 -->
<c:import url="/topLeft">
<%-- 현재 페이지 해당 메뉴번호 지정 --%>
	<c:param name="menuNo" value="4"></c:param>
</c:import>
<!-- 구현내용 -->
<div class="title_wrap">
	<div class="title_table">
		<div class="title_txt">현재 페이지의 타이틀</div>
	</div>
</div>
<div class="contents_area">
	<!-- 내용은 여기에 구현하세요. -->
<<<<<<< HEAD
			
	
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
=======









>>>>>>> refs/heads/kimgyeonggoo
</div>
<!-- 구현끝 -->
<!-- 바텀 -->
<c:import url="/bottom"></c:import>
</body>
</html>