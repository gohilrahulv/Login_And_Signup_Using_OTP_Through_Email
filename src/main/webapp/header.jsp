<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {
  margin: 0;
  font-family: Arial, Helvetica, sans-serif;
}

.topna {
  overflow: hidden;
  background-color: #333;
  display: flex;
  justify-content: center;
  position: fixed;
      width: 100%;
      top: 0;
      z-index: 1000; 
   
}

.topna a {
  float: left;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
}



.topna a.active {
  background-color: #04AA6D;
  color: white;
}
</style>
</head>
<body>

<div class="topna">
  <center>
  <a href="index.jsp">User Profile management</a>
  </center>
</div>



</body>
</html>
