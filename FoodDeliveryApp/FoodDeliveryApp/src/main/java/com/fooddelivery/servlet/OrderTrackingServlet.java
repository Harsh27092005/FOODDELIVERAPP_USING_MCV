package com.fooddelivery.servlet;

import com.fooddelivery.dao.OrderDAO;
import com.fooddelivery.entity.Order;
import com.fooddelivery.entity.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/OrderTrackingServlet")
public class OrderTrackingServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();
    
    private void advanceStatus(Order order) {
        if (order == null || "Delivered".equals(order.getStatus())) return;
        String current = order.getStatus();
        String next = current;
        if ("Preparing".equals(current)) {
            try {
                Thread.sleep(2000); // Wait 2 seconds before marking as ready
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            next = "Food Ready";
        } else if ("Food Ready".equals(current)) {
            next = "Out for Delivery";
        } else if ("Out for Delivery".equals(current)) {
            next = "Delivered";
        }
        if (!next.equals(current)) {
            orderDAO.updateOrderStatus(order.getOrderId(), next);
            order.setStatus(next);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
            
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            int orderId = Integer.parseInt(idParam);
            Order order = orderDAO.getOrderById(orderId);
            if (order != null) advanceStatus(order);
            request.setAttribute("order", order);
            request.getRequestDispatcher("tracking.jsp").forward(request, response);
        } else {
            User user = (User) request.getSession().getAttribute("user");
            List<Order> orders = orderDAO.getOrdersByUser(user.getUserId());
            for (Order o : orders) advanceStatus(o);
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("tracking.jsp").forward(request, response);
        }
    }
}
