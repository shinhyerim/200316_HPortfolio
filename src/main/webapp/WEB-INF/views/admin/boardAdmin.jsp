<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Board List</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="resources/js/bootstrap.bundle.js"></script>
<link rel="stylesheet" href="resources/css/bootstrap.css">
<link rel="stylesheet" href="resources/css/custom.css">
<link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
<script>
//검색
$(document).on('click', '#btnSearch', function(e){
	e.preventDefault();
	var url = "boardAdmin.le";
		url = url + "?searchType=" + $('#searchType').val();
		url = url + "&keyword=" + $('#keyword').val();
	
	location.href = url;
});	
// ------------------  Pagination 처리 -------------------------
// 이전 버튼 이벤트
function fn_prev(page, range, rangeSize, searchType, keyword){
	var page = ((range - 2) * rangeSize) + 1;
	var range = range - 1;	
	var url = "boardAdmin.le";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&searchType=" + $('#searchType').val();
		url = url + "&keyword" + keyword;
		
	location.href = url;
}
	
// 페이지 번호 클릭
function fn_pagination(page, range, rangeSize, searchType, keyword){
	var url = "boardAdmin.le";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&searchType=" + $('#searchType').val();
		url = url + "&keyword" + keyword;
		
	location.href = url;
}
	
// 다음 버튼 이벤트
function fn_next(page, range, rangeSize, searchType, keyword){
	var page = parseInt((range * rangeSize)) + 1;
	var range = parseInt(range) + 1;
	var url = "boardAdmin.le";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&searchType=" + $('#searchType').val();
		url = url + "&keyword" + keyword;
		
	location.href = url;
}
</script>
</head>
<body>
<%@include file ="../common/header.jsp" %>
	
<section class="container">
	<!-- 검색창 -->
	<div class="form-inline mt-3">
		<select class="form-control mx-1 mt-2" name="searchType" id="searchType">
			<option value="title"<c:out value="${pagination.searchType eq 'title' ? 'selected' : '' }"/>>제목</option>
			<option value="content"<c:out value="${pagination.searchType eq 'content' ? 'selected' : '' }"/>>내용</option>
			<option value="reg_id"<c:out value="${pagination.searchType eq 'reg_id' ? 'selected' : '' }"/>>작성자</option>
		</select>
		<input type="text" class="form-control mx-1 mt-2" name="keyword" id="keyword" placeholder="내용을 입력하세요.">
		<button class="btn btn-primary mx-1 mt-2" name="btnSearch" id="btnSearch">검색</button>
		<a class="btn btn-primary mx-1 mt-2" href="boardWrite.le">글작성</a>
	</div>
	<!-- 게시글 목록  -->
	<div class="form-group mt-4">
		<div class="row">
			<table class="table" style="text-align:center; border:1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align:center;">번호</th>
						<th style="background-color: #eeeeee; text-align:center;">제목</th>
						<th style="background-color: #eeeeee; text-align:center;">작성자</th>
						<th style="background-color: #eeeeee; text-align:center;">조회수</th>
						<th style="background-color: #eeeeee; text-align:center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${list == null}">
						<p> 작성된 글이 없습니다.</p>
					</c:if>
					<c:if test="${list != null}">
						<c:forEach items="${list}" var="list">
							<tr>
								<td>${list.rownum}</td>
								<td><a href="boardView.le?boardID=${list.boardID}" style="text-decoration:none;">${list.boardTitle}</a></td>
								<td>${list.userID}</td>
								<td>${list.hit}</td>
								<td>${list.boardRegdate}</td>
							</tr> 
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
	<!-- Pagination -->
	<div id="paginationBox">
		<ul class="pagination">
			<c:if test="${pagination.prev}">
				<li class="page-item"><a class="page-link" href="#" onClick="fn_prev('${pagination.page}','${pagination.range}','${pagination.rangeSize}','${search.searchType}','${search.keyword}')">이전</a></li>
			</c:if>
			<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
				<li class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> ">
					<a class="page-link" href="#" onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}','${search.searchType}','${search.keyword}')"> ${idx}</a>
				</li>
			</c:forEach>
			<c:if test="${pagination.next}">
				<li class="page-item"><a class="page-link" href="#" onClick="fn_next('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}','${search.searchType}','${search.keyword}')" >다음</a></li>
			</c:if>
		</ul>
	</div>
</section>
	
<%@include file ="../common/footer.jsp" %>
</body>
</html>