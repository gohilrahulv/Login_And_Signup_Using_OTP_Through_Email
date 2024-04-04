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
                // Email exists
                message = "Email already exists!..Please use a different email.";
            } else {
                // Email doesn't exist
                message = "Email available for signup!";
            }
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        // Handle the exception as needed
        message = "An error occurred while processing your request.";
    }

    out.println(message);
%>
