<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="util.EmailUtility" %>
<!DOCTYPE html>
<html>
<head>
    <title>Processing Email...</title>
</head>
<body>
    <%
        String recipient = request.getParameter("recipient");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        try {
            EmailUtility.sendEmail(recipient, subject, message);
            out.print("<h3 style='color: green;'>Email sent successfully to " + recipient + "!</h3>");
        } catch (Exception e) {
            out.print("<h3 style='color: red;'>Error occurred: " + e.getMessage() + "</h3>");
            e.printStackTrace(); 
        }
    %>
    <br>
    <a href="emailForm.jsp">Go Back</a>
</body>
</html>