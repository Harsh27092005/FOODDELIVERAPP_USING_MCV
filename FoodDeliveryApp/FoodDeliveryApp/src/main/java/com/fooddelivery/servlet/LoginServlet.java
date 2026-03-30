package com.fooddelivery.servlet;

import com.fooddelivery.dao.UserDAO;
import com.fooddelivery.entity.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String phone = request.getParameter("phone");
        String checkOnly = request.getParameter("checkOnly");
        
        // Handle user existence check from frontend
        if (checkOnly != null && checkOnly.equals("true")) {
            response.setContentType("text/plain");
            User existingUser = userDAO.getUserByPhone(phone);
            if (existingUser != null) {
                response.getWriter().print("exists");
            } else {
                response.getWriter().print("notfound");
            }
            return;
        }
        
        String password = request.getParameter("password");

        User user = userDAO.login(phone, password);
        
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("HomeServlet");
        } else {
            User existingUser = userDAO.getUserByPhone(phone);
            if (existingUser == null) {
                // Must register if phone does not exist
                response.sendRedirect("register.jsp?phone=" + phone + "&msg=Please+Register+First");
            } else {
                response.sendRedirect("login.jsp?error=Invalid+Credentials&phone=" + phone);
            }
        }
    }
}
