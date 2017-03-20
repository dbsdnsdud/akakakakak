<%@page import="com.newlecture.web.dao.mysql.MySQLNoticeDao"%>
<%@page import="com.newlecture.web.data.dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	String code = request.getParameter("code");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	NoticeDao noticeDao = new MySQLNoticeDao();
	int result = noticeDao.update(title, content, code);
	
	if(result > 0)
		// 목록으로 가기 (입력도구, 출력도구, 저장소)
		response.sendRedirect("notice-detail.jsp?c="+code);
	//else
		// 에러 페이지로 가기1
%>    
    