<%@ page import="com.dao.Dao" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Login</title>
    <link rel="stylesheet" href="style.css" />
    <style>
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
        function showError(errorMessage) {
            document.getElementById('loginError').innerText = errorMessage;
        }
    </script>
</head>
<body>

<jsp:include page="header.jsp"></jsp:include>

<div class="topnav">
    <a href="index.jsp">Home</a>
    <a href="signup.jsp">Sign Up</a>
    <a class="active" href="login.jsp">Login</a>
</div>

<center>
    <form name="loginForm" action="loginProcess.jsp" method="post" style="border:1px solid #ccc">
        <div class="container">
            
            <p>Please enter your credentials to log in.</p>
            <hr>
            
             <!-- Display password change success message -->
            
            <%
                HttpSession csession = request.getSession(false);
                if (csession != null && csession.getAttribute("passwordChangeSuccess") != null) {
                    out.println("<div class='success' style='color: green'>" + csession.getAttribute("passwordChangeSuccess") + "</div>");
                    csession.removeAttribute("passwordChangeSuccess"); // Remove attribute after displaying
                }
            %>
            
            

            <label for="email"><b>Email</b></label><br>
            <input type="text" placeholder="Enter Email" name="email" required><br>

            <label for="pass"><b>Password</b></label><br>
            <input type="password" placeholder="Enter Password" name="pass" required><br>
            <span id="loginError" class="error">
                <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
            </span>
            <div>
            <p>if your email is registered but not verifyed <a href="verify.jsp">Click Here</a> </p>
            </div>
            <div class="clearfix">
                <button type="submit" onclick="showError('');">Login</button>
            </div>
            <p><a href="forgot.jsp">Forgot Password?</a></p>
        </div>
    </form>
</center>
</body>
</html>
