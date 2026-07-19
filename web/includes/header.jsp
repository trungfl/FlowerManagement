<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
    /* Sleek hover effects for a more modern navbar experience */
    .nav-custom-link {
        position: relative;
        transition: color 0.2s ease;
    }
    .nav-custom-link::after {
        content: '';
        position: absolute;
        width: 0;
        height: 2px;
        bottom: 0;
        left: 50%;
        background-color: currentColor;
        transition: width 0.2s ease, left 0.2s ease;
    }
    .nav-custom-link:hover::after {
        width: 100%;
        left: 0;
    }
    /* Fix Bootstrap's native behavior rewriting button text padding */
    .navbar-nav .btn.nav-link {
        color: var(--bs-navbar-active-color) !important;
    }
    .navbar-nav .btn.nav-link:hover {
        color: #fff !important;
    }
</style>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm py-3">
    <div class="container">
        <!-- Logo / Shop Name -->
        <a class="navbar-brand fw-bold text-warning fs-4 d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-flower1"></i> FlowerShop
        </a>

        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <!-- Left Side Menu Navigation -->
            <ul class="navbar-nav me-auto align-items-lg-center gap-1 mt-2 mt-lg-0">
                <li class="nav-item">
                    <a class="nav-link fs-6 nav-custom-link d-flex align-items-center gap-1" href="${pageContext.request.contextPath}/home">
                        <i class="bi bi-house-door"></i> Home
                    </a>
                </li>

                <!-- Admin & Employee Specific Restrictions -->
                <c:if test="${not empty sessionScope.user}">
                    <c:if test="${sessionScope.user.roleID == 1 || sessionScope.user.roleID == 2}">
                        <li class="nav-item">
                            <a class="nav-link text-info fw-semibold fs-6 nav-custom-link d-flex align-items-center gap-1" href="${pageContext.request.contextPath}/manageFlower">
                                <i class="bi bi-box-seam"></i> Manage Inventory
                            </a>
                        </li>

                        <c:if test="${sessionScope.user.roleID == 2}">
                            <li class="nav-item">
                                <a class="nav-link text-warning fw-semibold fs-6 nav-custom-link d-flex align-items-center gap-1" href="${pageContext.request.contextPath}/manageOrders">
                                    <i class="bi bi-journal-text"></i> Process Orders
                                </a>
                            </li>
                        </c:if>
                    </c:if>

                    <c:if test="${sessionScope.user.roleID == 1}">
                        <li class="nav-item">
                            <a class="nav-link text-danger fw-semibold fs-6 nav-custom-link d-flex align-items-center gap-1" href="${pageContext.request.contextPath}/adminDashboard">
                                <i class="bi bi-speedometer2"></i> Admin Dashboard
                            </a>
                        </li>
                    </c:if>
                </c:if>
            </ul>

            <!-- Right Side Menu Navigation (Account, Cart, History) -->
            <ul class="navbar-nav align-items-lg-center gap-2 mt-3 mt-lg-0">
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <li class="nav-item">
                            <a class="nav-link btn btn-outline-light border-secondary text-white px-4 rounded-pill btn-sm fw-medium" href="${pageContext.request.contextPath}/login.jsp">Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link btn btn-warning text-dark fw-bold px-4 rounded-pill btn-sm shadow-sm" href="${pageContext.request.contextPath}/register.jsp">Register</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <!-- Order History Button (Clean Translucent Design) -->
                        <c:if test="${sessionScope.user.roleID == 3}">
                            <!-- Order History Button (Clean Translucent Design) -->
                            <li class="nav-item">
                                <a class="nav-link fw-semibold text-success fs-6 bg-white bg-opacity-10 rounded-3 px-3 d-flex align-items-center gap-1" href="${pageContext.request.contextPath}/orderHistory">
                                    <i class="bi bi-clock-history"></i> My Orders
                                </a>
                            </li>
                        </c:if>

                        <!-- Customer Cart Action Indicator -->
                        <c:if test="${sessionScope.user.roleID == 3}">
                            <li class="nav-item">
                                <a class="nav-link text-warning fw-semibold fs-6 nav-custom-link d-flex align-items-center gap-1 px-2" href="${pageContext.request.contextPath}/cart.jsp">
                                    <i class="bi bi-cart3"></i> Cart

                                    <c:if test="${not empty sessionScope.cart}">
                                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-success" style="font-size: 0.65rem;">
                                            ${sessionScope.cart.size()}
                                        </span>
                                    </c:if>
                                </a>
                            </li>
                        </c:if>

                        <!-- Logged In Identity Title Wrap -->
                        <li class="nav-item mx-lg-2">
                            <span class="nav-link text-light opacity-75 fs-6 d-flex align-items-center gap-1">
                                <i class="bi bi-person-circle"></i> Hello, <span class="text-white fw-semibold">${sessionScope.user.fullName}</span>
                            </span>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link btn btn-sm btn-danger text-white fw-semibold px-3 rounded-3 shadow-sm" href="${pageContext.request.contextPath}/logout">
                                <i class="bi bi-box-arrow-right me-1"></i> Logout
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>