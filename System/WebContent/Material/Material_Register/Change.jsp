<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
	<%
		Connection conn = null;
		Statement stmt = null;
		
		String Material_Num = request.getParameter("Material_Num");
		String Material_Name = request.getParameter("Material_Name");
		String Material_Price = request.getParameter("Material_Price");
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			
			stmt = conn.createStatement();
			String command = String.format("update Material set Material_Name='" + Material_Name + "', Material_Price='" + Material_Price + "' where Material_Num='" + Material_Num + "'");
			int rowNum = stmt.executeUpdate(command);
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
		response.sendRedirect("Material_Register.jsp");
	%>
</body>
</html>