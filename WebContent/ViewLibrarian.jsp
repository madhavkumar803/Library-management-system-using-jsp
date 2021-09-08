<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>view Librarion</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<<div class="abc">
<ul>
  <li><a href="index.html">Home</a></li>
  <li><a href="AddLibrarian.jsp">Add Librarian</a></li>
  <li><a href="ViewLibrarian.jsp">View Librarian</a></li>
  <li><a href="DeleteLibrarian.jsp">Delete Librarian</a></li>
  <li><a href="AdminLogout.jsp">Logout</a></li>
</ul>
</div>
<c:if test="${empty sessionScope['loginUsername'] or empty sessionScope['loginpassword']}">
<c:redirect url="index.html"/>
</c:if>

<sql:setDataSource var="db" 
driver="com.mysql.jdbc.Driver" 
url="jdbc:mysql://localhost:3306/test"
user="root" password="root"/>

<sql:query var="rs" dataSource="${db}">
select * from librarianlogin
</sql:query>

<table border="1" width="100%" cellpadding="4" cellspacing="0">
<tr>
	<th>Name</th>
	<th>User Name</th>
	<th>Password</th>
	<th>Mobile</th>
</tr>
<c:forEach items="${rs.rows}" var="row">
<tr>
	<th><c:out value="${row.name}"/></th>
	<th><c:out value="${row.uname}"/></th>
	<th><c:out value="${row.pass}"/></th>
	<th><c:out value="${row.mob}"/></th>
</tr>
</c:forEach>
</table>

</body>
</html>