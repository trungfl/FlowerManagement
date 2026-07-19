<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>Order Processing Center</title>
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
        
        .management-card {
            border-radius: 1rem;
            border: none;
            background-color: #ffffff;
        }
        
        .form-select:focus {
            border-color: #198754;
            box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.25);
        }
        
        /* Consistent styles with inventory table layout */
        .custom-table thead.head-dark {
            background-color: #2c3e50;
            color: #ffffff;
        }
        
        .custom-table thead.head-muted {
            background-color: #eef2f5;
            color: #495057;
        }
        
        .custom-table th {
            font-weight: 600;
            padding: 1rem;
            border: none;
        }
        
        .custom-table td {
            padding: 1rem;
            vertical-align: middle;
            color: #495057;
            border-bottom: 1px solid #eef2f5;
        }
        
        .table-hover tbody tr:hover {
            background-color: #f8f9fa;
        }
        
        /* Subtle warning highlight for untaken pending orders */
        .row-pending {
            background-color: #fffdf5 !important;
        }
        .row-pending:hover {
            background-color: #fff9e6 !important;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Top Horizontal Header Navbar -->
    <jsp:include page="../includes/header.jsp"/>

    <div class="container-fluid mt-5 mb-5 px-4 px-lg-5">
        
        <!-- Dashboard Header Dashboard Title Section -->
        <div class="d-flex align-items-center gap-2 mb-4">
            <h2 class="h4 fw-bold text-dark m-0">📋 Order Processing System</h2>
            <span class="badge bg-secondary px-2 py-1 text-uppercase tracking-wider small rounded">Employee Portal</span>
        </div>

        <!-- SECTION 1: ACTIVE ORDERS -->
        <div class="card shadow-sm p-4 management-card mb-5">
            <div class="d-flex align-items-center gap-2 mb-3">
                <h3 class="h5 fw-bold text-dark m-0">⚙️ Active Orders</h3>
                <span class="text-muted small">(Processing, Shipping, Delivered)</span>
            </div>
            
            <div class="table-responsive rounded-3 border">
                <table class="table table-hover align-middle text-center custom-table mb-0">
                    <thead class="head-dark">
                        <tr>
                            <th>Order #</th>
                            <th class="text-start">Customer Info</th>
                            <th class="text-start">Order Details</th>
                            <th>Total</th>
                            <th>Status / Handler</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${activeOrders}" var="o">
                            <tr class="${empty o.employeeUsername ? 'row-pending' : ''}">
                                <td class="fw-bold text-dark fs-6">#${o.orderId}</td>
                                <td class="text-start small">
                                    <div class="fw-bold text-dark"><i class="bi bi-person-fill me-1"></i>${o.fullName}</div>
                                    <div class="text-muted"><i class="bi bi-telephone-fill me-1" style="font-size: 0.8rem;"></i>${o.phone}</div>
                                    <div class="text-muted text-wrap" style="max-width: 250px;"><i class="bi bi-geo-alt-fill me-1" style="font-size: 0.8rem;"></i>${o.address}</div>
                                </td>
                                <td class="text-start small text-dark text-wrap" style="max-width: 300px;">
                                    ${detailsMap[o.orderId]}
                                </td>
                                <td class="text-success fw-bold fs-5"><fmt:formatNumber value="${o.totalAmount}" type="number" pattern="#,###"/> VND</td>
                                <td>
                                    <span class="badge bg-${o.status == 'Delivered' ? 'success' : 'secondary'} px-3 py-2 shadow-sm rounded-pill mb-1">
                                        ${o.status}
                                    </span>
                                    <br>
                                    <small class="d-block mt-1">
                                        <c:choose>
                                            <c:when test="${empty o.employeeUsername}">
                                                <span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 rounded-pill px-2 py-1">🔴 Unassigned</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 rounded-pill px-2 py-1">🟢 User: ${o.employeeUsername}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </small>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty o.employeeUsername}">
                                            <form action="${pageContext.request.contextPath}/manageOrders" method="POST" class="m-0">
                                                <input type="hidden" name="action" value="take">
                                                <input type="hidden" name="orderId" value="${o.orderId}">
                                                <button type="submit" class="btn btn-success fw-bold px-3 py-2 rounded-2 shadow-sm btn-sm">
                                                    <i class="bi bi-hand-index-thumb me-1"></i>Take Order
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:when test="${o.employeeUsername == sessionScope.user.username}">
                                            <form action="${pageContext.request.contextPath}/manageOrders" method="POST" class="m-0 mx-auto" style="max-width: 150px;">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="orderId" value="${o.orderId}">
                                                <select name="status" class="form-select form-select-sm mb-2 rounded-2">
                                                    <option value="Processing" ${o.status == 'Processing' ? 'selected' : ''}>Processing</option>
                                                    <option value="Packaging" ${o.status == 'Packaging' ? 'selected' : ''}>Packaging</option>
                                                    <option value="Shipping" ${o.status == 'Shipping' ? 'selected' : ''}>Shipping</option>
                                                    <option value="Delivered" ${o.status == 'Delivered' ? 'selected' : ''}>Delivered</option>
                                                    <option value="Cancelled" ${o.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                                </select>
                                                <button type="submit" class="btn btn-outline-success btn-sm fw-bold w-100 rounded-2">
                                                    <i class="bi bi-check2-circle me-1"></i>Update
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn btn-light btn-sm text-muted w-100 border rounded-2" disabled>
                                                <i class="bi bi-lock-fill me-1"></i>Locked
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty activeOrders}">
                            <tr>
                                <td colspan="6" class="text-muted py-5">
                                    <i class="bi bi-clipboard-x display-6 d-block mb-2 text-black-50"></i>
                                    No active orders pending tracking queue updates.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- SECTION 2: COMPLETED ORDERS -->
        <div class="card shadow-sm p-4 management-card">
            <div class="d-flex align-items-center mb-3">
                <h3 class="h5 fw-bold text-success m-0">✅ Completed Orders Archive</h3>
            </div>
            
            <div class="table-responsive rounded-3 border">
                <table class="table align-middle text-center custom-table mb-0">
                    <thead class="head-muted">
                        <tr>
                            <th>Order #</th>
                            <th class="text-start">Customer Info</th>
                            <th class="text-start">Order Details</th>
                            <th>Total</th>
                            <th>Completed Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${completedOrders}" var="o">
                            <tr class="table-light text-muted">
                                <td class="fw-bold small">#${o.orderId}</td>
                                <td class="text-start small">
                                    <div class="fw-bold text-secondary"><i class="bi bi-person-fill me-1"></i>${o.fullName}</div>
                                    <div><i class="bi bi-telephone-fill me-1" style="font-size: 0.8rem;"></i>${o.phone}</div>
                                </td>
                                <td class="text-start small text-wrap" style="max-width: 350px;">
                                    ${detailsMap[o.orderId]}
                                </td>
                                <td class="fw-bold text-dark"><fmt:formatNumber value="${o.totalAmount}" type="number" pattern="#,###"/> VND</td>
                                <td>
                                    <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-3 py-1 rounded-pill small mb-1">
                                        Completed
                                    </span>
                                    <br>
                                    <small class="d-block text-muted mt-1" style="font-size: 0.75rem; line-height: 1.2;">
                                        <strong>Received At:</strong><br>${o.receivedDate}
                                    </small>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty completedOrders}">
                            <tr>
                                <td colspan="5" class="text-muted py-5">
                                    <i class="bi bi-archive display-6 d-block mb-2 text-black-50"></i>
                                    No records found inside completed archives yet.
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