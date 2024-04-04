<%@ page import="com.dao.Dao" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Change Password</title>
    <link rel="stylesheet" href="style.css" />
    <style>
        /* Full-width input fields */
        input[type=text], input[type=password] {
          width: 70%;
          padding: 15px;
          margin: 5px 0 22px 0;
          display: inline-block;
          border: none;
          background: #f1f1f1;
        }

        input[type=text]:focus, input[type=password]:focus {
          background-color: #ddd;
          outline: none;
        }

        textarea {
            width: 70%;
            padding: 15px;
            margin: 5px 0 22px 0;
            display: inline-block;
            border: none;
            background: #f1f1f1;
            height: 150px;
            font-size: 16px;
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
          opacity:1;
        }

        /* Extra styles for the cancel button */
        .cancelbtn {
          padding: 14px 20px;
          background-color: #f44336;
        }

        .cancelbtn, .signupbtn {
          float: left;
          width: 50%;
        }

        .container {
          padding: 16px;
        }

        .clearfix::after {
          content: "";
          clear: both;
          display: table;
        }

        @media screen and (max-width: 300px) {
          .cancelbtn, .signupbtn {
             width: 100%;
          }
        }

        .error {
          color: red;
          font-size: 14px;
        }
    </style>
    <script type="text/javascript">
        function validateForm() {
            var oldPass = document.forms["changePasswordForm"]["oldPass"].value;
            var newPass = document.forms["changePasswordForm"]["newPass"].value;
            var confirmNewPass = document.forms["changePasswordForm"]["confirmNewPass"].value;

            document.getElementById('oldPassError').innerText = "";
            document.getElementById('newPassError').innerText = "";
            document.getElementById('confirmNewPassError').innerText = "";

            // Add your password validation logic here

            var uppercaseRegex = /[A-Z]/;
            if (!uppercaseRegex.test(newPass)) {
                document.getElementById('newPassError').innerText = "Password must contain at least one uppercase letter";
                return false;
            }

            var lowercaseRegex = /[a-z]/;
            if (!lowercaseRegex.test(newPass)) {
                document.getElementById('newPassError').innerText = "Password must contain at least one lowercase letter";
                return false;
            }

            var digitRegex = /\d+/;
            if (!digitRegex.test(newPass)) {
                document.getElementById('newPassError').innerText = "Password must contain at least one digit";
                return false;
            }

            var specialCharRegex = /[@$!%*?&]/;
            if (!specialCharRegex.test(newPass)) {
                document.getElementById('newPassError').innerText = "Password must contain at least one special character (@$!%*?&)";
                return false;
            }

            if (newPass.length < 8) {
                document.getElementById('newPassError').innerText = "Password must be at least 8 characters long";
                return false;
            }

            if (newPass !== confirmNewPass) {
                document.getElementById('confirmNewPassError').innerText = "New Password and Confirm New Password do not match.";
                return false;
            }

            return true;
        }
    </script>
</head>
<body>

<jsp:include page="header.jsp"></jsp:include>

<div class="topnav">
    <a href="index.jsp">Home</a>
    
    <%-- Check if the user is logged in --%>
    <% HttpSession userSession = request.getSession(false); %>
    <% if (userSession != null && userSession.getAttribute("userEmail") != null) { %>
        <!-- User is logged in -->
        <%
        String userEmail = (String) userSession.getAttribute("userEmail");
        String userFname = Dao.getUserFirstName(userEmail); 
        %>
        <a href="logout.jsp">Logout(<%= userFname %>)</a>
        <a class="active" href="changePassword.jsp">Change Password</a>
    <% } else { %>
        <!-- User is not logged in -->
        <a href="signup.jsp">Sign Up</a>
        <a href="login.jsp">Login</a>
    <% } %>
    <%
    String cerreo = (String) request.getAttribute("changePasswordError");
    if (cerreo == null) {
        cerreo = "";  // set it to an empty string if null
    }
	%>

</div>

<center>
    <form name="changePasswordForm" action="changePasswordProcess.jsp" method="post" onsubmit="return validateForm()" style="border:1px solid #ccc">
        <div class="container">
            
            <p>Please enter your old and new passwords.</p>
            <hr>

            <label for="oldPass"><b>Old Password</b></label><br>
            <input type="password" placeholder="Enter Old Password" name="oldPass" required><br>
            <span id="oldPassError" class="error"><%= cerreo %></span></span><br>

            <label for="newPass"><b>New Password</b></label><br>
            <input type="password" placeholder="Enter New Password" name="newPass" required><br>
            <span id="newPassError" class="error"></span>
            <br>

            <label for="confirmNewPass"><b>Confirm New Password</b></label><br>
            <input type="password" placeholder="Confirm New Password" name="confirmNewPass" required><br>
            <span id="confirmNewPassError" class="error"></span>

            <div class="clearfix">
                <button type="submit">Change Password</button>
            </div>
        </div>
    </form>
    
</center>

</body>
</html>
