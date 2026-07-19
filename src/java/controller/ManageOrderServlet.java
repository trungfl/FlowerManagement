package controller;

import dao.OrderDAO;
import model.Order;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ManageOrderServlet", urlPatterns = {"/manageOrders"})
public class ManageOrderServlet extends HttpServlet {
    
// Replace the doGet content with this to split the lists
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || user.getRoleID() != 2) { response.sendRedirect("home"); return; }
        
        OrderDAO dao = new OrderDAO();
        List<Order> allOrders = dao.getAllOrders();
        
        List<Order> activeOrders = new java.util.ArrayList<>();
        List<Order> completedOrders = new java.util.ArrayList<>();
        Map<Integer, String> detailsMap = new HashMap<>();
        
        for(Order o : allOrders) {
            detailsMap.put(o.getOrderId(), dao.getOrderItemsText(o.getOrderId()));
            if ("Completed".equals(o.getStatus())) {
                completedOrders.add(o);
            } else {
                activeOrders.add(o);
            }
        }
        
        request.setAttribute("activeOrders", activeOrders);
        request.setAttribute("completedOrders", completedOrders);
        request.setAttribute("detailsMap", detailsMap);
        request.getRequestDispatcher("employee/orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || user.getRoleID() != 2) return;

        String action = request.getParameter("action");
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        OrderDAO dao = new OrderDAO();

        if ("take".equals(action)) {
            dao.takeOrder(orderId, user.getUsername());
        } else if ("update".equals(action)) {
            String status = request.getParameter("status");
            dao.updateOrderStatusLogged(orderId, status, user.getUsername());
        }
        response.sendRedirect("manageOrders");
    }
}