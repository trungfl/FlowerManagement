package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng người dùng đến giao diện trang đăng nhập
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        String remember = request.getParameter("remember");

        UserDAO dao = new UserDAO();
        User account = dao.checkLogin(user, pass);

        if (account != null) {
            // Lưu Session (Giải quyết triệt để lỗi Header Issue 1)
            HttpSession session = request.getSession();
            session.setAttribute("user", account);

            // Xử lý Cookie (Issue 4)
            Cookie cUser = new Cookie("cUser", user);
            Cookie cPass = new Cookie("cPass", pass);
            
            // Xử lý chống lỗi null cho Cookie
            String remValue = (remember != null) ? remember : ""; 
            Cookie cRem = new Cookie("cRem", remValue);
            
            if (remember != null) {
                cUser.setMaxAge(60 * 60 * 24 * 7); // Lưu 7 ngày
                cPass.setMaxAge(60 * 60 * 24 * 7);
                cRem.setMaxAge(60 * 60 * 24 * 7);
            } else {
                cUser.setMaxAge(0);
                cPass.setMaxAge(0);
                cRem.setMaxAge(0);
            }
            response.addCookie(cUser);
            response.addCookie(cPass);
            response.addCookie(cRem);

            // Phân quyền chuyển trang
            if (account.getRoleID() == 1) {
                response.sendRedirect("admin/dashboard.jsp");
            } else if (account.getRoleID() == 2) {
                response.sendRedirect("manageFlower");
            } else {
                response.sendRedirect("home");
            }
        } else {
            request.setAttribute("error", "Invalid username or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}