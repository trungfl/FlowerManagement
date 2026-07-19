<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>My Order History - Flower Shop</title>
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
        
        .history-card {
            border-radius: 1rem;
            border: none;
            background-color: #ffffff;
        }
        
        .custom-table thead.head-dark {
            background-color: #2c3e50;
            color: #ffffff;
        }
        
        .custom-table th {
            font-weight: 600;
            padding: 1rem;
            border: none;
        }
        
        .custom-table td {
            padding: 1.25rem 1rem;
            vertical-align: middle;
            color: #495057;
            border-bottom: 1px solid #eef2f5;
        }
        
        .table-hover tbody tr:hover {
            background-color: #f8f9fa;
        }
        
        .row-completed {
            background-color: #fdfdfd !important;
            opacity: 0.85;
        }
        
        .status-badge {
            font-size: 0.8rem;
            padding: 0.4rem 0.8rem;
            font-weight: 600;
            border-radius: 50rem;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Top Horizontal Header Navbar -->
    <jsp:include page="includes/header.jsp"/>

    <div class="container mt-5 mb-5 px-4 px-lg-5">
        
        <!-- Dashboard Title Header -->
        <div class="d-flex align-items-center gap-2 mb-4">
            <h2 class="h4 fw-bold text-dark m-0">📜 My Order History</h2>
            <span class="badge bg-success bg-opacity-10 text-success px-2 py-1 text-uppercase tracking-wider small rounded border border-success border-opacity-25">Customer Portal</span>
        </div>

        <!-- Order Records Container -->
        <div class="card shadow-sm p-4 history-card">
            <div class="table-responsive rounded-3 border">
                <table class="table table-hover align-middle text-center custom-table mb-0">
                    <thead class="head-dark">
                        <tr>
                            <th>Order #</th>
                            <th>Total Amount</th>
                            <th>Status Tracking</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orders}" var="o">
                            <tr class="${o.status == 'Completed' ? 'row-completed text-muted' : ''}">
                                <!-- Order ID -->
                                <td class="fw-bold text-dark fs-6">#${o.orderId}</td>
                                
                                <!-- Formatted Price -->
                                <td class="text-success fw-bold fs-5">
                                    <fmt:formatNumber value="${o.totalAmount}" type="number" pattern="#,###"/> VND
                                </td>
                                
                                <!-- Dynamic Status Handling Column -->
                                <td>
                                    <c:choose>
                                        <c:when test="${o.status == 'Delivered'}">
                                            <span class="badge bg-success status-badge shadow-sm">${o.status}</span>
                                        </c:when>
                                        <c:when test="${o.status == 'Cancelled'}">
                                            <span class="badge bg-danger status-badge shadow-sm">${o.status}</span>
                                        </c:when>
                                        <c:when test="${o.status == 'Completed'}">
                                            <span class="badge bg-secondary status-badge shadow-sm">${o.status}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-warning text-dark status-badge shadow-sm">${o.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                    <!-- Shipping Notification Indicator -->
                                    <c:if test="${o.status == 'Shipping'}">
                                        <div class="mt-2 small text-danger fw-semibold">
                                            <i class="bi bi-telephone-inbound-fill me-1"></i> Please keep your phone nearby
                                        </div>
                                    </c:if>
                                </td>
                                
                                <!-- Contextual Action Controls -->
                                <td>
                                    <c:choose>
                                        <c:when test="${o.status == 'Completed'}">
                                            <button class="btn btn-sm btn-light text-muted border px-3 py-2 rounded-2" disabled>
                                                <i class="bi bi-box-seam me-1"></i> Received
                                            </button>
                                            <div class="d-block text-success small mt-1" style="font-size: 0.75rem;">
                                                <strong>At:</strong> ${o.receivedDate}
                                            </div>
                                        </c:when>
                                        
                                        <c:when test="${o.status == 'Delivered'}">
                                            <form action="${pageContext.request.contextPath}/orderHistory" method="POST" class="m-0">
                                                <input type="hidden" name="action" value="complete">
                                                <input type="hidden" name="orderId" value="${o.orderId}">
                                                <button type="submit" class="btn btn-sm btn-success fw-bold px-3 py-2 rounded-2 shadow-sm">
                                                    <i class="bi bi-check-circle me-1"></i> Mark as Received
                                                </button>
                                            </form>
                                        </c:when>
                                        
                                        <c:otherwise>
                                            <button class="btn btn-sm btn-light border text-muted px-3 py-2 rounded-2" disabled>
                                                <i class="bi bi-hourglass-split me-1"></i> Processing Order
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty orders}">
                            <tr>
                                <td colspan="4" class="text-muted py-5">
                                    <i class="bi bi-receipt display-6 d-block mb-2 text-black-50"></i>
                                    You haven't placed any orders yet.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
        
    </div>
</body>
</html>