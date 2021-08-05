<%@page import="com.koreait.board.BoardDTO"%>
<%@page import="com.koreait.reply.ReplyDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import= "java.util.ArrayList" %>
<%@ page import="com.koreait.db.Dbconn"%>
<jsp:useBean id="board" class="com.koreait.board.BoardDTO"/>
<jsp:useBean id="dao" class="com.koreait.board.BoardDAO"/>
<jsp:setProperty property="title" param="b_title" name="board"/>
<jsp:setProperty property="content" param="b_content" name="board"/>
<jsp:setProperty property="file" param="b_file" name="board"/>
<jsp:setProperty property="regdate" param="b_regdate" name="board"/>
<jsp:setProperty property="hit" param="b_hit" name="board"/>
<jsp:setProperty property="like" param="b_like" name="board"/>
<jsp:useBean id="reply" class="com.koreait.reply.ReplyDTO"/>
<jsp:useBean id="re_dao" class="com.koreait.reply.ReplyDAO"/>
<%
   if(session.getAttribute("userid") == null){
%>
   <script>
      alert('로그인 후 이용하세요');
      location.href='../login.jsp';
   </script>
<%
   }else{

   board.setIdx(Integer.parseInt(String.valueOf(request.getParameter("b_idx"))));
   reply.setBoardidx(board.getIdx());
   if(dao.view(board)!=null){
      
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글보기</title>
<script>
   function like(){
      const xhr = new XMLHttpRequest();
      xhr.onreadystatechange = function(){
         if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200){
            document.getElementById('like').innerHTML = xhr.responseText;
         }
      }
      xhr.open('GET', './like_ok.jsp?b_idx=<%=board.getIdx()%>', true);
      xhr.send();
   }
</script>
</head>
<body>
   <h2>글보기</h2>
   
   <table border="1" width="800">
      <tr>
         <td>제목</td><td><%=board.getTitle()%></td>
      </tr>
      <tr>
         <td>날짜</td><td><%=board.getRegdate()%></td>
      </tr>
      <tr>
         <td>작성자</td><td><%=board.getUserid()%></td>
      </tr>
      <tr>
         <td>조회수</td><td><%=board.getHit()%></td>
      </tr>
      <tr>
         <td>좋아요</td><td><span id="like"><%=board.getLike()%></span></td>
      </tr>
      <tr>
         <td>내용</td><td><%=board.getContent()%></td>
      </tr>
      <tr>
         <td>파일</td>
         <td>
            <%
               if(board.getFile() != null && !board.getFile().equals("")){
                  out.println("첨부파일");
                  out.println("<img src='../upload/"+board.getFile()+"' alt='첨부파일' width='150'>");
               }
            %>
         </td>
      </tr>
      <tr>
         <td colspan="2">
<%
   if(board.getUserid().equals((String)session.getAttribute("userid"))){
%>
      <input type="button" value="수정" onclick="location.href='./edit.jsp?b_idx=<%=board.getIdx()%>'"> 
      <input type="button" value="삭제" onclick="location.href='./delete.jsp?b_idx=<%=board.getIdx()%>'">
<%
   }   
%>      
         <input type="button" value="좋아요" onclick="like()">
         <input type="button" value="리스트" onclick="location.href='./list.jsp'">
         </td>
      </tr>
   </table>
   <hr/>
<form method="post" action="reply_ok.jsp">
      <input type="hidden" name="b_idx" value="<%=board.getIdx()%>">
      <p><%=session.getAttribute("userid")%> : <input type="text" size="40" name="re_content"> <input type="submit" value="확인"></p>
   </form>
   <hr/>
      <% ArrayList<ReplyDTO> list = re_dao.selectReply(reply);  //board를 해주는 이유가 BoardDTO에 들어있는 맘대로 사용하기 위해서 써준다(get/set같은)
         for(int i=0; i<list.size(); i++){
            
      %>
      <p><%=list.get(i).getUserid()%> : <%=list.get(i).getContent()%> ( <%=list.get(i).getRegdate()%> ) 

<%
        if(list.get(i).getUserid().equals((String)session.getAttribute("userid"))){
%>
            <input type="button" value="삭제" onclick="location.href='reply_del.jsp?re_idx=<%=list.get(i).getIdx()%>'">
<% 
        }
      }
      
   }
%>
</body>
</html>
<%    
   }
%>