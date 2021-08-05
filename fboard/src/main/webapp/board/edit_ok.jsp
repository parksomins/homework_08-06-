<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<jsp:useBean id="board" class="com.koreait.board.BoardDTO"/>
	<jsp:setProperty property="title" param="b_title" name="board"/>
	<jsp:setProperty property="content" param="b_content" name="board"/>
	<jsp:setProperty property="file" param="b_file" name="board"/>
	<jsp:setProperty property="idx" param="b_idx" name="board"/>
	<jsp:useBean id="dao" class="com.koreait.board.BoardDAO"/>
<%
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("userid") == null){
%>
	<script>
		alert('로그인 후 이용하세요');
		location.href='../login.jsp';
	</script>
<%
	}else{
		try{
			String uploadPath = request.getRealPath("upload");// 물리적인 실제 경로임. (이클립스에서만.)
            System.out.println(uploadPath);
            int size = 1024*1024*10;
            MultipartRequest  multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy()); 
            board.setIdx(Integer.parseInt(String.valueOf(request.getParameter("b_idx"))));
			board.setTitle((String)multi.getParameter("b_title"));
			board.setFile((String)multi.getParameter("b_file"));
			board.setContent((String)multi.getParameter("b_content"));
			if(dao.edit2(board)==1){
%>
			<script>
				alert('수정되었습니다');
				location.href='view.jsp?b_idx=<%=board.getIdx()%>';
			</script>
<%
			}else{
%>
			<script>
				alert('수정 실패');
				history.back();
			</script>
<%
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
%>