<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%
	if(session.getAttribute("userid") == null){
%>

	<script>
		alert('�α��� �� ����ϼ���');
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
		alert('�����Ǿ����ϴ�.');
		location.href="list.jsp";
	</script>
<%
   } else {
%>
<script>
   alert('��������');
   history.back();
</script>
<%
   }
	}
%>