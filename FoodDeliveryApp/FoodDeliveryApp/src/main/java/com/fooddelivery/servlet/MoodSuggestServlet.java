package com.fooddelivery.servlet;

import com.fooddelivery.dao.MoodSuggestDAO;
import com.fooddelivery.dao.RestaurantDAO;
import com.fooddelivery.entity.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/MoodSuggestServlet")
public class MoodSuggestServlet extends HttpServlet {

    private MoodSuggestDAO dao = new MoodSuggestDAO();
    private RestaurantDAO restaurantDAO = new RestaurantDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("allCities", restaurantDAO.getAllCities());
        request.getRequestDispatcher("mood.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        String mood = request.getParameter("mood");
        String cuisine = request.getParameter("cuisine");
        // City from form overrides user's stored city
        String formCity = request.getParameter("city");
        String userCity = (user != null && user.getCity() != null) ? user.getCity() : "";
        String city = (formCity != null && !formCity.trim().isEmpty()) ? formCity : userCity;

        List<Map<String, Object>> suggestions = dao.getSuggestions(city, mood, cuisine);

        request.setAttribute("suggestions", suggestions);
        request.setAttribute("mood", mood);
        request.setAttribute("cuisine", cuisine);
        request.setAttribute("city", city);
        request.setAttribute("allCities", restaurantDAO.getAllCities());
        request.getRequestDispatcher("mood.jsp").forward(request, response);
    }
}
