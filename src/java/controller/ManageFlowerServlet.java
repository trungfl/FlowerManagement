package controller;

import dao.FlowerDAO;
import model.Flower;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManageFlowerServlet", urlPatterns = {"/manageFlower"})
public class ManageFlowerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String keyword = request.getParameter("search");
        if (keyword == null) keyword = "";
        
        FlowerDAO dao = new FlowerDAO();
        List<Flower> list = dao.searchFlowers(keyword, 1, 100); 
        
        request.setAttribute("flowerList", list);
        // TRỎ CHÍNH XÁC VÀO THƯ MỤC EMPLOYEE THEO ẢNH CỦA BẠN
        request.getRequestDispatcher("employee/list-flower.jsp").forward(request, response);
    }
}