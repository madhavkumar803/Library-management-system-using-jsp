<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Librarion</title>
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
<h3>Add Librarian</h3>
<form action="" method="post">
Name<br/>
<input type="text" name="name"/><br/>
User Name<br/>
<input type="text" name="uname"/><br/>
Password<br/>
<input type="password" name="pass"/><br/>
Mobile Number<br/>
<input type="number" name="mob"/><br/><br/>
<button type="submit">Submit</button>
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
Insert into librarianlogin (name,uname,pass,mob) values(?,?,?,?)
<sql:param value="${param.name}"/>
<sql:param value="${param.uname}"/>
<sql:param value="${param.pass}"/>
<sql:param value="${param.mob}"/>
</sql:update>
<c:set var="ispass" value="0"/>
<sql:query var="rs" dataSource="${db}">
select * from librarianlogin where uname="${param.uname}" and pass="${param.pass}"
</sql:query>
<c:forEach items="${rs.rows}" var="row">
<c:if test="${row.uname eq param.uname and row.pass eq param.pass}">
<c:set var="ispass" value="1"/>
</c:if>
</c:forEach>
</c:if>
<c:choose>
<c:when test="${ispass>0}"><c:out value="Librarian Added Succesfully"/></c:when>
<c:otherwise><c:out value="Librarian Not Added Try Again "/></c:otherwise>
</c:choose>

</body>
</html>