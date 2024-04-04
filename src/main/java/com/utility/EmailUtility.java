package com.utility;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.util.Properties;
import java.util.Random;

public class EmailUtility {

    // Method to generate a random 4-digit OTP
    private static String generateOtp() {
        Random rand = new Random();
        int otpValue = rand.nextInt(9000) + 1000;
        return String.valueOf(otpValue);
    }
 // Custom exception for invalid email
    public static class InvalidEmailException extends Exception {
        public InvalidEmailException(String message) {
            super(message);
        }
    }
    // Method to send an email with OTP
    public static boolean sendOtpEmail(String to,HttpServletRequest request) throws InvalidEmailException {
    	// Validate the email address
        if (!isValidEmail(to)) {
            throw new InvalidEmailException("Invalid email address: " + to);
        }
        // Generate a random 4-digit OTP
        String otp = generateOtp();
        
        // Set the OTP in the session attribute
        HttpSession session1 = request.getSession();
        session1.setAttribute("otp", otp);
        

        // Configure email properties (replace with your email server details)
        Properties props = new Properties();
        props.setProperty("mail.smtp.host", "smtp.gmail.com");
        props.setProperty("mail.smtp.auth", "true");
        props.setProperty("mail.smtp.port", "587");
        props.setProperty("mail.smtp.starttls.enable", "true");

        // Create a session with the properties
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("Abc@gmail.com", "abcd efgh igkl mnop");
                //place your emailid("Abc@gmail.com") and app password("abcd efgh igkl mnop")
                //if u don't know how to genrate app password then search on google or youtube "how to genrate app password in gmail"
               
            }
        });

        try {
            // Create a MimeMessage
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("Abc@gmail.com"));//place your email
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("Verification OTP");
            message.setText("Your OTP for registration is: " + otp);

            // Send the message
            Transport.send(message);

            

        } catch (MessagingException e) {
        	 e.printStackTrace();
             System.out.print("Exception occurred: " + e.getMessage());
        }
		return true;
    }
    private static boolean isValidEmail(String email) {
        
        return email != null && email.contains("@");
    }
}
