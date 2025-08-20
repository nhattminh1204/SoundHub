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

@WebServlet(name = "OrderHistoryServlet", urlPatterns = {"/order-history"})
public class OrderHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Get user's orders
        List<Order> orders = Database.getOrderDAO().getOrdersByUserId(user.getId());
        
        // Load order items for each order
        for (Order order : orders) {
            order.setOrderItems(Database.getOrderDAO().getOrderItemsByOrderId(order.getId()));
        }
        
        request.setAttribute("orders", orders);
        request.setAttribute("title", "Lịch sử đơn hàng");
        request.getRequestDispatcher("/views/order-history.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        
        String action = request.getParameter("action");
        String orderIdStr = request.getParameter("orderId");
        
        if ("cancel".equals(action) && orderIdStr != null) {
            try {
                int orderId = Integer.parseInt(orderIdStr);
                
                // Check if order belongs to user
                Order order = Database.getOrderDAO().getOrderById(orderId);
                if (order != null && order.getUserId() == user.getId() && 
                    ("pending".equals(order.getStatus()) || "confirmed".equals(order.getStatus()))) {
                    
                    Database.getOrderDAO().updateOrderStatus(orderId, "cancelled");
                    session.setAttribute("order_success", "Hủy đơn hàng thành công");
                } else {
                    session.setAttribute("order_error", "Không thể hủy đơn hàng này");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("order_error", "ID đơn hàng không hợp lệ");
            }
        }
        
        response.sendRedirect("order-history");
    }
}