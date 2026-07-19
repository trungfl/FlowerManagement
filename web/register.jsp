<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Flower Shop</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts & Bootstrap Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            height: 100vh;
            position: relative;
            overflow: hidden;
            background-color: #2c3e50;
        }
        
        .register-bg {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('${pageContext.request.contextPath}/assets/login-bg.webp'); 
            background-size: cover;
            background-position: center;
            filter: blur(8px);
            transform: scale(1.05);
            z-index: 1;
        }
        
        .register-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.45);
            z-index: 2;
        }
        
        .register-container {
            position: relative;
            z-index: 3;
            width: 100%;
            height: 100%;
        }
        
        .register-card {
            border-radius: 1rem;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(4px);
            border: none;
            width: 420px;
        }
        
        .form-control:focus {
            border-color: #198754;
            box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.25);
        }
        
        .link-success-custom {
            color: #198754;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s ease;
        }
        .link-success-custom:hover {
            color: #146c43;
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="register-bg"></div>
    <div class="register-overlay"></div>
    
    <div class="register-container d-flex align-items-center justify-content-center">
        
        <a href="${pageContext.request.contextPath}/home" class="btn btn-light shadow-sm position-absolute top-0 start-0 m-4 rounded-pill px-3 py-2 fw-medium text-dark d-flex align-items-center gap-2">
            <i class="bi bi-arrow-left"></i> Back to Home Page
        </a>
        
        <div class="card register-card shadow-lg p-4 mx-3">
            <div class="text-center mb-4">
                <span class="h4 fw-bold text-success d-flex align-items-center justify-content-center gap-2 mb-1">
                    <i class="bi bi-flower1"></i> FlowerShop
                </span>
                <p class="text-muted small">Create your account to start ordering</p>
            </div>
            
            <!-- Strict validation check ensuring string text content exists -->
            <c:if test="${not empty error && error.trim().length() > 0}">
                <div class="alert alert-danger border-0 py-2 small text-center rounded-3">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="POST">
                <div class="mb-3">
                    <label class="form-label fw-medium text-dark small">Full Name</label>
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0 text-muted"><i class="bi bi-card-text"></i></span>
                        <input type="text" name="fullname" class="form-control border-start-0 ps-0" placeholder="Enter your full name" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-medium text-dark small">Username</label>
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0 text-muted"><i class="bi bi-person"></i></span>
                        <input type="text" name="username" class="form-control border-start-0 ps-0" placeholder="Choose a username" required>
                    </div>
                </div>
                <div class="mb-4">
                    <label class="form-label fw-medium text-dark small">Password</label>
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0 text-muted"><i class="bi bi-lock"></i></span>
                        <input type="password" name="password" class="form-control border-start-0 ps-0" placeholder="Create a password" required>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-success w-100 py-2 rounded-3 fw-bold shadow-sm">
                    <i class="bi bi-person-plus me-1"></i> Create Account
                </button> 
            </form>
            
            <div class="text-center mt-4 pt-2 border-top">
                <span class="small text-muted">Already have an account? 
                    <a href="login.jsp" class="link-success-custom">Back to Login</a>
                </span>
            </div>
        </div>
    </div>
    
</body>
</html>