<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
<title>SignUp Pagen</title>
<sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
url = "jdbc:mysql://localhost:3307/test"
user = "root"  password = "root"/>
</head>
<body>
<form action="#" method="post">
<table border="0" cellspacing="2" cellpadding="5">
<thead>
    <tr>
        <th colspan="2">SignUp Form</th>
    </tr>
</thead>
<tbody>
	<tr>
       <td><label>User Name</label></td>
       <td><input type="text" name="uname"/></td>
   	</tr>
   	<tr>
       <td><label>Password</label></td>
       <td><input type="text" name="pass"/></td>
   	</tr>
	<tr>
 		<td><input type="submit" value="SignUp" /></td>
		<td><input type="reset" value="Reset"/></td>
	</tr>
</tbody>
</table>
</form>
<p>Existiing User | <a href="Login.jsp">Login Here </a></p>


<c:if test="${ empty param.uname or empty param.pass}">
<c:redirect url="Signup.jsp" >

</c:redirect>
</c:if>

<sql:update dataSource="${snapshot}" var="result">
INSERT INTO logindata (uname,pass) VALUES (?,?);
<sql:param value="${param.uname}"/>
<sql:param value="${param.pass}"/>
</sql:update>
<c:if test="${result>=1}">
Congratulations ! Data inserted successfully.
</c:if>
</body>
</html>