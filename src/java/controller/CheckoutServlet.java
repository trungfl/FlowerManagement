package controller;

import dao.FlowerDAO;
import dao.OrderDAO;
import model.CartItem;
import model.Order;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String payment = request.getParameter("paymentMethod");

        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");
        
        if (cart != null && !cart.isEmpty() && user != null) {
            double total = 0;
            // Đã sửa item.quantity thành item.getQuantity()
            for (CartItem item : cart.values()) total += item.getFlower().getPrice() * item.getQuantity();
            
            OrderDAO orderDAO = new OrderDAO();
            Order newOrder = new Order(0, user.getUsername(), name, phone, address, payment, total, null, "Processing");
            int orderId = orderDAO.createOrder(newOrder);
            
            if(orderId > 0) {
                FlowerDAO flowerDAO = new FlowerDAO();
                for (CartItem item : cart.values()) {
                    orderDAO.createOrderDetail(orderId, item.getFlower().getFlowerId(), item.getQuantity(), item.getFlower().getPrice());
                    flowerDAO.deductQuantity(item.getFlower().getFlowerId(), item.getQuantity());
                }
                session.removeAttribute("cart");
                response.sendRedirect("orderHistory"); 
                return;
            }
        }
        response.sendRedirect("cart.jsp");
    }
}