<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Book</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<div class="abc">
<ul>
  <li><a href="index.html">Home</a></li>
  <li><a href="Viewbook.jsp">View Book</a></li>
  <li><a href="Issuebook.jsp">Issue Book</a></li>
  <li><a href="Viewissuedbook.jsp">View Issued Book</a></li>
  <li><a href="Returnbook.jsp">Return Book</a></li>
  <li><a href="LibrarionLogout.jsp">Logout</a></li>
 </ul>
</div>
<h3>Add Book</h3>
<form action="" method="post">
Book Id<br/>
<input type="text" name="bookid"/><br/>
Name<br/>
<input type="text" name="name"/><br/>
Quantity<br/>
<input type="number" name="qty"/><br/><br/>
<button type="submit">Save Book</button>
</form>
<c:if test="${empty sessionScope['loginUsername1'] or empty sessionScope['loginpassword1']}">
<c:redirect url="index.html"/>
</c:if>

<sql:setDataSource var="db" 
driver="com.mysql.jdbc.Driver" 
url="jdbc:mysql://localhost:3306/test"
user="root" password="root"/>

<c:if test="${not empty param.bookid and not empty param.name and not empty param.qty}">

<sql:update var="rs" dataSource="${db}">
insert into bookdetail(BookId,BookTitle,Quantity) values (?,?,?);
<sql:param value="${param.bookid}"/>
<sql:param value="${param.name}"/>
<sql:param value="${param.qty}"/>
</sql:update>
</c:if>

<c:set var="ispass" value="0"/>
<sql:query var="rs" dataSource="${db}">
select * from bookdetail where BookId="${param.bookid}"
</sql:query>
<c:forEach items="${rs.rows}" var="row">
<c:if test="${row.BookId eq param.bookid}">
<c:set var="ispass" value="1"/>
</c:if>

</c:forEach>
<c:choose>
<c:when test="${ispass>0}"><c:out value="Book Added Succesfully"/></c:when>
<c:otherwise><c:out value="Book Not Added Try Again "/></c:otherwise>
</c:choose>
</body>
</html>