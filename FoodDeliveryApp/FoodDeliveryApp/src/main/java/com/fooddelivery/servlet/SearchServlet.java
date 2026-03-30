package com.fooddelivery.servlet;

import com.fooddelivery.dao.RestaurantDAO;
import com.fooddelivery.entity.Restaurant;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
    private RestaurantDAO restaurantDAO = new RestaurantDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String query = request.getParameter("query");
        if (query == null) query = "";
        
        List<Restaurant> results = restaurantDAO.searchRestaurants(query);
        com.fooddelivery.entity.User user = (com.fooddelivery.entity.User) request.getSession().getAttribute("user");
        final String userCity = (user != null && user.getCity() != null) ? user.getCity().trim().toLowerCase() : "";

        // Normalize city names
        for (Restaurant r : results) {
            if (r.getCity() != null) {
                String c = r.getCity().trim();
                if (c.length() > 0) {
                    r.setCity(c.substring(0, 1).toUpperCase() + c.substring(1).toLowerCase());
                }
            }
        }

        // Sort: User's city first, then alphabetically
        java.util.Collections.sort(results, (r1, r2) -> {
            String c1 = r1.getCity().trim();
            String c2 = r2.getCity().trim();
            boolean isR1UserCity = c1.toLowerCase().equals(userCity);
            boolean isR2UserCity = c2.toLowerCase().equals(userCity);
            
            if (isR1UserCity && !isR2UserCity) return -1;
            if (!isR1UserCity && isR2UserCity) return 1;
            return c1.compareToIgnoreCase(c2);
        });
        
        List<String> allCities = restaurantDAO.getAllCities();
        
        request.setAttribute("restaurants", results);
        request.setAttribute("searchQuery", query);
        request.setAttribute("allCities", allCities);
        request.setAttribute("selectedCity", "All"); // Search searches everywhere
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
