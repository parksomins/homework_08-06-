package com.koreait.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.koreait.db.Dbconn;
import com.koreait.db.SqlMapConfig;

public class BoardDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	   SqlSessionFactory ssf = SqlMapConfig.getSqlMapInstance();
	   SqlSession sqlsession;
	   
	   public BoardDAO() {
		      sqlsession = ssf.openSession(true);
		      System.out.println("마이바티스성공");
	   }
	   
	   public int write(BoardDTO board) {
		   HashMap<String, String> datamap = new HashMap();
		   datamap.put("b_userid", board.getUserid());
		   datamap.put("b_title", board.getTitle());
		   datamap.put("b_content", board.getContent());
		   datamap.put("b_file", board.getFile());
		   return sqlsession.insert("Board.write", datamap);
		   
	   }
	   
	   public int delete(BoardDTO board) {
		   HashMap<String, String> datamap = new HashMap();
		   datamap.put("b_idx", String.valueOf(board.getIdx()));
		   return (Integer.parseInt(String.valueOf(sqlsession.delete("Board.delete", datamap))));
	   }
	   
	   public BoardDTO edit(BoardDTO board) {
		   HashMap<String, String> datamap = new HashMap();
		   datamap.put("b_idx", String.valueOf(board.getIdx()));
		   datamap = sqlsession.selectOne("Board.edit", datamap);
		   
		   if(datamap != null) {
			   board.setTitle(datamap.get("b_title"));
			   board.setContent(datamap.get("b_content"));
			   board.setFile(datamap.get("b_file"));
			   return board;
			   
		   }
		   return null;
	   }
	   
	   public int edit2(BoardDTO board) {
		   HashMap<String, String> datamap = new HashMap();
		   if(board.getFile() != null && !board.getFile().equals("")){
		   datamap.put("b_idx", String.valueOf(board.getIdx()));
		   datamap.put("b_userid", board.getUserid());
		   datamap.put("b_title", board.getTitle());
		   datamap.put("b_content", board.getContent());
		   datamap.put("b_file", board.getFile());
		   return sqlsession.update("Board.edit2_1", datamap);
		   }else {
			   datamap.put("b_idx", String.valueOf(board.getIdx()));
			   datamap.put("b_userid", board.getUserid());
			   datamap.put("b_title", board.getTitle());
			   datamap.put("b_content", board.getContent());
			   return sqlsession.update("Board.edit2_2", datamap);
	   }
		   
		   }
	   
	   public BoardDTO like(BoardDTO board) {
		   int b_like = 0;
		   HashMap<String, String> datamap = new HashMap();
		   datamap.put("b_idx", String.valueOf(board.getIdx()));
		   sqlsession.update("Board.like_ok", datamap);
		   datamap = sqlsession.selectOne("Board.like", datamap);
		   if(datamap != null) {
			   board.setLike(Integer.parseInt(String.valueOf(datamap.get("b_like"))));
		   }
		   return board;
		     
	   }
	   
	   public BoardDTO view(BoardDTO board) {
		   HashMap<String, String> datamap = new HashMap();
		   HashMap<String, String> datamap2 = new HashMap();
		   datamap.put("b_idx", String.valueOf(board.getIdx()));
		   datamap = sqlsession.selectOne("Board.view", datamap);
		   datamap2.put("b_idx", String.valueOf(board.getIdx()));
		   datamap2 = sqlsession.selectOne("Board.view_ok", datamap2);
		   if(datamap2 != null){
				board.setUserid(datamap2.get("b_userid"));
				board.setTitle(datamap2.get("b_title"));
				board.setContent(datamap2.get("b_content"));
				board.setRegdate(String.valueOf(datamap2.get("b_regdate")).substring(0,10));
				board.setLike(Integer.parseInt(String.valueOf(datamap2.get("b_like"))));
				board.setHit(Integer.parseInt(String.valueOf(datamap2.get("b_hit"))));
				board.setFile(datamap2.get("b_file"));
			}
		   return board;
	   }
	   public List<BoardDTO> reply_view(BoardDTO board1) {//매개변수를 int로 해주면 pstmt를 안 써줘도 ?안에 바로 값이 들어간다.
		   	ArrayList<BoardDTO> list = new ArrayList();
		      
		         try {
		            sql = "select re_idx, re_userid, re_content, re_regdate from tb_reply where re_boardidx=? order by re_idx desc";
		            pstmt = conn.prepareStatement(sql);
		            pstmt.setInt(1, board1.getIdx());
		            rs = pstmt.executeQuery();
		            
		            while(rs.next()){
		               BoardDTO board = new BoardDTO();
		               board.setIdx(rs.getInt("re_idx"));
		               board.setUserid(rs.getString("re_userid"));
		               board.setContent(rs.getString("re_content"));
		               board.setRegdate(rs.getString("re_regdate"));
		               list.add(board);
		               
		            }
		      }catch(Exception e) {
		         e.printStackTrace();
		      }
		         return list;
		   }
	   public int totalCount() { //전체 게시글 가져오는 메소드    //매개변수 값을 안 받아와도 되니까 ()에 아무것도 안 넣어줘도 됨. 왜냐햐면 totalCount를 새로 받아야 하니까
	       return (Integer.parseInt(String.valueOf(sqlsession.selectOne("Board.totalCount"))));            
		   }
		   
		   public ArrayList<BoardDTO> pageNum(int start, int pagePerCount){
		      try{
		         ArrayList<BoardDTO> boardList = new ArrayList();
		         conn = Dbconn.getConnection();
		         if(conn != null) {
		         sql = "select b_idx, b_userid, b_title, b_regdate, b_hit, b_like, b_file from tb_board order by b_idx desc limit ?, ?";
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setInt(1, start);
		         pstmt.setInt(2, pagePerCount);
		         rs = pstmt.executeQuery();
		         
		         while(rs.next()){
		            BoardDTO boarddto = new BoardDTO();
		            boarddto.setIdx(rs.getInt("b_idx"));
		            boarddto.setUserid(rs.getString("b_userid"));
		            boarddto.setTitle(rs.getString("b_title"));
		            boarddto.setRegdate(rs.getString("b_regdate").substring(0, 10));
		            boarddto.setHit(rs.getInt("b_hit"));
		            boarddto.setLike(rs.getInt("b_like"));
		            boarddto.setFile(rs.getString("b_file"));
		            boardList.add(boarddto);
		            
		         }
		         return boardList;
		         }
		         
		      }catch(Exception e){
		         e.printStackTrace();
		      }
		      return null;
		   }
		   
	   
}
