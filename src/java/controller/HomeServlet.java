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

@WebServlet(name = "HomeServlet", urlPatterns = {"/home", ""})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Lấy tham số tìm kiếm và phân trang
        String search = request.getParameter("search");
        if (search == null) search = "";
        
        String pageRaw = request.getParameter("page");
        int page = 1;
        try {
            if (pageRaw != null) page = Integer.parseInt(pageRaw);
        } catch (NumberFormatException e) { page = 1; }
        
        int pageSize = 9; // Giống với logic bạn đã chia cột trong JSP

        // 2. Gọi DAO lấy dữ liệu
        FlowerDAO dao = new FlowerDAO();
        List<Flower> list = dao.searchFlowers(search, page, pageSize);
        int totalItems = dao.countTotalFlowers(search);
        int endPage = (int) Math.ceil((double) totalItems / pageSize);

        // 3. Đẩy dữ liệu ra jsp
        request.setAttribute("flowerList", list);
        request.setAttribute("endPage", endPage);
        request.setAttribute("currentPage", page);
        request.setAttribute("searchKeyword", search);
        
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}