<%@page import="javax.management.modelmbean.ModelMBean"%>
<%@page import="com.utility.EmailUtility"%>
<%@page import="com.dao.Dao"%>
<%@page import="com.model.Model"%>



<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<jsp:useBean id="m" class="com.model.Model"/>    
<jsp:setProperty property="*" name="m"/>
<!DOCTYPE html>
<html>
<head>
<title></title>
<body>

	<%
	try 
	{
		
	    //code to save data in the database
	    int data = Dao.savedata(m);
	    String email = request.getParameter("email");
	    String fname = request.getParameter("fname");
		
		//Model TO Save Email
		Model m2 =new Model();
		m2.setEmail(email);
		m2.setFname(fname);
		
		
		
	    if(data > 0) {
	    	//If Data Inserted
	    	session.setAttribute("email",email);
	    	String userEmail = m.getEmail();
	    	session.setAttribute("fname",fname);
	    	String userFname = m.getFname();
			response.sendRedirect("otp1.jsp");
			
	    } 
	    else 
	    {
	    	//If Data Not Inserted
	        out.print("Failed to insert data");
	    }
	} 
	catch (Exception e) 
	{
		//Show Any Error
	    e.printStackTrace();
	    out.print("Exception occurred: " + e.getMessage());
	}
    %>
			


</body>
</html>