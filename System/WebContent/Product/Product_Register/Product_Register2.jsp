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
		location="Product_Register.jsp"
	}
</script>
</head>
<body>
	<%
		String[] Material_Num, MR_Amount;
		
		String Product_Num = request.getParameter("Product_Num");
		String Product_Name = request.getParameter("Product_Name");
		
		Material_Num = request.getParameterValues("Material_Num");
		MR_Amount = request.getParameterValues("Material_Amount");
		
		Connection conn = null;
		Statement stmt = null;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			
			stmt = conn.createStatement();
			String command = String.format("insert into Product(Product_Num, Product_Name) values('%s', '%s');", Product_Num, Product_Name);
			stmt.executeUpdate(command);
			
			for(int i = 0; i < MR_Amount.length; i++){
				command = String.format("insert into Material_Requirement(Product_Product_Num, Material_Material_Num, MR_Amount) values('%s', '%s', '%s');", Product_Num, Material_Num[i], MR_Amount[i]);
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