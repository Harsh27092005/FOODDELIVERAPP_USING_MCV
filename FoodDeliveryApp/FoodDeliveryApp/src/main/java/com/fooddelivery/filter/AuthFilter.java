package com.fooddelivery.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        
        String loginURI = req.getContextPath() + "/login.jsp";
        String registerURI = req.getContextPath() + "/register.jsp";
        
        boolean loggedIn = session != null && session.getAttribute("user") != null;
        boolean loginRequest = req.getRequestURI().equals(loginURI);
        boolean registerRequest = req.getRequestURI().equals(registerURI);
        
        // Allow static resources and public servlets
        boolean isStaticOrPublic = req.getRequestURI().endsWith(".css") || req.getRequestURI().endsWith(".js")
                                    || req.getRequestURI().contains("LoginServlet") 
                                    || req.getRequestURI().contains("RegisterServlet")
                                    || req.getRequestURI().contains("CheckPhoneServlet");

        if (loggedIn || loginRequest || registerRequest || isStaticOrPublic) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(loginURI);
        }
    }

    @Override
    public void destroy() {}
}
