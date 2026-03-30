package com.fooddelivery.servlet;

import com.fooddelivery.dao.RestaurantDAO;
import com.fooddelivery.entity.Restaurant;
import com.fooddelivery.entity.User;
import com.fooddelivery.service.AISuggestionService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
    private RestaurantDAO restaurantDAO = new RestaurantDAO();
    private AISuggestionService aiService = new AISuggestionService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        
        String action = request.getParameter("action");
        String selectedCity = request.getParameter("city");

        if ("setCity".equals(action) && selectedCity != null && !selectedCity.isEmpty()) {
            user.setCity(selectedCity);
            new com.fooddelivery.dao.UserDAO().updateUserCity(user.getUserId(), selectedCity);
            response.sendRedirect("HomeServlet");
            return;
        }

        List<Restaurant> restaurants;
        if (selectedCity == null || selectedCity.isEmpty() || "All".equals(selectedCity)) {
            restaurants = restaurantDAO.getRestaurantsByCity("All");
            final String userCity = (user != null && user.getCity() != null) ? user.getCity().trim().toLowerCase() : "";
            
            // Normalize city names for grouping/display
            for (Restaurant r : restaurants) {
                if (r.getCity() != null) {
                    String c = r.getCity().trim();
                    if (c.length() > 0) {
                        r.setCity(c.substring(0, 1).toUpperCase() + c.substring(1).toLowerCase());
                    }
                }
            }
            
            // Sort: User's city first, then alphabetically
            java.util.Collections.sort(restaurants, (r1, r2) -> {
                String c1 = r1.getCity().trim();
                String c2 = r2.getCity().trim();
                boolean isR1UserCity = c1.toLowerCase().equals(userCity);
                boolean isR2UserCity = c2.toLowerCase().equals(userCity);
                
                if (isR1UserCity && !isR2UserCity) return -1;
                if (!isR1UserCity && isR2UserCity) return 1;
                return c1.compareToIgnoreCase(c2);
            });
            selectedCity = "All";
        } else {
            restaurants = restaurantDAO.getRestaurantsByCity(selectedCity);
            // Also normalize for single city view
            for (Restaurant r : restaurants) {
                if (r.getCity() != null) {
                    String c = r.getCity().trim();
                    if (c.length() > 0) {
                        r.setCity(c.substring(0, 1).toUpperCase() + c.substring(1).toLowerCase());
                    }
                }
            }
        }
        
        boolean showCityModal = false;
        if ((selectedCity == null || selectedCity.trim().isEmpty() || "All".equals(selectedCity)) && (user == null || user.getCity() == null || user.getCity().isEmpty())) {
            showCityModal = true;
        }
        
        List<String> allCities = restaurantDAO.getAllCities();
        String aiSuggestion = aiService.getSuggestion(user);
        
        request.setAttribute("restaurants", restaurants);
        request.setAttribute("allCities", allCities);
        request.setAttribute("selectedCity", selectedCity);
        request.setAttribute("aiSuggestion", aiSuggestion);
        request.setAttribute("showCityModal", showCityModal);
        
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
