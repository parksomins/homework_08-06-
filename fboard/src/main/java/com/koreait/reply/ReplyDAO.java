package com.koreait.reply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.koreait.db.Dbconn;
import com.koreait.db.SqlMapConfig;

public class ReplyDAO {
	   Connection conn;
	   PreparedStatement pstmt;
	   ResultSet rs;
	   String sql = "";
	   
	   SqlSessionFactory ssf = SqlMapConfig.getSqlMapInstance();
	   SqlSession sqlsession;
	   
	   public ReplyDAO() {
		      sqlsession = ssf.openSession(true);
		      System.out.println("마이바티스성공");
	   }
	   
	   public int reply(ReplyDTO reply) {
		   HashMap<String, String> datamap = new HashMap();
		   datamap.put("re_userid", reply.getUserid());
		   datamap.put("re_content", reply.getContent());
		   datamap.put("re_boardidx", String.valueOf(reply.getBoardidx()));
		   return sqlsession.insert("Reply.reply", datamap);
		   
	   }
	   
	   public int re_delete(ReplyDTO reply) {
			HashMap<String, String> dataMap = new HashMap();
			dataMap.put("re_idx", String.valueOf(reply.getIdx()));
			return sqlsession.delete("Reply.re_delete",dataMap);
		}
	   
	   public ArrayList<ReplyDTO> selectReply(ReplyDTO reply){
	          ArrayList<ReplyDTO> list = new ArrayList();
	         try {
	            conn = Dbconn.getConnection();
	            sql = "select re_idx, re_userid, re_content, re_regdate from tb_reply where re_boardidx=? order by re_idx desc";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setInt(1, reply.getIdx());
	            rs = pstmt.executeQuery();
	            while(rs.next()) {
	               ReplyDTO reply1 = new ReplyDTO();
	               reply1.setIdx(rs.getInt("re_idx"));
	               reply1.setUserid(rs.getString("re_userid"));
	               reply1.setContent(rs.getString("re_content"));
	               reply1.setRegdate(rs.getString("re_regdate"));
	               list.add(reply1);
	            }
	            return list;
	         }catch(Exception e) {
	            e.printStackTrace();
	         }
	         return null;
	      }
	   
	   public int replyNum(int idx) {
		   	try {
		   		  conn = Dbconn.getConnection();
		   		  if(conn != null) {
			   	  sql = "select count(re_idx) as replycnt from tb_reply where re_boardidx=" + idx;
			      pstmt = conn.prepareStatement(sql);
			      rs = pstmt.executeQuery();
			      int replycnt = 0;
			      if(rs.next()) {
			    	  replycnt = rs.getInt("replycnt");
			      }
			      return replycnt;
		   		  }   
		   	}catch(Exception e) {
		   		e.printStackTrace();
		   	}
		   	return 0;
	   }
}