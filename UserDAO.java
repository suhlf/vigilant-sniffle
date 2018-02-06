package user;
//데이터 베이스 접근 객체 약자 데이터베이스에 회원정보를 넣거나등 하는것

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;



public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO(){
		try {
			String dbURL = "jdbc:mysql://localhost:33060/BBS";
			String dbID = "root";
			String dbPassword = "1323!021dldud";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}//db연결
	public int login(String userID,String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword))
					return 1; //로그인 성공
				else
					return 0; //비밀번호 불일치
			}
			return -1;//아이디가 없음
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; //데이터 베이스 오류
	}
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES(?,?,?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserName());
			pstmt.setString(3, user.getUserGender());
			pstmt.setString(4, user.getUserEmail());
			pstmt.setString(5, user.getUserPassword());
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
				return -1;
	}
		
	
}//login 기능 구현 이 함수를 실제로 사용해서 사용자에게 로그인 결과를
//알려줄 페이지 설정 ->loginAction.jsp login.jsp에 넘어가는 것이 있음

