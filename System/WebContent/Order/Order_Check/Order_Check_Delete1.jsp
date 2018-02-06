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
		alert("삭제되었습니다.")
		location="Order_Check.jsp"
	}
</script>
</head>
<body>
	<%
		String Order_Num = request.getParameter("Order_Num");
		String url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";

		Connection conn = null;
		Statement stmt = null;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			
			stmt = conn.createStatement();
			String command = String.format("delete from order_history where Order_Order_Num ='" + Order_Num + "'");
			stmt.executeUpdate(command);
			command = String.format("delete from system.order where Order_Num = '" + Order_Num + "'");
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