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
		
		String Cus_Num = request.getParameter("Cus_Num");
		String Cus_Name = request.getParameter("Cus_Name");
		String Cus_Tel = request.getParameter("Cus_Tel");
		String Cus_Addr = request.getParameter("Cus_Addr");
		String Cus_Email = request.getParameter("Cus_Email");
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			
			stmt = conn.createStatement();
			String command = String.format("update customer set Cus_Name='" + Cus_Name + "', Cus_Tel='" + Cus_Tel + "', Cus_Addr='" + Cus_Addr + "', Cus_Email='" + Cus_Email + "' where Cus_Num='" + Cus_Num + "'");
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
		response.sendRedirect("Customer_Register.jsp");
	%>
</body>
</html>