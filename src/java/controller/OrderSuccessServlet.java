package controller;

import data.dao.Database;
import model.Order;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "OrderSuccessServlet", urlPatterns = {"/order-success"})
public class OrderSuccessServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        
        String orderIdStr = request.getParameter("id");
        if (orderIdStr == null) {
            response.sendRedirect("home");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdStr);
            Order order = Database.getOrderDAO().getOrderById(orderId);
            
            if (order == null || order.getUserId() != user.getId()) {
                response.sendRedirect("home");
                return;
            }
            
            request.setAttribute("order", order);
            request.setAttribute("title", "Đặt hàng thành công");
            request.getRequestDispatcher("/views/order-success.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("home");
        }
    }
}