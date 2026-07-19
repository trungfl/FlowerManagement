package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"}, dispatcherTypes = {jakarta.servlet.DispatcherType.REQUEST})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String path = req.getServletPath();

        // 1. Cho phép chuỗi rỗng "", trang chủ, các file jsp công khai, tài nguyên tĩnh và thư mục ASSETS
        if (path.isEmpty() || path.equals("/") || 
            path.equals("/home") || path.equals("/home.jsp") || 
            path.equals("/login") || path.equals("/login.jsp") || 
            path.equals("/register") || path.equals("/register.jsp") || 
            path.startsWith("/css/") || path.startsWith("/js/") || 
            path.startsWith("/images/") || path.startsWith("/assets/")) { // <--- Đã thêm /assets/ ở đây
            
            chain.doFilter(request, response);
            return;
        }

        // 2. Chặn các trang yêu cầu quyền (giỏ hàng, admin, manageOrders...)
        Object user = req.getSession().getAttribute("user");
        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/login");
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
    }
}