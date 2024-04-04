<%@ page import="java.sql.*" %> 
<%
String mobile = request.getParameter("mobile").toString();
System.out.println("mobile: " + mobile);
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
    String query = "SELECT * FROM my WHERE mobile=?";
    try (PreparedStatement preparedStatement = con.prepareStatement(query)) {
        preparedStatement.setString(1, mobile);
        ResultSet rs = preparedStatement.executeQuery();

        int count = 0;
        while (rs.next()) {
            count++;
        }

        if (count > 0) {
            message = "Mobile already exists!";
        } else {
            message = "Mobile available for signup!";
        }
    }
} catch (ClassNotFoundException | SQLException e) {
    e.printStackTrace();
    message = "An error occurred while processing your request.";
}

out.println(message);
System.out.println(message);
%>
