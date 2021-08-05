
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("UTF-8");
   if (session.getAttribute("userid") == null) {
%>
<script>
   alert('로그인 후 이용하세요');
   location.href = '../login.jsp';
</script>
<%
   } else {
%>
<jsp:useBean id="board" class="com.koreait.board.BoardDTO"/>
<jsp:setProperty property="title" param="b_title" name="board"/>
<jsp:setProperty property="file" param="b_file" name="board"/>
<jsp:setProperty property="content" param="b_content" name="board"/>
<jsp:useBean id="dao" class="com.koreait.board.BoardDAO"/>
<%
   board.setUserid((String) session.getAttribute("userid"));
      if (dao.write(board) == 1) {
%>
<script>
   alert('등록되었습니다.');
   location.href = 'list.jsp';
</script>

<%
   } else {
%>
<script>
   alert('등록실패');
   history.back();
</script>


<%
}
   }
%>