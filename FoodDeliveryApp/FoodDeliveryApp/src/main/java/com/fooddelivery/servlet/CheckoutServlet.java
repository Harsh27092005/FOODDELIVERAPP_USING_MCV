package com.fooddelivery.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String totalAmountStr = request.getParameter("totalAmount");
        String restaurantIdStr = request.getParameter("restaurantId");
        
        if (totalAmountStr == null || restaurantIdStr == null || totalAmountStr.isEmpty() || restaurantIdStr.isEmpty()) {
            totalAmountStr = "500.0";
            restaurantIdStr = "1";
        }
        
        request.setAttribute("totalAmount", totalAmountStr);
        request.setAttribute("restaurantId", restaurantIdStr);
        request.getRequestDispatcher("payment.jsp").forward(request, response);
    }
}
