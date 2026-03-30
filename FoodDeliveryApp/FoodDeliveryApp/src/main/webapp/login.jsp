<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.fooddelivery.entity.*, com.fooddelivery.dao.*, javax.servlet.http.*" %>
<%-- Urban Eats v2.1 - Force Recompile --%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Urban Eats</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
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
            --danger: #ef4444;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #ede9fe 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            color: var(--text-primary);
            transition: all 0.3s ease;
            font-size: 1.05rem;
        }

        body.dark-mode {
            background: linear-gradient(135deg, #1a1625 0%, #2d1b65 100%);
            color: #e9d5ff;
        }

        body.dark-mode .card {
            background: rgba(45, 32, 72, 0.82);
            border: 1px solid rgba(139, 92, 246, 0.2);
            backdrop-filter: blur(15px);
        }

        body.dark-mode .form-control {
            background: rgba(59, 45, 94, 0.5);
            color: #e9d5ff;
            border: 1px solid rgba(139, 92, 246, 0.3);
        }

        .btn-purple {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white; border: none; font-weight: 800;
            padding: 16px 32px; border-radius: 20px;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            font-size: 1.15rem;
            box-shadow: 0 8px 25px rgba(139, 92, 246, 0.35);
        }

        .btn-purple:hover {
            transform: translateY(-4px);
            box-shadow: 0 15px 40px rgba(139, 92, 246, 0.5);
            color: white;
        }

        .dark-toggle-fixed {
            position: fixed; top: 2.5rem; right: 2.5rem;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white; border: none; border-radius: 22px; width: 60px; height: 60px;
            font-size: 1.5rem; cursor: pointer; z-index: 999;
            box-shadow: 0 10px 30px rgba(139,92,246,0.4);
            display: flex; align-items: center; justify-content: center;
            transition: all 0.3s ease;
        }
        .dark-toggle-fixed:hover { transform: translateY(-4px) rotate(15deg); }

        .form-control {
            border-radius: 16px;
            border: 2px solid var(--border-color);
            padding: 16px 22px;
            font-size: 1.1rem;
            background: var(--surface-light);
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .form-label {
            font-weight: 800;
            color: var(--text-secondary);
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 1.5px;
            margin-bottom: 12px;
            display: block;
        }

        .card {
            border-radius: 40px;
            border: none;
            background: var(--surface);
            box-shadow: 0 30px 80px rgba(0, 0, 0, 0.1);
        }

        .logo-icon {
            font-size: 5rem;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 1rem;
            display: inline-block;
        }

        .step-indicator {
            display: flex;
            justify-content: space-between;
            gap: 0.75rem;
            margin-bottom: 2rem;
        }

        .step {
            flex: 1;
            height: 6px;
            background: #e2e8f0;
            border-radius: 10px;
            transition: background 0.4s ease;
        }

        .step.active {
            background: linear-gradient(90deg, var(--primary) 0%, var(--primary-dark) 100%);
        }

        .link-custom {
            color: var(--primary);
            text-decoration: none;
            font-weight: 700;
            transition: all 0.2s ease;
        }

        .link-custom:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }

        .error-message {
            color: var(--danger);
            font-size: 0.8rem;
            font-weight: 700;
            margin-top: 8px;
            display: flex;
            align-items: center;
        }
        .error-message::before {
            content: "\F33A";
            font-family: "bootstrap-icons";
            margin-right: 6px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center align-items-center min-vh-100 py-5">
            <div class="col-12 col-sm-10 col-md-8 col-lg-5 col-xl-4">
                
                <!-- Brand Section -->
                <div class="text-center mb-5">
                    <div class="logo-icon"><i class="bi bi-basket-fill"></i></div>
                    <h1 class="fw-800 mb-1" style="font-size: 2.5rem; letter-spacing: -1.5px;">Urban <span class="text-purple">Eats</span></h1>
                    <p class="text-secondary fw-600 mb-0">Premium Food Delivery</p>
                </div>

                <!-- Session Messages -->
                <% 
                    String msg = request.getParameter("msg"); 
                    String err = request.getParameter("error");
                    if (msg != null) { 
                %>
                    <div class="alert alert-success border-0 d-flex align-items-center mb-4" style="background: #f0fdf4; color: #15803d;">
                        <i class="bi bi-check-circle-fill me-3 fs-4"></i>
                        <div><%= msg %></div>
                    </div>
                <% } %>
                <% if (err != null) { %>
                    <div class="alert alert-danger border-0 d-flex align-items-center mb-4" style="background: #fef2f2; color: #b91c1c;">
                        <i class="bi bi-exclamation-triangle-fill me-3 fs-4"></i>
                        <div><%= err %></div>
                    </div>
                <% } %>

                <!-- Authentication Card -->
                <div class="card p-4 p-md-5 mb-4">
                    <!-- Step 1: Phone Verification -->
                    <div id="step-phone">
                        <h2 class="fw-800 mb-2" style="font-size: 1.8rem;">Welcome back</h2>
                        <p class="text-secondary fw-500 mb-4">Enter your mobile number to continue</p>

                        <div class="step-indicator">
                            <div class="step active"></div>
                            <div class="step"></div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Phone Number</label>
                            <div class="position-relative">
                                <input type="text" id="phoneInput" class="form-control form-control-lg" 
                                       maxlength="10" inputmode="numeric" autocomplete="off" value="">
                            </div>
                            <div id="phoneError" class="error-message" style="display:none;"></div>
                        </div>

                        <button onclick="checkPhone()" class="btn btn-purple btn-lg w-100 mb-4 py-3 rounded-pill shadow-sm">
                            Continue <i class="bi bi-arrow-right ms-2"></i>
                        </button>

                        <div class="text-center">
                            <p class="text-secondary fw-500 mb-0">New to Urban Eats? 
                                <a href="register.jsp" class="link-custom ms-1">Create account</a>
                            </p>
                        </div>
                    </div>

                    <!-- Step 2: Password Entry -->
                    <div id="step-password" style="display:none;">
                        <button type="button" onclick="resetPhone()" class="btn btn-link text-decoration-none p-0 mb-3 fw-700" style="color:var(--primary);">
                            <i class="bi bi-chevron-left me-1"></i> Back
                        </button>

                        <h2 class="fw-800 mb-2" style="font-size: 1.8rem;">Security</h2>
                        <p class="text-secondary fw-500 mb-4">Verification required for access</p>

                        <div class="step-indicator">
                            <div class="step active"></div>
                            <div class="step active"></div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Active Account</label>
                            <div class="d-flex align-items-center justify-content-between bg-light p-3 rounded-4 border">
                                <span class="fw-700 text-primary" id="phoneDisplay"></span>
                                <a href="#" onclick="resetPhone(event)" class="link-custom small">Change</a>
                            </div>
                        </div>

                        <form action="LoginServlet" method="post" id="loginForm">
                            <input type="hidden" name="phone" id="hiddenPhone">
                            <div class="mb-4">
                                <label class="form-label">Enter Password</label>
                                <input type="password" name="password" id="passwordInput" class="form-control form-control-lg" required>
                            </div>
                            <button type="submit" class="btn btn-purple btn-lg w-100 py-3 rounded-pill shadow-sm">
                                Login Access <i class="bi bi-shield-lock ms-2"></i>
                            </button>
                        </form>
                    </div>
                </div>

                <p class="text-center text-secondary small px-3">
                    Secure login powered by Urban Eats Encryption. <br>
                    <a href="#" class="link-custom mx-1">Terms</a> · <a href="#" class="link-custom mx-1">Privacy Policy</a>
                </p>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const body = document.body;

        // Theme Persistence
        if (localStorage.getItem('darkMode') === 'on') {
            body.classList.add('dark-mode');
        }

        // Phone Input Formatting
        const phoneInput = document.getElementById('phoneInput');
        phoneInput.addEventListener('input', function() {
            this.value = this.value.replace(/\D/g, '').slice(0, 10);
            document.getElementById('phoneError').style.display = 'none';
        });

        phoneInput.addEventListener('keypress', (e) => { if (e.key === 'Enter') checkPhone(); });

        // AJAX Flow
        function checkPhone() {
            const phone = phoneInput.value.trim();
            const errEl = document.getElementById('phoneError');
            const phoneRegex = /^[0-9]{10}$/;
            
            if (!phoneRegex.test(phone)) {
                errEl.style.display = 'flex';
                errEl.textContent = phone ? 'Mobile number must be 10 digits.' : 'Phone number is required.';
                return;
            }

            // AJAX call to verify user state
            fetch('LoginServlet', {
                method: 'POST',
                headers: { 
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'X-Requested-With': 'XMLHttpRequest' 
                },
                body: 'phone=' + encodeURIComponent(phone) + '&checkOnly=true'
            })
            .then(res => res.text())
            .then(data => {
                if (data === 'exists') {
                    // Switch to password step
                    document.getElementById('step-phone').style.display = 'none';
                    document.getElementById('step-password').style.display = 'block';
                    document.getElementById('phoneDisplay').textContent = phone;
                    document.getElementById('hiddenPhone').value = phone;
                    document.getElementById('passwordInput').focus();
                } else if (data === 'notfound') {
                    // Redirect for registration
                    window.location.href = 'register.jsp?phone=' + encodeURIComponent(phone) + '&msg=Urban+Eats+welcomes+you!+Please+complete+registration.';
                } else {
                    errEl.style.display = 'flex';
                    errEl.textContent = 'Service unavailable. Try again later.';
                }
            })
            .catch(err => {
                console.error('Auth Error:', err);
                errEl.style.display = 'flex';
                errEl.textContent = 'Connection failed. Check your network.';
            });
        }

        function resetPhone(e) {
            if (e) e.preventDefault();
            document.getElementById('step-password').style.display = 'none';
            document.getElementById('step-phone').style.display = 'block';
            phoneInput.focus();
        }
    </script>
</body>
</html>
