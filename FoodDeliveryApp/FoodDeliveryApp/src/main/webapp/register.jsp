<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Urban Eats v2.1 - Premium Register --%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Urban Eats</title>
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
            font-family: 'Inter', sans-serif;
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

    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center align-items-center min-vh-100 py-5">
            <div class="col-12 col-sm-10 col-md-8 col-lg-6 col-xl-5">
                
                <div class="text-center mb-4">
                    <div class="logo-icon"><i class="bi bi-basket-fill"></i></div>
                    <h1 class="fw-800 mb-1" style="font-size: 2.2rem; letter-spacing: -1px;">Urban <span style="color:var(--primary);">Eats</span></h1>
                    <p class="text-secondary fw-600 mb-0">Join the Premium Food Community</p>
                </div>

                <% 
                    String err = request.getParameter("error"); 
                    String msg = request.getParameter("msg");
                    if (msg != null) { 
                %>
                    <div class="alert alert-info border-0 d-flex align-items-center mb-4" style="background: #f0f9ff; color: #0369a1;">
                        <i class="bi bi-info-circle-fill me-3 fs-4"></i>
                        <div><strong>Welcome!</strong> <%= msg %></div>
                    </div>
                <% } %>
                <% if (err != null) { %>
                    <div class="alert alert-danger border-0 d-flex align-items-center mb-4" style="background: #fef2f2; color: #b91c1c;">
                        <i class="bi bi-exclamation-triangle-fill me-3 fs-4"></i>
                        <div><%= err %></div>
                    </div>
                <% } %>

                <div class="card p-4 p-md-5">
                    <h2 class="fw-800 mb-2" style="font-size: 1.8rem;">Create Account</h2>
                    <p class="text-secondary fw-500 mb-4">Start your culinary journey with us today.</p>

                    <form action="RegisterServlet" method="post" id="regForm">
                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <label class="form-label">Full Name</label>
                                <input type="text" id="regName" name="name" class="form-control" required autocomplete="off" value="">
                            </div>
                            <div class="col-md-12 mb-3">
                                <label class="form-label">Email Address</label>
                                <input type="email" id="regEmail" name="email" class="form-control" required autocomplete="off" value="">
                            </div>
                            <div class="col-md-12 mb-3">
                                <label class="form-label">Create Password</label>
                                <input type="password" id="regPassword" name="password" class="form-control" required autocomplete="new-password" value="">
                            </div>
                            <div class="col-md-12 mb-4">
                                <label class="form-label">Phone Number</label>
                                <input type="text" id="regPhone" name="phone" class="form-control" required maxlength="10" inputmode="numeric" autocomplete="off" value="${not empty param.phone ? param.phone : ''}">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-purple btn-lg w-100 py-3 rounded-pill shadow-sm mb-4">
                            Complete registration <i class="bi bi-person-plus-fill ms-2"></i>
                        </button>
                    </form>

                    <div class="text-center">
                        <p class="text-secondary fw-500 mb-0">Already a member? 
                            <a href="login.jsp" class="link-custom ms-1">Login here</a>
                        </p>
                    </div>
                </div>

                <p class="text-center text-secondary small mt-4 px-3">
                    By joining, you agree to our <a href="#" class="link-custom">Terms of Service</a> & <a href="#" class="link-custom">Privacy Policy</a>
                </p>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const body = document.body;

        if (localStorage.getItem('darkMode') === 'on') {
            body.classList.add('dark-mode');
        }

        // Combined Validation Logic
        const regPhone = document.getElementById('regPhone');
        const regName = document.getElementById('regName');

        regPhone.addEventListener('input', function() {
            this.value = this.value.replace(/\D/g, '').slice(0, 10);
        });

        regName.addEventListener('input', function() {
            this.value = this.value.replace(/[^A-Za-z\s]/g, '');
        });

        document.getElementById('regForm').addEventListener('submit', function(e) {
            const phone = regPhone.value.trim();
            const name = regName.value.trim();
            const email = document.getElementById('regEmail').value.trim();
            const password = document.getElementById('regPassword').value;
            
            const phoneRegex = /^[0-9]{10}$/;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            
            if (!phoneRegex.test(phone)) {
                e.preventDefault();
                alert('Please enter a valid 10-digit mobile number.');
                return;
            }
            if (name.length < 2) {
                e.preventDefault();
                alert('Please enter your full name.');
                return;
            }
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('Please enter a valid email address.');
                return;
            }
            if (password.length < 6) {
                e.preventDefault();
                alert('Password must be at least 6 characters long.');
                return;
            }
        });
    </script>
</body>
</html>
