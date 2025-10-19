package utils;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtility {

    public static void sendEmail(String toEmail, String subject, String messageContent)
            throws MessagingException {

        final String fromEmail = "tientqhe171973@fpt.edu.vn"; // Email của bạn
        final String password = "rppgzubcwztnywst";     // App password bạn tạo ở Gmail

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(fromEmail));
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
        msg.setSubject(subject);
        msg.setContent(messageContent, "text/html; charset=utf-8");

        Transport.send(msg);
    }
}