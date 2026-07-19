package controller;

import dao.FlowerDAO;
import dao.UserDAO;
import model.Flower;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "POSServlet", urlPatterns = {"/pos"})
public class POSServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FlowerDAO dao = new FlowerDAO();
        List<Flower> availableFlowers = dao.searchFlowers("", 1, 100);
        request.setAttribute("flowerList", availableFlowers);
        request.getRequestDispatcher("pos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Nhận chế độ giao dịch từ giao diện (IMPORT hoặc EXPORT)
        String mode = request.getParameter("transactionMode"); 
        String[] flowerIds = request.getParameterValues("flowerId");
        String[] quantities = request.getParameterValues("qty");
        
        if (flowerIds != null && quantities != null) {
            FlowerDAO flowerDAO = new FlowerDAO();
            User currentUser = (User) request.getSession().getAttribute("user");
            
            for (int i = 0; i < flowerIds.length; i++) {
                int id = Integer.parseInt(flowerIds[i]);
                int qty = Integer.parseInt(quantities[i]);
                
                if (qty > 0) {
                    if ("IMPORT".equals(mode)) {
                        flowerDAO.addQuantity(id, qty);
                        if (currentUser != null) {
                            new UserDAO().saveLog(currentUser.getUsername(), "POS Import: Added " + qty + " to Flower ID " + id);
                        }
                    } else { // Mặc định là EXPORT (Bán hàng)
                        flowerDAO.deductQuantity(id, qty);
                        if (currentUser != null) {
                            new UserDAO().saveLog(currentUser.getUsername(), "POS Sale: Deducted " + qty + " of Flower ID " + id);
                        }
                    }
                }
            }
        }
        // Gửi kèm mode lên URL để hiển thị thông báo đúng trên giao diện
        response.sendRedirect("pos?success=true&mode=" + mode);
    }
}