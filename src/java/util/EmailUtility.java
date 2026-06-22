/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.DataHandler;

/**
 *
 * @author sho
 */
public class EmailUtility {

    public static void sendEmail(String toAddress, String subject, String messageBody) throws MessagingException {
        
        String host = "smtp.gmail.com";
        String port = "587"; 
        final String userName = "shukriraja10@gmail.com"; // Your Gmail address
        final String password = "cqsc jgip ybnl ymhd"; // Your 16-digit Google App Password

        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true"); 

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(userName, password);
            }
        });

        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(userName));
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toAddress));
        msg.setSubject(subject);
        msg.setText(messageBody);

        Transport.send(msg);
    }
}