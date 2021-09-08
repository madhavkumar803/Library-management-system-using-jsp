<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Issued Book</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<div class="abc">
<ul>
  <li><a href="index.html">Home</a></li>
  <li><a href="Viewbook.jsp">View Book</a></li>
  <li><a href="Addbook.jsp">Add Book</a></li>
  <li><a href="Issuebook.jsp">Issue Book</a></li>
  <li><a href="Returnbook.jsp">Return Book</a></li>
  <li><a href="LibrarionLogout.jsp">Logout</a></li>
 </ul>
</div>
<c:if test="${empty sessionScope['loginUsername1'] or empty sessionScope['loginpassword1']}">
<c:redirect url="index.html"/>
</c:if>

<sql:setDataSource var="db" 
driver="com.mysql.jdbc.Driver" 
url="jdbc:mysql://localhost:3306/test"
user="root" password="root"/>

<sql:query var="rs" dataSource="${db}">select * from issuebook</sql:query>

<table border="1" cellspacing="0">
<tr><th>Book ID</th><th>Student Id</th><th>Student Name</th><th>Student Monile</th></tr>
<c:forEach items="${rs.rows}" var="row">
<tr>
	<td>${row.BookId}</td>
	<td>${row.StudentId}</td>
	<td>${row.StudentName}</td>
	<td>${row.StudentMonile}</td>
</tr>

</c:forEach>
</table>
</body>
</html>