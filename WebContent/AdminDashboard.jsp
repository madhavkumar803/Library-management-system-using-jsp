<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin DashBoard</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<sql:setDataSource var="db" 
driver="com.mysql.jdbc.Driver" 
url="jdbc:mysql://localhost:3306/test" 
user="root" password="root"/>

<sql:query var="rs" dataSource="${db}">
select * from adminlogin where uname="${param.uname}" and pass="${param.pass}"
</sql:query>

<c:set var="ispass" value="0"/>

<c:forEach items="${rs.rows}" var="row">
<c:if test="${row.uname eq param.uname and row.pass eq param.pass}">
<c:set var="ispass" value="1"/>
<c:set scope="session" var="loginUsername" value="${param.uname}"/>
<c:set scope="session" var="loginpassword" value="${param.pass}"/>
</c:if>
</c:forEach>
<c:if test="${empty sessionScope['loginUsername'] or empty sessionScope['loginpassword']}">
<c:redirect url="index.html"/>
</c:if>
<c:choose>
<c:when test="${ispass>0}"/>
<c:otherwise><c:redirect url="index.html"/></c:otherwise>
</c:choose>
<div class="abc">
<ul>
  <li><a href="index.html">Home</a></li>
  <li><a href="AddLibrarian.jsp">Add Librarian</a></li>
  <li><a href="ViewLibrarian.jsp">View Librarian</a></li>
  <li><a href="DeleteLibrarian.jsp">Delete Librarian</a></li>
  <li><a href="AdminLogout.jsp">Logout</a></li>
</ul>
</div> 
</body>
</html>