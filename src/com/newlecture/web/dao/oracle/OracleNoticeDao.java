package com.newlecture.web.dao.oracle;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.newlecture.web.data.dao.NoticeDao;
import com.newlecture.web.data.entity.Member;
import com.newlecture.web.data.entity.Notice;
import com.newlecture.web.data.view.NoticeView;

public class OracleNoticeDao implements NoticeDao{

	@Override
	public List<NoticeView> getList() {
		return getList(1, "TITLE", "");
	}

	@Override
	public List<NoticeView> getList(int page) {
		return getList(page, "TITLE", "");
	}

	@Override
	public List<NoticeView> getList(int page, String field, String query) {
		String sql = "SELECT * FROM NOTICE WHERE MID LIKE '%" + query + "%'";
		List<NoticeView> list = new ArrayList<>();
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			String url = "jdbc:oracle:thin:@211.238.142.251:1521:orcl"; // DB연결
			Connection con = DriverManager.getConnection(url, "c##sist", "dclass"); // 드라이브 로드
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(sql);
			
			NoticeView noticeView = null;

			while (rs.next()) {
				noticeView = new NoticeView();
				noticeView.setCode(rs.getString("CODE"));
				noticeView.setTitle(rs.getString("TITLE"));

				list.add(noticeView);
			}

			rs.close();
			st.close();
			con.close();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int getSize() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getSize(String field, String query) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int add(Notice notice) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int add(String title, String content, String writer) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(Notice notice) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(String title, String content, String code) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String code) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public NoticeView get(String code) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public NoticeView getPrev(String code) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public NoticeView getNext(String code) {
		// TODO Auto-generated method stub
		return null;
	}

}
