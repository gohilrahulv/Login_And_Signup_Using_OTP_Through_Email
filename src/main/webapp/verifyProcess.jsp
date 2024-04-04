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
        Model m2 =new Model();
		m2.setEmail(email);

        // Store the email in the session
        HttpSession ses = request.getSession();
        ses.setAttribute("email",email);
    	String userEmail = m2.getEmail();



            // Check if the email is registered
            Dao dao = new Dao(); // Assuming Dao is your data access object
            boolean isEmailRegistered = dao.isEmailRegistered(email);

            if (isEmailRegistered) {
                // Check if the email is already verified
                boolean isEmailVerified = dao.isEmailVerified(email);

                if (isEmailVerified) {
                	request.setAttribute("error", "This email is already verified. Login");
                    request.getRequestDispatcher("verify.jsp").forward(request, response);
        %>
                    
        <%
                } else {
                    // Logic for sending a new verification code can be added here
                    // dao.sendVerificationCode(email);
                    // Send OTP to the user's email
					
					EmailUtility.sendOtpEmail(email,request);
					response.sendRedirect("votp.jsp");
                   
                   
        %>
                    
        <%
                }
            } else {
	            	request.setAttribute("error", "This email is not registered. Please sign up.");
	                request.getRequestDispatcher("verify.jsp").forward(request, response);
        %>
               
        <%
            }
        %>

    </div>


</body>
</html>
