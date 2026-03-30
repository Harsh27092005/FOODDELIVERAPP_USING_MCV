package com.fooddelivery.dao;

import com.fooddelivery.entity.MenuItem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MenuDAO {
    
    public List<MenuItem> getMenuByRestaurant(int restaurantId) {
        List<MenuItem> list = new ArrayList<>();
        String query = "SELECT * FROM Menu WHERE restaurant_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, restaurantId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new MenuItem(
                        rs.getInt("item_id"), rs.getInt("restaurant_id"), rs.getString("name"),
                        rs.getDouble("price"), rs.getString("description"), 
                        rs.getInt("is_veg") == 1
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public MenuItem getItemById(int itemId) {
        MenuItem item = null;
        String query = "SELECT * FROM Menu WHERE item_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, itemId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    item = new MenuItem(
                        rs.getInt("item_id"), rs.getInt("restaurant_id"), rs.getString("name"),
                        rs.getDouble("price"), rs.getString("description"), 
                        rs.getInt("is_veg") == 1
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return item;
    }
}
