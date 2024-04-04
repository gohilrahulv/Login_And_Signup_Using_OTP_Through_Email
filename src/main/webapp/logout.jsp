<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%
    // Get the session
    HttpSession userSession = request.getSession(false);

    // Invalidate the session if it exists
    if (session != null) {
        session.invalidate();
    }

    // Redirect to the login page
    response.sendRedirect("index.jsp");
%>
