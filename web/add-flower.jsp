<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Product</title>
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
        .alert-rule {
            background-color: #fff7ed;
            border: 1px solid #ffedd5;
            color: #c2410c;
            border-radius: 0.75rem;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Top Horizontal Header Navbar Include -->
    <jsp:include page="includes/header.jsp"/>
    
    <div class="container mt-5 mb-5" style="max-width: 650px;">
        <!-- Header Section Title Info -->
        <div class="text-center mb-4">
            <h3 class="fw-bold text-dark m-0">➕ Add New Flower Product</h3>
            <p class="text-muted small mt-1">Insert a new unique arrangement into the active operational store database.</p>
        </div>
        
        <!-- Main Form Card Control Box Holder -->
        <div class="card p-4 p-md-5 shadow-sm form-card">
            <!-- Dynamic Param Validation Feedback Alerts Elements -->
            <c:if test="${param.error == 'true'}">
                <div class="alert alert-danger d-flex align-items-center gap-2 rounded-3 mb-4">
                    <i class="bi bi-exclamation-octagon-fill"></i>
                    <div>Invalid input data. Please thoroughly re-check structural inputs.</div>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/addFlower" method="POST" enctype="multipart/form-data">
                <!-- Name Text Input -->
                <div class="mb-4">
                    <label class="form-label">Flower Display Name</label>
                    <input type="text" name="name" class="form-control" placeholder="e.g., Red Roses Luxury Bouquet" required>
                </div>
                
                <!-- Category Index Mapping ID & Price Grid Alignment Row Elements -->
                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <label class="form-label">Category Classification ID</label>
                        <input type="number" name="categoryId" class="form-control" value="1" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Unit Base Price (VND)</label>
                        <input type="number" step="1" name="price" class="form-control" placeholder="Value in VND" required>
                    </div>
                </div>
                
                <!-- Operational Quantity Entry Field -->
                <div class="mb-4">
                    <label class="form-label">Initial Stock Quantity</label>
                    <input type="number" name="quantity" class="form-control" placeholder="Initial units available" required>
                </div>
                
                <!-- Long Text Box Area for Descriptions -->
                <div class="mb-4">
                    <label class="form-label">Catalog Marketing Description</label>
                    <textarea name="description" class="form-control" rows="3" placeholder="Describe the configuration notes..." required></textarea>
                </div>
                
                <!-- Interactive Select Multi-choice Status Dropdown Elements -->
                <div class="mb-4">
                    <label class="form-label">Initial Product Status</label>
                    <select name="status" class="form-select fw-medium" required>
                        <option value="Available" selected>🟢 Available (Sẵn sàng bán)</option>
                        <option value="Pre-order">🟡 Pre-order (Hàng đặt trước)</option>
                        <option value="Unavailable">⚪ Unavailable (Ngừng bán)</option>
                    </select>
                </div>
                
                <!-- Media Binary Multipart Upload Fields and Alert Constraints Notification Fields -->
                <div class="mb-5">
                    <label class="form-label">Asset Image Attachment</label>
                    <input type="file" name="imageFile" class="form-control" accept="image/png, image/jpeg" required>
                    
                    <div class="p-3 mt-3 alert-rule small d-flex gap-2">
                        <i class="bi bi-info-circle-fill fs-5 flex-shrink-0"></i>
                        <div>
                            <span class="fw-bold d-block text-uppercase tracking-wider mb-1">Asset Design Constraints Rule:</span>
                            Upload strictly **SQUARE** images (1:1 ratio, optimal sizes: 800x800 or 600x600 pixels). Maximum allowed size limit: 2MB to keep site load speeds high.
                        </div>
                    </div>
                </div>
                
                <!-- Final Operations Submission Controls Buttons -->
                <div class="d-flex gap-3 justify-content-between pt-2 border-top">
                    <a href="${pageContext.request.contextPath}/manageFlower" class="btn btn-light border px-4 py-2.5 rounded-3 fw-medium text-secondary">
                        Cancel
                    </a>
                    <button type="submit" class="btn btn-success px-4 py-2.5 rounded-3 fw-bold shadow-sm">
                        <i class="bi bi-plus-circle-fill me-1"></i> Create Product
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>