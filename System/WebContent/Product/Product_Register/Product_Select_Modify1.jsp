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
		alert("수정되었습니다.")
		location="Product_Register.jsp"
	}
</script>
</head>
<body>
	<%
		String[] Material_Num, MR_Amount;
		
		String Product_Num = request.getParameter("Product_Num");
		Material_Num = request.getParameterValues("Material_Num");
		MR_Amount = request.getParameterValues("MR_Amount");
		
		Connection conn = null;
		Statement stmt = null;
		
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";
		
		try{		
			conn = DriverManager.getConnection(url, "root", "postscript1!");

			for(int i = 0; i < MR_Amount.length; i++){
				stmt = conn.createStatement();
				String command = String.format("update Material_Requirement set MR_Amount='"+ MR_Amount[i] + "' where Product_Product_Num='" + Product_Num + "' and Material_Material_Num='" + Material_Num[i] + "'");
				stmt.executeUpdate(command);
			}
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