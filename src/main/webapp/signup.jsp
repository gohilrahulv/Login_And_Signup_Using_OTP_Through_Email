<%@page import="com.dao.Dao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sign Up</title>
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

<script>
function validateForm() {
    var email = document.forms["signupForm"]["email"].value;
    var mobile = document.forms["signupForm"]["mobile"].value;
    var pass = document.forms["signupForm"]["pass"].value;
    var cpass = document.forms["signupForm"]["cpass"].value;

    document.getElementById('emailError').innerText = "";
    document.getElementById('mobileError').innerText = "";
    document.getElementById('passError').innerText = "";
    document.getElementById('cpassError').innerText = "";

    var emailRegex = /^\S+@\S+\.\S+$/;
    if (!emailRegex.test(email)) {
        document.getElementById('emailError').innerText = "Please enter a valid email address";
        return false;
    }

    var mobileRegex = /^\d{10}$/;
    if (!mobileRegex.test(mobile)) {
        document.getElementById('mobileError').innerText = "Please enter a valid 10-digit mobile number";
        return false;
    }

    var uppercaseRegex = /[A-Z]/;
    if (!uppercaseRegex.test(pass)) {
        document.getElementById('passError').innerText = "Password must contain at least one uppercase letter";
        return false;
    }

    var lowercaseRegex = /[a-z]/;
    if (!lowercaseRegex.test(pass)) {
        document.getElementById('passError').innerText = "Password must contain at least one lowercase letter";
        return false;
    }

    var digitRegex = /\d/;
    if (!digitRegex.test(pass)) {
        document.getElementById('passError').innerText = "Password must contain at least one digit";
        return false;
    }

    var specialCharRegex = /[@$!%*?&]/;
    if (!specialCharRegex.test(pass)) {
        document.getElementById('passError').innerText = "Password must contain at least one special character (@$!%*?&)";
        return false;
    }

    if (pass.length <= 8) {
        document.getElementById('passError').innerText = "Password must be more than 8 characters long";
        return false;
    }

    if (pass !== cpass) {
        document.getElementById('cpassError').innerText = "Password and Confirm Password do not match.";
        return false;
    }

    check(email, function (emailValidationResult) {
        if (emailValidationResult === "Email available for signup!") {
            checkMobile(mobile, function (mobileValidationResult) {
                if (mobileValidationResult === "Mobile available for signup!") {
                    document.forms["signupForm"].submit();
                } else {
                    document.getElementById('mobileError').innerText = mobileValidationResult;
                }
            });
        } else {
            document.getElementById('emailError').innerText = emailValidationResult;
        }
    });

    return false;
}

function check(email, callback) {
    var xmlHttp = GetXmlHttpObject();
    var url = "checkajax.jsp";
    url = url + "?email=" + encodeURIComponent(email);
    xmlHttp.onreadystatechange = function () {
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
            var showdata = xmlHttp.responseText.trim();
            document.getElementById("mydiv").innerHTML = showdata;

            if (showdata === "Email available for signup!") {
                callback(showdata);
            } else {
                document.getElementById('emailError').innerText = showdata;
            }
        }
    };
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);
}

function checkMobile(mobile, callback) {
    var xmlHttpMobile = GetXmlHttpObject();
    var urlMobile = "checkmajax.jsp";
    urlMobile = urlMobile + "?mobile=" + encodeURIComponent(mobile);
    xmlHttpMobile.onreadystatechange = function () {
        if (xmlHttpMobile.readyState == 4 && xmlHttpMobile.status == 200) {
            var showdataMobile = xmlHttpMobile.responseText.trim();
            document.getElementById("mobileError").innerText = showdataMobile;

            if (showdataMobile === "Mobile available for signup!") {
                callback(showdataMobile);
            } else {
                document.getElementById('mobileError').innerText = showdataMobile;
            }
        }
    };
    xmlHttpMobile.open("GET", urlMobile, true);
    xmlHttpMobile.send(null);
}

function GetXmlHttpObject() {
    var xmlHttp = null;
    try {
        xmlHttp = new XMLHttpRequest();
    } catch (e) {
        try {
            xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
    }
    return xmlHttp;
}
</script>
</head>
<body>

<jsp:include page="header.jsp"></jsp:include>

<div class="topnav">
  <a href="index.jsp">Home</a>
  <a class="active" href="signup.jsp">Sign Up</a>
  <a href="login.jsp">Login</a>
</div>

<form name="signupForm" action="insert.jsp" method="post" onsubmit="return validateForm()" style="border:1px solid #ccc">
  <div class="container">
    <P>Sign Up Form</P>
    <p>Please fill in this form to create an account.</p>
    <hr>

    <label for="fname"><b>First Name</b></label><br>
    <input type="text" placeholder="Enter First Name" name="fname" required><br>

    <label for="lname"><b>Last Name</b></label><br>
    <input type="text" placeholder="Enter Last Name" name="lname" required><br>

    <label for="email"><b>Email</b></label><br>
    <input type="text" placeholder="Enter Email" name="email" required>
    <span id="emailError" class="error"></span>
    <div id="mydiv" hidden=""></div><br> 

    <label for="mobile"><b>Mobile</b></label><br>
    <input type="text" placeholder="Enter Mobile" name="mobile" required>
    <span id="mobileError" class="error"></span>
    <div id="mobileError" hidden=""></div><br> 

    <label for="address"><b>Address</b></label><br>
    <textarea placeholder="Enter Address" name="address" required></textarea><br>

    <label><b>Gender</b></label><br><br>
    <input type="radio" id="male" name="gender" value="male" required>
    <label for="male">Male</label>
    <input type="radio" id="female" name="gender" value="female" required>
    <label for="female">Female</label><br><br><br>

    <label for="pass"><b>Password</b></label><br>
    <input type="password" placeholder="Enter Password" name="pass" required>
    <span id="passError" class="error"></span><br>

    <label for="cpass"><b>Confirm Password</b></label><br>
    <input type="password" placeholder="Repeat Password" name="cpass" required>
    <span id="cpassError" class="error"></span><br>

    <p>By creating an account you agree to our <a style="color:dodgerblue">Terms And Privacy</a>.</p>

    <div class="clearfix">
      <button type="submit" class="signupbtn">Sign Up</button>
    </div>
  </div>
</form>

</body>
</html>
