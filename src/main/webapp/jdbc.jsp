<%
javax.sql.DataSource dataSource = (javax.sql.DataSource) new javax.naming.InitialContext().lookup("java:/comp/env/jdbc/DataSource");
java.sql.Connection connection = dataSource.getConnection();
try {
	connection.createStatement().executeQuery("select 1");
} finally {
	connection.close();
}
%>
JDBC connection OK.
