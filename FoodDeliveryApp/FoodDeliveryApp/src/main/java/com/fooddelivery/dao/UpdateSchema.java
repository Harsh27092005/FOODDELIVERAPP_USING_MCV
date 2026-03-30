package com.fooddelivery.dao;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.SQLException;

public class UpdateSchema {
    public static void main(String[] args) {
        System.out.println("Connecting to Database to apply schema updates...");
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            
            // Alter Users table to add profile_photo
            // Using try-catch around execute to ignore table already has column error
            try {
                stmt.execute("ALTER TABLE Users ADD profile_photo VARCHAR2(500) DEFAULT NULL");
                System.out.println("Successfully added profile_photo column to Users table.");
            } catch (SQLException e) {
                if (e.getErrorCode() == 1430 || e.getMessage().contains("column being added already exists")) {
                    System.out.println("Column profile_photo already exists in Users table.");
                } else {
                    e.printStackTrace();
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println("Schema update script completed.");
    }
}
