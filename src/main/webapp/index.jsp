<%@ page import="com.dao.Dao" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Home</title>
    <link rel="stylesheet" href="style.css" />
</head>
<body>

<jsp:include page="header.jsp"></jsp:include>

<div class="topnav">
    <a class="active" href="index.jsp">Home</a>
    
    <%-- Check if the user is logged in --%>
    <% HttpSession userSession = request.getSession(false); %>
    <% if (userSession != null && userSession.getAttribute("userEmail") != null) { %>
        <!-- User is logged in -->
        <%--<a href="logout.jsp">Logout(<%= userSession.getAttribute("fname") %>)</a>--%>
        <%
        String userEmail = (String) userSession.getAttribute("userEmail");
        String userFname = Dao.getUserFirstName(userEmail); 
        %>
        <a href="logout.jsp">Logout(<%= userFname %>)</a>
        
        <a href="changePassword.jsp">Change Password</a>
    <% } else { %>
        <!-- User is not logged in -->
        <a href="signup.jsp">Sign Up</a>
        <a href="login.jsp">Login</a>
    <% } %>
</div>

<!-- Add your main content here -->

</body>
</html>
