package com.fooddelivery.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:oracle:thin:@//localhost:1521/orclpdb1";
    // Change these credentials to match your local Oracle setup
    private static final String USER = "LOCALUSER";
    private static final String PASSWORD = "OracleHomeUser1";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            System.err.println("Failed to connect to Oracle DB. Please ensure the driver is loaded and DB is running.");
        }
        return conn;
    }
}
