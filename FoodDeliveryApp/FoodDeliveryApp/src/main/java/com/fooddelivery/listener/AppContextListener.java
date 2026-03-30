package com.fooddelivery.listener;

import com.fooddelivery.dao.DBConnection;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.Statement;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Checking Database Status on Startup...");
        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                System.err.println("Failed to obtain database connection. Skipping initialization.");
                return;
            }

            try (Statement stmt = conn.createStatement()) {
                // 1. Only create tables if the USERS table is missing
                if (!tableExists(conn, "USERS")) {
                    System.out.println("==> Users table MISSING. Initializing Database Schema (schema.sql)...");
                    executeSqlScript(AppContextListener.class.getResourceAsStream("/sql/schema.sql"), stmt);
                    System.out.println("==> Database Schema initialized SUCCESS.");
                } else {
                    System.out.println("==> Database schema already exists. Skipping schema.sql.");
                }

                // 2. Only insert data if the RESTAURANTS table is empty
                if (isTableEmpty(conn, "RESTAURANTS")) {
                    System.out.println("==> Restaurants table EMPTY. Seeding Sample Data (data.sql)...");
                    executeSqlScript(AppContextListener.class.getResourceAsStream("/sql/data.sql"), stmt);
                    System.out.println("==> Database Seeded SUCCESS.");
                } else {
                    System.out.println("==> Restaurants already present. Skipping data.sql to prevent duplication.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private boolean tableExists(Connection conn, String tableName) {
        try {
            java.sql.DatabaseMetaData metaData = conn.getMetaData();
            try (java.sql.ResultSet rs = metaData.getTables(null, null, tableName.toUpperCase(), new String[]{"TABLE"})) {
                return rs.next();
            }
        } catch (Exception e) {
            System.err.println("Error checking if table " + tableName + " exists: " + e.getMessage());
            return false;
        }
    }

    private boolean isTableEmpty(Connection conn, String tableName) {
        String query = "SELECT COUNT(*) FROM " + tableName;
        try (Statement stmt = conn.createStatement();
             java.sql.ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt(1) == 0;
            }
        } catch (Exception e) {
            // Table might not exist yet, which is handled by schema check
            return true;
        }
        return true;
    }

    private void executeSqlScript(InputStream is, Statement stmt) throws Exception {
        if (is == null) {
            System.err.println("SQL script not found in resources/sql/");
            return;
        }
        BufferedReader reader = new BufferedReader(new InputStreamReader(is));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            String cleanLine = line;
            int commentIdx = cleanLine.indexOf("--");
            if (commentIdx != -1) {
                cleanLine = cleanLine.substring(0, commentIdx);
            }
            if (cleanLine.trim().isEmpty()) {
                continue;
            }
            sb.append(cleanLine).append(" ");
            
            if (cleanLine.trim().endsWith(";")) {
                String sql = sb.toString().replace(";", "").trim();
                sb.setLength(0);
                if (!sql.isEmpty() && !sql.equalsIgnoreCase("COMMIT")) {
                    try {
                        stmt.execute(sql);
                        System.out.println("Executed: " + sql.substring(0, Math.min(30, sql.length())) + "...");
                    } catch (Exception e) {
                        System.err.println("SQL Execution Failed for: " + sql.substring(0, Math.min(30, sql.length())) + "...");
                        System.err.println("Reason: " + e.getMessage());
                    }
                }
            }
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
