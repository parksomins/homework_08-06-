<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
   request.setCharacterEncoding("UTF-8");
   if(session.getAttribute("userid") == null){
      
%>
<script>
   alert('로그인 후 이용하세요.');
   location.href = '../login.jsp';
</script>
<%
   } else { 

%>
<jsp:useBean id="reply" class="com.koreait.reply.ReplyDTO"/>
<jsp:useBean id="r_dao" class="com.koreait.reply.ReplyDAO"/>

<%
		reply.setIdx(Integer.parseInt(String.valueOf(request.getParameter("b_idx"))));
		reply.setContent(request.getParameter("re_content"));
		reply.setUserid((String)session.getAttribute("userid"));
		if(r_dao.reply(reply) == 0){
%>
<script>
	alert('등록실패했습니다.');
	history.back();
	
</script>
<%
	}else{
%>

<script>
   alert('댓글이 등록되었습니다.');
   location.href='view.jsp?b_idx=<%=reply.getIdx()%>';
</script>
          
<% 
		}
      }
%>
