package com.fooddelivery.dao;

import com.fooddelivery.entity.Restaurant;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class RestaurantDAO {
	public Map<String, List<Restaurant>> getRestaurantsGroupedByCity() {
	    Map<String, List<Restaurant>> map = new LinkedHashMap<>();

	    String query = "SELECT * FROM Restaurants ORDER BY city";

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(query);
	         ResultSet rs = ps.executeQuery()) {

	        while (rs.next()) {
	            Restaurant r = new Restaurant(
	                rs.getInt("restaurant_id"),
	                rs.getString("name"),
	                rs.getString("city").trim(),
	                rs.getDouble("rating"),
	                rs.getInt("delivery_time"),
	                rs.getInt("is_veg_only") == 1,
	                rs.getString("offers")
	            );

	            String city = r.getCity();

	            map.putIfAbsent(city, new ArrayList<>());
	            map.get(city).add(r);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return map;
	}
    
    public List<Restaurant> getRestaurantsByCity(String city) {
        List<Restaurant> list = new ArrayList<>();
        String query;
        boolean fetchAll = (city == null || city.equalsIgnoreCase("All"));
        
        if (fetchAll) {
            query = "SELECT * FROM Restaurants";
        } else {
            query = "SELECT * FROM Restaurants WHERE LOWER(city) = ?";
        }
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            if (!fetchAll) {
                ps.setString(1, city.toLowerCase());
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Restaurant(
                        rs.getInt("restaurant_id"), rs.getString("name"), rs.getString("city").trim(),
                        rs.getDouble("rating"), rs.getInt("delivery_time"), 
                        rs.getInt("is_veg_only") == 1, rs.getString("offers")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<String> getAllCities() {
        List<String> cities = new ArrayList<>();
        String query = "SELECT DISTINCT city FROM Restaurants WHERE city IS NOT NULL ORDER BY city";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                cities.add(rs.getString("city"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cities;
    }

    public List<Restaurant> searchRestaurants(String keyword) {
        List<Restaurant> list = new ArrayList<>();
        String query = "SELECT DISTINCT r.restaurant_id, r.name, r.city, r.rating, r.delivery_time, r.is_veg_only, r.offers " +
                       "FROM Restaurants r " +
                       "LEFT JOIN Menu m ON r.restaurant_id = m.restaurant_id " +
                       "WHERE LOWER(r.name) LIKE ? OR LOWER(r.city) LIKE ? " +
                       "   OR LOWER(m.name) LIKE ? OR LOWER(m.description) LIKE ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            String term = "%" + (keyword == null ? "" : keyword.trim().toLowerCase()) + "%";
            ps.setString(1, term);
            ps.setString(2, term);
            ps.setString(3, term);
            ps.setString(4, term);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Restaurant(
                        rs.getInt("restaurant_id"), rs.getString("name"), rs.getString("city").trim(),
                        rs.getDouble("rating"), rs.getInt("delivery_time"), 
                        rs.getInt("is_veg_only") == 1, rs.getString("offers")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public Restaurant getRestaurantById(int id) {
        Restaurant restaurant = null;
        String query = "SELECT * FROM Restaurants WHERE restaurant_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    restaurant = new Restaurant(
                        rs.getInt("restaurant_id"), rs.getString("name"), rs.getString("city").trim(),
                        rs.getDouble("rating"), rs.getInt("delivery_time"), 
                        rs.getInt("is_veg_only") == 1, rs.getString("offers")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurant;
    }
}
