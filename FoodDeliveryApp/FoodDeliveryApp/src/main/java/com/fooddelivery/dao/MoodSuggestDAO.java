package com.fooddelivery.dao;


import java.sql.*;
import java.util.*;

public class MoodSuggestDAO {

    /**
     * Maps mood + cuisine to keyword hints for searching the menu.
     */
    public static List<String> getKeywords(String mood, String cuisine) {
        List<String> kw = new ArrayList<>();
        // cuisine keywords
        if ("Indian".equalsIgnoreCase(cuisine)) {
            kw.addAll(Arrays.asList("biryani", "paneer", "dal", "masala", "curry", "roti", "naan", "tikka", "butter"));
        } else if ("Chinese".equalsIgnoreCase(cuisine)) {
            kw.addAll(Arrays.asList("noodles", "fried rice", "manchurian", "wok", "spring roll", "dim sum", "chilli"));
        } else if ("Italian".equalsIgnoreCase(cuisine)) {
            kw.addAll(Arrays.asList("pizza", "pasta", "risotto", "lasagna", "margherita", "pepperoni"));
        } else if ("Fast Food".equalsIgnoreCase(cuisine)) {
            kw.addAll(Arrays.asList("burger", "fries", "sandwich", "wrap", "hot dog", "nuggets", "milkshake"));
        } else if ("South Indian".equalsIgnoreCase(cuisine)) {
            kw.addAll(Arrays.asList("dosa", "idli", "vada", "sambar", "rasam", "uttapam", "appam", "coconut"));
        }
        // mood overrides / additions
        if ("Happy".equalsIgnoreCase(mood)) {
            kw.addAll(Arrays.asList("special", "loaded", "feast", "party"));
        } else if ("Sad".equalsIgnoreCase(mood)) {
            kw.addAll(Arrays.asList("comfort", "soul", "hot", "soup", "chocolate", "dessert"));
        } else if ("Romantic".equalsIgnoreCase(mood)) {
            kw.addAll(Arrays.asList("pasta", "paneer", "creamy", "rich", "butter", "starter"));
        } else if ("Adventurous".equalsIgnoreCase(mood)) {
            kw.addAll(Arrays.asList("spicy", "fiery", "loaded", "extra", "masala", "chilli"));
        } else if ("Comfort".equalsIgnoreCase(mood)) {
            kw.addAll(Arrays.asList("dal", "khichdi", "soup", "warm", "home", "plain"));
        }
        return kw;
    }

    public List<Map<String, Object>> getSuggestions(String city, String mood, String cuisine) {
        List<Map<String, Object>> results = new ArrayList<>();
        List<String> keywords = getKeywords(mood, cuisine);
        if (keywords.isEmpty()) return results;

        // Build LIKE conditions
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < keywords.size(); i++) {
            if (i > 0) sb.append(" OR ");
            sb.append("LOWER(m.name) LIKE ? OR LOWER(m.description) LIKE ?");
        }

        // Known valid cities – if user's city is not one of them, search all
        boolean searchAll = (city == null || city.trim().isEmpty() ||
                city.equalsIgnoreCase("Pending") || city.equalsIgnoreCase("All"));

        String cityClause = searchAll ? "" : "UPPER(r.city) = UPPER(?) AND ";
        String sql = "SELECT m.item_id, m.name AS item_name, m.price, m.description, m.is_veg, " +
                "r.name AS restaurant_name, r.restaurant_id, r.city AS rest_city " +
                "FROM Menu m JOIN Restaurants r ON m.restaurant_id = r.restaurant_id " +
                "WHERE " + cityClause + "(" + sb.toString() + ") " +
                "AND ROWNUM <= 9";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            int idx = 1;
            if (!searchAll) ps.setString(idx++, city);
            for (String kw : keywords) {
                ps.setString(idx++, "%" + kw.toLowerCase() + "%");
                ps.setString(idx++, "%" + kw.toLowerCase() + "%");
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new LinkedHashMap<>();
                    row.put("itemId", rs.getInt("item_id"));
                    row.put("name", rs.getString("item_name"));
                    row.put("price", rs.getDouble("price"));
                    row.put("description", rs.getString("description"));
                    row.put("isVeg", rs.getInt("is_veg") == 1);
                    row.put("restaurantName", rs.getString("restaurant_name"));
                    row.put("restaurantId", rs.getInt("restaurant_id"));
                    row.put("restaurantCity", rs.getString("rest_city"));
                    results.add(row);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return results;
    }
}
