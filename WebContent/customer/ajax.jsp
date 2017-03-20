
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="com.newlecture.web.data.view.NoticeView"%>
<%@page import="java.util.List"%>
<%@page import="com.newlecture.web.dao.mysql.MySQLNoticeDao"%>
<%@page import="com.newlecture.web.data.dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// .../notice.jsp?p=5 -->  ==>> .../notice.jsp?p=5&?&? (3가지가 필요!)
	String _page = request.getParameter("p");
	String _field = request.getParameter("f");
	String _query = request.getParameter("q");

	int pg = 1;
	String field = "TITLE";
	String query = "";

	if (_page != null && !_page.equals("")) //값이 넘겨진 것이 있다면 && 
		pg = Integer.parseInt(_page);

	if (_field != null && !_field.equals("")) //값이 넘겨진 것이 있다면 && 
		field = _field;

	if (_query != null && !_query.equals("")) //값이 넘겨진 것이 있다면 && 
		query = _query;

	NoticeDao noticeDao = new MySQLNoticeDao();
	List<NoticeView> list = noticeDao.getList(pg, field, query);

	int size = noticeDao.getSize(field, query);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>으갹갹갹</title>
<link href="../css/customer/style.css" type="text/css" rel="stylesheet" />
<script src="../js/customer/notice.js"> </script>

<script>
	window.addEventListener("load", function(e) {
		
		var regButton = document.querySelector("#reg-button");
		var moreButton = document.querySelector("#more-button"); 
			
		regButton.onclick = function(){

			var request = new window.XMLHttpRequest();
			request.open("GET" ,"notice-reg-partial.jsp", true); 
			//request.onreadystatechange = function(){
			request.onload = function(){
				var form = request.responseText;
				document.body.innerHTML += form;

			};
			request.send();

			return false;

			//event.preventDefault();

			//alert("hello");

			//return false;
		};

		/* var notices = [
			{code:"1", title:"오오오"},
			{code:"2", title:"요요요"},
			{code:"3", title:"유유유"}
		]; */
		
		/*var a = function(){};
		moreButton.addEventListener("click", a);
		moreButton.removeEventListener("click", a);
		moreButton.textContent = "처리중...";*/

		moreButton.onclick = function(){
			
			/* var temp = "3+4";			
			var x = eval(temp); */
			
			/* eval("var x = 5+4");
			alert(x); */
			
			//var data = eval('[{code:"1", title:"오오오1asdf"},{code:"2", title:"요요요2asdf"},{code:"3", title:"우우우3asdf"}]');
			// -> 다른 언어에선 eval이 없기 때문에 JSON을 써야한다 (JSON을 쓰려면 "" 을 다 해줘야 한다)
			//var data = JSON.parse('[{"code":"1", "title":"오오오1asdf"},{"code":"2", "title":"요요요2asdf"},{"code":"3", "title":"우우우3asdf"}]');
			
			//var data = JSON.parse();
			//alert(data[1].title);
		
			//var request = new ActiveXObject("Microsoft.XMLHTTP"); 모든 브라우져에서 실행시키기 위해서는 밑의 방법이 더 바람직하다.
			var request = new window.XMLHttpRequest();
			//request.open("GET" ,"ajax-data.jsp?p=2", false); // false 동기형
			request.open("GET" ,"ajax-data.jsp?p=2", true); // true 비동기형 // 함수 단위로 위임할 수 있다.
			//request.onreadystatechange = function(){
			request.onload = function(){
				//if(request.readyState == 4){ ==> onload로 하면 if문이 필요없다.
					var notices = JSON.parse(request.responseText);
				
					var template = document.querySelector("#notice-row");
					
					for(var i in notices){
						var tbody = document.querySelector(".notice-table tbody");
						var tds = template.content.querySelectorAll("td");

						tds[0].innerText = notices[i].code;
						tds[1].innerText = notices[i].title;
						
						var clone = document.importNode(template.content, true);
						tbody.appendChild(clone); 
					}; 
					
					document.body.removeChild(screen); 
				//}
			};	
			request.send();
			
			var screen = document.createElement("div");
			screen.style.width = "100%";
			screen.style.height = "100%";
			screen.style.position = "fixed";
			screen.style.left = "0px";
			screen.style.top = "0px";
			screen.style.background = "#000";
			screen.style.opacity = "0.5";
			
			document.body.appendChild(screen);
			
			
			/* var notices = JSON.parse(request.responseText);
			
			var template = document.querySelector("#notice-row");
			
			for(var i in notices){
				var tbody = document.querySelector(".notice-table tbody");
				var tds = template.content.querySelectorAll("td");

				tds[0].innerText = notices[i].code;
				tds[1].innerText = notices[i].title;
				
				var clone = document.importNode(template.content, true);
				tbody.appendChild(clone);  */
		};
	});
</script>



</head>
<body>
	<!-- ---------------------------------------------헤 더------------------------------------------------------------ -->
	<header id="header">
		<div class="content-container">

			<h1 id="logo">
				<img src="../images/logo.png" alt="뉴렉처 온라인">
			</h1>

			<section>
				<h1 class="hidden">header</h1>
				<!-- 스타일에는  세미콜론 써주기!-->
				<nav id="main-menu" class="hr-menu">
					<h1 class="">
						메인메뉴 <input type="button" value="클릭" id="btn-result" />
					</h1>
					<ul>
						<!-- ul,ol,dl -->
						<li><a href="">학습가이드</a></li>
						<li><a href="">뉴렉과정</a></li>
						<li><a href="">강좌선택</a></li>
					</ul>
				</nav>

				<div id="lecture-search-form">
					<h3 class="hidden">검색 폼</h3>
					<form>
						<fieldset>
							<legend class="hidden">검색 필드</legend>
							<label>과정검색</label> <input type="text" /> <input
								class="lecture-search-btn" type="submit" value="검색" />
						</fieldset>
					</form>
				</div>

				<nav id="account-menu" class="hr-menu">
					<h1 class="hidden">계정메뉴</h1>
					<ul>
						<li><a href="../index.html">HOME</a></li>
						<li><a href="../account/login.html">로그인</a></li>
						<li><a href="../join.html">회원가입</a></li>
					</ul>
				</nav>

				<nav id="member-menu" class="hr-menu">
					<h1 class="hidden">회원메뉴</h1>
					<ul>
						<li><input type="button" value="마이페이지" /></li>
						<li><input type="button" value="고객 센터" /></li>
					</ul>
				</nav>

			</section>
		</div>
	</header>
	<!-- ---------------------------------------------비주얼------------------------------------------------------------ -->
	<div id="visual">
		<!-- 비ㅇ주얼 영역 -->
		<div class="content-container"></div>
	</div>


	<!-- -----------------------------------------------바디---------------------------------------------------------- -->
	<div id="body">
		<!-- 섹션과 메인을 div로 묶어줌 -->
		<div class="content-container clearfix">
			<aside id="aside">
				<!-- div를 시맨틱하게 태그로 표현 (nav, article, aside) -->
				<!-- 	Section 내에서 헤더 푸터 따로 사용 가능. 메인은 사용 불가능 (문서 내 메인은 단 하나만 존재해야함 ) -->
				<h1 class="aside-title aside-main-title aside-margin">고객센터</h1>
				<nav>
					<h1 class="hidden">고객센터 메뉴</h1>

					<ul>
						<li class="aside-menu-item"><a class="aside-menu-item-link"
							href="">공지사항</a></li>
						<li class="aside-menu-item"><a class="aside-menu-item-link"
							href="">1:1고객문의</a></li>
						<li class="aside-menu-item"><a class="aside-menu-item-link"
							href="">학습안내</a></li>
					</ul>

				</nav>

				<nav>
					<div>
						<h1 class="aside-title margin">추천사이트</h1>
						<ul class="margin">
							<li><a href=""><img src="../images/answeris.png"
									alt="answeris"></a></li>
							<li><a href=""><img src="../images/w3c.png" alt="w3c"></a></li>
							<li><a href=""><img src="../images/microsoft.png"
									alt="마이크로소프트"></a></li>
						</ul>
					</div>
				</nav>
			</aside>


			<main id="main"> <!-- <section id="quick-menu">
					<h2>퀵메뉴</h2>
				</section> -->
			<h2 class="main-title">
				공지사항[<%=size%>]
			</h2>
			<div class="breadcrumb">
				<h3 class="hidden">breadcrumb</h3>
				<ul>
					<li>home</li>
					<li>고객센터</li>
					<li>공지사항</li>
				</ul>
			</div>

			<div>
				<h3 class="hidden">과정 검색 폼</h3>
				<form class="main-margin">
					<fieldset>
						<legend class="hidden">검색필드</legend>
						<label class="hidden">검색분류</label> <select name="f">
							<option value="TITLE" <%if (field.equals("TITLE")) {%> selected
								<%}%>>제목</option>
							<option value="CONTENT" <%if (field.equals("CONTENT")) {%>
								selected <%}%>>내용</option>
						</select> <label class="hidden">검색어</label> <input name="q" type="text"
							value="<%=query%>" placeholder="검색어를 입력하세요" /> <input
							class="btn btn-search" type="submit" value="검색" /> <input
							type="hidden" name="p" value="1" />
					</fieldset>
				</form>

			</div>

			<div class="notice">
				<h3 class="hidden">공지목록</h3>

				<table class="table notice-table">
					<thead>
						<tr>
							<td>번호</td>
							<td>제목</td>
							<td>작성자</td>
							<td>작성일</td>
							<td>조회수</td>
						</tr>
					</thead>

					<tbody>
						<template id="notice-row">
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						</template>
						<%
							for (NoticeView v : list) {
						%>
						<tr>
							<td><%=v.getCode()%></td>
							<td><%=v.getTitle()%></td>
							<td><%=v.getWriter()%></td>
							<td><%=v.getRegDate()%></td>
							<td><%=v.getHit()%></td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
			</div>
			<%
				int last = (size % 10) > 0 ? size / 10 + 1 : size / 10;
			%>
			<div class="margin"><%=pg%>/<%=last%>
				pages
			</div>
			<!-- 제목도, 목록도, 문장도, 폼도, 표도 아니면 모두 div -->
			<div class="margin">
				<div>
					<a href="">이전</a>
				</div>
				<ul>
					<%
						for (int i = 0; i < last; i++) {
					%>
					<li><a href="?p=<%=i + 1%>&f=<%=field%>&q=<%=query%>"><%=i + 1%></a></li>
					<%
						}
					%>
					<%-- 
					<li><a href="?p=2&f=<%=field %>&q=<%=query %>">2</a></li>
					<li><a href="?p=3&f=<%=field %>&q=<%=query %>">3</a></li>
					<li><a href="?p=4&f=<%=field %>&q=<%=query %>">4</a></li>
					<li><a href="?p=5&f=<%=field %>&q=<%=query %>">5</a></li>
					 --%>
				</ul>
				<div>
					<a href="">다음</a>
				</div>
			</div>

			<div>
				<a id="reg-button" href="notice-reg.jsp">글쓰기</a> 
				<span id="more-button">더보기</span>
			</div>
			</main>
		</div>
	</div>

	<!-- -----------------------------------------------푸터---------------------------------------------------------- -->
	<footer id="footer">
		<div class="content-container">

			<h2>회사정보</h2>
			푸터당
			<div>주소서울특별시 마포구 토정로35길 11, 인우빌딩 5층
				266호관리자메일admin@newlecture.com사업자 등록번호132-18-46763 통신 판매업 신고제
				2013-서울강동-0969 호 상호뉴렉처대표박용우전화번호070-4206-4084 [죄송합니다. 당분간 문의내용은 고개센터
				메뉴에서 1:1 문의를 이용해주시기 바랍니다] Copyright ⓒ newlecture.com 2012-2014 All
				Right Reserved. Contact admin@newlecture.com for more information</div>
		</div>
	</footer>

</body>
</html>