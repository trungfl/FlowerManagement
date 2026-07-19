<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>Flower Shop - Home</title>
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
        
        /* Hero/Banner container styling */
        .hero-section {
            position: relative;
            overflow: hidden;
            background-color: #2c3e50; /* Changed to a nice soft slate fallback color */
            padding: 5rem 0;
        }
        
        /* The blurred background layer */
        .hero-bg {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('${pageContext.request.contextPath}/assets/hero-flowers.webp'); 
            background-size: cover;
            background-position: center;
            filter: blur(6px);
            transform: scale(1.05); 
            z-index: 1;
        }
        
        /* Dark shade tint for typography readability overlay */
        .hero-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.4);
            z-index: 2;
        }
        
        /* Forces header search elements above background blocks */
        .hero-content {
            position: relative;
            z-index: 3;
        }

        /* Card interactive hover effect */
        .flower-card {
            transition: transform 0.25s ease, box-shadow 0.25s ease;
        }
        .flower-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.08) !important;
        }
        
        /* Consistent green palette alignment for pagination controls */
        .page-item.active .page-link {
            background-color: #198754;
            border-color: #198754;
        }
        .page-link {
            color: #198754;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Top Horizontal Header Navbar -->
    <jsp:include page="includes/header.jsp"/>
    
    <!-- Hero Header / Search Section with Blurred Background Image -->
    <div class="hero-section text-center mb-5">
        <div class="hero-bg"></div>
        <div class="hero-overlay"></div>
        
        <div class="container hero-content">
            <h1 class="fw-bold text-white mb-2">Find Your Perfect Blooms</h1>
            <p class="text-white-50 mb-4">Fresh, hand-picked flowers delivered straight to your door.</p>
            
            <form action="${pageContext.request.contextPath}/home" method="GET" class="d-flex justify-content-center mx-auto" style="max-width: 600px;">
                <div class="input-group shadow rounded">
                    <span class="input-group-text bg-white border-end-0 text-muted">
                        <i class="bi bi-search"></i>
                    </span>
                    <input class="form-control border-start-0 ps-0 py-2" type="search" name="search" value="${searchKeyword}" placeholder="Search flowers...">
                    <button class="btn btn-success px-4 fw-medium" type="submit">Search</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Main Products Collection Display Area -->
    <div class="container mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="h4 fw-bold text-dark m-0">🌸 Featured Collection</h2>
            <span class="text-muted small">Showing results for your selection</span>
        </div>
        
        <!-- Updated to structural grid sizing rows -->
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
            <c:forEach items="${flowerList}" var="f">
                <div class="col">
                    <div class="card h-100 border-0 shadow-sm flower-card rounded-4 overflow-hidden">
                        <!-- Card Cover Image & Stock Badges Layout -->
                        <div class="position-relative">
                            <img src="${pageContext.request.contextPath}/assets/${f.imageURL}" class="card-img-top" style="height: 260px; object-fit: cover;">
                            <span class="position-absolute top-0 start-0 m-3 badge bg-${f.status == 'Available' ? 'success' : (f.status == 'Pre-order' ? 'warning text-dark' : 'secondary')} px-3 py-2 shadow-sm">
                                ${f.status}
                            </span>
                        </div>
                        
                        <!-- Main Text Descriptions Info Body -->
                        <div class="card-body d-flex flex-column text-center px-4 pt-4 pb-3">
                            <h5 class="card-title fw-bold text-dark mb-2">${f.name}</h5>
                            <p class="card-text text-muted small flex-grow-1">${f.description}</p>
                            <div class="mt-3">
                                <span class="h3 fw-bold text-success"><fmt:formatNumber value="${f.price}" type="number" pattern="#,###"/> VND</span>
                            </div>
                        </div>
                        
                        <!-- Interactive Customer Action Footer Section -->
                        <div class="card-footer bg-white px-4 pb-4 pt-0 border-top-0">
                            <c:if test="${empty sessionScope.user or sessionScope.user.roleID == 3}">
                                <a href="${pageContext.request.contextPath}/cart?action=add&id=${f.flowerId}" class="btn btn-outline-success w-100 py-2 rounded-3 fw-medium">
                                    <i class="bi bi-cart-plus me-2"></i>Add to Cart
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <!-- Centered Pagination Control Links Component -->
        <nav aria-label="Page navigation" class="pt-5">
            <ul class="pagination justify-content-center m-0">
                <c:forEach begin="1" end="${endPage}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''} mx-1">
                        <a class="page-link rounded shadow-sm px-3" href="${pageContext.request.contextPath}/home?page=${i}&search=${searchKeyword}">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </div>
</body>
</html>