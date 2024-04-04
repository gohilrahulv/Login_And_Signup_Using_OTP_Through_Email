<%@ page import="java.sql.*" %>
<%
    String email = request.getParameter("email").toString();
    String message = "";

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Connect to the database
        String jdbcURL = "jdbc:mysql://localhost:3306/aj";
        String dbUser = "root";
        String dbPassword = "";
        Connection con = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // Create a statement and execute a query
		String query = "SELECT * FROM my WHERE email=?";
        try (PreparedStatement preparedStatement = con.prepareStatement(query)) {
            preparedStatement.setString(1, email);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                if ("verify".equals(rs.getString("login_status"))) {
                    // Email exists, and status is verified
                    message = "Ok!";
                } else {
                    // Email exists, but status is not verified
                    message = "Email is registered, but the account is not yet verified. Please verify your account.";
                }
            } else {
                // Email doesn't exist
                message = "Email is not registered. Please sign up.";
            }

        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        // Handle the exception as needed
        message = "An error occurred while processing your request.";
    }

    out.println(message);
%>
