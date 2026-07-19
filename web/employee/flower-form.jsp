<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Flower</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="../includes/header.jsp"/>
    
    <div class="container mt-5" style="max-width: 600px;">
        <h3 class="text-center text-primary">UPDATE FLOWER INFORMATION</h3>
        
        <form action="${pageContext.request.contextPath}/updateFlower" method="POST" class="p-4 bg-white shadow rounded mt-3">
            <input type="hidden" name="id" value="${FLOWER.flowerId}">
            
            <div class="mb-3">
                <label>Flower Name</label>
                <input type="text" name="name" value="${FLOWER.name}" class="form-control" required>
            </div>
            
            <div class="row mb-3">
                <div class="col-md-6">
                    <label>Category ID</label>
                    <input type="number" name="categoryId" value="${FLOWER.categoryId}" class="form-control" required>
                </div>
                <div class="col-md-6">
                    <label>Price</label>
                    <input type="number" name="price" value="${FLOWER.price}" class="form-control" required>
                </div>
            </div>
            
            <div class="row mb-3">
                <div class="col-md-6">
                    <label>Quantity in Stock</label>
                    <input type="number" name="quantity" value="${FLOWER.quantity}" class="form-control" required>
                </div>
                <div class="col-md-6">
                    <label>Status</label>
                    <select name="status" class="form-select">
                        <option value="1" ${FLOWER.status ? 'selected' : ''}>Available</option>
                        <option value="0" ${!FLOWER.status ? 'selected' : ''}>Unavailable</option>
                    </select>
                </div>
            </div>
            
            <div class="mb-3">
                <label>Description</label>
                <textarea name="description" class="form-control" rows="3">${FLOWER.description}</textarea>
            </div>
            
            <button type="submit" class="btn btn-primary w-100">Save Changes</button>
            <a href="${pageContext.request.contextPath}/manageFlower" class="btn btn-secondary w-100 mt-2">Back</a>
        </form>
    </div>
</body>
</html>