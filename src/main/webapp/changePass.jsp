<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>



<%@page import="com.dao.Dao"%>
<%@page import="com.model.Model"%>
<%@page import="java.util.Random"%>
<%@page import="com.utility.EmailUtility"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@page import="java.io.PrintWriter"%>
<%@page import="javax.servlet.RequestDispatcher"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.annotation.WebServlet"%>
<%@page import="javax.servlet.http.HttpServlet"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>


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
        input[type=password] {
            width: 25%;
            padding: 15px;
            margin: 5px 0 0 0;
            display: inline-block;
            border: none;
            background: #f1f1f1;
        }

        input[type=password]:focus {
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
            width: 20%;
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
		.error {
		  color: red;
		  font-size: 14px;
		}

       
        
        
    </style>
   <script type="text/javascript">
    function validateForm() {
        var newPassword = document.forms["changepass"]["newPassword"].value;
        var confirmPassword = document.forms["changepass"]["confirmPassword"].value;

        document.getElementById('newPassworderror').innerText = "";
        document.getElementById('confirmPassworderror').innerText = "";

        var uppercaseRegex = /[A-Z]/;
        if (!uppercaseRegex.test(newPassword)) {
            document.getElementById('newPassworderror').innerText = "Password must contain at least one uppercase letter";
            return false;
        }

        var lowercaseRegex = /[a-z]/;
        if (!lowercaseRegex.test(newPassword)) {
            document.getElementById('newPassworderror').innerText = "Password must contain at least one lowercase letter";
            return false;
        }

        var digitRegex = /\d/;
        if (!digitRegex.test(newPassword)) {
            document.getElementById('newPassworderror').innerText = "Password must contain at least one digit";
            return false;
        }

        var specialCharRegex = /[@$!%*?&]/;
        if (!specialCharRegex.test(newPassword)) {
            document.getElementById('newPassworderror').innerText = "Password must contain at least one special character (@$!%*?&)";
            return false;
        }

        if (newPassword.length < 8) {
            document.getElementById('newPassworderror').innerText = "Password must be more than 8 characters long";
            return false;
        }

        if (newPassword !== confirmPassword) {
            document.getElementById('confirmPassworderror').innerText = "Password and Confirm Password do not match.";
            return false;
        }
    }
</script>

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
	  <%
    response.setContentType("text/html;charset=UTF-8");
    PrintWriter otpVerifyOut = response.getWriter();

    try {
        // Get the user-entered OTP and the stored OTP from the session
        String userEnteredOTP = request.getParameter("OTP");
        String storedOTP = (String) request.getSession().getAttribute("otp");

        // Check if the entered OTP matches the stored OTP
        if (userEnteredOTP != null && userEnteredOTP.equals(storedOTP)) {
            request.getSession().setAttribute("otpVerified", true);
%>
	    
    <jsp:include page="header.jsp"></jsp:include>
    <div class="topnav">
        <a href="index.jsp">Home</a>
        <a href="signup.jsp">Sign Up</a>
        <a class="active" href="login.jsp">Login</a>
    </div>
    <center>
        <!-- Display change password form only if OTP is verified -->
        <c:if test="${not empty otpVerified and otpVerified}">
            <form name="changepass" action="changePassProcess.jsp" onsubmit="return validateForm()" method="post" style="border: 1px solid #ccc">
                <p>Change Password</p>
                <hr>

                <label for="newPassword"><b>New Password</b></label><br>
                <input type="password" placeholder="Enter New Password" name="newPassword" required><br>
				<span id="newPassworderror" class="error"></span><br><br>
				
                <label for="confirmPassword"><b>Confirm Password</b></label><br>
                <input type="password" placeholder="Confirm Password" name="confirmPassword" required><br>
                <span id="confirmPassworderror" class="error"></span><br>
                <br>
				<br>
                <div class="clearfix">
                    <button type="submit">Change Password</button>
                </div>
            </form>
        </c:if>
</center>
    
</body>
</html>
<%
        } else {
            // Incorrect OTP, display an error message
            request.setAttribute("error", "Incorrect OTP. Please try again or resend OTP by clicking on Resend OTP");
            RequestDispatcher dispatcher = request.getRequestDispatcher("fotp.jsp");
            dispatcher.forward(request, response);
        }
    } catch (Exception e) {
        e.printStackTrace();
        otpVerifyOut.print("Exception occurred: " + e.getMessage());
    }
%>
