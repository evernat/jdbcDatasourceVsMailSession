# discussion of jdbc datasource vs mail session loading in Tomcat

With the source of a basic webapp in this repo, see that the jdbc driver is loaded from WEB-INF/lib and used in a jndi datasource declared in context.xml:
1. Either run `mvn tomcat7:run`
2. Open http://localhost:8080/jdbc.jsp

or

1. Run `mvn package` then deploy target/test-0.1.war in Tomcat 9 or Tomcat 8 or in most versions of Tomcat 7
2. Open http://localhost:8080/test-0.1/jdbc.jsp and see "JDBC connection OK".

Note that this quite well known Tomcat's feature since some version of Tomcat long ago seems to be the opposite of what says the [Tomcat's doc](https://tomcat.apache.org/tomcat-9.0-doc/jndi-datasource-examples-howto.html#DriverManager,_the_service_provider_mechanism_and_memory_leaks):

> Drivers packaged in web applications (in WEB-INF/lib) and in the shared class loader (where configured) will not be visible and will not be loaded automatically. If you are considering disabling this feature, note that the scan would be triggered by the first web application that is using JDBC, leading to failures when this web application is reloaded and for other web applications that rely on this feature.
>
> Thus, the web applications that have database drivers in their WEB-INF/lib directory cannot rely on the service provider mechanism and should register the drivers explicitly.

And perhaps some version of the [JRE Memory Leak Prevention Listener](https://tomcat.apache.org/tomcat-9.0-doc/config/listeners.html) introduced by accident this feature which is used by so many webapps now. Users don't think anymore that it is an accident and they think that it is a feature which makes their webapps' deployment autonomous.

We have seen that the jdbc driver is loaded from WEB-INF/lib and used in a jndi datasource declared in context.xml. Now, a jndi mail session is the second thing declared in context.xml next to the datasource, to configure smtp server like the database server for the datasource. Is the javamail driver loaded from WEB-INF/lib and used in a jndi mail session?

Not at all. See that the javamail driver is not loaded from WEB-INF/lib:

3. Open mail.jsp next to jdbc.jsp (http://localhost:8080/mail.jsp or http://localhost:8080/test-0.1/mail.jsp) and see "root Cause ClassNotFoundException: javax.mail.Authenticator"

Why is there a difference of behavior from the user's point of view, between jdbc datasource and mail session?

Could it be fixed by loading the javamail driver from WEB-INF/lib?

Or could the latest javamail driver be added in the Tomcat's lib directory? (There are not many questions for which javamail to use anyway and it would make things easier.)
