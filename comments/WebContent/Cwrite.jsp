<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ page import="java.sql.*"%>
	<%
		request.setCharacterEncoding("utf-8");
		//이름,비번,내용을 가져온다
		String name = request.getParameter("name");
		String pw = request.getParameter("pw");
		String content = request.getParameter("content");

		//db접속해서 sql실행하기 위한 부분
		//오라클 정보 설정
		String DB_URL = "jdbc:oracle:thin:@localhost:1521:ORCL"; //자신의 컴퓨터에 오라클이 있다면 localhost
		String DB_USER = "scott"; //DB USER명
		String DB_PASSWORD = "tiger"; //패스워드

		Connection con = null;
		PreparedStatement pstmt = null; //속성의 파라미터(인덱스)를 지정해서 사용할 수 있음
		
		//db접속
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("OracleDriver의 로딩이 정상적으로 이뤄졌습니다."); 
			con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		} catch (SQLException e) {
			out.println(e);
		}
		
		String sql = "insert into comments(seq,name,pw,content) values((select max(seq)+1 from comments),?,?,?)"; //방명록 등록 명령
		
		//sql문 설정
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1,name);
		pstmt.setString(2,pw);
		pstmt.setString(3,content);
		
		pstmt.executeUpdate(); //sql문1 실행시킴
		
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}  // PreparedStatement객체 해제
		if(con != null) try{con.close();}catch(SQLException sqle){}    // Connection해제
		
		response.sendRedirect("Clist.jsp");

		//pstmt.executeUpdate() //insert, update문 (입력값 수정시 사용)
		//pstmt.executeQuery() //select문 (return값-결과값 있는 sql문 실행시 사용)
	%>

</body>
</html>