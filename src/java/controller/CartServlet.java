package controller;

import dao.FlowerDAO;
import model.CartItem;
import model.Flower;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Kiểm tra đăng nhập
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");

        // Logic thêm sản phẩm
        if ("add".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                
                // Lấy giỏ hàng từ session, ép kiểu về Map<Integer, CartItem>
                Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
                if (cart == null) {
                    cart = new HashMap<>();
                }
                
                if (cart.containsKey(id)) {
                    // Nếu hoa đã có trong giỏ, tăng số lượng
                    CartItem item = cart.get(id);
                    item.setQuantity(item.getQuantity() + 1);
                } else {
                    // Nếu chưa có, lấy hoa từ DB và tạo CartItem mới
                    FlowerDAO dao = new FlowerDAO();
                    Flower f = dao.getFlowerById(id);
                    if (f != null) {
                        cart.put(id, new CartItem(f, 1));
                    }
                }
                
                // Lưu lại Map đã cập nhật vào Session
                session.setAttribute("cart", cart);
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect("cart");
            return;
        }

        // Nếu chỉ là truy cập trang giỏ hàng
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}