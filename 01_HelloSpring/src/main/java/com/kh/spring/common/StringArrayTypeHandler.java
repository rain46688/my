package com.kh.spring.common;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;

public class StringArrayTypeHandler implements TypeHandler<String[]> {

	@Override
	public void setParameter(PreparedStatement ps, int i, String[] parameter, JdbcType jdbcType) throws SQLException {
		// TODO Auto-generated method stub
		// demo-mapper.xml에서 값을넣을때 이 메소드가 실행됨 그거를 재정의해서 임맛대로 바꾸는것
		System.out.println(" === setParameter 실행 === ");
		if (parameter != null) {
			String param = String.join(",", parameter);
			ps.setString(i, param);
		} else {
			ps.setString(i, "");
			// 아무것도 선택안하면 빈값을 넣음
		}

	}

	@Override
	public String[] getResult(ResultSet rs, String columnName) throws SQLException {
		// TODO Auto-generated method stub
		String[] result = rs.getString(columnName).split(",");
		return result;
	}

	@Override
	public String[] getResult(ResultSet rs, int columnIndex) throws SQLException {
		// TODO Auto-generated method stub
		return rs.getString(columnIndex).split(",");
	}

	@Override
	public String[] getResult(CallableStatement cs, int columnIndex) throws SQLException {
		// TODO Auto-generated method stub
		return cs.getString(columnIndex).split(",");
	}

}
