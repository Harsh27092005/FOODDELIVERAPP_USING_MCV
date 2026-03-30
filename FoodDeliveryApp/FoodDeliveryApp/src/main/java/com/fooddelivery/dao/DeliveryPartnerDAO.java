package com.fooddelivery.dao;

import com.fooddelivery.entity.DeliveryPartner;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DeliveryPartnerDAO {
    
    public DeliveryPartner assignAvailablePartner() {
        DeliveryPartner partner = null;
        String query = "SELECT * FROM Delivery_Partner WHERE status = 'AVAILABLE' AND ROWNUM <= 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    partner = new DeliveryPartner(
                        rs.getInt("partner_id"), rs.getString("name"),
                        rs.getString("phone"), rs.getString("current_location"),
                        rs.getString("status")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return partner;
    }
}
