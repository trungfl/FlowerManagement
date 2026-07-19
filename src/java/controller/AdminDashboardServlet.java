package controller;

import dao.OrderDAO;
import dao.FlowerDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// 1. Đổi URL thành /adminDashboard để không bao giờ bị trùng với thư mục vật lý
@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/adminDashboard"})
public class AdminDashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OrderDAO orderDAO = new OrderDAO();
        request.setAttribute("totalCustomers", orderDAO.getTotalCustomers());
        request.setAttribute("monthlyRev", orderDAO.getMonthlyRevenue());
        request.setAttribute("monthlyOrders", orderDAO.getMonthlyTotalOrders());
        request.setAttribute("lowStock", new FlowerDAO().getLowStockFlowers());
        
        // Cố gắng gọi UserDAO, nếu bạn chưa code phần logs thì nó có thể bỏ qua
// Update the try-catch block inside the doGet method:
        try {
            request.setAttribute("logs", new UserDAO().getRecentLogs());
            request.setAttribute("orderLogs", new UserDAO().getOrderLogs());
        } catch (Exception e) { 
            e.printStackTrace(); 
        }
        
        // 2. Trỏ đường dẫn tuyệt đối vào thư mục admin chứa file jsp
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}