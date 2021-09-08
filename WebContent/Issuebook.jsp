<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Issue Book</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<div class="abc">
<ul>
  <li><a href="index.html">Home</a></li>
  <li><a href="Viewbook.jsp">View Book</a></li>
  <li><a href="Addbook.jsp">Add Book</a></li>
  <li><a href="Viewissuedbook.jsp">View Issued Book</a></li>
  <li><a href="Returnbook.jsp">Return Book</a></li>
  <li><a href="LibrarionLogout.jsp">Logout</a></li>
 </ul>
</div>
<h3>Issue Book</h3>
<form action="" method="post">
Book Id<br/>
<input type="number" name="bookid"/><br/>
Student Id<br/>
<input type="text" name="studentid"/><br/>
 Student Name<br/>
<input type="text" name="studentname" /><br/>
Student Mobile<br/>
<input type="number" name="studentmobile"/><br/><br/>
<button type="submit"> Issue Book</button>
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
Insert into issuebook (BookId, StudentId, StudentName, StudentMonile) values(?,?,?,?)
<sql:param value="${param.bookid}"/>
<sql:param value="${param.studentid}"/>
<sql:param value="${param.studentname}"/>
<sql:param value="${param.studentmobile}"/>
</sql:update>
<c:set var="qty" value="${qty-1}"/>
<c:out value="Book Issued Succesfully"/>

<sql:update var="row2" dataSource="${db}">
UPDATE bookdetail set Quantity="${qty}" where Bookid="${row.BookId}"
</sql:update>

</c:when>
<c:otherwise><c:out value="Book Issue Failed! Try Again."/></c:otherwise>
</c:choose>

</c:forEach>
</c:when>
<c:otherwise><c:out value="Book Issue Failed! Try Again."/></c:otherwise>
</c:choose>
</body>
</html>