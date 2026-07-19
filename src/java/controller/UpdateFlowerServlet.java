package controller;

import dao.FlowerDAO;
import model.Flower;
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

@WebServlet(name = "UpdateFlowerServlet", urlPatterns = {"/updateFlower"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class UpdateFlowerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idRaw = request.getParameter("id");
        if (idRaw != null) {
            try {
                int id = Integer.parseInt(idRaw);
                FlowerDAO dao = new FlowerDAO();
                Flower f = dao.getFlowerById(id);
                
                if (f != null) {
                    request.setAttribute("flower", f);
                    request.getRequestDispatcher("update.jsp").forward(request, response);
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("manageFlower?error=true");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("flowerId"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String status = request.getParameter("status");
            String catIdStr = request.getParameter("categoryId");
            String qtyStr = request.getParameter("quantity");
            int categoryId = (catIdStr != null && !catIdStr.isEmpty()) ? Integer.parseInt(catIdStr) : 0;
            int quantity = (qtyStr != null && !qtyStr.isEmpty()) ? Integer.parseInt(qtyStr) : 0;

            String imageURL = request.getParameter("oldImageURL");

Part filePart = request.getPart("imageFile");
if (filePart != null && filePart.getSize() > 0) {
    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
    
    String uploadPath = "C:\\Users\\Trungfl2912\\Documents\\NetBeansProjects\\FlowerManagement\\web\\assets"; 
    
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) uploadDir.mkdir();
    
    filePart.write(uploadPath + File.separator + fileName);
    imageURL = fileName;
}

            Flower flower = new Flower(id, name, categoryId, description, price, quantity, status, imageURL);
            FlowerDAO dao = new FlowerDAO();
            dao.updateFlower(flower);
            
            response.sendRedirect("manageFlower");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manageFlower?error=true");
        }
    }
}