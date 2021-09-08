<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Return Book</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<div class="abc">
<ul>
  <li><a href="index.html">Home</a></li>
  <li><a href="Viewbook.jsp">View Book</a></li>
  <li><a href="Addbook.jsp">Add Book</a></li>
  <li><a href="Issuebook.jsp">Issue Book</a></li>
  <li><a href="Viewissuedbook.jsp">View Issued Book</a></li>
  <li><a href="LibrarionLogout.jsp">Logout</a></li>
 </ul>
</div>
<h3>Return Book</h3>

<form action="" method="post">
Book Id<br/>
<input type="text" name="bookid"/><br/>
Student Id<br/>
<input type="text"name="studentid"/><br/>
<button type="submit">Return Book</button><br/><br/>
</form>
<c:if test="${empty sessionScope['loginUsername1'] or empty sessionScope['loginpassword1']}">
<c:redirect url="index.html"/>
</c:if>

<sql:setDataSource var="db" 
driver="com.mysql.jdbc.Driver" 
url="jdbc:mysql://localhost:3306/test"
user="root" password="root"/>

<c:choose>
<c:when test="${not empty param.bookid && not empty param.studentid}">

<sql:query var="rs" dataSource="${db}">
select * from bookdetail where BookId="${param.bookid}"
</sql:query>
<c:forEach items="${rs.rows}" var="row">

<c:set var="qty" value="${row.Quantity}"/>

<c:choose>
<c:when test="${row.BookId eq param.bookid}">
<sql:update var="row1" dataSource="${db}">
DELETE FROM issuebook WHERE BookId="${param.bookid}" and StudentId="${param.studentid}"
</sql:update>
<c:out value="Issued Book Removed Succesfully"/>

<c:set var="qty" value="${qty+1}"/>

<sql:update var="row2" dataSource="${db}">
UPDATE bookdetail set Quantity="${qty}" WHERE BookId="${param.bookid}";
</sql:update>

</c:when>
<c:otherwise><c:out value="Book Return Failed! Try Again."/></c:otherwise>
</c:choose>

</c:forEach>
</c:when>
<c:otherwise><c:out value="Book Return Failed! Try Again."/></c:otherwise>
</c:choose>


</body>
</html>