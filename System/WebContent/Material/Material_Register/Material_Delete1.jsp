<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script>
	function g(){
		alert("삭제되었습니다.")
		location="Material_Register.jsp"
	}
</script>
</head>
<body>
	<%
		Connection conn = null;
		Statement stmt = null;
		
		String Material_Num = request.getParameter("Material_Num");
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			
			stmt = conn.createStatement();
			String command = String.format("delete from Material_Requirement where Material_Material_Num='" + Material_Num + "'");
			stmt.executeUpdate(command);
			command = String.format("update Material set Material_Name='', Material_Price='0' where Material_Num='" + Material_Num + "'");
			stmt.executeUpdate(command);
		}
		finally{
			try{
				stmt.close();
				conn.close();
			}
			catch(Exception e){
				out.println(e);
			}
		}
	%>
<script>
	go()
</script>
</body>
</html>