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

    <script>
        function check(email) {
            var xmlHttp = GetXmlHttpObject();
            var url = "checkajax1.jsp";
            url = url + "?email=" + encodeURIComponent(email);

            xmlHttp.onreadystatechange = function () {
                if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                    var showdata = xmlHttp.responseText.trim();
                    document.getElementById("mydiv").innerHTML = showdata;

                    if (showdata === "Ok!") {
                        // Email is verified, you can proceed with the form submission or any other action
                        //document.getElementById('emailError').innerText = showdata;
                        document.forms['forgot'].submit(); // Submit the form
                    } else {
                        // Email is not verified, show error
                        document.getElementById('emailError').innerText = showdata;
                    }
                }
            };

            xmlHttp.open("GET", url, true);
            xmlHttp.send(null);
        }

        function GetXmlHttpObject() {
            var xmlHttp = null;
            try {
                // Firefox, Opera 8.0+, Safari
                xmlHttp = new XMLHttpRequest();
            } catch (e) {
                // Internet Explorer
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
        <a href="signup.jsp">Sign Up</a>
        <a class="active" href="login.jsp">Login</a>
    </div>

    <center>
        <div class="container">
            <form name="forgot" action="forgotProcess.jsp" method="post" onsubmit="check(document.forms['forgot']['email'].value); return false;" style="border:1px solid #ccc">
                <p>Enter Your Email For Forgot Password</p>

                <label for="email"><b>Email</b></label><br>
                <input type="text" placeholder="Enter Email" name="email" required><br>
                <div>
            <p>if your email is registered but not verifyed <a href="verify.jsp">Click Here</a> </p>
            </div>
                <div class="clearfix">
                    <button type="submit">Submit</button>
                </div>

                <div id="emailError" class="error"></div>
                <div id="mydiv" hidden=""></div>
            </form>
        </div>
    </center>
</body>
</html>
