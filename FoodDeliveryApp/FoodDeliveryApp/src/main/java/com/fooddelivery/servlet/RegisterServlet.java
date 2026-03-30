package com.fooddelivery.servlet;

import com.fooddelivery.dao.UserDAO;
import com.fooddelivery.entity.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String city = "Pending";

        // Server-side validation for phone (10 digits)
        if (phone == null || !phone.trim().matches("^[0-9]{10}$")) {
            response.sendRedirect("error.jsp?type=invalid_phone");
            return;
        }
        
        // Check if phone already exists
        User existingUser = userDAO.getUserByPhone(phone.trim());
        if (existingUser != null) {
            response.sendRedirect("register.jsp?error=Phone+Number+Already+Registered&phone=" + phone);
            return;
        }
        
        // Validation for Email
        if (email == null || !email.trim().matches("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$")) {
            response.sendRedirect("error.jsp?type=invalid_email");
            return;
        }
        // Validation for Name (Alpha-only, 2-50 chars)
        if (name == null || !name.trim().matches("^[A-Za-z\\s]{2,50}$")) {
            response.sendRedirect("error.jsp?type=invalid_name");
            return;
        }
        // Validation for Password (Min 6 chars)
        if (password == null || password.length() < 6) {
            response.sendRedirect("error.jsp?type=weak_password");
            return;
        }

        User user = new User(0, name.trim(), email.trim(), password, phone.trim(), city);
        boolean registered = userDAO.register(user);

        if (registered) {
            User newUser = userDAO.getUserByPhone(phone.trim());
            if (newUser == null) {
                // Failsafe: if we couldn't fetch the user back immediately (e.g., DB latency),
                // we manually create the object to ensure auto-login succeeds.
                newUser = new User(0, name.trim(), email.trim(), password, phone.trim(), city);
            }
            request.getSession().setAttribute("user", newUser);
            response.sendRedirect("HomeServlet");
        } else {
            response.sendRedirect("register.jsp?error=Registration+Failed&phone=" + phone);
        }
    }
}
