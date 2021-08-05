<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%
	if(session.getAttribute("userid") == null){
%>

	<script>
		alert('로그인 후 사용하세요');
		location.href="../login.jsp";
		
	</script>
<%
	}else{

%>
<jsp:useBean id="board" class="com.koreait.board.BoardDTO"/>
<jsp:setProperty property="idx" param="b_idx" name="board"/>
<jsp:useBean id="dao" class="com.koreait.board.BoardDAO"/>
<%
   board.setUserid((String) session.getAttribute("userid"));
      if (dao.delete(board) == 1) {
%>
	<script>
		alert('삭제되었습니다.');
		location.href="list.jsp";
	</script>
<%
   } else {
%>
<script>
   alert('삭제실패');
   history.back();
</script>
<%
   }
	}
%>