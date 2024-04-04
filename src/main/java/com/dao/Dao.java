package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.model.Model;

public class Dao 
{

	public static Connection getconnect()
	{
		Connection con = null;
		
			try 
			{
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aj","root","");
			} 
			catch (Exception e) 
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		return con;
	}
	
	public static int savedata(Model m)
	{
		int status =0;
		
		try (Connection con = getconnect();
	             PreparedStatement ps = con.prepareStatement("insert into my (fname,lname,email,mobile,address,gender,pass) values (?,?,?,?,?,?,?)")) {

	            ps.setString(1, m.getFname());
	            ps.setString(2, m.getLname());
	            ps.setString(3, m.getEmail());
	            ps.setString(4, m.getMobile());
	            ps.setString(5, m.getAddress());
	            ps.setString(6, m.getGender());
	            ps.setString(7, m.getPass());

	            status = ps.executeUpdate();

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return status;

	}
	public static boolean updateLoginStatus(String userEmail) {
        Connection con = null;
        PreparedStatement pst = null;

        try {
            con = getconnect();
            String updateQuery = "UPDATE my SET login_status = 'verify' WHERE email = ?";
            pst = con.prepareStatement(updateQuery);
            pst.setString(1, userEmail);

            int rowsAffected = pst.executeUpdate();
            return rowsAffected > 0;  // If rowsAffected > 0, update was successful
        } catch (SQLException e) {
            e.printStackTrace();
        } 
        

        return false;  // Return false if update fails
    }
	public static String checkLoginStatus(String email, String password) {
        String statusMessage = "";

        try (Connection con = getconnect();
                PreparedStatement pst = con.prepareStatement("SELECT * FROM my WHERE email = ?")) {

            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                String loginStatus = rs.getString("login_status");

                if ("verify".equals(loginStatus)) {
                    String storedPassword = rs.getString("pass");

                    if (password.equals(storedPassword)) {
                        statusMessage = "success";
                    } else {
                        statusMessage = "incorrect_password";
                    }
                } else {
                    statusMessage = "unverified_email";
                }
            } else {
                statusMessage = "email_not_registered";
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return statusMessage;
    }
	public static boolean changePassword(String userEmail, String oldPassword, String newPassword) {
	    boolean passwordChanged = false;

	    try (Connection con = getconnect();
	         PreparedStatement pst = con.prepareStatement("SELECT * FROM my WHERE email = ? AND pass = ?")) {

	        pst.setString(1, userEmail);
	        pst.setString(2, oldPassword);

	        ResultSet rs = pst.executeQuery();

	        if (rs.next()) {
	            // User and old password match, proceed to update the password
	            try (PreparedStatement updatePst = con.prepareStatement("UPDATE my SET pass = ? WHERE email = ?")) {
	                updatePst.setString(1, newPassword);
	                updatePst.setString(2, userEmail);

	                int rowsAffected = updatePst.executeUpdate();

	                if (rowsAffected > 0) {
	                    passwordChanged = true;
	                }
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return passwordChanged;
	}
	public static boolean verifyOldPassword(String userEmail, String oldPassword) {
	    try (Connection con = getconnect();
	         PreparedStatement pst = con.prepareStatement("SELECT * FROM my WHERE email = ? AND pass = ?")) {

	        pst.setString(1, userEmail);
	        pst.setString(2, oldPassword);

	        ResultSet rs = pst.executeQuery();

	        return rs.next();  // Returns true if there is a match, false otherwise
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return false;  // Return false in case of an exception or no match
	}
	public static boolean isEmailRegistered(String email) {
	    try (Connection con = getconnect();
	         PreparedStatement pst = con.prepareStatement("SELECT * FROM my WHERE email = ?")) {

	        pst.setString(1, email);
	        ResultSet rs = pst.executeQuery();

	        return rs.next();  // Returns true if email is registered, false otherwise
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return false;  // Return false in case of an exception
	}

	public static boolean isEmailVerified(String email) {
	    try (Connection con = getconnect();
	         PreparedStatement pst = con.prepareStatement("SELECT login_status FROM my WHERE email = ?")) {

	        pst.setString(1, email);
	        ResultSet rs = pst.executeQuery();

	        if (rs.next()) {
	            String loginStatus = rs.getString("login_status");
	            return "verify".equals(loginStatus);  // Returns true if email is verified, false otherwise
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return false;  // Return false in case of an exception or if the email is not found
	}
	public static boolean updatePassword(String userEmail, String newPassword) {
	    boolean passwordChanged = false;

	    try (Connection con = getconnect();
	         PreparedStatement pst = con.prepareStatement("UPDATE my SET pass = ? WHERE email = ?")) {

	        pst.setString(1, newPassword);
	        pst.setString(2, userEmail);

	        int rowsAffected = pst.executeUpdate();

	        if (rowsAffected > 0) {
	            passwordChanged = true;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return passwordChanged;
	}
	public static String getUserFirstName(String userEmail) {
        String firstName = null;

        try (Connection con = getconnect();
             PreparedStatement pst = con.prepareStatement("SELECT fname FROM my WHERE email = ?")) {

            pst.setString(1, userEmail);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                firstName = rs.getString("fname");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return firstName;
    }




}
