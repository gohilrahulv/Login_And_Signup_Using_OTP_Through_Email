<%@page import="com.utility.EmailUtility"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title></title>
</head>
<body>
<%
// Send OTP to the user's email
String userEmail = (String) session.getAttribute("email");
String userFname = (String) session.getAttribute("fname");
EmailUtility.sendOtpEmail(userEmail,request);
response.sendRedirect("otp.jsp");

%>
</body>
</html>