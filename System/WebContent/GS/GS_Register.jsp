<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<style>
	input{text-align:center}
	table{text-align:center}
    #topMenu {
            height: 30px;
            width: 850px;
    }
    #topMenu ul {       
        list-style-type: none;  
        margin: 0px;            
        padding: 0px;          
    }
    #topMenu ul li {          
        color: white;            
        background-color: #2d2d2d;  
        float: left;             
        line-height: 30px;       
        vertical-align: middle;   
        text-align: center;         
        position: relative;        
    }
    .menuLink, .submenuLink {          
        text-decoration:none;              
        display: block;                    
        width: 150px;                       
        font-size: 12px;                    
        font-weight: bold;              
        font-family: "Trebuchet MS", Dotum; 
    }
    .menuLink {  
        color: white;
    }
    .topMenuLi:hover .menuLink {    
        color: white;                 
        background-color: #4d4d4d;  
    }
    .submenuLink {         
        color: #2d2d2d;            
        background-color: white;  
        border: solid 1px black; 
        margin-top: -1px;           
    }
    .longLink {     
        width: 190px; 
    }
    .submenu {             
        position: absolute;     
        height: 0px;        
        overflow: hidden;     
        transition: height .2s; 
        -webkit-transition: height .2s; 
        -moz-transition: height .2s; 
        -o-transition: height .2s; 
    }
    .topMenuLi:hover .submenu { 
        height: 93px;          
    }
    .submenuLink:hover {       
        color: black;              
        background-color: #dddddd; 
    }
</style>
<script>
	function change(){
		location="Change_GS.jsp"
	}
	function reset(){
		C.C1.value="";
		C.C2.value="";
	}
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
</script>
</head>
<body onload="realtimeClock()">
<center>
<nav id="topMenu">
	<ul>
		<li class="topMenuLi">
			<a class="menuLink" href="../../Customer/Customer_Register.jsp">고객등록</a>
		</li>
		<li class="topMenuLi">
			<a class="menuLink" href="../../Customer/Customer_Register.jsp">제품등록</a>
		</li>
	</ul>
</nav>
</center>
<form name="A">
	<table align="right">
		<tr>
			<td>
				<input type="text" name="A1" disabled>
			</td>
		</tr>
	</table>
</form>
<br>
<h1 align="center">제품등록</h1>
	<%
		String GS_Num = null;
		String GS_SBD = null;
		int a = 1;
	
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		String url = "jdbc:mysql://localhost:3306/mydb?verifyServerCertificate=false&useSSL=true";
		
		try{
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from GS");
			
			while(rs.next()){
				a++;			
			}
		}
		catch(SQLException sqle){
			out.println(sqle);
		}
		finally{
			conn.close();
			stmt.close();
			rs.close();
		}
		
		if(a < 10){
			GS_Num = "B00" + a;
		}
		else if(a < 100){
			GS_Num = "B0" + a;
		}
		else if(a < 1000){
			GS_Num = "B" + a;
		}
	%>
<form action="GS_Register(1).jsp">
	<table align="center">
		<tr>
			<td align="right">
				제품번호 : 
			</td>
			<td>
				<input type="text" value="<%= GS_Num %>"  disabled>
				<input type="hidden" name ="GS_Num" value="<%= GS_Num %>">
			</td>
		</tr>
		<tr>
			<td align="right">
				제품명 : 
			</td>
			<td>
				<input type="text" name="GS_Name">
			</td>
		</tr>
		<tr>
			<td align="right">
				유통기한 : 
			</td>
			<td>
				<input type="date" name="GS_Date">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<br>
				<input type="submit" value="등록" style="width:60px; height:30px">
				<input type="button" value="취소" style="width:60px; height:30px" onclick="reset()">
				<input type="button"  value="수정" style="width:60px; height:30px" onclick="change()">
				<input type="button" value="삭제" style="width:60px; height:30px" onclick="location='GS_Delete.jsp'">
			</td>
		</tr>
	</table>
</form>
</body>
</html>