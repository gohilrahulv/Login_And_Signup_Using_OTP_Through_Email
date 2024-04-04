<%@page import="com.model.Model"%>
<%@page import="com.utility.EmailUtility"%>
<%@ page import="com.dao.Dao" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title></title>
    <link rel="stylesheet" href="style.css" />
    <style>
        /* Add your styles if needed */
    </style>
    <!-- Add any JavaScript functions if needed -->
</head>
<body>

<jsp:include page="header.jsp"></jsp:include>

<div class="topnav">
    <a href="index.jsp">Home</a>
    <a class="active" href="signup.jsp">Sign Up</a>
    <a href="login.jsp">Login</a>
</div>

<div class="container">
    <h2>Email Verification</h2>
    <hr>

    <% 
        // Retrieve the email from the form submission
        String email = request.getParameter("email");
        Model m2 = new Model();
        m2.setEmail(email);

        // Store the email in the session
        HttpSession ses = request.getSession();
        ses.setAttribute("email", email);
        String userEmail = m2.getEmail();

        // Send OTP to the user's email
        boolean isOtpSent = false;

        try {
            isOtpSent = EmailUtility.sendOtpEmail(email, request);
        } catch (Exception e) {
            // Handle any exceptions that might occur during email sending
            e.printStackTrace();

            // Set an error attribute to display an error message in verify.jsp
            request.setAttribute("error", "Error sending OTP. Please try again.");
            request.getRequestDispatcher("forgot.jsp").forward(request, response);
        }

        if (isOtpSent) {
            // Redirect to votp.jsp after sending OTP successfully
            response.sendRedirect("fotp.jsp");
        } else {
            // Set an error attribute to display an error message in verify.jsp
            request.setAttribute("error", "Error sending OTP. Please try again.");
            request.getRequestDispatcher("forgot.jsp").forward(request, response);
        }
    %>
</div>

</body>
</html>
