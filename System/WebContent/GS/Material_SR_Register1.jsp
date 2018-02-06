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
	function realtimeClock() {
		document.A.A1.value = getTimeStamp();
		setTimeout("realtimeClock()", 1000);
	}

	function getTimeStamp() {
		var d = new Date();

		var s = leadingZeros(d.getFullYear(), 4) + '-'
				+ leadingZeros(d.getMonth() + 1, 2) + '-'
				+ leadingZeros(d.getDate(), 2) + ' ' +

				leadingZeros(d.getHours(), 2) + ':'
				+ leadingZeros(d.getMinutes(), 2) + ':'
				+ leadingZeros(d.getSeconds(), 2);

		return s;
	}

	function leadingZeros(n, digits) {
		var zero = '';
		n = n.toString();

		if (n.length < digits) {
			for (i = 0; i < digits - n.length; i++)
				zero += '0';
		}

		return zero + n;
	}
	function warehousing(){
		alert("입고 되었습니다.")
		location="Material_SR_Register.jsp"
	}
	function release(){
		alert("출고 되었습니다.")
		location="Material_SR_Register.jsp"
	}
</script>
</head>
<body onload="realtimeClock()">
	<form name="A">
		<table align="right">
			<tr>
				<td>
					<input type="text" name="A1" disabled>
				</td>
			</tr>
		</table>
	</form>
	<%
		java.util.Date d = new java.util.Date();
		String Material_Num = null;
		String Material_Name = request.getParameter("Material_Name");
		String SR = request.getParameter("SR");
		int Material_Amount = Integer.parseInt(request.getParameter("Material_Amount"));
		String Date = null;
		int MS_Amount = 0;
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		if(SR.equals("입고")){
		String url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";
		
		try{
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from material where Material_Name = '" + Material_Name + "'");
			
			rs.next();
			Material_Num = rs.getString("Material_Num");
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
			command = String.format("insert into material_warehousing(Material_Material_Num, MW_Date, MW_Amount) values('%s', '%s', '%s');", Material_Num, Date, Material_Amount);
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
			String sql = "select * from Material_Stock where Material_Material_Num = '" + Material_Num + "'";
			rs = stmt.executeQuery(sql);
			
			rs.last();
			MS_Amount = rs.getInt("MS_Amount");
		}
		catch(SQLException sqle){
			out.println(sqle);
		}
		finally{
			rs.close();
			stmt.close();
			conn.close();
		}
		
		int a = MS_Amount + Material_Amount;
		
		try{
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			stmt = conn.createStatement();
			command = String.format("insert into material_stock(Material_Material_Num, MS_Date, MS_Amount) values('%s', '%s', '%s');", Material_Num, Date, a);
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
				rs = stmt.executeQuery("select * from material where Material_Name = '" + Material_Name + "'");
				
				rs.next();
				Material_Num = rs.getString("Material_Num");
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
				command = String.format("insert into material_release (Material_Material_Num, MR_Date, MR_Amount) values('%s', '%s', '%s');", Material_Num, Date, Material_Amount);
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
				String sql = "select * from Material_Stock where Material_Material_Num = '" + Material_Num + "'";
				rs = stmt.executeQuery(sql);
				
				rs.last();
				MS_Amount = rs.getInt("MS_Amount");
			}
			catch(SQLException sqle){
				out.println(sqle);
			}
			finally{
				rs.close();
				stmt.close();
				conn.close();
			}
			
			int a = MS_Amount - Material_Amount;
			
			try{
				conn = DriverManager.getConnection(url, "root", "postscript1!");
				stmt = conn.createStatement();
				command = String.format("insert into material_stock(Material_Material_Num, MS_Date, MS_Amount) values('%s', '%s', '%s');", Material_Num, Date, a);
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