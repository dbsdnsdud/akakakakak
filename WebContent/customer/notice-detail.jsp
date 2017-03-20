<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="com.newlecture.web.data.view.NoticeView"%>
<%@page import="java.util.List"%>
<%@page import="com.newlecture.web.dao.mysql.MySQLNoticeDao"%>
<%@page import="com.newlecture.web.data.dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	String code = request.getParameter("c");

	NoticeDao noticeDao = new MySQLNoticeDao();
	NoticeView n = noticeDao.get(code);
	NoticeView prev = noticeDao.getPrev(code);
	NoticeView next = noticeDao.getNext(code);
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>으갹갹갹</title>
<link href="../css/customer/style.css" type="text/css" rel="stylesheet"/>
<script src="../js/customer/notice.js"> </script>

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
					<h1 class="">메인메뉴
						<input type="button" value="클릭" id="btn-result" />
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
				<h2 class="main-title">공지사항 내용</h2>
				<div class="breadcrumb">
					<h3 class="hidden">breadcrumb</h3>
					<ul>
						<li>home</li>
						<li>고객센터</li>
						<li>공지사항</li>
					</ul>
				</div>
				
				
				<table border="1">
					<tbody>
						<tr>
							<th>제목</th>
							<td><%=n.getTitle()%></td>
						</tr>
						<tr>
							<th>작성자</th>
							<td><%=n.getWriter()%></td>
						</tr>
						<tr>
							<th>작성일</th>
							<td><%=n.getRegDate()%></td>
						</tr>
						<tr>
							<th>조회수</th>
							<td><%=n.getHit()%></td>
						</tr>
						<tr>
							<td colspan="2">
								<%=n.getContent()%>
							</td>
						</tr>
					</tbody>
				</table>
				<div>
					<a href="notice.jsp">목록</a>
					<a href="notice-edit.jsp?c=<%=n.getCode() %>">수정</a>
					<a href="notice-del-proc.jsp?c=<%=n.getCode() %>">삭제</a>
				</div>
				
				<div>
					<ul>
						<li>
							<span>다음글:</span>
							<%if(next == null){ %>
							<span>다음글이 존재하지 않습니다.</span>
							<%}else{ %>
							<a href="?c=<%=next.getCode()%>"><%=next.getTitle()%></a>
							<% } %>
						</li>
						<li>
							<span>이전글:</span>
							<a href="?c=<%=prev.getCode()%>"><%=prev.getTitle()%></a>
						</li>
					</ul>
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