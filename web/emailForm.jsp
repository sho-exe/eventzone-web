<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Send Email</title>
</head>
<body>
    <h2>Send Email via Gmail</h2>
    <form action="sendEmailController.jsp" method="post">
        <label>To (Recipient Email):</label><br>
        <input type="email" name="recipient" required style="width: 300px;"><br><br>
        
        <label>Subject:</label><br>
        <input type="text" name="subject" required style="width: 300px;"><br><br>
        
        <label>Message:</label><br>
        <textarea name="message" rows="5" cols="40" required></textarea><br><br>
        
        <input type="submit" value="Send Email">
    </form>
</body>
</html>