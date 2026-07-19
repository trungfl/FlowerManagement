package controller;

import dao.FlowerDAO;
import dao.UserDAO;
import model.Flower;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@MultipartConfig(maxFileSize = 1024 * 1024 * 2) 
@WebServlet(name = "AddFlowerServlet", urlPatterns = {"/addFlower"})
public class AddFlowerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("add-flower.jsp").forward(request, response);
    }

@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            // Fix lỗi đỏ: Chuyển đổi checkbox sang String status
String status = request.getParameter("status");

            jakarta.servlet.http.Part filePart = request.getPart("imageFile");
            String fileName = java.nio.file.Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + java.io.File.separator + "assets";
            java.io.File uploadDir = new java.io.File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();
            filePart.write(uploadPath + java.io.File.separator + fileName);

            // Đã truyền đúng String status
            Flower newFlower = new Flower(0, name, categoryId, description, price, quantity, status, fileName);
            boolean success = new dao.FlowerDAO().addFlower(newFlower);

            response.sendRedirect("manageFlower");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("add-flower.jsp?error=true");
        }
    }
}