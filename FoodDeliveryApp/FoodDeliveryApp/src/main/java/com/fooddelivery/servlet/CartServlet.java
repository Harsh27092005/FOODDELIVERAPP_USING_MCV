package com.fooddelivery.servlet;

import com.fooddelivery.dao.CartDAO;
import com.fooddelivery.entity.Cart;
import com.fooddelivery.entity.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Locale;
import com.fooddelivery.dao.MenuDAO;
import com.fooddelivery.dao.RestaurantDAO;
import com.fooddelivery.entity.MenuItem;
import com.fooddelivery.entity.Restaurant;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    private CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
            if (isAjax) {
                response.setContentType("application/json");
                response.setStatus(401);
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Please login first\"}");
                return;
            }
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Handle AJAX cart count request (called from restaurant.jsp via GET)
        String action = request.getParameter("action");
        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        if ("count".equals(action) && isAjax) {
            try {
                User user = (User) session.getAttribute("user");
                List<Cart> items = cartDAO.getCartByUser(user.getUserId());
                int totalCount = items.stream().mapToInt(Cart::getQuantity).sum();
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"success\",\"cartCount\":" + totalCount + "}");
            } catch (Exception e) {
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"success\",\"cartCount\":0}");
            }
            return;
        }
        
        try {
            User user = (User) session.getAttribute("user");
            List<Cart> cartItems = cartDAO.getCartByUser(user.getUserId());
            int restaurantId = cartDAO.getRestaurantIdFromCart(user.getUserId());
            
            MenuDAO menuDAO = new MenuDAO();
            RestaurantDAO resDAO = new RestaurantDAO();
            Map<Integer, MenuItem> menuMap = new HashMap<>();
            double subtotal = 0;
            
            for (Cart c : cartItems) {
                MenuItem item = menuDAO.getItemById(c.getItemId());
                if (item != null) {
                    menuMap.put(c.getItemId(), item);
                    subtotal += (item.getPrice() * c.getQuantity());
                }
            }
            
            double discountAmount = 0;
            String offerText = "";
            if (restaurantId > 0) {
                Restaurant res = resDAO.getRestaurantById(restaurantId);
                if (res != null) {
                    String offers = res.getOffers();
                    if (offers != null && offers.contains("%")) {
                        try {
                            String clean = offers.replaceAll("[^0-9]", "");
                            if (!clean.isEmpty()) {
                                int pct = Integer.parseInt(clean);
                                discountAmount = subtotal * (pct / 100.0);
                                offerText = pct + "% OFF";
                            }
                        } catch(Exception e) {}
                    } else if (offers != null && offers.toLowerCase().contains("off")) {
                         discountAmount = subtotal * 0.10; // flat 10% 
                         offerText = "10% OFF";
                    }
                }
            }
            
            double total = subtotal - discountAmount;
            if (total < 0) total = 0;

            request.setAttribute("cartItems", cartItems);
            request.setAttribute("menuMap", menuMap);
            request.setAttribute("subtotal", subtotal);
            request.setAttribute("discountAmount", discountAmount);
            request.setAttribute("totalAmount", total);
            request.setAttribute("offerText", offerText);
            request.setAttribute("restaurantId", restaurantId);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("[CartServlet] Error loading cart: " + e.getMessage());
            // Forward with empty cart - user sees "Your cart is feeling light" 
            request.setAttribute("cartItems", new java.util.ArrayList<>());
            request.setAttribute("menuMap", new HashMap<>());
            request.setAttribute("subtotal", 0.0);
            request.setAttribute("discountAmount", 0.0);
            request.setAttribute("totalAmount", 0.0);
            request.setAttribute("offerText", "");
            request.setAttribute("restaurantId", 0);
        }
        
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String requestedWith = request.getHeader("X-Requested-With");
        boolean isAjax = "XMLHttpRequest".equals(requestedWith);
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            if (isAjax) {
                response.setContentType("application/json");
                response.setStatus(401);
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Please login first\"}");
            } else {
                response.sendRedirect("login.jsp");
            }
            return;
        }

        if ("add".equals(action)) {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            int qty = Integer.parseInt(request.getParameter("quantity"));
            int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
            
            // Constrain quantity to 1-99
            if (qty < 1) qty = 1;
            if (qty > 99) qty = 99;
            
            int existingRestaurantId = cartDAO.getRestaurantIdFromCart(user.getUserId());
            if (existingRestaurantId > 0 && existingRestaurantId != restaurantId) {
                if (isAjax) {
                    response.setContentType("application/json");
                    response.getWriter().write("{\"status\":\"error\",\"message\":\"different_restaurant\",\"cartCount\":0}");
                } else {
                    response.sendRedirect("RestaurantServlet?id=" + restaurantId + "&error=different_restaurant");
                }
                return;
            }
            
            Cart cart = new Cart(0, user.getUserId(), itemId, qty);
            cartDAO.addToCart(cart);
            
            if (isAjax) {
                // Return updated count for the floating bar
                List<Cart> items = cartDAO.getCartByUser(user.getUserId());
                int totalCount = items.stream().mapToInt(Cart::getQuantity).sum();
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"success\",\"cartCount\":" + totalCount + "}");
            } else {
                response.sendRedirect("RestaurantServlet?id=" + restaurantId);
            }
        } else if ("clear_and_add".equals(action)) {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            int qty = Integer.parseInt(request.getParameter("quantity"));
            int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
            
            // clear existing cart completely
            cartDAO.clearCart(user.getUserId());
            
            if (qty < 1) qty = 1;
            if (qty > 99) qty = 99;
            
            Cart cart = new Cart(0, user.getUserId(), itemId, qty);
            cartDAO.addToCart(cart);
            
            if (isAjax) {
                List<Cart> items = cartDAO.getCartByUser(user.getUserId());
                int totalCount = items.stream().mapToInt(Cart::getQuantity).sum();
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"success\",\"cartCount\":" + totalCount + "}");
            } else {
                response.sendRedirect("RestaurantServlet?id=" + restaurantId);
            }
        } else if ("count".equals(action)) {
            List<Cart> items = cartDAO.getCartByUser(user.getUserId());
            int totalCount = items.stream().mapToInt(Cart::getQuantity).sum();
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"success\",\"cartCount\":" + totalCount + "}");
        } else if ("update".equals(action)) {
            int cartId = Integer.parseInt(request.getParameter("cartId"));
            int newQty = Integer.parseInt(request.getParameter("newQuantity"));
            cartDAO.updateQuantity(cartId, newQty);
            
            if (isAjax) {
                // Recalculate everything for JSON response
                List<Cart> cartItems = cartDAO.getCartByUser(user.getUserId());
                int resId = cartDAO.getRestaurantIdFromCart(user.getUserId());
                MenuDAO menuDAO = new MenuDAO();
                double subtotal = 0;
                for (Cart c : cartItems) {
                    MenuItem item = menuDAO.getItemById(c.getItemId());
                    if (item != null) subtotal += (item.getPrice() * c.getQuantity());
                }
                
                double discount = 0;
                if (resId > 0) {
                    Restaurant res = new RestaurantDAO().getRestaurantById(resId);
                    if (res != null) {
                        String offers = res.getOffers();
                        if (offers != null && offers.contains("%")) {
                            try {
                                int pct = Integer.parseInt(offers.replaceAll("[^0-9]", ""));
                                discount = subtotal * (pct / 100.0);
                            } catch(Exception e) {}
                        } else if (offers != null && offers.toLowerCase().contains("off")) {
                            discount = subtotal * 0.10;
                        }
                    }
                }
                double total = subtotal - discount;
                if (total < 0) total = 0;
                int totalCount = cartItems.stream().mapToInt(Cart::getQuantity).sum();

                response.setContentType("application/json");
                response.getWriter().write(String.format(Locale.US,
                    "{\"status\":\"success\",\"subtotal\":%.2f,\"discount\":%.2f,\"total\":%.2f,\"cartCount\":%d}",
                    subtotal, discount, total, totalCount
                ));
            } else {
                response.sendRedirect("CartServlet");
            }
        } else if ("remove".equals(action)) {
            int cartId = Integer.parseInt(request.getParameter("cartId"));
            cartDAO.removeFromCart(cartId);
            if (isAjax) {
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"success\"}");
            } else {
                response.sendRedirect("CartServlet");
            }
        }
    }
}
