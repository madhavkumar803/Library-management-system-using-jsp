<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Librarian DashBoard</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<sql:setDataSource var="db" 
driver="com.mysql.jdbc.Driver" 
url="jdbc:mysql://localhost:3306/test" 
user="root" password="root"/>

<sql:query var="rs" dataSource="${db}">
select * from librarianlogin where uname="${param.uname}" and pass="${param.pass}"
</sql:query>

<c:set var="ispass" value="0"/>

<c:forEach items="${rs.rows}" var="row">
<c:if test="${row.uname eq param.uname and row.pass eq param.pass}">
<c:set var="ispass" value="1"/>
<c:set scope="session" var="loginUsername1" value="${param.uname}"/>
<c:set scope="session" var="loginpassword1" value="${param.pass}"/>
</c:if>
</c:forEach>

<c:if test="${empty sessionScope['loginUsername1'] or empty sessionScope['loginpassword1']}">
<c:redirect url="index.html"/>
</c:if>

<c:choose>
<c:when test="${ispass>0}"/>
<c:otherwise><c:redirect url="index.html"/></c:otherwise>
</c:choose>
<div class="abc">
<ul>
  <li><a href="index.html">Home</a></li>
  <li><a href="Viewbook.jsp">View Book</a></li>
  <li><a href="Addbook.jsp">Add Book</a></li>
  <li><a href="Issuebook.jsp">Issue Book</a></li>
  <li><a href="Viewissuedbook.jsp">View Issued Book</a></li>
  <li><a href="Returnbook.jsp">Return Book</a></li>
  <li><a href="LibrarionLogout.jsp">Logout</a></li>
 </ul>
</div>
</body>
</html>