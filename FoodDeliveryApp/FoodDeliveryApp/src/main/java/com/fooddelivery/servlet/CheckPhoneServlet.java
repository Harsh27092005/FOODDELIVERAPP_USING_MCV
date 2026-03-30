package com.fooddelivery.servlet;

import com.fooddelivery.dao.UserDAO;
import com.fooddelivery.entity.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/CheckPhoneServlet")
public class CheckPhoneServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String phone = request.getParameter("phone");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Indian phone number validation (exactly 10 digits)
        if (phone == null || !phone.trim().matches("^[0-9]{10}$")) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"exists\": false, \"error\": \"invalid_format\"}");
            return;
        }

        User user = userDAO.getUserByPhone(phone.trim());
        if (user != null) {
            response.getWriter().write("{\"exists\": true}");
        } else {
            response.getWriter().write("{\"exists\": false}");
        }
    }
}
