package com.koreait.db;

import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlMapConfig {
	private static SqlSessionFactory sqlsession;
	//제일 처음 객체 만들 때만 실행됨 (한번만 실행)
	static {
		try {
			String resource = "com/koreait/db/config.xml";
			Reader reader = Resources.getResourceAsReader(resource);
			sqlsession = new SqlSessionFactoryBuilder().build(reader);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static SqlSessionFactory getSqlMapInstance() {
		return sqlsession;
	}
	
}
