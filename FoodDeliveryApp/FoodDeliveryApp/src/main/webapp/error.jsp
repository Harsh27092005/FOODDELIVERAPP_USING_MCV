<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Oops! - Urban Eats</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #8b5cf6;
            --primary-dark: #7c3aed;
            --primary-light: #ede9fe;
            --surface: #ffffff;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #ede9fe 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-primary);
        }

        .error-card {
            background: var(--surface);
            border-radius: 32px;
            padding: 4rem 3rem;
            max-width: 550px;
            width: 90%;
            text-align: center;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.08);
            border: none;
        }

        .icon-circle {
            width: 100px; height: 100px;
            background: rgba(239, 68, 68, 0.1);
            color: #ef4444;
            border-radius: 30px;
            display: flex; align-items: center; justify-content: center;
            font-size: 3.5rem;
            margin: 0 auto 2.5rem;
        }

        h1 { font-weight: 800; font-size: 2.25rem; letter-spacing: -1.5px; margin-bottom: 1.5rem; }
        p { font-size: 1.1rem; color: var(--text-secondary); line-height: 1.6; margin-bottom: 2.5rem; }

        .btn-purple {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white; border: none; font-weight: 700;
            padding: 14px 40px; border-radius: 18px;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            box-shadow: 0 10px 25px rgba(139, 92, 246, 0.3);
        }
        .btn-purple:hover {
            transform: translateY(-4px);
            box-shadow: 0 15px 35px rgba(139, 92, 246, 0.4);
            color: white;
        }
    </style>
</head>
<body>

    <div class="error-card">
        <div class="icon-circle">
            <i class="bi bi-exclamation-octagon-fill"></i>
        </div>
        
        <h1>Something went wrong</h1>
        
        <p>
            <% 
                String type = request.getParameter("type");
                Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
                String errorMessage = (String) request.getAttribute("javax.servlet.error.message");

                if (statusCode != null) {
                    if (statusCode == 404) {
                        out.print("The page you're looking for doesn't exist. Let's get you back on track.");
                    } else if (statusCode == 500) {
                        out.print("Our servers are having a bit of a moment. Please try again in a few minutes.");
                    } else {
                        out.print("An unexpected system error occurred (Code: " + statusCode + ").");
                    }
                } else if (type != null) {
                    if ("invalid_phone".equals(type)) out.print("The phone number you entered is invalid. Please use exactly 10 digits.");
                    else if ("invalid_email".equals(type)) out.print("That email format doesn't look right. Please check and try again.");
                    else if ("invalid_name".equals(type)) out.print("Your name should only contain letters and be between 2 to 50 characters.");
                    else if ("weak_password".equals(type)) out.print("Security first! Your password must be at least 6 characters long.");
                    else out.print("We couldn't process that request. Please verify your details.");
                } else {
                    out.print("An unknown error occurred. Let's return to safety.");
                }
            %>
        </p>

        <div class="d-grid gap-3">
            <a href="HomeServlet" class="btn btn-purple">
                Return to Dashboard
            </a>
            <a href="login.jsp" class="btn btn-link text-decoration-none text-muted fw-700">Back to Login</a>
        </div>
    </div>

</body>
</html>
