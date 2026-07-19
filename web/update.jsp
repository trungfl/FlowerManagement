<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Flower</title>
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
        .form-card {
            background: #ffffff;
            border: none;
            border-radius: 1.25rem;
        }
        .form-label {
            font-weight: 600;
            color: #4b5563;
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
        }
        .form-control, .form-select {
            border-radius: 0.5rem;
            padding: 0.625rem 0.75rem;
            border: 1px solid #d1d5db;
        }
        .form-control:focus, .form-select:focus {
            border-color: #10b981;
            box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.15);
        }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="includes/header.jsp"/>
    
    <div class="container mt-5 mb-5" style="max-width: 650px;">
        <!-- Header Text Section -->
        <div class="text-center mb-4">
            <h3 class="fw-bold text-dark m-0">✏️ Edit Flower Product</h3>
            <p class="text-muted small mt-1">Modify configuration parameters, upload assets, or manage database persistence.</p>
        </div>
        
        <!-- Interactive Form Card Box Container -->
        <div class="card p-4 p-md-5 shadow-sm form-card">
            <form action="${pageContext.request.contextPath}/updateFlower" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="flowerId" value="${flower.flowerId}">
                <input type="hidden" name="oldImageURL" value="${flower.imageURL}">
                
                <!-- Flower Name Input -->
                <div class="mb-4">
                    <label class="form-label">Name</label>
                    <input type="text" class="form-control" name="name" value="${flower.name}" required>
                </div>
                
                <!-- Category ID Mapping Index Component -->
                <div class="mb-4">
                    <label class="form-label">Category ID</label>
                    <input type="number" class="form-control" name="categoryId" value="${flower.categoryId}" required>
                </div>
                
                <!-- Catalog Descriptions Text Area Element -->
                <div class="mb-4">
                    <label class="form-label">Description</label>
                    <textarea class="form-control" name="description" rows="3" required>${flower.description}</textarea>
                </div>
                
                <!-- Financial Price Specification Input Container -->
                <div class="mb-4">
                    <label class="form-label">Price</label>
                    <input type="number" step="0.01" class="form-control" name="price" value="${flower.price}" required>
                </div>
                
                <!-- Available Stock Quantitative Tracking Units Fields -->
                <div class="mb-4">
                    <label class="form-label">Quantity</label>
                    <input type="number" class="form-control" name="quantity" value="${flower.quantity}" required>
                </div>
                
                <!-- Active Operational System Status Configuration Options Menu -->
                <div class="mb-4">
                    <label class="form-label">Status</label>
                    <select class="form-select fw-medium" name="status">
                        <option value="Available" ${flower.status == 'Available' ? 'selected' : ''}>🟢 Available</option>
                        <option value="Pre-order" ${flower.status == 'Pre-order' ? 'selected' : ''}>🟡 Pre-order</option>
                        <option value="Unavailable" ${flower.status == 'Unavailable' ? 'selected' : ''}>⚪ Unavailable</option>
                    </select>
                </div>

                <!-- Asset File Control Block with Current Dynamic Thumbnail Context Image Previews -->
                <div class="mb-5">
                    <label class="form-label">Product Image Asset</label>
                    <input type="file" class="form-control" name="imageFile" accept="image/*">
                    <div class="mt-3 p-2 bg-light rounded-3 border d-inline-block">
                        <span class="d-block small text-muted fw-bold mb-2 text-center">Current Asset:</span>
                        <img src="${pageContext.request.contextPath}/assets/${flower.imageURL}" width="120" class="img-thumbnail border-0 rounded-2 shadow-sm">
                    </div>
                </div>

                <!-- Action Controls Routing Execution Handles Block Footer Panel -->
                <div class="d-flex flex-column flex-sm-row justify-content-between gap-3 pt-3 border-top">
                    <div class="d-flex gap-2 order-2 order-sm-1">
                        <button type="submit" class="btn btn-success px-4 py-2.5 rounded-3 fw-bold shadow-sm">
                            <i class="bi bi-check-circle-fill me-1"></i> Save Changes
                        </button>
                        <a href="${pageContext.request.contextPath}/manageFlower" class="btn btn-light border px-4 py-2.5 rounded-3 fw-medium text-secondary">
                            Cancel
                        </a>
                    </div>
                    
                    <!-- Destructive Action Mutation Entry Component Handle -->
                    <div class="order-1 order-sm-2">
                        <a href="${pageContext.request.contextPath}/deleteFlower?id=${flower.flowerId}" 
                           class="btn btn-outline-danger px-4 py-2.5 rounded-3 fw-medium d-flex align-items-center justify-content-center gap-1" 
                           onclick="return confirm('Are you sure you want to delete this flower?');">
                           <i class="bi bi-trash3-fill"></i> Delete Flower
                        </a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>