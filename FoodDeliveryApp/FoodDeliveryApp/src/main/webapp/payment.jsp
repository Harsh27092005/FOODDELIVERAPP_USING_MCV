<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Payment - Urban Eats</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #8b5cf6; --primary-dark: #7c3aed; --primary-light: #ede9fe; }
        body { font-family: 'Inter', sans-serif; background: #f5f3ff; }
        body.dark-mode { background: #1a1625 !important; color: #e9d5ff !important; }
        body.dark-mode .card { background: #2d2048 !important; color: #e9d5ff; border: none; }
        body.dark-mode .navbar { background: #13011f !important; }
        body.dark-mode .text-muted { color: #c4b5fd !important; }
        body.dark-mode .text-dark { color: #e9d5ff !important; }
        body.dark-mode .text-purple { color: #c4b5fd !important; }
        body.dark-mode h4 { color: #e9d5ff !important; }
        body.dark-mode #cardDetails { background: #3b2d5e !important; border-color: #5b3f8c !important; }
        body.dark-mode .form-control { background: #1a1625 !important; color: #e9d5ff !important; }
        .bg-purple { background: var(--primary) !important; }
        .btn-purple { background: var(--primary); color: white; border: none; }
        .btn-purple:hover { background: var(--primary-dark); color: white; }
        .text-purple { color: var(--primary) !important; }
        .dark-toggle { background: none; border: none; color: white; font-size: 1.3rem; cursor: pointer; }
        .payment-option:hover { background-color: var(--primary-light); cursor: pointer; }
        .form-check-input:checked + .form-check-label { color: var(--primary); }
        .wallet-icon { background: var(--primary-light); display: inline-block; border-radius: 50%; padding: 1.2rem; }
    </style>
</head>
<body class="pb-5">
<nav class="navbar navbar-expand-lg navbar-dark bg-purple shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="HomeServlet"><i class="bi bi-basket-fill text-warning"></i> Urban Eats</a>
        <div class="d-flex align-items-center gap-2">
            <button class="dark-toggle" id="darkToggle" title="Toggle dark mode"><i class="bi bi-moon-stars-fill"></i></button>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-5">
            <div class="card border-0 shadow-sm rounded-4 mt-3">
                <div class="card-body p-4 p-md-5">
                    <div class="text-center mb-5">
                        <div class="wallet-icon mb-3">
                            <i class="bi bi-wallet2 text-purple" style="font-size: 3rem;"></i>
                        </div>
                        <h4 class="fw-bold mt-2">Payment Options</h4>
                        <p class="text-muted mb-0">Total Amount: <strong class="fs-4 text-purple">₹${totalAmount}</strong></p>
                    </div>
                    <form action="PaymentServlet" method="post">
                        <input type="hidden" name="totalAmount" value="${totalAmount}">
                        <input type="hidden" name="restaurantId" value="${restaurantId}">
                        <div class="form-check border rounded-4 p-3 mb-3 d-flex align-items-center payment-option">
                            <input class="form-check-input ms-2 me-3 fs-5" type="radio" name="paymentMethod" id="upi" value="UPI" checked onclick="toggleCard(false)">
                            <label class="form-check-label flex-grow-1 fw-bold fs-5" for="upi">
                                <i class="bi bi-phone me-2 text-primary fs-4"></i> UPI Pay
                            </label>
                        </div>
                        <div class="form-check border rounded-4 p-3 mb-3 d-flex align-items-center payment-option">
                            <input class="form-check-input ms-2 me-3 fs-5" type="radio" name="paymentMethod" id="card" value="CARD" onclick="toggleCard(true)">
                            <label class="form-check-label flex-grow-1 fw-bold fs-5" for="card">
                                <i class="bi bi-credit-card me-2 text-dark fs-4"></i> Credit/Debit Card
                            </label>
                        </div>
                        
                        <!-- Card Details Form (Hidden) -->
                        <div id="cardDetails" class="mb-4 p-3 border rounded-4 bg-light" style="display:none;">
                            <div class="mb-3">
                                <label class="small fw-bold text-muted">Card Number</label>
                                <input type="text" name="cardNumber" id="cardNumber" class="form-control border-0" placeholder="0000 0000 0000 0000" maxlength="16">
                            </div>
                            <div class="row">
                                <div class="col-6 mb-3">
                                    <label class="small fw-bold text-muted">Expiry (MM/YY)</label>
                                    <input type="text" name="expiry" id="expiry" class="form-control border-0" placeholder="MM/YY" maxlength="5">
                                </div>
                                <div class="col-6 mb-3">
                                    <label class="small fw-bold text-muted">CVV</label>
                                    <input type="password" name="cvv" id="cvv" class="form-control border-0" placeholder="***" maxlength="3">
                                </div>
                            </div>
                        </div>

                        <div class="form-check border rounded-4 p-3 mb-5 d-flex align-items-center payment-option">
                            <input class="form-check-input ms-2 me-3 fs-5" type="radio" name="paymentMethod" id="cod" value="COD" onclick="toggleCard(false)">
                            <label class="form-check-label flex-grow-1 fw-bold fs-5" for="cod">
                                <i class="bi bi-cash-coin me-2 text-success fs-4"></i> Cash on Delivery
                            </label>
                        </div>
                        <button type="submit" class="btn btn-purple btn-lg w-100 fw-bold rounded-pill shadow-sm py-3">Pay ₹${totalAmount} &amp; Place Order</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function toggleCard(show) {
        const details = document.getElementById('cardDetails');
        details.style.display = show ? 'block' : 'none';
        // Toggle required attributes
        document.getElementById('cardNumber').required = show;
        document.getElementById('expiry').required = show;
        document.getElementById('cvv').required = show;
    }

    document.querySelector('form').addEventListener('submit', function(e) {
        const method = document.querySelector('input[name="paymentMethod"]:checked').value;
        if (method === 'CARD') {
            const card = document.getElementById('cardNumber').value.replace(/\s/g, '');
            const expiry = document.getElementById('expiry').value;
            const cvv = document.getElementById('cvv').value;
            
            if (card.length !== 16 || isNaN(card)) {
                e.preventDefault();
                alert('Please enter a valid 16-digit card number.');
                return;
            }
            if (!/^\d{2}\/\d{2}$/.test(expiry)) {
                e.preventDefault();
                alert('Please enter expiry in MM/YY format.');
                return;
            }
            if (cvv.length !== 3 || isNaN(cvv)) {
                e.preventDefault();
                alert('Please enter a valid 3-digit CVV.');
                return;
            }
        }
    });

    document.addEventListener('DOMContentLoaded', function() {
        // Numeric only for Card and CVV
        const cardInput = document.getElementById('cardNumber');
        const cvvInput = document.getElementById('cvv');
        const expiryInput = document.getElementById('expiry');

        [cardInput, cvvInput].forEach(el => {
            el.addEventListener('keypress', function(e) {
                if (!/[0-9]/.test(e.key) && e.key !== 'Backspace') e.preventDefault();
            });
        });

        expiryInput.addEventListener('keypress', function(e) {
            if (!/[0-9/]/.test(e.key) && e.key !== 'Backspace') e.preventDefault();
        });
        
        // Auto-slash for expiry
        expiryInput.addEventListener('input', function(e) {
            let val = this.value.replace(/\D/g, '');
            if (val.length > 2) {
                this.value = val.substring(0, 2) + '/' + val.substring(2, 4);
            }
        });
    });

    const body = document.body;
    const toggleBtn = document.getElementById('darkToggle');
    if (localStorage.getItem('darkMode') === 'on') {
        body.classList.add('dark-mode');
        toggleBtn.innerHTML = '<i class="bi bi-sun-fill"></i>';
    }
    toggleBtn.addEventListener('click', () => {
        body.classList.toggle('dark-mode');
        const isDark = body.classList.contains('dark-mode');
        localStorage.setItem('darkMode', isDark ? 'on' : 'off');
        toggleBtn.innerHTML = isDark ? '<i class="bi bi-sun-fill"></i>' : '<i class="bi bi-moon-stars-fill"></i>';
    });
</script>
</body>
</html>
