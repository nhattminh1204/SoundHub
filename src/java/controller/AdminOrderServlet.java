package controller;

import data.dao.Database;
import model.Order;
import model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminOrderServlet", urlPatterns = {"/admin-orders"})
public class AdminOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }
        
        // Get all orders
        List<Order> orders = Database.getOrderDAO().getAllOrders();
        
        // Load order items for each order
        for (Order order : orders) {
            order.setOrderItems(Database.getOrderDAO().getOrderItemsByOrderId(order.getId()));
        }
        
        request.setAttribute("orders", orders);
        request.setAttribute("title", "Quản lý đơn hàng");
        request.getRequestDispatcher("/views/admin/admin-orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }
        
        String action = request.getParameter("action");
        String orderIdStr = request.getParameter("orderId");
        
        if ("updateStatus".equals(action) && orderIdStr != null) {
            try {
                int orderId = Integer.parseInt(orderIdStr);
                String newStatus = request.getParameter("status");
                
                Database.getOrderDAO().updateOrderStatus(orderId, newStatus);
                
                session.setAttribute("admin_success", "Cập nhật trạng thái đơn hàng thành công");
            } catch (NumberFormatException e) {
                session.setAttribute("admin_error", "ID đơn hàng không hợp lệ");
            }
        }
        
        response.sendRedirect("admin-orders");
    }
}