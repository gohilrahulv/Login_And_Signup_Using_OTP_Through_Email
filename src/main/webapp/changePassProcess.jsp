<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.dao.Dao"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="javax.servlet.ServletException"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Password Change Status</title>
    <script>
        function showAlert(message) {
            alert(message);
            window.location.href = "login.jsp"; // Redirect to login.jsp
        }
    </script>
</head>
<body>
<%
    try {
        // Retrieve user email and new password from the form
        HttpSession session1 = request.getSession();
        String userEmail = (String) session.getAttribute("email");
        String newPassword = request.getParameter("newPassword");

        // Update the password in the database
        boolean passwordChanged = Dao.updatePassword(userEmail, newPassword);

        if (passwordChanged) {
            // Password successfully changed
%>
            <script>
                showAlert('Password changed successfully!,Login With New Password');
            </script>
<%
        } else {
            // Password change failed
%>
            <script>
                showAlert('Failed to change password. Please try again.');
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            showAlert('Exception occurred: <%= e.getMessage() %>');
        </script>
<%
    }
%>
</body>
</html>
