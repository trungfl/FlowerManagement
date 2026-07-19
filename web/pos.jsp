<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>POS System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="includes/header.jsp"/>
    
    <div class="container mt-5">
        <h2 class="text-center mb-4 fw-bold">💻 POS - Inventory Management</h2>
        
        <!-- Thông báo thành công -->
        <c:if test="${param.success == 'true'}">
            <div class="alert alert-success text-center fw-bold">
                <c:choose>
                    <c:when test="${param.mode == 'IMPORT'}">✅ Import transaction successful! Inventory restocked.</c:when>
                    <c:otherwise>✅ Export transaction successful! Inventory deducted.</c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/pos" method="POST" class="card shadow p-4">
            
            <!-- Nút chọn chế độ (Toggle Mode) -->
            <div class="d-flex justify-content-center mb-4">
                <div class="btn-group" role="group" style="width: 400px;">
                    <input type="radio" class="btn-check" name="transactionMode" id="modeExport" value="EXPORT" checked onchange="changeMode()">
                    <label class="btn btn-outline-danger fw-bold" for="modeExport">📤 Export (Sale)</label>

                    <input type="radio" class="btn-check" name="transactionMode" id="modeImport" value="IMPORT" onchange="changeMode()">
                    <label class="btn btn-outline-success fw-bold" for="modeImport">📥 Import (Restock)</label>
                </div>
            </div>

            <!-- Bảng chọn sản phẩm -->
            <table class="table table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>Select Flower</th>
                        <th width="20%">Quantity</th>
                        <th width="15%">Action</th>
                    </tr>
                </thead>
                <tbody id="posTable">
                    <tr>
                        <td>
                            <select name="flowerId" class="form-select" required>
                                <option value="">-- Select Product --</option>
                                <c:forEach items="${flowerList}" var="f">
                                    <option value="${f.flowerId}">${f.name} (In Stock: ${f.quantity})</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td><input type="number" name="qty" class="form-control" min="1" required></td>
                        <td><button type="button" class="btn btn-secondary w-100" disabled>Fixed</button></td>
                    </tr>
                </tbody>
            </table>
            
            <div class="d-flex justify-content-between mt-3">
                <button type="button" class="btn btn-info text-white fw-bold" onclick="addRow()">+ Add More Items</button>
                <button type="submit" id="submitBtn" class="btn btn-danger fw-bold fs-5 px-5">Confirm Export</button>
            </div>
        </form>
    </div>

    <script>
        // JS để thêm dòng
        function addRow() {
            let options = '<option value="">-- Select Product --</option>';
            <c:forEach items="${flowerList}" var="f">
                options += '<option value="${f.flowerId}">${f.name} (In Stock: ${f.quantity})</option>';
            </c:forEach>
            
            let html = `<tr>
                <td><select name="flowerId" class="form-select" required>` + options + `</select></td>
                <td><input type="number" name="qty" class="form-control" min="1" required></td>
                <td><button type="button" class="btn btn-warning w-100" onclick="this.closest('tr').remove()">Remove</button></td>
            </tr>`;
            document.getElementById('posTable').insertAdjacentHTML('beforeend', html);
        }

        // JS để đổi màu nút Submit theo chế độ
        function changeMode() {
            let isExport = document.getElementById('modeExport').checked;
            let btn = document.getElementById('submitBtn');
            if (isExport) {
                btn.className = 'btn btn-danger fw-bold fs-5 px-5';
                btn.innerText = 'Confirm Export';
            } else {
                btn.className = 'btn btn-success fw-bold fs-5 px-5';
                btn.innerText = 'Confirm Import';
            }
        }
    </script>
</body>
</html>