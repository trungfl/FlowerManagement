<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:if test="${empty totalCustomers && empty monthlyRev}">
    <c:redirect url="/adminDashboard"/> 
</c:if>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Flower Shop</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts & Bootstrap Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f4f6f9 !important;
        }
        
        /* Glassmorphism Metric Cards with High Contrast */
        .stat-card {
            border-radius: 1.25rem;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            background: rgba(255, 255, 255, 0.7) !important;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
        }
        
        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.06) !important;
        }

        /* Unique Color Variants per Metric */
        .card-customers {
            border: 1px solid rgba(79, 70, 229, 0.25) !important;
            box-shadow: 0 4px 15px rgba(79, 70, 229, 0.05);
        }
        .card-customers .text-label { color: #4f46e5; }
        .card-customers .text-value { color: #312e81; }
        .card-customers .icon-shape { background: rgba(79, 70, 229, 0.1); color: #4f46e5; }

        .card-revenue {
            border: 1px solid rgba(5, 150, 105, 0.25) !important;
            box-shadow: 0 4px 15px rgba(5, 150, 105, 0.05);
        }
        .card-revenue .text-label { color: #059669; }
        .card-revenue .text-value { color: #064e3b; }
        .card-revenue .icon-shape { background: rgba(5, 150, 105, 0.1); color: #059669; }

        .card-orders {
            border: 1px solid rgba(217, 119, 6, 0.25) !important;
            box-shadow: 0 4px 15px rgba(217, 119, 6, 0.05);
        }
        .card-orders .text-label { color: #d97706; }
        .card-orders .text-value { color: #78350f; }
        .card-orders .icon-shape { background: rgba(217, 119, 6, 0.1); color: #d97706; }

        .icon-shape {
            width: 48px;
            height: 48px;
            border-radius: 50rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }
        
        /* Dark Terminal Logs */
        .terminal-log {
            height: 320px; 
            overflow-y: auto; 
            font-family: 'Courier New', Courier, monospace;
            background-color: #111827 !important;
            border-radius: 1rem;
            border: 1px solid #1f2937;
            font-size: 0.875rem;
            line-height: 1.6;
            box-shadow: inset 0 2px 8px rgba(0,0,0,0.8);
        }

        .terminal-log::-webkit-scrollbar {
            width: 6px;
        }
        .terminal-log::-webkit-scrollbar-thumb {
            background: #374151;
            border-radius: 10px;
        }
        
        .table-custom {
            border-radius: 1rem;
            overflow: hidden;
            border: none !important;
        }
        
        .table-custom thead {
            background-color: #fef2f2;
            color: #991b1b;
        }
        
        .table-custom th {
            font-weight: 600;
            padding: 1rem;
            border: none;
        }

        .table-custom td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #f1f5f9;
        }
        
        .section-card {
            background: #ffffff;
            border-radius: 1.25rem;
            border: none;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Top Horizontal Header Navbar -->
    <jsp:include page="../includes/header.jsp"/>
    
    <div class="container mt-5 mb-5 px-4 px-lg-5">
        
        <!-- Header Section -->
        <div class="d-flex justify-content-between align-items-center mb-5">
            <div>
                <h2 class="h3 fw-bold text-dark m-0">📊 Executive Dashboard</h2>
                <p class="text-muted small m-0 mt-1">Real-time enterprise metrics & administrative operations monitoring.</p>
            </div>
            <span class="badge bg-dark px-3 py-2 text-uppercase tracking-wider rounded-pill border border-secondary border-opacity-25 fs-7">
                <i class="bi bi-shield-lock-fill me-1 text-warning"></i> Admin Root
            </span>
        </div>
        
        <!-- High-Performance Metrics Row -->
        <div class="row g-4 mb-5">
            <!-- Total Customers -->
            <div class="col-12 col-md-4">
                <div class="card stat-card card-customers p-4 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h4 class="h6 text-label fw-semibold text-uppercase tracking-wide mb-2">Total Customers</h4>
                            <h2 class="display-6 fw-bold mb-0 text-value">${totalCustomers}</h2>
                        </div>
                        <div class="icon-shape">
                            <i class="bi bi-people-fill"></i>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Monthly Revenue -->
            <div class="col-12 col-md-4">
                <div class="card stat-card card-revenue p-4 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h4 class="h6 text-label fw-semibold text-uppercase tracking-wide mb-2">Monthly Revenue</h4>
                            <h2 class="display-6 fw-bold mb-0 text-value">
                                <fmt:formatNumber value="${monthlyRev}" type="number" pattern="#,###.##"/>VND
                            </h2>
                        </div>
                        <div class="icon-shape">
                            <i class="bi bi-currency-dollar"></i>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Monthly Orders -->
            <div class="col-12 col-md-4">
                <div class="card stat-card card-orders p-4 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h4 class="h6 text-label fw-semibold text-uppercase tracking-wide mb-2">Monthly Orders</h4>
                            <h2 class="display-6 fw-bold mb-0 text-value">${monthlyOrders}</h2>
                        </div>
                        <div class="icon-shape">
                            <i class="bi bi-cart-check-fill"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- Low Stock Alerts Panel Container -->
            <div class="col-12">
                <div class="card p-4 shadow-sm section-card">
                    <div class="d-flex align-items-center gap-2 mb-3">
                        <i class="bi bi-exclamation-triangle-fill text-danger fs-5"></i>
                        <h4 class="h5 fw-bold text-dark m-0">Critical Low Stock Alerts (< 5 items)</h4>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table align-middle text-center table-custom border mb-0">
                            <thead>
                                <tr>
                                    <th class="text-start">Flower ID</th>
                                    <th>Flower Display Name</th>
                                    <th class="text-end">Current Stock Quantity</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${lowStock}" var="f">
                                    <tr>
                                        <td class="text-start fw-semibold text-secondary">#${f.flowerId}</td>
                                        <td class="fw-medium text-dark">${f.name}</td>
                                        <td class="text-end">
                                            <span class="badge bg-danger bg-opacity-10 text-danger fw-bold px-3 py-2 rounded">
                                                ${f.quantity} Units Left
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty lowStock}">
                                    <tr>
                                        <td colspan="3" class="text-muted py-4">
                                            <i class="bi bi-check-circle-fill text-success me-1"></i> All products are well stocked!
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Enhanced Administrative Operational Logging Rows -->
            <div class="col-12 col-lg-6">
                <div class="card p-4 shadow-sm section-card h-100">
                    <div class="d-flex align-items-center gap-2 mb-3">
                        <i class="bi bi-terminal-fill text-secondary fs-5"></i>
                        <h4 class="h5 fw-bold text-dark m-0">Inventory & System Logs</h4>
                    </div>
                    <div class="card p-3 terminal-log text-info">
                        <c:forEach items="${logs}" var="l">
                            <div class="mb-1"><span class="text-secondary opacity-50">&gt;</span> ${l}</div>
                        </c:forEach>
                        <c:if test="${empty logs}">
                            <div class="text-muted font-monospace italic">&gt; System idle. No recent inventory activities.</div>
                        </c:if>
                    </div>
                </div>
            </div>

            <div class="col-12 col-lg-6">
                <div class="card p-4 shadow-sm section-card h-100">
                    <div class="d-flex align-items-center gap-2 mb-3">
                        <i class="bi bi-box-seam-fill text-success fs-5"></i>
                        <h4 class="h5 fw-bold text-dark m-0">Order Processing Logs</h4>
                    </div>
                    <div class="card p-3 terminal-log text-success">
                        <c:forEach items="${orderLogs}" var="ol">
                            <div class="mb-1"><span class="text-secondary opacity-50">&gt;</span> ${ol}</div>
                        </c:forEach>
                        <c:if test="${empty orderLogs}">
                            <div class="text-muted font-monospace italic">&gt; System idle. No recent fulfillment updates.</div>
                        </c:if>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</body>
</html>