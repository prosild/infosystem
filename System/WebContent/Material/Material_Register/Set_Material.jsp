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
		location="Material_Register.jsp"
	}
</script>
</head>
<body>
	<%
		String Material_Num = request.getParameter("Material_Num");
		String Material_Name = request.getParameter("Material_Name");
		String Material_Price = request.getParameter("Material_Price");
		
		Connection conn = null;
		Statement stmt = null;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			
			stmt = conn.createStatement();
			String command = String.format("insert into Material" + "(Material_Num, Material_Name, Material_Price) values('%s', '%s', '%s');", Material_Num, Material_Name, Material_Price);
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