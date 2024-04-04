<%@ page import="com.dao.Dao" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@page import="com.model.Model"%>
    
<jsp:useBean id="m" class="com.model.Model"/>    
<jsp:setProperty property="*" name="m"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Login Process</title>
    <!-- Add your stylesheet link if needed -->
</head>
<body>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("pass");
    String fname = request.getParameter("fname");

    String loginStatus = Dao.checkLoginStatus(email, password);

    switch (loginStatus) {
        case "success":
            // Set up session for successful login
            HttpSession userSession = request.getSession(true);
            userSession.setAttribute("userEmail", email);
            userSession.setAttribute("userFname", fname); 
            System.out.println("fname: " + fname);
            System.out.println("userFname in session: " + userSession.getAttribute("userFname"));

            response.sendRedirect("index.jsp"); // Redirect to success page or wherever you want
            break;
        case "incorrect_password":
            request.setAttribute("error", "Incorrect password. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            break;
        case "unverified_email":
            request.setAttribute("error", "Email is registered but not verified. Please verify your email.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            break;
        case "email_not_registered":
            request.setAttribute("error", "Email is not registered. Please sign up.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            break;
        default:
            request.setAttribute("error", "Unexpected error. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
    }
%>

</body>
</html>
