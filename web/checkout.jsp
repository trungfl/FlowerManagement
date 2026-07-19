<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout - Flower Shop</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts & Bootstrap Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f9fafb !important;
        }
        
        .checkout-card {
            border-radius: 1rem;
            border: none;
            background-color: #ffffff;
        }
        
        .order-summary-card {
            border-radius: 1rem;
            border: none;
            background-color: #ffffff;
            position: sticky;
            top: 20px;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #198754;
            box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.25);
        }
        
        .input-group-text {
            background-color: #ffffff;
            color: #6c757d;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Top Horizontal Header Navbar -->
    <jsp:include page="includes/header.jsp"/>
    
    <div class="container mt-5 mb-5">
        <h2 class="h4 fw-bold text-dark mb-4">Secure Checkout</h2>
        
        <!-- Server Error Alert Messaging Block -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger border-0 shadow-sm rounded-3 py-2 text-center small mb-4">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
            </div>
        </c:if>
        
        <c:set var="totalAmount" value="0"/>
        <c:forEach items="${sessionScope.cart}" var="mapItem">
            <c:set var="item" value="${mapItem.value}"/>
            <c:set var="itemTotal" value="${item.flower.price * item.quantity}"/>
            <c:set var="totalAmount" value="${totalAmount + itemTotal}"/>
        </c:forEach>
        
        <div class="row g-4">
            <!-- Left Side Column: Delivery Details Input Form -->
            <div class="col-12 col-lg-7">
                <form action="${pageContext.request.contextPath}/checkout" method="POST" class="card shadow-sm p-4 checkout-card">
                    <h3 class="h5 fw-bold text-dark mb-4 border-bottom pb-2">Shipping Information</h3>
                    
                    <div class="mb-3">
                        <label class="form-label fw-medium text-dark small">Full Name (No special characters/emojis)</label>
                        <div class="input-group">
                            <span class="input-group-text border-end-0"><i class="bi bi-person"></i></span>
                            <input type="text" name="fullName" class="form-control border-start-0 ps-0" placeholder="e.g. Nguyen Van A" required>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-medium text-dark small">Phone Number</label>
                        <div class="input-group">
                            <span class="input-group-text border-end-0"><i class="bi bi-telephone"></i></span>
                            <input type="text" name="phone" class="form-control border-start-0 ps-0" placeholder="e.g. 0912345678" required>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-medium text-dark small">Delivery Address</label>
                        <div class="input-group">
                            <span class="input-group-text border-end-0 align-items-start pt-2"><i class="bi bi-geo-alt"></i></span>
                            <textarea name="address" class="form-control border-start-0 ps-0" rows="3" placeholder="Enter your full street address, district, and city..." required></textarea>
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label fw-medium text-dark small">Payment Method</label>
                        <div class="input-group">
                            <span class="input-group-text border-end-0"><i class="bi bi-credit-card"></i></span>
                            <select name="paymentMethod" class="form-select border-start-0 ps-0">
                                <option value="Cash">Cash on Delivery</option>
                                <option value="Card">Credit/Debit Card</option>
                            </select>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-success btn-lg w-100 py-3 rounded-3 fw-bold shadow-sm">
                        <i class="bi bi-lock-fill me-1"></i> Place Order
                    </button>
                </form>
            </div>
            
            <!-- Right Side Column: Dynamic Order Items Review Column Stack -->
            <div class="col-12 col-lg-5">
                <div class="card shadow-sm p-4 order-summary-card">
                    <h3 class="h5 fw-bold text-dark border-bottom pb-3 mb-3">Review Items</h3>
                    
                    <!-- Small Mini-cart itemized scroll list -->
                    <div class="mb-4 style-scroll" style="max-height: 240px; overflow-y: auto;">
                        <c:forEach items="${sessionScope.cart}" var="mapItem">
                            <c:set var="item" value="${mapItem.value}"/>
                            <div class="d-flex align-items-center justify-content-between border-bottom py-2 pe-2">
                                <div class="d-flex align-items-center gap-2">
                                    <img src="${pageContext.request.contextPath}/assets/${item.flower.imageURL}" class="rounded-2 border" style="width: 45px; height: 45px; object-fit: cover;">
                                    <div>
                                        <h5 class="small fw-bold text-dark mb-0 text-truncate" style="max-width: 180px;">${item.flower.name}</h5>
                                        <span class="text-muted small">Qty: ${item.quantity}</span>
                                    </div>
                                </div>
                                <span class="small fw-bold text-secondary">
                                    <fmt:formatNumber value="${item.flower.price * item.quantity}" type="number" pattern="#,###"/> VND
                                </span>
                            </div>
                        </c:forEach>
                        
                        <c:if test="${empty sessionScope.cart}">
                            <p class="text-muted text-center small py-3">No products chosen.</p>
                        </c:if>
                    </div>
                    
                    <!-- Grand Summary Totals -->
                    <div class="d-flex justify-content-between mb-2 small">
                        <span class="text-muted">Subtotal</span>
                        <span class="fw-semibold text-dark">
                            <fmt:formatNumber value="${totalAmount}" type="number" pattern="#,###"/> VND
                        </span>
                    </div>
                    <div class="d-flex justify-content-between mb-3 small">
                        <span class="text-muted">Shipping Fees</span>
                        <span class="text-success fw-medium">FREE</span>
                    </div>
                    
                    <div class="d-flex justify-content-between align-items-center border-top pt-3">
                        <span class="fw-bold text-dark">Total Amount Due:</span>
                        <span class="text-success fw-bold fs-5">
                            <fmt:formatNumber value="${totalAmount}" type="number" pattern="#,###"/> VND
                        </span>
                    </div>
                </div>
            </div>
        </div>
        
    </div>
</body>
</html>