<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script>
	function error(){
		alert("로그인에 실패하였습니다.");
		location = "Login.html"
	}
</script>
</head>
<body>
	<%
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		String ID = null, PS = null;
		String id, password;
		
		id = request.getParameter("ID");
		password = request.getParameter("Password");
		String url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";
		
		try{
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from Emp");
			
			while(rs.next()){
				ID = rs.getString("id");
				PS = rs.getString("password");
			}
		}
		catch(SQLException sqle){
			out.println(sqle);
		}
		finally{
			rs.close();
			stmt.close();
			conn.close();
		}
	%>
	<%
		if(ID.equals(id) && PS.equals(password)){ 
			response.sendRedirect("main.jsp");
		}
		else{ %>
		<script>error()</script>
		<%}%>
</body>
</html>