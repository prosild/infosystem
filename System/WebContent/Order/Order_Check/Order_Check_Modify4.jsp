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
		location="Order_Check.jsp"
	}
</script>
</head>
<body>
	<%
		String Order_Num = request.getParameter("Order_Num");
		String[] Product_Num, Product_Price, Product_Amount;
		String Cus_Num = request.getParameter("Cus_Num");
		String Order_Sum = request.getParameter("Order_Sum");
		Product_Num = request.getParameterValues("Product_Num");
		Product_Price = request.getParameterValues("Product_Price");
		Product_Amount = request.getParameterValues("Product_Amount");
		java.util.Date d = new java.util.Date();
		String url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";
		String Date;
		
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
			url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			
			stmt = conn.createStatement();
			String command = String.format("delete from order_history where Order_Order_Num ='" + Order_Num + "'");
			stmt.executeUpdate(command);
			command = String.format("delete from system.order where Order_Num = '" + Order_Num + "'");
			stmt.executeUpdate(command);
			command = String.format("insert into system.Order(Order_Num, Order_Date, Order_Sum, Customer_Cus_Num) values('%s', '%s', '%s', '%s');", Order_Num, Date, Order_Sum, Cus_Num);
			stmt.executeUpdate(command);
		}
		catch(Exception e){
			out.println(e);
		}
		finally{
			stmt.close();
			conn.close();
		}
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			for(int i = 0; i < Product_Num.length; i++){
			stmt = conn.createStatement();
			String command = String.format("insert into Order_History(Order_Order_Num, Product_Product_Num, Order_History_Amount, Order_History_Sale_Price) values('%s', '%s', '%s', '%s');", Order_Num, Product_Num[i], Product_Amount[i], Product_Price[i]);
			stmt.executeUpdate(command);}
		}
		catch(Exception e){
			out.println(e);
		}
		finally{
			stmt.close();
			conn.close();
		}
		for(int j = 0; j < Product_Amount.length; j++){
			Connection conn1 = DriverManager.getConnection(url, "root", "postscript1!");
			Statement stmt1 = conn1.createStatement();
			String sql = "select product.Product_Name, product_stock.PS_Amount from product_stock join product on product.Product_Num = product_stock.Product_Product_Num where Product_Product_Num ='" + Product_Num[j] + "'";
			ResultSet rs1 = stmt1.executeQuery(sql);
			
			rs1.last();
				String Product_Name = rs1.getString("Product_Name");
				String PS_Amount = rs1.getString("PS_Amount");
				if(Integer.parseInt(Product_Amount[j]) > Integer.parseInt(PS_Amount)){
					int c = Integer.parseInt(PS_Amount) - Integer.parseInt(Product_Amount[j]);
					%><script>alert("<%=Product_Name%>가 <%=-c%>개 부족합니다. 생산이 필요합니다.")</script><%
				}
				rs1.close();
				stmt1.close();
				conn1.close();
		}
	%>
<script>
	go();
</script>
</body>
</html>