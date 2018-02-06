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
		location="Production_Directions_Register.jsp"
	}
</script>
</head>
<body>
	<%
		java.util.Date d = new java.util.Date();
		String[] Product_Num = request.getParameterValues("Product_Num");
		String[] PD_Amount = request.getParameterValues("PD_Amount");
		String Date = null;
		int day = d.getDate();
		
		if(day < 10){
			Date = d.getYear() + 1900  + "-" + ((int)d.getMonth() + 1) + "-0" + d.getDate() + "-" + d.getHours() + "시" + d.getMinutes() + "분" +  d.getSeconds() + "초";
		}
		else{
			Date = d.getYear() + 1900  + "-" + ((int)d.getMonth() + 1) + "-" + d.getDate() + "-" + d.getHours() + "시" + d.getMinutes() + "분" +  d.getSeconds() + "초";
		}
		
		Connection conn = null;
		Statement stmt = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			for(int i = 0; i < Product_Num.length; i++){
			stmt = conn.createStatement();
			String command = String.format("insert into Production_Directions" + "(Product_Product_Num, PD_Date, PD_Amount) values('%s', '%s', '%s');", Product_Num[i], Date, PD_Amount[i]);
			stmt.executeUpdate(command);
		}}
		catch(Exception e){
			out.println(e);
		}
		finally{
			stmt.close();
			conn.close();
		}
	%>
<script>
	go()
</script>
</body>
</html>