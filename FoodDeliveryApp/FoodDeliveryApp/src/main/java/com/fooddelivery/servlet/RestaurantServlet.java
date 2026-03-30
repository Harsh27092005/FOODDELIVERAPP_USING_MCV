package com.fooddelivery.servlet;

import com.fooddelivery.dao.MenuDAO;
import com.fooddelivery.dao.RestaurantDAO;
import com.fooddelivery.entity.MenuItem;
import com.fooddelivery.entity.Restaurant;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/RestaurantServlet")
public class RestaurantServlet extends HttpServlet {
    private RestaurantDAO restaurantDAO = new RestaurantDAO();
    private MenuDAO menuDAO = new MenuDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect("HomeServlet");
            return;
        }
        int id = Integer.parseInt(idParam);
        
        Restaurant restaurant = restaurantDAO.getRestaurantById(id);
        List<MenuItem> menu = menuDAO.getMenuByRestaurant(id);
        
        request.setAttribute("restaurant", restaurant);
        request.setAttribute("menu", menu);
        request.getRequestDispatcher("restaurant.jsp").forward(request, response);
    }
}
