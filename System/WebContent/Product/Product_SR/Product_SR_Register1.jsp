<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script>
	function warehousing(){
		alert("입고 되었습니다.")
		location="Product_SR_Register.jsp"
	}
	function release(){
		alert("출고 되었습니다.")
		location="Product_SR_Register.jsp"
	}
</script>
	<%
		java.util.Date d = new java.util.Date();
		String Product_Num = null;
		String Product_Name = request.getParameter("Product_Name");
		String SR = request.getParameter("SR");
		int Product_Amount = Integer.parseInt(request.getParameter("Product_Amount"));
		String Date = null;
		int PS_Amount = 0;
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		if(SR.equals("입고")){
		String url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";
		
		try{
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from Product where Product_Name = '" + Product_Name + "'");
			
			rs.next();
			Product_Num = rs.getString("Product_Num");
		}
		catch(SQLException sqle){
			out.println(sqle);
		}
		finally{
			rs.close();
			stmt.close();
			conn.close();
		}
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = null;
		stmt = null;
		String command;
		
		url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";
		
		int day = d.getDate();
		
		if(day < 10){
			Date = d.getYear() + 1900  + "-" + ((int)d.getMonth() + 1) + "-0" + d.getDate() + "-" + d.getHours() + "시" + d.getMinutes() + "분" +  d.getSeconds() + "초";
		}
		else{
			Date = d.getYear() + 1900  + "-" + ((int)d.getMonth() + 1) + "-" + d.getDate() + "-" + d.getHours() + "시" + d.getMinutes() + "분" +  d.getSeconds() + "초";
		}
		
		try{
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			stmt = conn.createStatement();
			command = String.format("insert into Product_warehousing(Product_Product_Num, PW_Date, PW_Amount) values('%s', '%s', '%s');", Product_Num, Date, Product_Amount);
			stmt.executeUpdate(command);
		}
		catch(SQLException sqle){
			out.println(sqle);
		}
		finally{
			stmt.close();
			conn.close();
		}
		Class.forName("com.mysql.jdbc.Driver");
		conn = null;
		stmt = null;
		rs = null;
		
		try{
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			stmt = conn.createStatement();
			String sql = "select * from Product_Stock where Product_Product_Num = '" + Product_Num + "'";
			rs = stmt.executeQuery(sql);
			
			rs.last();
			PS_Amount = rs.getInt("PS_Amount");
		}
		catch(SQLException sqle){
			out.println(sqle);
		}
		finally{
			rs.close();
			stmt.close();
			conn.close();
		}
		
		int a = PS_Amount + Product_Amount;
		
		try{
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			stmt = conn.createStatement();
			command = String.format("insert into Product_stock(Product_Product_Num, PS_Date, PS_Amount) values('%s', '%s', '%s');", Product_Num, Date, a);
			stmt.executeUpdate(command);
		}
		catch(SQLException sqle){
			out.println(sqle);
		}
		finally{
			stmt.close();
			conn.close();
		}
		%><script>warehousing()</script><%
	}
		if(SR.equals("출고")){
			String url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";
			
			try{
				conn = DriverManager.getConnection(url, "root", "postscript1!");
				stmt = conn.createStatement();
				rs = stmt.executeQuery("select * from Product where Product_Name = '" + Product_Name + "'");
				
				rs.next();
				Product_Num = rs.getString("Product_Num");
			}
			catch(SQLException sqle){
				out.println(sqle);
			}
			finally{
				rs.close();
				stmt.close();
				conn.close();
			}
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = null;
			stmt = null;
			String command;
			
			url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";
			
			int day = d.getDate();
			
			if(day < 10){
				Date = d.getYear() + 1900  + "-" + ((int)d.getMonth() + 1) + "-0" + d.getDate() + "-" + d.getHours() + "시" + d.getMinutes() + "분" +  d.getSeconds() + "초";
			}
			else{
				Date = d.getYear() + 1900  + "-" + ((int)d.getMonth() + 1) + "-" + d.getDate() + "-" + d.getHours() + "시" + d.getMinutes() + "분" +  d.getSeconds() + "초";
			}
			
			try{
				conn = DriverManager.getConnection(url, "root", "postscript1!");
				stmt = conn.createStatement();
				command = String.format("insert into Product_release(Product_Product_Num, PR_Date, PR_Amount) values('%s', '%s', '%s');", Product_Num, Date, Product_Amount);
				stmt.executeUpdate(command);
			}
			catch(SQLException sqle){
				out.println(sqle);
			}
			finally{
				stmt.close();
				conn.close();
			}
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = null;
			stmt = null;
			rs = null;
			
			try{
				conn = DriverManager.getConnection(url, "root", "postscript1!");
				stmt = conn.createStatement();
				String sql = "select * from Product_Stock where Product_Product_Num = '" + Product_Num + "'";
				rs = stmt.executeQuery(sql);
				
				rs.last();
				PS_Amount = rs.getInt("PS_Amount");
			}
			catch(SQLException sqle){
				out.println(sqle);
			}
			finally{
				rs.close();
				stmt.close();
				conn.close();
			}
			
			int a = PS_Amount - Product_Amount;
			
			try{
				conn = DriverManager.getConnection(url, "root", "postscript1!");
				stmt = conn.createStatement();
				command = String.format("insert into Product_stock(Product_Product_Num, PS_Date, PS_Amount) values('%s', '%s', '%s');", Product_Num, Date, a);
				stmt.executeUpdate(command);
			}
			catch(SQLException sqle){
				out.println(sqle);
			}
			finally{
				stmt.close();
				conn.close();
			}
			%><script>release()</script><%
		}
	%>
</body>
</html>