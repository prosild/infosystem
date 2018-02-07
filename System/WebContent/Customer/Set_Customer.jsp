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
		location="Customer_Register.jsp"
	}
</script>
</head>
<body>
	<%
		String Cus_Num = request.getParameter("Cus_Num");
		String Cus_Name = request.getParameter("Cus_Name");
		String Cus_Tel = request.getParameter("Cus_Tel");
		String Cus_Addr = request.getParameter("Cus_Addr");
		String Cus_Email = request.getParameter("Cus_Email");
		System.out.println(Cus_Name);
		Connection conn = null;
		Statement stmt = null;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			
			stmt = conn.createStatement();
			String command = String.format("insert into Customer" + "(Cus_Num, Cus_Name, Cus_Tel, Cus_Addr, Cus_Email) values('%s', '%s', '%s', '%s', '%s');", Cus_Num, Cus_Name, Cus_Tel, Cus_Addr, Cus_Email);
			stmt.executeUpdate(command);
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