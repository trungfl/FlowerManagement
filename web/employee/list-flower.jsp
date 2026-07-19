<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Inventory</title>
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
        
        .form-control:focus {
            border-color: #198754;
            box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.25);
        }
        
        /* Premium style adjustments for the inventory table */
        .custom-table thead {
            background-color: #2c3e50;
            color: #ffffff;
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
        
        .product-img {
            transition: transform 0.2s ease;
        }
        
        .product-img:hover {
            transform: scale(1.15);
        }
    </style>
</head>
<body class="bg-light">
    <!-- Top Horizontal Header Navbar -->
    <jsp:include page="../includes/header.jsp"/>

    <div class="container mt-5 mb-5">
        <div class="card shadow-sm p-4 management-card">
            
            <!-- Dynamic Dashboard Header Title section -->
            <div class="d-flex align-items-center gap-2 mb-4">
                <h2 class="h4 fw-bold text-dark m-0">📦 Flower Inventory Management</h2>
                <span class="badge bg-secondary px-2 py-1 text-uppercase tracking-wider small rounded">Staff Portal</span>
            </div>

            <!-- Dashboard Actions Row Layout -->
            <div class="row g-3 justify-content-between mb-4">
                <!-- Advanced Search Component Structure -->
                <div class="col-12 col-md-6">
                    <form action="${pageContext.request.contextPath}/manageFlower" method="GET" class="d-flex">
                        <div class="input-group shadow-sm rounded">
                            <span class="input-group-text bg-white border-end-0 text-muted">
                                <i class="bi bi-search"></i>
                            </span>
                            <input class="form-control border-start-0 ps-0 py-2" type="search" name="search" value="${param.search}" placeholder="Search flower by name...">
                            <button class="btn btn-success px-4 fw-medium" type="submit">Search</button>
                        </div>
                    </form>
                </div>

                <!-- Add New Product Button Context block -->
                <div class="col-12 col-md-auto">
                    <a href="${pageContext.request.contextPath}/add-flower.jsp" class="btn btn-success w-100 py-2 px-4 fw-bold shadow-sm d-flex align-items-center gap-2 justify-content-center">
                        <i class="bi bi-plus-circle"></i> Add New Product
                    </a>
                </div>
            </div>

            <!-- Premium Stylized Table Responsive wrapper wrapper element -->
            <div class="table-responsive rounded-3 border">
                <table class="table table-hover align-middle text-center custom-table m-0">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
                            <th class="text-start">Flower Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${flowerList}" var="f">
                            <tr>
                                <td class="fw-bold text-muted small">${f.flowerId}</td>
                                <td>
                                    <img src="${pageContext.request.contextPath}/assets/${f.imageURL}" class="rounded-3 shadow-sm product-img" style="width: 50px; height: 50px; object-fit: cover;">
                                </td>
                                <td class="text-start fw-bold text-dark">${f.name}</td>
                                <td class="text-success fw-bold"><fmt:formatNumber value="${f.price}" type="number" pattern="#,###"/> VND</td>
                                <td class="fw-medium">${f.quantity}</td>
                                <td>
                                    <span class="badge bg-${f.status == 'Available' ? 'success' : (f.status == 'Pre-order' ? 'warning text-dark' : 'secondary')} px-3 py-2 shadow-sm rounded-pill">
                                        ${f.status}
                                    </span>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/updateFlower?id=${f.flowerId}" class="btn btn-outline-warning btn-sm px-3 fw-bold rounded-2">
                                        <i class="bi bi-pencil-square me-1"></i>Edit
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <!-- Empty list handler message layout template -->
                        <c:if test="${empty flowerList}">
                            <tr>
                                <td colspan="7" class="text-muted py-5">
                                    <i class="bi bi-inbox display-6 d-block mb-2 text-black-50"></i>
                                    No records matching the current parameters found.
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