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
		
		String Product_Num = request.getParameter("Product_Num");
		String Product_Name = request.getParameter("Product_Name");
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			
			stmt = conn.createStatement();
			String command = String.format("update Product set Product_Name='" + Product_Name + "' where Product_Num='" + Product_Num + "'");
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
		response.sendRedirect("Product_Register.jsp");
	%>
</body>
</html>