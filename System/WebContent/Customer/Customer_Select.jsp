<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<style>
	input{text-align:center}
	table{text-align:center}
    #topMenu {
            height: 30px;  /* 메인 메뉴의 높이 */
            width: 850px;  /* 메인 메뉴의 넓이 */
    }
    #topMenu ul {           /* 메인 메뉴 안의 ul을 설정함: 상위메뉴의 ul+하위 메뉴의 ul */
        list-style-type: none;  /* 메인 메뉴 안의 ul 내부의 목록 표시를 없애줌 */
        margin: 0px;            /* 메인 메뉴 안의 ul의 margin을 없앰 */
        padding: 0px;           /* 메인 메뉴 안의 ul의 padding을 없앰 */
    }
    #topMenu ul li {            /* 메인 메뉴 안에 ul 태그 안에 있는 li 태그의 스타일 적용(상위/하위메뉴 모두) */
        color: white;               /* 글씨 색을 흰색으로 설정 */
        background-color: #2d2d2d;  /* 배경 색을 RGB(2D2D2D)로 설정 */
        float: left;                /* 왼쪽으로 나열되도록 설정 */
        line-height: 30px;          /* 텍스트 한 줄의 높이를 30px로 설정 */
        vertical-align: middle;     /* 세로 정렬을 가운데로 설정 */
        text-align: center;         /* 텍스트를 가운데로 정렬 */
        position: relative;         /* 해당 li 태그 내부의 top/left 포지션 초기화 */
    }
    .menuLink, .submenuLink {           /* 상위 메뉴와 하위 메뉴의 a 태그에 공통으로 설정할 스타일 */
        text-decoration:none;               /* a 태그의 꾸밈 효과 제거 */
        display: block;                     /* a 태그의 클릭 범위를 넓힘 */
        width: 150px;                       /* 기본 넓이를 150px로 설정 */
        font-size: 12px;                    /* 폰트 사이즈를 12px로 설정 */
        font-weight: bold;                  /* 폰트를 굵게 설정 */
        font-family: "Trebuchet MS", Dotum; /* 기본 폰트를 영어/한글 순서대로 설정 */
    }
    .menuLink {     /* 상위 메뉴의 글씨색을 흰색으로 설정 */
        color: white;
    }
    .topMenuLi:hover .menuLink {    /* 상위 메뉴의 li에 마우스오버 되었을 때 스타일 설정 */
        color: white;                 /* 글씨 색 밝은회색 */
        background-color: #4d4d4d;  /* 배경색을 밝은 회색으로 설정 */
    }
    .submenuLink {          /* 하위 메뉴의 a 태그 스타일 설정 */
        color: #2d2d2d;             /* 글씨 색을 RGB(2D2D2D)로 설정 */
        background-color: white;    /* 배경색을 흰색으로 설정 */
        border: solid 1px black;    /* 테두리를 설정 */
        margin-top: -1px;           /* 위 칸의 하단 테두리와 아래칸의 상단 테두리가 겹쳐지도록 설덩 */
    }
    .longLink {     /* 좀 더 긴 메뉴 스타일 설정 */
        width: 190px;   /* 넓이는 190px로 설정 */
    }
    .submenu {              /* 하위 메뉴 스타일 설정 */
        position: absolute;     /* html의 flow에 영향을 미치지 않게 absolute 설정 */
        height: 0px;            /* 초기 높이는 0px로 설정 */
        overflow: hidden;       /* 실 내용이 높이보다 커지면 해당 내용 감춤 */
        transition: height .2s; /* height를 변화 시켰을 때 0.2초간 변화 되도록 설정(기본) */
        -webkit-transition: height .2s; /* height를 변화 시켰을 때 0.2초간 변화 되도록 설정(구버전 크롬/사파라ㅣ) */
        -moz-transition: height .2s; /* height를 변화 시켰을 때 0.2초간 변화 되도록 설정(구버전 파폭) */
        -o-transition: height .2s; /* height를 변화 시켰을 때 0.2초간 변화 되도록 설정(구버전 오페라) */
    }
    .topMenuLi:hover .submenu { /* 상위 메뉴에 마우스 모버한 경우 그 안의 하위 메뉴 스타일 설정 */
        height: 93px;           /* 높이를 93px로 설정 */
    }
    .submenuLink:hover {        /* 하위 메뉴의 a 태그의 마우스 오버 스타일 설정 */
        color: black;                 /* 글씨색을 빨간색으로 설정 */
        background-color: #dddddd;  /* 배경을 RGB(DDDDDD)로 설정 */
    }
</style>
<script>
	function modify(){
		alert("수정되었습니다.");
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
	<form name="A">
		<table align="right">
			<tr>
				<td>
					<input type="text" name="A1" disabled>
				</td>
			</tr>
		</table>
	</form>
<center>
<nav id="topMenu">
	<ul>
		<li class="topMenuLi">
			<a class="menuLink" href="Customer_Register.jsp">고객등록</a>
		</li>
		<li class="topMenuLi">
			<a class="menuLink">주문관리</a>
			<ul class="submenu">
				<li>
					<a class="submenuLink" href="../Order/Order_Register/Order_Register.jsp">주문등록</a>
				</li>
				<li>
					<a class="submenuLink" href="">주문내역조회</a>
				</li>
			</ul>
		</li>
		<li class="topMenuLi">
			<a class="menuLink">제품관리</a>
			<ul class="submenu">
				<li>
					<a class="submenuLink" href="../Product/Product_Register/Product_Register.jsp">제품등록</a>
				</li>
				<li>
					<a class="submenuLink" href="../Product/Product_Stock/Product_Stock_Check.jsp">제품재고확인</a>			
				</li>
				<li>
					<a class="submenuLink" href="../Product/Product_SR/Product_SR_Register.jsp">제품입출고등록</a>			
				</li>
			</ul>
		</li>
		<li class="topMenuLi">
			<a class="menuLink">자재관리</a>
			<ul class="submenu">
				<li>
					<a class="submenuLink" href="../Material/Material_Register/Material_Register.jsp">자재등록</a>
				</li>
				<li>
					<a class="submenuLink" href="../Material/Material_Stock/Material_Stock_Check.jsp">자재재고확인</a>			
				</li>
				<li>
					<a class="submenuLink" href="../Material/Material_SR/Material_SR_Register.jsp">자재입출고등록</a>			
				</li>
			</ul>
		</li>
		<li class="topMenuLi">
			<a class="menuLink" href="">생산지시서관리</a>
			<ul class="submenu">
			<li>
				<a class="submenuLink" href="../Production_Directions/Production_Directions_Register/Production_Directions_Register.jsp">생산지시서작성</a>
			</li>
			<li>
				<a class="submenuLink" href="../Production_Directions/Production_Directions_Check/Production_Directions_Check.jsp">생산지시서확인</a>			
			</li>
			</ul>
		</li>
	</ul>
</nav>
</center>
	<h1 align="center">고객정보수정</h1>
	<%
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		String url = "jdbc:mysql://localhost:3306/system?verifyServerCertificate=false&useSSL=true";
		
		String cus_num = request.getParameter("Number");
		String Cus_Num = null;
		String Cus_Name = null;
		String Cus_Tel = null;
		String Cus_Addr = null;
		String Cus_Email = null;
		
		try{
			conn = DriverManager.getConnection(url, "root", "postscript1!");
			stmt = conn.createStatement();
			String sql = "SELECT * FROM Customer WHERE Cus_Num='" + cus_num + "'";
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				Cus_Num = rs.getString("Cus_Num");
				Cus_Name = rs.getString("Cus_Name");
				Cus_Tel = rs.getString("Cus_Tel");
				Cus_Addr = rs.getString("Cus_Addr");
				Cus_Email = rs.getString("Cus_Email"); %>
				
				<form action="Change.jsp" method="post">
					<table align="center" border="1">
						<tr>
							<td>
								고객번호
							</td>
							<td>
								고객명
							</td>
							<td>
								전화번호
							</td>
							<td>
								주소
							</td>
							<td>
								E-mail
							</td>
						</tr>
						<tr>
							<td>
								<input type="text" value="<%= Cus_Num %>"  disabled>
								<input type="hidden" name="Cus_Num" value="<%= Cus_Num %>">
							</td>
							<td>
								<input type="text" name="Cus_Name" value="<%= Cus_Name %>">
							</td>
							<td>
								<input type="text" name="Cus_Tel" value="<%= Cus_Tel %>">
							</td>
							<td>
								<input type="text" name="Cus_Addr" value="<%= Cus_Addr %>">
							</td>
							<td>
								<input type="text" name="Cus_Email" value="<%= Cus_Email %>">
							</td>
							<td>
								<input type="submit" value="등록" onclick="modify()">
							</td>
						</tr>
					</table>
		<% } %>
			</form>
	<%}
		catch(SQLException e){
			out.println(e);
		}
		finally{
			rs.close();
			stmt.close();
			conn.close();
		}
	%>
</body>
</html>