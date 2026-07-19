package utils;

import org.apache.commons.dbcp2.BasicDataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DBCPUtils {
    private static BasicDataSource dataSource;

    static {
        dataSource = new BasicDataSource();
        // Explicitly set the Driver class to fix the "Cannot create JDBC driver" error
        dataSource.setDriverClassName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        
        dataSource.setUrl("jdbc:sqlserver://localhost:1433;databaseName=FlowerShop;encrypt=false");
        dataSource.setUsername("sa");
        dataSource.setPassword("12345678"); // Update with your actual SQL Server password
        dataSource.setMinIdle(5);
        dataSource.setMaxIdle(10);
        dataSource.setMaxTotal(25);
    }

    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
}