package com.ConnectionFactory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {

    private static final String URL = System.getenv("DB_URL");
    private static final String USER = System.getenv("DB_USER");
    private static final String PASSWORD = System.getenv("DB_PASSWORD");

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("org.postgresql.Driver");
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
