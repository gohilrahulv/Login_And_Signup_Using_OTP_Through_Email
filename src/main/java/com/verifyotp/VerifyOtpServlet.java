package com.verifyotp;
import java.io.IOException;
import java.io.PrintWriter;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.Dao;




@WebServlet("/verifyOtp")
public class VerifyOtpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Get the user-entered OTP and the stored OTP from the session
            String userEnteredOTP = request.getParameter("OTP");
            String storedOTP = (String) request.getSession().getAttribute("otp");
            
            String userEmail = (String) request.getSession().getAttribute("email");
            // Check if the entered OTP matches the stored OTP
            if (userEnteredOTP != null && userEnteredOTP.equals(storedOTP)) {
            	boolean updateStatus = Dao.updateLoginStatus(userEmail);
            	//verify login_status.
            	if (updateStatus) {
                    // Update successful
                    response.sendRedirect("login.jsp");
                } else {
                    // Update failed, handle accordingly
                    request.setAttribute("error", "Failed to update login status. Please try again.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("otp.jsp");
                    dispatcher.forward(request, response);
                }
            	
                // Correct OTP, redirect to login page
                //response.sendRedirect("login.jsp");
            } else {
                // Incorrect OTP, display an error message
            	request.setAttribute("error", "Incorrect OTP Please Try Again. Or Resend OTP by Click On Resend OTP");
            	
                RequestDispatcher dispatcher = request.getRequestDispatcher("otp.jsp");
                dispatcher.forward(request, response);
                
            }
            //Show Error If Any Error To Check OTP.
        } catch (Exception e) {
            e.printStackTrace();
            out.print("Exception occurred: " + e.getMessage());
        }
    }
}