<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Thank You</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center justify-content-center" style="height: 100vh;">
    <div class="text-center card shadow p-5">
        <h1 class="text-success mb-3">✅ Thank you for your purchase!</h1>
        <p class="text-muted mb-4">Your order has been successfully placed and the inventory is updated.</p>
        <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-lg">Back to Homepage</a>
    </div>
</body>
</html>