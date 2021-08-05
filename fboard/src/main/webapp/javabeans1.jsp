<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.koreait.member.MemberDTO" %>
<%
	MemberDTO memberDTO = new MemberDTO();
	memberDTO.setUserid("apple");
	memberDTO.setUserpw("1234");
	memberDTO.setUsername("김사과");

%>
<jsp:useBean id="member" class="com.koreait.member.MemberDTO" scope="page"/>
<jsp:setProperty property="userid" name="member" value="banana"/>
<jsp:setProperty property="userpw" name="member" value="1111"/>
<jsp:setProperty property="username" name="member" value="반하나"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h2>자바빈즈 테스트 - 1</h2>
	<hr/>
	<p>memberDTO의 아이디 : <%=memberDTO.getUserid() %></p>
	<p>memberDTO의 비밀번호 : <%=memberDTO.getUserpw() %></p>
	<p>memberDTO의 이름 : <%=memberDTO.getUsername() %></p>
	<p><jsp:getProperty property="userid" name="member"/></p>
<p><jsp:getProperty property="userpw" name="member"/></p>
<p><jsp:getProperty property="username" name="member"/></p>
</body>
</html>