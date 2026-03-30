<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${restaurant.name} - Menu - Urban Eats</title>
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

        /* Premium Navbar - Cinematic Scale (Standardized) */
        .navbar {
            background: rgba(139, 92, 246, 0.95);
            backdrop-filter: blur(12px);
            padding: 1rem 0;
            box-shadow: 0 4px 40px rgba(0, 0, 0, 0.08);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            z-index: 1000;
        }
        body.dark-mode .navbar {
            background: rgba(15, 23, 42, 0.9);
            border-bottom: 1px solid rgba(139, 92, 246, 0.2);
        }

        .nav-icon-link {
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(255, 255, 255, 0.12);
            border-radius: 20px;
            color: white !important;
            transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
            text-decoration: none;
            border: 1px solid rgba(255, 255, 255, 0.15);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .nav-icon-link i { font-size: 1.6rem; }

        .nav-icon-link:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-5px) scale(1.1);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }

        .dark-toggle {
            width: 60px; height: 60px; display: flex; align-items: center; justify-content: center;
            background: rgba(255, 255, 255, 0.12); border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 20px; color: white; cursor: pointer; transition: all 0.4s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .dark-toggle i { font-size: 1.5rem; }

        .dark-toggle:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-5px);
        }

        /* Restaurant Header Overlay Scale Up */
        .rest-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            border-radius: 40px;
            padding: 3.5rem;
            color: white;
            box-shadow: 0 25px 60px rgba(139, 92, 246, 0.3);
            margin-bottom: 4rem;
            position: relative;
            overflow: hidden;
        }
        .rest-header::after {
            content: ""; position: absolute; top: -40%; right: -10%;
            width: 450px; height: 450px;
            background: rgba(255,255,255,0.08);
            border-radius: 50%;
        }

        .rating-chip {
            background: #10b981;
            padding: 10px 20px;
            border-radius: 18px;
            font-weight: 800;
            font-size: 1.3rem;
            box-shadow: 0 6px 15px rgba(0,0,0,0.15);
        }

        .menu-card {
            border-radius: 32px;
            border: none;
            background: var(--surface);
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.04);
            overflow: hidden;
            padding: 1rem;
        }
        body.dark-mode .menu-card {
            background: rgba(30, 41, 59, 0.7);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(139, 92, 246, 0.15);
        }

        .menu-item {
            padding: 2rem;
            border-bottom: 1px solid var(--border-color);
            transition: all 0.3s ease;
        }
        body.dark-mode .menu-item { border-bottom-color: rgba(139, 92, 246, 0.1); }
        .menu-item:hover { background: rgba(139, 92, 246, 0.03); }

        .btn-purple {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white; border: none; font-weight: 800;
            padding: 14px 28px; border-radius: 18px;
            transition: all 0.3s ease;
            box-shadow: 0 6px 20px rgba(139, 92, 246, 0.25);
            font-size: 1.05rem;
        }
        .btn-purple:hover { transform: translateY(-3px); box-shadow: 0 12px 30px rgba(139, 92, 246, 0.4); color: white; }

        /* Quantity Widget Scale Up */
        .qty-widget {
            background: var(--surface-light);
            border-radius: 16px;
            border: 1px solid var(--border-color);
            display: flex; align-items: center;
            padding: 6px;
        }
        body.dark-mode .qty-widget { background: rgba(15, 23, 42, 0.5); border-color: rgba(139, 92, 246, 0.25); }
        .qty-widget button {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(139, 92, 246, 0.2);
            color: var(--primary);
            width: 40px; height: 40px;
            border-radius: 12px;
            font-size: 1.2rem;
            font-weight: 800; cursor: pointer;
            transition: all 0.2s ease;
        }
        .qty-widget button:hover { background: var(--primary); color: white; }
        .qty-widget input {
            width: 45px; border: none; background: transparent; text-align: center;
            font-weight: 800; font-size: 1.2rem; color: var(--text-primary);
        }

        body.dark-mode .menu-item h4.text-dark { color: #e9d5ff !important; }
        body.dark-mode .menu-item .text-secondary { color: rgba(233, 213, 255, 0.72) !important; }

        body.dark-mode .qty-widget button {
            background: rgba(255, 255, 255, 0.06);
            border-color: rgba(139, 92, 246, 0.35);
            color: #e9d5ff;
        }
        body.dark-mode .qty-widget input { color: #f8fafc; }

        /* Hide number spinners for a cleaner stepper */
        .qty-widget input[type="number"]::-webkit-outer-spin-button,
        .qty-widget input[type="number"]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        .qty-widget input[type="number"] { -moz-appearance: textfield; }


        /* Veg Switch */
        .veg-switch { display: flex; align-items: center; cursor: pointer; user-select: none; }
        .veg-switch input { display: none; }
        .veg-slider { width: 52px; height: 26px; background: #cbd5e1; border-radius: 100px; position: relative; transition: 0.3s; margin-right: 12px; }
        .veg-slider::before { content: ""; position: absolute; width: 18px; height: 18px; background: white; border-radius: 50%; top: 3px; left: 3px; transition: 0.3s; }
        .veg-switch input:checked + .veg-slider { background: #10b981; }
        .veg-switch input:checked + .veg-slider::before { transform: translateX(26px); }
        .veg-label { font-weight: 700; font-size: 0.95rem; color: var(--text-secondary); }
        .veg-switch input:checked ~ .veg-label { color: #10b981; }

        /* Floating Cart Bar - Premium Glassmorphism */
        #floatingCartBar {
            position: fixed; bottom: 30px; left: 50%; transform: translateX(-50%);
            width: 90%; max-width: 500px;
            background: rgba(139, 92, 246, 0.9);
            backdrop-filter: blur(15px);
            color: white; border-radius: 24px;
            padding: 12px 24px;
            display: none; align-items: center; justify-content: space-between;
            box-shadow: 0 15px 40px rgba(139, 92, 246, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.2);
            z-index: 1001;
            animation: slideUp 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        @keyframes slideUp {
            from { transform: translate(-50%, 150%); opacity: 0; }
            to { transform: translate(-50%, 0); opacity: 1; }
        }

        .btn-view-cart {
            background: white; color: var(--primary);
            font-weight: 800; padding: 10px 20px; border-radius: 16px;
            text-decoration: none; font-size: 0.9rem; transition: all 0.3s ease;
        }
        .btn-view-cart:hover { background: #f8fafc; transform: scale(1.05); }
        
        /* ═══ DARK MODE TEXT FIXES ═══ */
        body.dark-mode .text-dark { color: #f1f5f9 !important; }
        body.dark-mode h4.text-dark { color: #f1f5f9 !important; }

    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
    <div class="container-fluid px-4">
        <a class="navbar-brand fw-800 fs-3" href="HomeServlet">
            <i class="bi bi-basket-fill text-warning me-2"></i>Urban Eats
        </a>
        <div class="ms-auto d-flex align-items-center gap-3">
            <a href="HomeServlet" class="nav-icon-link" title="Home"><i class="bi bi-house-door-fill"></i></a>
            <a href="MoodSuggestServlet" class="nav-icon-link" title="AI Suggest"><i class="bi bi-stars"></i></a>
            <a href="CartServlet" class="nav-icon-link" title="My Cart"><i class="bi bi-cart3"></i></a>
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
    <!-- Header Section -->
    <div class="rest-header mt-5">
        <div class="row align-items-center g-4">
            <div class="col-md-8">
                <div class="d-flex align-items-center gap-3 mb-2">
                    <span class="badge bg-white text-primary rounded-pill fw-800 px-3 py-2">Open Now</span>
                    <span class="badge bg-white bg-opacity-20 text-white rounded-pill fw-700 px-3 py-2"><i class="bi bi-clock me-1"></i> ${restaurant.deliveryTime}m</span>
                </div>
                <h1 class="fw-800 mb-2" style="font-size: clamp(2.2rem, 4.5vw, 3.5rem); letter-spacing: -2px;">${restaurant.name}</h1>
                <p class="fs-5 opacity-90 fw-500 mb-0"><i class="bi bi-geo-alt-fill me-2"></i>${restaurant.city}</p>
            </div>
            <div class="col-md-4 text-md-end">
                <div class="rating-chip d-inline-block">
                    <i class="bi bi-star-fill me-1"></i> ${restaurant.rating}
                </div>
                <c:if test="${not empty restaurant.offers}">
                    <div class="mt-3 fs-5 fw-700">
                        <i class="bi bi-gift-fill me-2"></i> ${restaurant.offers}
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Filter Bar -->
    <div class="d-flex justify-content-between align-items-center mb-5 px-3">
        <h3 class="fw-800 letter-tight mb-0">Menu Discovery</h3>
        <label class="veg-switch">
            <input type="checkbox" id="vegToggleMenu">
            <span class="veg-slider"></span>
            <span class="veg-label"><i class="bi bi-leaf-fill me-1"></i>Pure Veg Selection</span>
        </label>
    </div>

    <!-- Menu Grid -->
    <div class="menu-card mb-5">
        <c:forEach var="item" items="${menu}">
            <div class="menu-item border-bottom last-child-border-0" data-is-veg="${item.isVeg()}">
                <div class="row align-items-center g-3">
                    <div class="col-md-1">
                        <i class="bi bi-record-btn-fill fs-3 ${item.veg ? 'text-success' : 'text-danger'}"></i>
                    </div>
                    <div class="col-md-7">
                        <h4 class="fw-800 mb-1 text-dark">${item.name}</h4>
                        <h5 class="fw-800 text-primary mb-3">₹${item.price}</h5>
                        <p class="text-secondary small mb-0 pe-md-5">${item.description}</p>
                    </div>
                    <div class="col-md-4 text-md-end">
                        <form action="CartServlet" method="post" class="d-inline-flex flex-column align-items-md-end gap-2 ajax-add-form">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="itemId" value="${item.itemId}">
                            <input type="hidden" name="restaurantId" value="${restaurant.restaurantId}">
                            
                            <div class="qty-widget p-1">
                                <button type="button" onclick="this.nextElementSibling.stepDown()">-</button>
                                <input type="number" name="quantity" value="1" min="1" max="99" readonly>
                                <button type="button" onclick="this.previousElementSibling.stepUp()">+</button>
                            </div>
                            
                            <button type="submit" class="btn btn-purple px-4 py-2 fw-800 rounded-3">
                                ADD TO BAG
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
        
        <c:if test="${empty menu}">
            <div class="p-5 text-center py-5">
                <i class="bi bi-cloud-slash fs-1 text-muted opacity-25 mb-3 d-block"></i>
                <h4 class="fw-700">Digital menu loading...</h4>
                <p class="text-secondary">Please check back in a few moments.</p>
            </div>
        </c:if>
    </div>
</div>

<!-- Floating Cart Bar -->
<div id="floatingCartBar">
    <div class="d-flex align-items-center gap-3">
        <div class="bg-white text-primary p-2 rounded-4" style="box-shadow: 0 4px 12px rgba(0,0,0,0.1);">
            <i class="bi bi-cart-fill fs-4"></i>
        </div>
        <div>
            <span id="cartItemCount" class="fw-800 fs-5 d-block line-height-1">0</span>
            <span class="small opacity-75 fw-600">items in bag</span>
        </div>
    </div>
    <a href="CartServlet" class="btn-view-cart text-uppercase">
        View Order <i class="bi bi-chevron-right ms-1"></i>
    </a>
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

    document.addEventListener("DOMContentLoaded", function() {
        // Veg Filtering
        const vegToggle = document.getElementById('vegToggleMenu');
        const menuItems = document.querySelectorAll('.menu-item');
        
        vegToggle.addEventListener('change', () => {
            const onlyVeg = vegToggle.checked;
            menuItems.forEach(item => {
                const isVeg = item.getAttribute('data-is-veg') === 'true';
                item.style.display = (onlyVeg && !isVeg) ? 'none' : 'block';
            });
        });

        const cartBar = document.getElementById('floatingCartBar');
        const countSpan = document.getElementById('cartItemCount');

        function syncCartBar(count) {
            if (count > 0) {
                countSpan.innerText = count;
                cartBar.style.display = 'flex';
            } else {
                cartBar.style.display = 'none';
            }
        }

        // Initial Sync
        fetch('CartServlet?action=count', { headers: { 'X-Requested-With': 'XMLHttpRequest' }})
        .then(res => res.json())
        .then(data => { if (data.status === 'success') syncCartBar(data.cartCount); });

        // AJAX Add Logic
        document.querySelectorAll('.ajax-add-form').forEach(form => {
            form.addEventListener('submit', function(e) {
                e.preventDefault();
                const btn = this.querySelector('button[type="submit"]');
                btn.disabled = true;
                btn.style.opacity = '0.7';

                fetch('CartServlet', {
                    method: 'POST',
                    headers: { 
                        'X-Requested-With': 'XMLHttpRequest',
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: new URLSearchParams(new FormData(this))
                })
                .then(res => res.json())
                .then(data => {
                    if (data.status === 'success') {
                        syncCartBar(data.cartCount);
                        const oldText = btn.innerText;
                        btn.innerText = 'ADDED';
                        btn.classList.add('bg-success');
                        setTimeout(() => {
                            btn.innerText = oldText;
                            btn.classList.remove('bg-success');
                            btn.disabled = false;
                            btn.style.opacity = '1';
                        }, 1000);
                    } else if (data.status === 'error' && data.message === 'different_restaurant') {
                        if (confirm("Your cart contains items from another restaurant. Do you want to clear your cart and add this item?")) {
                            const fd = new URLSearchParams(new FormData(form));
                            fd.set('action', 'clear_and_add');
                            fetch('CartServlet', {
                                method: 'POST',
                                headers: { 
                                    'X-Requested-With': 'XMLHttpRequest',
                                    'Content-Type': 'application/x-www-form-urlencoded'
                                },
                                body: fd
                            })
                            .then(res => res.json())
                            .then(d => {
                                if (d.status === 'success') {
                                    syncCartBar(d.cartCount);
                                    const oldText = btn.innerText;
                                    btn.innerText = 'ADDED';
                                    btn.classList.add('bg-success');
                                    setTimeout(() => {
                                        btn.innerText = oldText;
                                        btn.classList.remove('bg-success');
                                        btn.disabled = false;
                                        btn.style.opacity = '1';
                                    }, 1000);
                                }
                            })
                            .catch(() => { btn.disabled = false; btn.style.opacity = '1'; });
                        } else {
                            btn.disabled = false;
                            btn.style.opacity = '1';
                        }
                    } else {
                        btn.disabled = false;
                        btn.style.opacity = '1';
                    }
                })
                .catch(() => { btn.disabled = false; btn.style.opacity = '1'; });
            });
        });
    });
</script>
</body>
</html>
