package com.fooddelivery.dao;

import com.fooddelivery.entity.Cart;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
    
    public boolean addToCart(Cart cart) {
        String checkQuery = "SELECT quantity FROM Cart WHERE user_id = ? AND item_id = ?";
        String updateQuery = "UPDATE Cart SET quantity = quantity + ? WHERE user_id = ? AND item_id = ?";
        String insertQuery = "INSERT INTO Cart (user_id, item_id, quantity) VALUES (?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection()) {
            // 1. Check if item exists
            try (PreparedStatement psCheck = conn.prepareStatement(checkQuery)) {
                psCheck.setInt(1, cart.getUserId());
                psCheck.setInt(2, cart.getItemId());
                try (ResultSet rs = psCheck.executeQuery()) {
                    if (rs.next()) {
                        // 2. Exists -> Update
                        try (PreparedStatement psUpdate = conn.prepareStatement(updateQuery)) {
                            psUpdate.setInt(1, cart.getQuantity());
                            psUpdate.setInt(2, cart.getUserId());
                            psUpdate.setInt(3, cart.getItemId());
                            return psUpdate.executeUpdate() > 0;
                        }
                    } else {
                        // 3. Not Exists -> Insert
                        try (PreparedStatement psInsert = conn.prepareStatement(insertQuery)) {
                            psInsert.setInt(1, cart.getUserId());
                            psInsert.setInt(2, cart.getItemId());
                            psInsert.setInt(3, cart.getQuantity());
                            return psInsert.executeUpdate() > 0;
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Cart> getCartByUser(int userId) {
        List<Cart> list = new ArrayList<>();
        String query = "SELECT c.* FROM Cart c WHERE c.user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Cart(
                        rs.getInt("cart_id"), rs.getInt("user_id"), 
                        rs.getInt("item_id"), rs.getInt("quantity")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getRestaurantIdFromCart(int userId) {
        String query = "SELECT m.restaurant_id FROM Cart c JOIN Menu m ON c.item_id = m.item_id WHERE c.user_id = ? AND ROWNUM <= 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("restaurant_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean updateQuantity(int cartId, int newQuantity) {
        if (newQuantity <= 0) {
            return removeFromCart(cartId);
        }
        String query = "UPDATE Cart SET quantity = ? WHERE cart_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, newQuantity);
            ps.setInt(2, cartId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean removeFromCart(int cartId) {
        String query = "DELETE FROM Cart WHERE cart_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, cartId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean clearCart(int userId) {
        String query = "DELETE FROM Cart WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
