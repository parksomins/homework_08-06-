<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.koreait.member.MemberDTO" %>
<%
	MemberDTO memberDTO = new MemberDTO();
	memberDTO.setUserid("apple");
	memberDTO.setUserpw("1234");
	memberDTO.setUsername("����");

%>
<jsp:useBean id="member" class="com.koreait.member.MemberDTO" scope="page"/>
<jsp:setProperty property="userid" name="member" value="banana"/>
<jsp:setProperty property="userpw" name="member" value="1111"/>
<jsp:setProperty property="username" name="member" value="���ϳ�"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h2>�ڹٺ��� �׽�Ʈ - 1</h2>
	<hr/>
	<p>memberDTO�� ���̵� : <%=memberDTO.getUserid() %></p>
	<p>memberDTO�� ��й�ȣ : <%=memberDTO.getUserpw() %></p>
	<p>memberDTO�� �̸� : <%=memberDTO.getUsername() %></p>
	<p><jsp:getProperty property="userid" name="member"/></p>
<p><jsp:getProperty property="userpw" name="member"/></p>
<p><jsp:getProperty property="username" name="member"/></p>
</body>
</html>