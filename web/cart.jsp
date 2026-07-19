<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>My Cart - Flower Shop</title>
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
        
        .cart-card {
            border-radius: 1rem;
            border: none;
            background-color: #ffffff;
        }
        
        .summary-card {
            border-radius: 1rem;
            border: none;
            background-color: #ffffff;
            position: sticky;
            top: 20px;
        }
        
        .cart-item {
            border-bottom: 1px solid #eef2f5;
            padding: 1.5rem 0;
            transition: background-color 0.2s ease;
        }
        
        .cart-item:last-child {
            border-bottom: none;
        }
        
        .product-img {
            border-radius: 0.75rem;
            object-fit: cover;
            width: 90px;
            height: 90px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .btn-remove {
            color: #dc3545;
            background: none;
            border: none;
            padding: 0;
            font-size: 0.9rem;
            font-weight: 500;
            text-decoration: none;
            transition: color 0.2s ease;
        }
        
        .btn-remove:hover {
            color: #a71d2a;
            text-decoration: underline;
        }

        .cart-count-badge {
            background-color: #e8f5e9;
            color: #198754;
            font-size: 1rem;
            padding: 0.35rem 0.75rem;
            border-radius: 50rem;
            font-weight: 600;
            border: 1px solid rgba(25, 135, 84, 0.15);
        }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="includes/header.jsp"/>
    
    <div class="container mt-5 mb-5">
        <div class="d-flex align-items-center gap-3 mb-4">
            <h2 class="h4 fw-bold text-dark m-0">🛒 Your Shopping Cart</h2>
            <c:if var="hasItems" test="${not empty sessionScope.cart}">
                <span class="cart-count-badge">${sessionScope.cart.size()} items</span>
            </c:if>
        </div>
        
        <c:set var="totalAmount" value="0"/>
        
        <c:choose>
            <c:when test="${hasItems}">
                <div class="row g-4">
                    <div class="col-12 col-lg-8">
                        <div class="card shadow-sm p-4 cart-card">
                            <div class="d-none d-md-flex row border-bottom pb-2 mb-2 text-muted small fw-bold">
                                <div class="col-md-6">PRODUCT DETAILS</div>
                                <div class="col-md-2 text-center">PRICE</div>
                                <div class="col-md-2 text-center">QUANTITY</div>
                                <div class="col-md-2 text-end">TOTAL</div>
                            </div>
                            
                            <c:forEach items="${sessionScope.cart}" var="mapItem">
                                <c:set var="item" value="${mapItem.value}"/>
                                <c:set var="itemTotal" value="${item.flower.price * item.quantity}"/>
                                <c:set var="totalAmount" value="${totalAmount + itemTotal}"/>
                                
                                <div class="row align-items-center cart-item g-3">
                                    <div class="col-12 col-md-6 d-flex align-items-center gap-3">
                                        <!-- If you don't use dynamic asset images, you can fall back to a placeholder or ${item.flower.imageURL} -->
                                        <img src="${pageContext.request.contextPath}/assets/${item.flower.imageURL}" class="product-img" onerror="this.src='https://images.unsplash.com/photo-1526047932273-341f2a7631f9?w=400';">
                                        <div>
                                            <h4 class="h6 fw-bold text-dark mb-1">${item.flower.name}</h4>
                                            <a href="${pageContext.request.contextPath}/cart?action=remove&id=${item.flower.flowerId}" class="btn-remove d-inline-flex align-items-center gap-1">
                                                <i class="bi bi-trash3"></i> Remove
                                            </a>
                                        </div>
                                    </div>
                                    
                                    <div class="col-4 col-md-2 text-md-center">
                                        <span class="d-md-none text-muted small d-block">Price:</span>
                                        <span class="fw-medium text-dark">
                                            <fmt:formatNumber value="${item.flower.price}" type="number" pattern="#,###"/> VND
                                        </span>
                                    </div>
                                    
                                    <div class="col-4 col-md-2 text-md-center">
                                        <span class="d-md-none text-muted small d-block">Qty:</span>
                                        <span class="badge bg-light border text-dark px-3 py-2 fs-6 fw-normal">${item.quantity}</span>
                                    </div>
                                    
                                    <div class="col-4 col-md-2 text-end">
                                        <span class="d-md-none text-muted small d-block">Total:</span>
                                        <span class="text-success fw-bold fs-5">
                                            <fmt:formatNumber value="${itemTotal}" type="number" pattern="#,###"/> VND
                                        </span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <div class="mt-4">
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary rounded-pill px-4 fw-medium shadow-sm">
                                <i class="bi bi-arrow-left me-1"></i> Continue Shopping
                            </a>
                        </div>
                    </div>
                    
                    <div class="col-12 col-lg-4">
                        <div class="card shadow-sm p-4 summary-card">
                            <h3 class="h5 fw-bold text-dark border-bottom pb-3 mb-3">Order Summary</h3>
                            
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Subtotal</span>
                                <span class="fw-bold text-dark">
                                    <fmt:formatNumber value="${totalAmount}" type="number" pattern="#,###"/> VND
                                </span>
                            </div>
                            <div class="d-flex justify-content-between mb-3">
                                <span class="text-muted">Shipping</span>
                                <span class="text-success small fw-medium">FREE</span>
                            </div>
                            
                            <div class="d-flex justify-content-between align-items-center border-top pt-3 mb-4">
                                <span class="fw-bold text-dark fs-5">Total Estimated:</span>
                                <span class="text-success fw-bold fs-5">
                                    <fmt:formatNumber value="${totalAmount}" type="number" pattern="#,###"/> VND
                                </span>
                            </div>
                            
                            <a href="${pageContext.request.contextPath}/checkout.jsp" class="btn btn-success btn-lg w-100 py-3 rounded-3 fw-bold shadow-sm d-flex align-items-center justify-content-center gap-2">
                                Proceed to Checkout <i class="bi bi-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </c:when>
            
            <c:otherwise>
                <div class="card shadow-sm p-5 cart-card text-center">
                    <div class="py-4">
                        <i class="bi bi-cart-x display-1 text-muted mb-3 d-block"></i>
                        <h3 class="h5 fw-bold text-dark mb-2">Your cart is currently empty</h3>
                        <p class="text-muted small mb-4">Looks like you haven't added any beautiful arrangements to your cart yet.</p>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-success px-4 py-2 rounded-pill fw-bold shadow-sm">
                            Explore Collections
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>