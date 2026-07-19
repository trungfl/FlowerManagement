package controller;

import dao.OrderDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "OrderHistoryServlet", urlPatterns = {"/orderHistory"})
public class OrderHistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            request.setAttribute("orders", new OrderDAO().getOrdersByUsername(user.getUsername()));
            request.getRequestDispatcher("history.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("complete".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            dao.OrderDAO dao = new dao.OrderDAO();
            dao.markOrderCompleted(orderId);
            
            // Add a log for Admin to see the customer received it
            model.User user = (model.User) request.getSession().getAttribute("user");
            if(user != null) {
                new dao.UserDAO().addOrderLog(user.getUsername(), "Customer confirmed receiving order #" + orderId);
            }
        }
        response.sendRedirect("orderHistory");
    }
}