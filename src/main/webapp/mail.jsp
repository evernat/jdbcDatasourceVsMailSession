<%
javax.mail.Session mailSession = (javax.mail.Session) new javax.naming.InitialContext().lookup("java:/comp/env/mail/Session");
// no need more, ClassNotFoundException above
%>
Mail session OK.
