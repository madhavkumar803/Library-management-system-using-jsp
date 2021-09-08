<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Librarian</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<div class="abc">
<ul>
  <li><a href="index.html">Home</a></li>
  <li><a href="AddLibrarian.jsp">Add Librarian</a></li>
  <li><a href="ViewLibrarian.jsp">View Librarian</a></li>
  <li><a href="DeleteLibrarian.jsp">Delete Librarian</a></li>
  <li><a href="AdminLogout.jsp">Logout</a></li>
</ul>
</div>
<h3>Delete Librarian</h3>
<form action="" method="post">
User Name<br/>
<input type="text" name="uname"/><br/>
Password<br/>
<input type="text" name="pass"/><br/><br/>
<button type="submit">Delete Librarian</button>
</form>
<c:if test="${empty sessionScope['loginUsername'] or empty sessionScope['loginpassword']}">
<c:redirect url="index.html"/>
</c:if>

<sql:setDataSource var="db" 
driver="com.mysql.jdbc.Driver" 
url="jdbc:mysql://localhost:3306/test"
user="root" password="root"/>

<c:if test="${not empty param.uname and not empty param.pass}">
<sql:update var="row" dataSource="${db}">
delete from librarianlogin where uname="${param.uname}" and pass="${param.pass}"
</sql:update>
<c:set var="ispass" value="0"/>
</c:if>

<c:forEach items="${rs.rows}" var="row">
<c:if test="${row.uname ne param.uname and row.pass ne param.pass}">
<c:set var="ispass" value="1"/>
</c:if>
</c:forEach>

<c:choose>
<c:when test="${ispass<1}"><c:out value="Librarian Deleted Succesfully"/></c:when>
<c:otherwise><c:out value="Librarian Not Deleted Try Again "/></c:otherwise>
</c:choose>

</body>
</html>