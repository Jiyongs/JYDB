<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>방명록 홈페이지(목록조회)</title>
</head>
<body>
<label>삭제할 글 번호와 비밀번호를 입력하세요.</label>
<form action="Cdelete.jsp" method="post">
	번호 : <input type="text" name="num" size=10></input><br />
	비번 : <input type="password" name="pw" size=10></input><br />
	<input type="submit" value="삭제"></input><br />
</form>
<table>
<tr><th>번호</th><th>이름</th><th>소감</th><th>작성일</th></tr>
<%
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String url = "jdbc:oracle:thin:@localhost:1521:ORCL";
	String user = "scott";
	String pw = "tiger";
	String sql = "select * from comments order by seq desc";
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = DriverManager.getConnection(url, user, pw);
	pstmt = con.prepareStatement(sql);

	rs = pstmt.executeQuery();
	//rs.next();
	//out.print(rs.getString(2));
	while(rs.next()) {
		int seq = rs.getInt(1);
		String name = rs.getString(2);
		String pass = rs.getString(3);
		String content = rs.getString(4);
		String rdate = rs.getString(5);
	%>
		<tr><td><%=seq%></td>
			<td><%=name %></td>
			<td><%=content %></td>
			<td><%=rdate %></td>
		</tr>
	<%
	}
	rs.close();
	pstmt.close();
	con.close();
%>
</table> <br />
</body>
</html>