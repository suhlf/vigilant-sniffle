package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

//DAO클래스는 데이터 접근 객체의 약자로써 디비에 접근하여 실제로 데이터베이스를 해준당.
public class BbsDAO {
	private Connection conn;
	//private PreparedStatement pstmt; 이것은 여러개의 함수를 써야하므로 (UserDAO에서는 하나만 쿼리썼기에..)
	//각 함수마다 이 연결을 시켜준다.
	private ResultSet rs;
	
	public BbsDAO(){
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
	
	public String getDate() {
		String SQL = "SELECT NOW()"; //SQL문법에서 현재 시각을 구하는 것.
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
		if(rs.next()) {
			return rs.getString(1);
		}
	}catch(Exception e) {
		e.printStackTrace();
		}
		return ""; //데이터베이스 오류!!!! 아무것도 걸리지않았을때(오류 or 시간출력)
	}
	
	public int getNext() { //글의 번호를 지정해주는 것. 1번글 2번글....
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC"; //SQL문법 DESC는 내림차순 번호
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
		if(rs.next()) {
			return rs.getInt(1)+1; //rs는 다음줄 다음줄로 넘어가는 것.다음줄이 생성된다면 +1하는 것이다.
		}
		return 1; //아무것도 즉, 게시판에 글이 하나도 없다면 1 반환하고 끝
	}catch(Exception e) {
		e.printStackTrace();
		}
		return -1; //데이터베이스 오류!!!! 아무것도 걸리지않았을때(오류 or 시간출력)
	}
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ?)"; //SQL문법에서 현재 시각을 구하는 것.
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());//다음번에 쓰여야 할 번호
			pstmt.setString(2, bbsTitle);//제목
			pstmt.setString(3,userID);//유저아이디
			pstmt.setString(4,getDate());//날짜
			pstmt.setString(5,bbsContent);//내용
			pstmt.setInt(6, 1);//available 처음으로 작성했을때 보여지는 것이므로 삭제가아니므로 1세팅
			return pstmt.executeUpdate();//insert같은 경우 성공적으로 수행을 했다면 0 이상의 결과 오류가 발생했을 시 -1반환 
			//rs는 insert를 사용할땐 사용 x
	}catch(Exception e) {
		e.printStackTrace();
		}
		return -1; //데이터베이스 오류!!!! 아무것도 걸리지않았을때(오류 or 시간출력)
	}
	
	public ArrayList<Bbs> getList(int pageNumber){
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() -(pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()- (pageNumber -1) * 10 );
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
	
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
		
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);//제목 수정
			pstmt.setString(2, bbsContent);//게시판 내용
			pstmt.setInt(3,bbsID);//게시판 번호
			return pstmt.executeUpdate();
			//rs는 insert를 사용할땐 사용 x
	}catch(Exception e) {
		e.printStackTrace();
		}
		return -1; //데이터베
	}
	
	public int delete(int bbsID) { //어떤 글인지 알 수 있도록 아이디값을 받아올 수 있또록 한다
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
		//이전에 말했듯이 글을 삭제하더라도 글에대한 정보가 남아있을 수 있도록(DB에 남아있을 수 있도록)
		//bbsAvailable값만 0으로 바꿔준다.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);//제목 수정
			return pstmt.executeUpdate();
			//rs는 insert를 사용할땐 사용 x
	}catch(Exception e) {
		e.printStackTrace();
		}
		return -1; //데이터베
	}
}

	
