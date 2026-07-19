package controller;

import dao.FlowerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DeleteFlowerServlet", urlPatterns = {"/deleteFlower"})
public class DeleteFlowerServlet extends HttpServlet {

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String idRaw = request.getParameter("id");
    if (idRaw != null) {
        try {
            int id = Integer.parseInt(idRaw);
            FlowerDAO dao = new FlowerDAO();
            dao.softDeleteFlower(id);
        } catch (Exception e) { e.printStackTrace(); }
    }
    response.sendRedirect("manageFlower");
}
}