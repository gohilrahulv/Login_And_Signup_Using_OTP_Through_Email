<%@page import="com.dao.Dao"%>
<%@page import="com.model.Model"%>
<%@page import="java.util.Random"%>
<%@page import="com.utility.EmailUtility"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<jsp:useBean id="m2" class="com.model.Model"/>    
<jsp:setProperty property="*" name="m2"/>
<!DOCTYPE html>
<html>
<head>
<title>Verify OTP</title>

<link rel="stylesheet" href="style.css" />
    <style>
        /* Full-width input fields */
        input[type=text] {
            width: 25%;
            padding: 15px;
            margin: 5px 0 0 0;
            display: inline-block;
            border: none;
            background: #f1f1f1;
        }

        input[type=text]:focus {
            background-color: #ddd;
            outline: none;
        }

        hr {
            border: 1px solid #f1f1f1;
            margin-bottom: 25px;
        }

        /* Set a style for all buttons */
        button {
            background-color: #04AA6D;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            width: 70%;
            opacity: 0.9;
        }

        button:hover {
            opacity: 1;
        }

      
        /* Float cancel and signup buttons and add an equal width */
        .vbtn {
            width: 10%;
        }

        /* Add padding to container elements */
        .container {
            padding: 16px;
        }

        /* Clear floats */
        .clearfix::after {
            content: "";
            clear: both;
            display: table;
        }

        /* Change styles for cancel button and signup button on extra small screens */
        @media screen and (max-width: 300px) {
            .vbtn {
                width: 100%;
            }
        }
        .vbtn1 {
    color: #2196f3!important;
    margin-left: 15%;
    
    font-size: small;
    
}
        
        
    </style>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
<meta charset="ISO-8859-1">
<title></title>
</head>
<body>
<%
// Retrieve the email from the session
HttpSession ses = request.getSession();
String email = (String) ses.getAttribute("email");
m2.setEmail(email);

//Check if OTP resend is triggered
String resendTriggered = request.getParameter("resend");
 if ("true".equals(resendTriggered)) {
        // Send OTP to the user's email
        
        boolean otpResent = EmailUtility.sendOtpEmail(m2.getEmail(), request);

        if (otpResent) {
        	request.setAttribute("otpResent", "OTP Resent successfully.");
        } else {
        	request.setAttribute("error", "Failed to resend OTP. Please try again.");
        }
    }

%>
	    
    <jsp:include page="header.jsp"></jsp:include>
    <div class="topnav">
        <a href="index.jsp">Home</a>
        <a class="active" href="signup.jsp">Sign Up</a>
        <a href="login.jsp">Login</a>
    </div>
    <center>
        <form action="verifyOtp" style="border: 1px solid #ccc" method="post">
            <div class="container">
                <p>OTP Sent To : <%=email%></p>
                <hr>
                <c:if test="${not empty error}">
            	<div style="color: red;">${error}</div>
        		</c:if>
        		<c:if test="${not empty otpResent}">
                <p style="color: green;">${otpResent}</p>
            	</c:if>
                <label for="otp1"><b>Enter Your 4-Digit OTP</b></label><br>
                <input type="text" placeholder="Enter OTP" name="OTP" maxlength="4">
                <p style="font-size :smaller; margin: 0 0 0 0;">Did not receive the email? Check your spam folder, or</p>
                
    			<a href="?resend=true" class="vbtn1">Resend OTP</a>
    			
                <div class="clearfix">
                    <button type="submit" class="vbtn">Verify</button>
                   
                    
                </div>
                
            </div>
        </form>
    </center>
    
</body>
</html>