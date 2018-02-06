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
	function go(){
		alert("등록되었습니다.")
		location="GS_Register.jsp"
	}
</script>
</head>
<body>
	<%
		String GS_Num = request.getParameter("GS_Num");
		String GS_Name = request.getParameter("GS_Name");
		String GS_Date = request.getParameter("GS_Date");
		
		Connection conn = null;
		Statement stmt = null;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/mydb?verifyServerCertificate=false&useSSL=true";
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			
			stmt = conn.createStatement();
			String command = String.format("insert into GS" + "(GS_Num, GS_Name, GS_Date) values('%s', '%s', '%s');", GS_Num, GS_Name, GS_Date);
			int rowNum = stmt.executeUpdate(command);
		}
		catch(Exception e){
			out.println(e);
		}
		finally{
			stmt.close();
			conn.close();
		}
	%>
<script>
	go();
</script>
</body>
</html>