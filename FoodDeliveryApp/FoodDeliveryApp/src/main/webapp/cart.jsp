<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart - Urban Eats</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #8b5cf6;
            --primary-dark: #7c3aed;
            --primary-light: #ede9fe;
            --primary-hover: #6d28d9;
            --surface: #ffffff;
            --surface-light: #f8fafc;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --border-color: #e2e8f0;
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

        /* ═══════════════════════════════════════════
           NAVBAR - Premium Standardized
           ═══════════════════════════════════════════ */
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

        .navbar-brand {
            font-size: 1.8rem !important;
            font-weight: 800 !important;
            letter-spacing: -1.5px;
        }

        .nav-icon-link {
            width: 48px;
            height: 48px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(255, 255, 255, 0.12);
            border-radius: 16px;
            color: white !important;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            text-decoration: none;
            border: 1px solid rgba(255, 255, 255, 0.15);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .nav-icon-link i {
            font-size: 1.25rem;
            color: white !important;
        }
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
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }

        /* ═══════════════════════════════════════════
           PAGE LAYOUT
           ═══════════════════════════════════════════ */
        .container { margin-top: 2.5rem; }

        .page-title {
            font-size: 2rem;
            font-weight: 800;
            letter-spacing: -1px;
            margin-bottom: 2rem;
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: 12px;
        }
        body.dark-mode .page-title { color: #f8fafc; }

        /* ═══════════════════════════════════════════
           BUTTONS
           ═══════════════════════════════════════════ */
        .btn-purple {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white; border: none; font-weight: 700;
            padding: 14px 28px; border-radius: 16px;
            transition: all 0.3s ease;
            box-shadow: 0 6px 20px rgba(139, 92, 246, 0.35);
            font-size: 1.05rem;
        }
        .btn-purple:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(139, 92, 246, 0.5);
            color: white;
        }

        /* ═══════════════════════════════════════════
           CART ITEM CARDS
           ═══════════════════════════════════════════ */
        .cart-card {
            border-radius: 24px;
            border: 1px solid var(--border-color);
            background: var(--surface);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.04);
            overflow: hidden;
        }
        body.dark-mode .cart-card {
            background: rgba(30, 41, 59, 0.7);
            border: 1px solid rgba(139, 92, 246, 0.15);
            backdrop-filter: blur(10px);
        }

        .cart-item {
            padding: 1.5rem 1.8rem;
            border-bottom: 1px solid var(--border-color);
            transition: background 0.3s ease;
        }
        .cart-item:last-child { border-bottom: none; }
        .cart-item:hover { background: rgba(139, 92, 246, 0.02); }
        body.dark-mode .cart-item {
            border-bottom-color: rgba(139, 92, 246, 0.1);
        }
        body.dark-mode .cart-item:hover { background: rgba(139, 92, 246, 0.05); }

        .item-name {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 4px;
        }
        body.dark-mode .item-name { color: #f1f5f9; }

        .item-unit-price {
            font-size: 0.85rem;
            color: var(--text-secondary);
            font-weight: 500;
        }

        .item-total {
            font-size: 1.25rem;
            font-weight: 800;
            color: var(--primary);
        }

        .veg-dot {
            width: 14px; height: 14px;
            border: 2px solid;
            border-radius: 3px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        .veg-dot.veg { border-color: #16a34a; }
        .veg-dot.veg::after { content: ""; width: 7px; height: 7px; border-radius: 50%; background: #16a34a; }
        .veg-dot.non-veg { border-color: #dc2626; }
        .veg-dot.non-veg::after { content: ""; width: 7px; height: 7px; border-radius: 50%; background: #dc2626; }

        /* ═══════════════════════════════════════════
           QUANTITY CONTROLS
           ═══════════════════════════════════════════ */
        .qty-controls {
            display: inline-flex;
            align-items: center;
            gap: 0;
            background: var(--surface-light);
            border-radius: 12px;
            border: 2px solid var(--border-color);
            overflow: hidden;
        }
        body.dark-mode .qty-controls {
            background: rgba(15, 23, 42, 0.5);
            border-color: rgba(139, 92, 246, 0.3);
        }

        .qty-controls button {
            width: 38px; height: 38px;
            display: flex; align-items: center; justify-content: center;
            background: transparent;
            border: none;
            color: var(--primary);
            font-size: 1.2rem;
            font-weight: 800;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .qty-controls button:hover {
            background: var(--primary);
            color: white;
        }
        body.dark-mode .qty-controls button { color: #c4b5fd; }
        body.dark-mode .qty-controls button:hover { background: var(--primary); color: white; }

        .qty-value {
            min-width: 36px;
            text-align: center;
            font-weight: 800;
            font-size: 1.05rem;
            color: var(--text-primary);
            padding: 0 4px;
            border-left: 2px solid var(--border-color);
            border-right: 2px solid var(--border-color);
            height: 38px;
            line-height: 38px;
        }
        body.dark-mode .qty-value {
            color: #f8fafc;
            border-color: rgba(139, 92, 246, 0.3);
        }

        .btn-remove {
            background: none;
            border: 2px solid #fca5a5;
            color: #ef4444;
            font-weight: 700;
            font-size: 0.85rem;
            padding: 6px 16px;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .btn-remove:hover {
            background: #fef2f2;
            border-color: #ef4444;
            transform: translateY(-1px);
        }
        body.dark-mode .btn-remove { border-color: rgba(239,68,68,0.4); }
        body.dark-mode .btn-remove:hover { background: rgba(239,68,68,0.1); }

        /* ═══════════════════════════════════════════
           BILL SUMMARY
           ═══════════════════════════════════════════ */
        .bill-card {
            border-radius: 24px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(139, 92, 246, 0.1);
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.06);
            padding: 1.8rem;
        }
        body.dark-mode .bill-card {
            background: rgba(30, 41, 59, 0.85);
            border: 1px solid rgba(139, 92, 246, 0.2);
            backdrop-filter: blur(15px);
        }

        .bill-title {
            font-size: 1.2rem;
            font-weight: 800;
            color: var(--primary);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .bill-row {
            display: flex; justify-content: space-between;
            margin-bottom: 0.9rem; font-weight: 500; color: var(--text-secondary);
            font-size: 0.95rem;
        }
        body.dark-mode .bill-row { color: #94a3b8; }

        .bill-row strong {
            color: var(--text-primary);
            font-weight: 700;
        }
        body.dark-mode .bill-row strong { color: #f8fafc; }

        .total-divider {
            border: none;
            border-top: 2px dashed var(--border-color);
            margin: 1.2rem 0;
        }
        body.dark-mode .total-divider { border-top-color: rgba(139, 92, 246, 0.2); }

        .total-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .total-label {
            font-size: 1.1rem;
            font-weight: 800;
            color: var(--primary);
        }
        .total-amount {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--primary);
        }

        .ssl-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 0.8rem;
            font-weight: 600;
            color: var(--primary);
            background: var(--primary-light);
            padding: 6px 14px;
            border-radius: 20px;
        }
        body.dark-mode .ssl-badge {
            background: rgba(139, 92, 246, 0.15);
            color: #c4b5fd;
        }

        /* ═══════════════════════════════════════════
           EMPTY CART
           ═══════════════════════════════════════════ */
        .empty-cart-card {
            border-radius: 24px;
            border: none;
            background: var(--surface);
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.05);
        }
        body.dark-mode .empty-cart-card {
            background: rgba(30, 41, 59, 0.7);
        }

        .empty-cart-icon {
            font-size: 5rem;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
    <div class="container-fluid px-4">
        <a class="navbar-brand" href="HomeServlet">
            <i class="bi bi-basket-fill text-warning me-2"></i>Urban Eats
        </a>
        <div class="ms-auto d-flex align-items-center gap-2">
            <a href="HomeServlet" class="nav-icon-link" title="Home"><i class="bi bi-house-door-fill"></i></a>
            <a href="MoodSuggestServlet" class="nav-icon-link" title="AI Suggest"><i class="bi bi-stars"></i></a>
            <a href="OrderTrackingServlet" class="nav-icon-link" title="My Orders"><i class="bi bi-box-seam"></i></a>
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
    <div class="page-title">
        <i class="bi bi-cart-check-fill text-primary"></i>Review Your Order
    </div>
    
    <c:if test="${not empty cartItems}">
        <div class="row g-4">
            <!-- Items Column -->
            <div class="col-lg-8">
                <div class="cart-card">
                    <c:forEach var="item" items="${cartItems}">
                        <c:set var="mItem" value="${menuMap[item.itemId]}" />
                        <div class="cart-item">
                            <div class="d-flex justify-content-between align-items-start">
                                <div class="flex-grow-1">
                                    <div class="d-flex align-items-center gap-2 mb-1">
                                        <span class="veg-dot ${mItem.veg ? 'veg' : 'non-veg'}"></span>
                                        <span class="item-name">${mItem.name}</span>
                                    </div>
                                    <div class="item-unit-price mb-3">₹${mItem.price} / unit</div>
                                    
                                    <div class="d-flex align-items-center gap-3">
                                        <div class="qty-controls">
                                            <button type="button" onclick="updateQty(${item.cartId}, ${item.quantity - 1}, this)" title="Decrease">−</button>
                                            <span class="qty-value" id="qty-${item.cartId}">${item.quantity}</span>
                                            <button type="button" onclick="updateQty(${item.cartId}, ${item.quantity + 1}, this)" title="Increase">+</button>
                                        </div>
                                        <button onclick="updateQty(${item.cartId}, 0, this)" class="btn-remove">
                                            <i class="bi bi-trash3"></i>Remove
                                        </button>
                                    </div>
                                </div>
                                <div class="text-end ms-3">
                                    <span class="item-total" id="item-total-${item.cartId}">₹${mItem.price * item.quantity}</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Bill Column -->
            <div class="col-lg-4">
                <div class="bill-card sticky-top" style="top: 90px;">
                    <div class="bill-title">
                        <i class="bi bi-receipt-cutoff"></i>Bill Summary
                    </div>
                    
                    <div class="bill-row">
                        <span>Items Total</span>
                        <strong id="bill-subtotal">₹${subtotal}</strong>
                    </div>
                    
                    <c:if test="${discountAmount > 0}">
                        <div class="bill-row" style="color: #16a34a;">
                            <span>Discount (${offerText})</span>
                            <strong style="color: #16a34a;" id="bill-discount">- ₹${discountAmount}</strong>
                        </div>
                    </c:if>

                    <div class="bill-row">
                        <span>Delivery Fee</span>
                        <strong style="color: #16a34a;">FREE</strong>
                    </div>

                    <hr class="total-divider">

                    <div class="total-row mb-4">
                        <span class="total-label">To Pay</span>
                        <span class="total-amount" id="bill-total">₹${totalAmount}</span>
                    </div>

                    <form action="CheckoutServlet" method="post">
                        <input type="hidden" name="totalAmount" value="${totalAmount}">
                        <input type="hidden" name="restaurantId" value="${restaurantId}">
                        <button type="submit" class="btn btn-purple w-100 py-3 rounded-pill">
                            Checkout & Place Order <i class="bi bi-arrow-right-circle ms-2"></i>
                        </button>
                    </form>
                    
                    <div class="text-center mt-3">
                        <span class="ssl-badge">
                            <i class="bi bi-shield-check"></i> SSL Secure Transaction
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${empty cartItems}">
        <div class="empty-cart-card text-center p-5 mt-4">
            <div class="empty-cart-icon"><i class="bi bi-bag-x-fill"></i></div>
            <h2 class="fw-800 mb-3">Your cart is feeling light</h2>
            <p class="text-secondary mb-4 mx-auto" style="max-width: 400px;">Looks like you haven't added anything yet. Discover the best food from top-rated restaurants near you.</p>
            <a href="HomeServlet" class="btn btn-purple px-5 rounded-pill">
                Explore Restaurants
            </a>
        </div>
    </c:if>
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

    function updateQty(cartId, newQty, btn) {
        if (newQty < 0) return;
        
        const controls = btn.closest('.qty-controls') || btn.closest('.cart-item');
        if (controls) {
            controls.style.opacity = '0.5';
            controls.style.pointerEvents = 'none';
        }

        fetch('${pageContext.request.contextPath}/CartServlet', {
            method: 'POST',
            headers: { 
                'Content-Type': 'application/x-www-form-urlencoded',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: 'action=update&cartId=' + cartId + '&newQuantity=' + newQty
        })
        .then(res => res.json())
        .then(data => {
            if (data.status === 'success') {
                location.reload();
            }
        })
        .catch(err => {
            console.error('Cart error:', err);
            location.reload();
        });
    }
</script>
</body>
</html>
