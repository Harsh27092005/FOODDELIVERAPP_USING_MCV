package com.fooddelivery.servlet;

import com.fooddelivery.dao.CartDAO;
import com.fooddelivery.dao.DeliveryPartnerDAO;
import com.fooddelivery.dao.OrderDAO;
import com.fooddelivery.entity.DeliveryPartner;
import com.fooddelivery.entity.Order;
import com.fooddelivery.entity.User;
import com.fooddelivery.observer.NotificationObserver;
import com.fooddelivery.service.NotificationService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();
    private CartDAO cartDAO = new CartDAO();
    private DeliveryPartnerDAO partnerDAO = new DeliveryPartnerDAO();
    private NotificationService notificationService = new NotificationService();

    @Override
    public void init() {
        notificationService.addObserver(new NotificationObserver());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
        int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
        String paymentMethod = request.getParameter("paymentMethod");
        
        // Server-side validation for Payment
        if ("CARD".equals(paymentMethod)) {
            String card = request.getParameter("cardNumber");
            String expiry = request.getParameter("expiry");
            String cvv = request.getParameter("cvv");
            
            if (card == null || card.length() != 16 || expiry == null || !expiry.matches("^\\d{2}/\\d{2}$") || cvv == null || cvv.length() != 3) {
                response.sendRedirect("error.jsp?type=invalid_payment");
                return;
            }
        }
        
        DeliveryPartner partner = partnerDAO.assignAvailablePartner();
        int partnerId = partner != null ? partner.getPartnerId() : 0; // 0 → stored as NULL in DB
        
        Order order = new Order(0, user.getUserId(), restaurantId, partnerId, totalAmount, "Preparing", paymentMethod, null);
        int orderId = orderDAO.createOrder(order);
        
        if (orderId > 0) {
            cartDAO.clearCart(user.getUserId());
            notificationService.notifyOrderStatusChange(orderId, "Preparing");
            
            new Thread(() -> {
                try {
                    Thread.sleep(2000); // 2-second gap after preparing
                    orderDAO.updateOrderStatus(orderId, "Food Ready");
                    notificationService.notifyOrderStatusChange(orderId, "Food Ready");

                    Thread.sleep(8000);
                    orderDAO.updateOrderStatus(orderId, "Out for Delivery");
                    notificationService.notifyOrderStatusChange(orderId, "Out for Delivery");
                    
                    Thread.sleep(8000);
                    orderDAO.updateOrderStatus(orderId, "Delivered");
                    notificationService.notifyOrderStatusChange(orderId, "Delivered");
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }).start();
            
            response.sendRedirect("OrderTrackingServlet?id=" + orderId);
        } else {
            response.sendRedirect("cart.jsp?error=Order+Failed");
        }
    }
}
