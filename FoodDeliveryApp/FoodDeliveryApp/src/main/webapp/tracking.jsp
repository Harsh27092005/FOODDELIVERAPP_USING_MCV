<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Track Order - Urban Eats</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #8b5cf6;
            --primary-dark: #7c3aed;
            --primary-light: #ede9fe;
            --surface: #ffffff;
            --surface-light: #f8fafc;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --border-color: #e2e8f0;
            --success: #10b981;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #ede9fe 100%);
            min-height: 100vh;
            color: var(--text-primary);
            transition: all 0.3s ease;
            font-size: 1.05rem;
        }
        body.dark-mode {
            background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 100%);
            color: #e2e8f0;
        }

        /* ═══ NAVBAR ═══ */
        .navbar {
            background: rgba(139, 92, 246, 0.95);
            backdrop-filter: blur(12px);
            padding: 0.8rem 0;
            box-shadow: 0 4px 40px rgba(0, 0, 0, 0.08);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            z-index: 1000;
        }
        body.dark-mode .navbar {
            background: rgba(15, 23, 42, 0.95);
            border-bottom: 1px solid rgba(139, 92, 246, 0.2);
        }
        .navbar-brand { font-size: 1.8rem !important; font-weight: 800 !important; letter-spacing: -1.5px; }

        .nav-icon-link {
            width: 48px; height: 48px;
            display: flex; align-items: center; justify-content: center;
            background: rgba(255, 255, 255, 0.12);
            border-radius: 16px; color: white !important;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            text-decoration: none;
            border: 1px solid rgba(255, 255, 255, 0.15);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .nav-icon-link i { font-size: 1.25rem; color: white !important; }
        .nav-icon-link:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-3px) scale(1.08);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }
        .dark-toggle {
            width: 48px; height: 48px; display: flex; align-items: center; justify-content: center;
            background: rgba(255, 255, 255, 0.12); border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 16px; color: white; cursor: pointer; transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .dark-toggle i { font-size: 1.25rem; }
        .dark-toggle:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-3px);
        }

        .container { margin-top: 2.5rem; }

        /* ═══ ORDER HEADER CARD ═══ */
        .order-header-card {
            background: linear-gradient(135deg, var(--primary) 0%, #6d28d9 50%, var(--primary-dark) 100%);
            border-radius: 28px;
            padding: 3rem 2rem;
            color: white;
            box-shadow: 0 20px 50px rgba(139, 92, 246, 0.3);
            margin-bottom: -40px;
            position: relative;
            z-index: 1;
            overflow: hidden;
        }
        .order-header-card::before {
            content: ""; position: absolute; top: -40%; right: -10%;
            width: 250px; height: 250px;
            background: rgba(255,255,255,0.08);
            border-radius: 50%;
        }
        .order-header-card::after {
            content: ""; position: absolute; bottom: -30%; left: -5%;
            width: 180px; height: 180px;
            background: rgba(255,255,255,0.05);
            border-radius: 50%;
        }

        .order-id-text {
            font-size: 2.5rem;
            font-weight: 800;
            letter-spacing: -2px;
            position: relative;
            z-index: 2;
        }
        .order-time-text {
            font-size: 1.05rem;
            opacity: 0.9;
            font-weight: 500;
            position: relative;
            z-index: 2;
        }
        .live-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(255,255,255,0.95);
            color: var(--primary);
            font-weight: 800;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 6px 16px;
            border-radius: 20px;
            position: relative;
            z-index: 2;
        }
        .live-dot {
            width: 8px; height: 8px;
            background: #ef4444;
            border-radius: 50%;
            animation: blink 1.5s infinite;
        }
        @keyframes blink {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.3; }
        }

        /* ═══ TIMELINE CARD ═══ */
        .timeline-card {
            border-radius: 28px;
            border: none;
            background: var(--surface);
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.05);
            padding: 5rem 2.5rem 2.5rem;
        }
        body.dark-mode .timeline-card {
            background: rgba(30, 41, 59, 0.75);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(139, 92, 246, 0.15);
        }

        /* ═══ TIMELINE ═══ */
        .timeline {
            position: relative;
            padding-left: 60px;
        }
        .timeline::before {
            content: ""; position: absolute;
            left: 23px; top: 5px; bottom: 5px;
            width: 3px;
            background: var(--border-color);
            border-radius: 3px;
        }
        body.dark-mode .timeline::before { background: rgba(255,255,255,0.08); }

        .timeline-step {
            position: relative;
            padding-bottom: 2.5rem;
            transition: all 0.5s ease;
        }
        .timeline-step:last-child { padding-bottom: 0; }

        .step-icon {
            position: absolute;
            left: -60px; top: -2px;
            width: 48px; height: 48px;
            border-radius: 16px;
            display: flex; align-items: center; justify-content: center;
            background: var(--surface-light);
            border: 2px solid var(--border-color);
            font-size: 1.4rem;
            z-index: 2;
            transition: all 0.4s ease;
        }
        body.dark-mode .step-icon {
            background: #1e293b;
            border-color: rgba(255,255,255,0.08);
        }

        .timeline-step.active .step-icon {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            border-color: transparent;
            box-shadow: 0 8px 20px rgba(16, 185, 129, 0.3);
            color: white;
        }

        .step-content {
            opacity: 0.45;
            transition: all 0.4s ease;
            padding-top: 2px;
        }
        .timeline-step.active .step-content {
            opacity: 1;
        }

        .step-title {
            font-weight: 800;
            font-size: 1.1rem;
            margin-bottom: 3px;
            color: var(--text-primary);
        }
        body.dark-mode .step-title { color: #f1f5f9; }
        .step-desc {
            font-weight: 500;
            font-size: 0.9rem;
            color: var(--text-secondary);
            line-height: 1.5;
        }

        /* Current step gets a subtle highlight */
        .timeline-step.current .step-icon {
            animation: pulse-glow 2s infinite;
        }
        @keyframes pulse-glow {
            0% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.4); }
            70% { box-shadow: 0 0 0 14px rgba(16, 185, 129, 0); }
            100% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0); }
        }

        /* ═══ PAYMENT FOOTER ═══ */
        .payment-footer {
            background: var(--surface-light);
            border-radius: 20px;
            padding: 1.5rem 2rem;
            border: 1px solid var(--border-color);
            margin-top: 2rem;
        }
        body.dark-mode .payment-footer {
            background: rgba(15, 23, 42, 0.4);
            border-color: rgba(139, 92, 246, 0.15);
        }

        .payment-label {
            font-size: 0.7rem;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--text-secondary);
            margin-bottom: 4px;
        }
        .payment-value {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--primary);
        }
        .payment-method {
            font-size: 1rem;
            font-weight: 700;
            color: var(--text-primary);
        }
        body.dark-mode .payment-method { color: #e2e8f0; }

        .btn-back {
            background: transparent;
            color: var(--primary);
            border: 2px solid var(--primary);
            font-weight: 700;
            padding: 12px 24px;
            border-radius: 16px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-back:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(139, 92, 246, 0.3);
        }

        /* ═══ ORDER LIST ═══ */
        .page-title {
            font-size: 2rem;
            font-weight: 800;
            letter-spacing: -1px;
            color: var(--text-primary);
        }
        body.dark-mode .page-title { color: #f8fafc; }

        .btn-purple {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white; border: none; font-weight: 700;
            padding: 12px 24px; border-radius: 14px;
            transition: all 0.3s ease;
            box-shadow: 0 6px 20px rgba(139, 92, 246, 0.3);
            text-decoration: none;
        }
        .btn-purple:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(139, 92, 246, 0.45);
            color: white;
        }

        .order-card {
            background: var(--surface);
            border-radius: 20px;
            padding: 1.5rem 1.8rem;
            border: 1px solid var(--border-color);
            transition: all 0.3s ease;
        }
        body.dark-mode .order-card {
            background: rgba(30, 41, 59, 0.6);
            border-color: rgba(139, 92, 246, 0.12);
        }
        .order-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.06);
        }

        .status-chip {
            padding: 6px 14px;
            border-radius: 10px;
            font-weight: 800;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .order-amount {
            font-size: 1.25rem;
            font-weight: 800;
            color: var(--primary);
        }

        .btn-track {
            background: none;
            border: 2px solid var(--primary);
            color: var(--primary);
            font-weight: 700;
            font-size: 0.85rem;
            padding: 6px 18px;
            border-radius: 12px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .btn-track:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-1px);
        }

        .empty-icon {
            font-size: 4rem;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 1rem;
        }

        body.dark-mode .order-card h5,
        body.dark-mode .text-dark { color: #f1f5f9 !important; }
    </style>
    <c:if test="${not empty order and order.status != 'Delivered'}">
        <meta http-equiv="refresh" content="7">
    </c:if>
</head>
<body class="pb-5">

<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
    <div class="container-fluid px-4">
        <a class="navbar-brand" href="HomeServlet">
            <i class="bi bi-basket-fill text-warning me-2"></i>Urban Eats
        </a>
        <div class="ms-auto d-flex align-items-center gap-2">
            <a href="HomeServlet" class="nav-icon-link" title="Home"><i class="bi bi-house-door-fill"></i></a>
            <a href="MoodSuggestServlet" class="nav-icon-link" title="AI Suggest"><i class="bi bi-stars"></i></a>
            <a href="CartServlet" class="nav-icon-link" title="My Cart"><i class="bi bi-cart3"></i></a>
            <div class="dropdown">
                <a href="#" class="nav-icon-link" data-bs-toggle="dropdown" aria-expanded="false" title="My Profile" style="overflow: hidden; padding: 0;">
                    <c:choose>
                        <c:when test="${not empty user.profilePhoto}">
                            <img src="${user.profilePhoto}" alt="Profile" style="width: 100%; height: 100%; object-fit: cover;">
                        </c:when>
                        <c:otherwise>
                            <i class="bi bi-person-circle"></i>
                        </c:otherwise>
                    </c:choose>
                </a>
                <ul class="dropdown-menu dropdown-menu-end shadow-sm" style="border-radius: 12px; margin-top: 10px;">
                    <li><a class="dropdown-item fw-600 py-2" href="ProfileServlet"><i class="bi bi-person-circle me-2 text-primary"></i>My Profile</a></li>
                    <li><a class="dropdown-item fw-600 py-2" href="#" id="darkToggleDropdown"><i class="bi bi-moon-stars-fill me-2 text-warning"></i>Dark Theme</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item fw-600 py-2 text-danger" href="login.jsp"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                </ul>
            </div>
        </div>
    </div>
</nav>

<div class="container pb-5">
    
    <c:choose>
        <c:when test="${not empty order}">
            <c:set var="st" value="${order.status}" />
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <!-- Order Header -->
                    <div class="order-header-card text-center">
                        <div class="mb-3">
                            <span class="live-badge"><span class="live-dot"></span> LIVE TRACKING</span>
                        </div>
                        <div class="order-id-text mb-1">Order #${order.orderId}</div>
                        <div class="order-time-text">
                            <i class="bi bi-clock-history me-1"></i>Placed <fmt:formatDate value="${order.createdAt}" pattern="hh:mm a" />
                        </div>
                    </div>

                    <!-- Timeline -->
                    <div class="timeline-card">
                        <div class="timeline">
                            <div class="timeline-step ${st == 'Preparing' || st == 'Food Ready' || st == 'Out for Delivery' || st == 'Delivered' ? 'active' : ''} ${st == 'Preparing' ? 'current' : ''}">
                                <div class="step-icon">
                                    <c:choose>
                                        <c:when test="${st == 'Preparing' || st == 'Food Ready' || st == 'Out for Delivery' || st == 'Delivered'}"><i class="bi bi-check-lg" style="color:white;"></i></c:when>
                                        <c:otherwise>📋</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="step-content">
                                    <div class="step-title">Order Confirmed</div>
                                    <div class="step-desc">Your order has been received and is being prepared with care.</div>
                                </div>
                            </div>

                            <div class="timeline-step ${st == 'Food Ready' || st == 'Out for Delivery' || st == 'Delivered' ? 'active' : ''} ${st == 'Food Ready' ? 'current' : ''}">
                                <div class="step-icon">
                                    <c:choose>
                                        <c:when test="${st == 'Food Ready' || st == 'Out for Delivery' || st == 'Delivered'}"><i class="bi bi-check-lg" style="color:white;"></i></c:when>
                                        <c:otherwise>👨‍🍳</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="step-content">
                                    <div class="step-title">Preparing Your Meal</div>
                                    <div class="step-desc">The chef is working their magic. Almost ready!</div>
                                </div>
                            </div>

                            <div class="timeline-step ${st == 'Out for Delivery' || st == 'Delivered' ? 'active' : ''} ${st == 'Out for Delivery' ? 'current' : ''}">
                                <div class="step-icon">
                                    <c:choose>
                                        <c:when test="${st == 'Out for Delivery' || st == 'Delivered'}"><i class="bi bi-check-lg" style="color:white;"></i></c:when>
                                        <c:otherwise>🛵</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="step-content">
                                    <div class="step-title">Out for Delivery</div>
                                    <div class="step-desc">A delivery partner is on the way to your doorstep.</div>
                                </div>
                            </div>

                            <div class="timeline-step ${st == 'Delivered' ? 'active' : ''} ${st == 'Delivered' ? 'current' : ''}">
                                <div class="step-icon">
                                    <c:choose>
                                        <c:when test="${st == 'Delivered'}"><i class="bi bi-check-lg" style="color:white;"></i></c:when>
                                        <c:otherwise>📦</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="step-content">
                                    <div class="step-title">Delivered</div>
                                    <div class="step-desc">Enjoy your meal! Thank you for choosing Urban Eats.</div>
                                </div>
                            </div>
                        </div>

                        <!-- Payment Footer -->
                        <div class="payment-footer d-flex justify-content-between align-items-center">
                            <div>
                                <div class="payment-label">Payment Amount</div>
                                <div class="payment-value">₹${order.totalAmount}</div>
                            </div>
                            <div class="text-end">
                                <div class="payment-label">Method</div>
                                <div class="payment-method"><i class="bi bi-credit-card-2-front me-1"></i>${order.paymentMethod}</div>
                            </div>
                        </div>

                        <div class="text-center mt-4">
                            <a href="OrderTrackingServlet" class="btn-back">
                                <i class="bi bi-arrow-left"></i> Back to My Orders
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        
        <c:otherwise>
            <div class="d-flex justify-content-between align-items-center mb-4">
                <span class="page-title">My Orders</span>
                <a href="HomeServlet" class="btn-purple">New Order <i class="bi bi-plus-lg ms-2"></i></a>
            </div>

            <div class="row g-4">
                <c:forEach var="o" items="${orders}">
                    <div class="col-lg-6">
                        <div class="order-card">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div>
                                    <h5 class="fw-800 mb-1 text-dark">Order #${o.orderId}</h5>
                                    <p class="text-secondary small fw-600 mb-0"><i class="bi bi-calendar3 me-1"></i><fmt:formatDate value="${o.createdAt}" pattern="dd MMM yyyy, hh:mm a" /></p>
                                </div>
                                <span class="status-chip ${o.status == 'Delivered' ? 'bg-success bg-opacity-10 text-success' : 'bg-primary bg-opacity-10 text-primary'}">
                                    ${o.status}
                                </span>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <span class="order-amount">₹${o.totalAmount}</span>
                                <a href="OrderTrackingServlet?id=${o.orderId}" class="btn-track">
                                    Track Status <i class="bi bi-arrow-right ms-1"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty orders}">
                    <div class="col-12 text-center py-5">
                        <div class="empty-icon"><i class="bi bi-receipt"></i></div>
                        <h4 class="fw-800 mb-2">Your order history is empty</h4>
                        <p class="text-secondary mb-4">Start your food journey today!</p>
                        <a href="HomeServlet" class="btn-purple px-5 py-3">Browse Menu</a>
                    </div>
                </c:if>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const body = document.body;
    const toggleBtn = document.getElementById('darkToggleDropdown');

    if (localStorage.getItem('darkMode') === 'on') {
        body.classList.add('dark-mode');
        toggleBtn.innerHTML = '<i class="bi bi-sun-fill me-2 text-warning"></i>Light Theme';
    } else {
        toggleBtn.innerHTML = '<i class="bi bi-moon-stars-fill me-2 text-warning"></i>Dark Theme';
    }

    toggleBtn.addEventListener('click', (e) => {
        e.preventDefault();
        e.stopPropagation();
        body.classList.toggle('dark-mode');
        const isDark = body.classList.contains('dark-mode');
        localStorage.setItem('darkMode', isDark ? 'on' : 'off');
        toggleBtn.innerHTML = isDark ? '<i class="bi bi-sun-fill me-2 text-warning"></i>Light Theme' : '<i class="bi bi-moon-stars-fill me-2 text-warning"></i>Dark Theme';
    });
</script>
</body>
</html>
