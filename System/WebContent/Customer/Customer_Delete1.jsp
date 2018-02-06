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
	function go(){
		alert("삭제되었습니다.")
		location="Customer_Register.jsp"
	}
</script>
</head>
<body>
	<%
		String Order_Num[] = new String[100];
		Connection conn = null;
		Statement stmt = null;
		int i = 0;
		
		String Cus_Num = request.getParameter("Cus_Num");
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			ResultSet rs = null;
			
			try{
			stmt = conn.createStatement();
			String command = String.format("select * from system.order where Customer_Cus_Num = '" + Cus_Num + "'");
			rs = stmt.executeQuery(command);
				while(rs.next()){
					Order_Num[i] = rs.getString("Order_Num");
					i++;
				}
				
			}finally{
				rs.close();
			}
			
			for(int j = 0; j < Order_Num.length; j++){
			String command = String.format("delete from order_history where Order_Order_Num = '" + Order_Num[j] + "'");
			stmt.executeUpdate(command);
			}
			String command = String.format("delete from system.order where Customer_Cus_Num = '" + Cus_Num + "'");
			stmt.executeUpdate(command);
			command = String.format("update customer set Cus_Name='', Cus_tel='', Cus_Addr='', Cus_Email='' where Cus_Num='" + Cus_Num + "'");
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