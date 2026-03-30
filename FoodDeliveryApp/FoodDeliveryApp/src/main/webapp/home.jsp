<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - Urban Eats</title>
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

        /* Premium Navbar - Cinematic Scale */
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

        .nav-icon-link i {
            font-size: 1.6rem;
        }

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

        .dark-toggle i {
            font-size: 1.5rem;
        }

        .dark-toggle:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }

        .container { margin-top: 3rem; }

        .btn-purple {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white; border: none; font-weight: 800;
            padding: 12px 24px; border-radius: 16px;
            transition: all 0.3s ease;
            box-shadow: 0 6px 20px rgba(139, 92, 246, 0.3);
            font-size: 1.1rem;
        }

        .btn-purple:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(139, 92, 246, 0.4);
            color: white;
        }

        /* Filter Section Scale Up */
        .filter-card {
            border-radius: 32px;
            border: none;
            background: var(--surface);
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.06);
            padding: 2.5rem !important;
        }
        body.dark-mode .filter-card {
            background: rgba(30, 41, 59, 0.7);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(139, 92, 246, 0.15);
        }

        .form-select-lg, .form-control-lg {
            border-radius: 18px;
            font-size: 1.1rem;
            font-weight: 600;
            height: 60px;
            border: 2px solid var(--border-color);
            transition: all 0.3s ease;
        }

        /* Restaurant Cards Scale Up */
        .restaurant-card {
            transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
        }

        .card {
            border-radius: 32px;
            border: 1px solid rgba(139, 92, 246, 0.15);
            background: linear-gradient(145deg, #ffffff 0%, #f5f3ff 100%);
            box-shadow: 0 10px 40px rgba(139, 92, 246, 0.08);
            transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
            overflow: hidden;
        }

        .restaurant-card:hover {
            transform: translateY(-12px);
        }
        .restaurant-card:hover .card {
            box-shadow: 0 25px 60px rgba(139, 92, 246, 0.18);
        }

        body.dark-mode .card {
            background: rgba(30, 41, 59, 0.75);
            border: 1px solid rgba(139, 92, 246, 0.12);
        }

        .rating-badge {
            background: #10b981;
            color: white;
            padding: 6px 14px;
            border-radius: 14px;
            font-weight: 800;
            font-size: 1.05rem;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .offer-banner {
            background: var(--primary-light);
            color: var(--primary);
            padding: 12px 18px;
            border-radius: 16px;
            font-weight: 800;
            font-size: 0.95rem;
        }
        body.dark-mode .offer-banner {
            background: rgba(139, 92, 246, 0.2);
            color: #c4b5fd;
        }

        .city-title {
            margin: 4rem 0 2.5rem;
            font-weight: 800;
            font-size: 2.2rem;
            display: flex;
            align-items: center;
            gap: 16px;
            color: var(--text-primary);
            letter-spacing: -1.5px;
        }
        body.dark-mode .city-title { color: #f8fafc; }
        .city-title::after {
            content: ""; flex: 1; height: 3px;
            background: linear-gradient(90deg, var(--primary) 0%, transparent 100%);
            opacity: 0.3;
        }

        /* Veg Switch */
        .veg-switch { display: flex; align-items: center; cursor: pointer; user-select: none; }
        .veg-switch input { display: none; }
        .veg-slider { width: 48px; height: 24px; background: #cbd5e1; border-radius: 100px; position: relative; transition: 0.3s; margin-right: 12px; }
        .veg-slider::before { content: ""; position: absolute; width: 18px; height: 18px; background: white; border-radius: 50%; top: 3px; left: 3px; transition: 0.3s; }
        .veg-switch input:checked + .veg-slider { background: #10b981; }
        .veg-switch input:checked + .veg-slider::before { transform: translateX(24px); }
        .veg-label { font-weight: 700; font-size: 0.95rem; color: var(--text-secondary); }
        .veg-switch input:checked ~ .veg-label { color: #10b981; }

        .form-select-lg:focus, .form-control-lg:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(139, 92, 246, 0.1);
        }

        /* ═══ DARK MODE TEXT FIXES ═══ */
        body.dark-mode .text-dark { color: #f1f5f9 !important; }
        body.dark-mode .card-body h5,
        body.dark-mode .card-body h4,
        body.dark-mode .card-body h3 { color: #f1f5f9 !important; }
        body.dark-mode .card-body .text-secondary { color: #94a3b8 !important; }
        body.dark-mode .badge.bg-light { background: rgba(30, 41, 59, 0.6) !important; color: #cbd5e1 !important; }
        body.dark-mode .form-select-lg,
        body.dark-mode .form-control-lg,
        body.dark-mode .input-group-text.bg-light {
            background: rgba(15, 23, 42, 0.4) !important;
            border-color: rgba(139, 92, 246, 0.2) !important;
            color: #f1f5f9 !important;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
    <div class="container-fluid px-5">
        <a class="navbar-brand fw-900" href="HomeServlet" style="font-size: 2.2rem; letter-spacing: -2px;">
            <i class="bi bi-basket-fill text-warning me-2"></i>Urban <span style="color:rgba(255,255,255,0.9)">Eats</span>
        </a>
        <div class="ms-auto d-flex align-items-center gap-3">
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
    <!-- AI Suggestion Alert -->
    <c:if test="${not empty aiSuggestion}">
        <div class="alert border-0 shadow-sm rounded-4 d-flex align-items-center mb-5 p-4" style="background: rgba(139, 92, 246, 0.1); color: var(--primary);">
            <div class="me-4 fs-1 text-primary animate-pulse"><i class="bi bi-stars"></i></div>
            <div>
                <h6 class="fw-800 mb-1">Tailored for your taste</h6>
                <p class="mb-0 fw-500 opacity-90"><c:out value="${aiSuggestion}"/></p>
            </div>
        </div>
    </c:if>

    <!-- Global Filter Card -->
    <div class="card filter-card p-4 mb-5">
        <div class="row align-items-center g-4">
            <div class="col-lg-3">
                <form action="HomeServlet" method="get" id="cityFilterForm">
                    <label class="form-label text-muted small fw-800 text-uppercase mb-2">Location</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0 border-2 rounded-start-3"><i class="bi bi-geo-alt-fill text-primary"></i></span>
                        <select name="city" class="form-select form-select-lg bg-light border-start-0 border-2 shadow-none rounded-end-3" onchange="document.getElementById('cityFilterForm').submit()">
                            <option value="All" <c:if test="${selectedCity == 'All' || empty selectedCity}">selected</c:if>>All Cities</option>
                            <c:forEach var="c" items="${allCities}">
                                <option value="${c}" <c:if test="${c == selectedCity}">selected</c:if>>${c}</option>
                            </c:forEach>
                        </select>
                    </div>
                </form>
            </div>
            <div class="col-lg-6">
                <form action="SearchServlet" method="get">
                    <label class="form-label text-muted small fw-800 text-uppercase mb-2">Search</label>
                    <div class="input-group">
                        <input type="text" name="query" class="form-control form-control-lg bg-light border-2 shadow-none" placeholder="Search for sushi, burgers, or pizza..." value="<c:out value='${searchQuery}'/>" style="border-radius: 14px 0 0 14px;">
                        <button type="submit" class="btn btn-purple btn-lg px-4" style="border-radius: 0 14px 14px 0;">Find Food</button>
                    </div>
                </form>
            </div>
            <div class="col-lg-3">
                <div class="d-flex justify-content-lg-end">
                    <label class="veg-switch">
                        <input type="checkbox" id="vegToggle">
                        <span class="veg-slider"></span>
                        <span class="veg-label">Vegetarian Only</span>
                    </label>
                </div>
            </div>
        </div>
    </div>

    <!-- Restaurant Listings -->
    <div class="row g-4">
        <c:set var="lastCity" value="" />
        <c:forEach var="r" items="${restaurants}">
            <c:if test="${r.city != lastCity}">
                <div class="col-12 city-title restaurant-card-group-header" data-city="${r.city}">
                    <i class="bi bi-pin-map text-primary"></i> <c:out value="${r.city}"/>
                </div>
                <c:set var="lastCity" value="${r.city}" />
            </c:if>
            
            <div class="col-md-6 col-lg-4 restaurant-card" data-veg-only="${r.isVegOnly()}" data-city="${r.city}">
                <a href="RestaurantServlet?id=${r.restaurantId}" class="text-decoration-none">
                    <div class="card h-100 p-0">
                        <!-- Card Image / Header placeholder for premium feel -->
                        <div style="height: 120px; background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%); opacity: 0.05;"></div>
                        
                        <div class="card-body p-4" style="margin-top: -60px;">
                            <div class="d-flex justify-content-between align-items-end mb-3">
                                <div class="bg-white p-2 rounded-4 shadow-sm border" style="width: 80px; height: 80px; display: flex; align-items: center; justify-content: center;">
                                    <i class="bi bi-shop fs-1 text-primary opacity-50"></i>
                                </div>
                                <div class="rating-badge">
                                    <i class="bi bi-star-fill"></i> ${r.rating}
                                </div>
                            </div>

                            <h5 class="fw-800 text-dark mb-1">${r.name}</h5>
                            <p class="text-secondary small mb-3"><i class="bi bi-geo-alt me-1"></i>${r.city}</p>
                            
                            <div class="d-flex align-items-center gap-3 mb-3">
                                <span class="badge bg-light text-secondary rounded-pill px-3 py-2 fw-700">
                                    <i class="bi bi-clock me-1 text-primary"></i> ${r.deliveryTime}m
                                </span>
                                <c:if test="${r.vegOnly}">
                                    <span class="badge bg-success bg-opacity-10 text-success rounded-pill px-3 py-2 fw-700">
                                        <i class="bi bi-leaf me-1"></i> Pure Veg
                                    </span>
                                </c:if>
                            </div>

                            <c:if test="${not empty r.offers}">
                                <div class="offer-banner mb-4">
                                    <i class="bi bi-gift-fill me-2"></i> ${r.offers}
                                </div>
                            </c:if>
                            
                            <button class="btn btn-outline-primary w-100 rounded-pill fw-700 py-2 border-2">
                                View Menu
                            </button>
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>
        
        <c:if test="${empty restaurants}">
            <div class="col-12 text-center py-5">
                <i class="bi bi-search fs-1 text-muted opacity-25 mb-3 d-block"></i>
                <h4 class="fw-800">No restaurants found</h4>
                <p class="text-secondary">Try adjusting your filters or location</p>
            </div>
        </c:if>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const body = document.body;
    const toggleBtn = document.getElementById('darkToggleDropdown');

    if (localStorage.getItem('darkMode') === 'on') {
        document.body.classList.add('dark-mode');
        toggleBtn.innerHTML = '<i class="bi bi-sun-fill me-2 text-warning"></i>Light Theme';
    } else {
        toggleBtn.innerHTML = '<i class="bi bi-moon-stars-fill me-2 text-warning"></i>Dark Theme';
    }

    toggleBtn.addEventListener('click', (e) => {
        e.preventDefault();
        e.stopPropagation();
        document.body.classList.toggle('dark-mode');
        const isDark = document.body.classList.contains('dark-mode');
        localStorage.setItem('darkMode', isDark ? 'on' : 'off');
        toggleBtn.innerHTML = isDark ? '<i class="bi bi-sun-fill me-2 text-warning"></i>Light Theme' : '<i class="bi bi-moon-stars-fill me-2 text-warning"></i>Dark Theme';
    });

    document.addEventListener("DOMContentLoaded", function() {
        // Veg Filtering Logic
        const vegToggle = document.getElementById('vegToggle');
        const restaurantCards = document.querySelectorAll('.restaurant-card');

        function filterVeg() {
            const isVegOnly = vegToggle.checked;
            const citiesWithVisibleRestaurants = new Set();

            restaurantCards.forEach(card => {
                const isCardVeg = card.getAttribute('data-veg-only') === 'true';
                const city = card.getAttribute('data-city');
                
                if (isVegOnly && !isCardVeg) {
                    card.style.display = 'none';
                } else {
                    card.style.display = 'block';
                    citiesWithVisibleRestaurants.add(city);
                }
            });

            document.querySelectorAll('.restaurant-card-group-header').forEach(header => {
                const headerCity = header.getAttribute('data-city');
                header.style.display = citiesWithVisibleRestaurants.has(headerCity) ? 'flex' : 'none';
            });
        }

        vegToggle.addEventListener('change', filterVeg);
    });
</script>
</body>
</html>
