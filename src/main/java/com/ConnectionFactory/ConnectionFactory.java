package com.ConnectionFactory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {

    // PostgreSQL connection details
    private static final String URL = "jdbc:postgresql://dpg-d5lr05je5dus73e1c020-a.singapore-postgres.render.com:5432/todoapp_db_e1fa";
    private static final String USER = "todoapp_db_e1fa_user";
    private static final String PASSWORD = "YcHLWCOIHVztudWSWamH7ORfMmXxCHZE";

    public static Connection getConnection() {
        Connection con = null;
        try {
            // Load PostgreSQL JDBC Driver
            Class.forName("org.postgresql.Driver");

            // Connect to database
            con = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("PostgreSQL Connected Successfully ✅");
        } catch (ClassNotFoundException e) {
            System.out.println("PostgreSQL Driver Not Found ❌");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("PostgreSQL Connection Failed ❌");
            e.printStackTrace();
        }
        return con;
    }
}
