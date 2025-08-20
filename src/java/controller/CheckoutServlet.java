package controller;

import data.dao.Database;
import model.Cart;
import model.Order;
import model.OrderItem;
import model.User;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        
        List<Cart> cartItems = Database.getCartItemDAO().getCartItems(user.getId());
        
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }
        
        BigDecimal subtotal = BigDecimal.ZERO;
        for (Cart item : cartItems) {
            BigDecimal itemTotal = BigDecimal.valueOf(item.getProduct().getPrice()).multiply(BigDecimal.valueOf(item.getQuantity()));
            subtotal = subtotal.add(itemTotal);
        }
        
        BigDecimal shippingFee = BigDecimal.valueOf(30000);
        BigDecimal total = subtotal.add(shippingFee);
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("shippingFee", shippingFee);
        request.setAttribute("total", total);
        request.setAttribute("title", "Thanh toán");
        
        request.getRequestDispatcher("/views/checkout.jsp").forward(request, response);
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
      
        List<Cart> cartItems = Database.getCartItemDAO().getCartItems(user.getId());
        
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }
        
        String shippingAddress = request.getParameter("address");
        String phone = request.getParameter("phone");
        String paymentMethod = request.getParameter("payment");
        
        if (shippingAddress == null || shippingAddress.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            paymentMethod == null || paymentMethod.trim().isEmpty()) {
            
            session.setAttribute("checkout_error", "Vui lòng điền đầy đủ thông tin");
            response.sendRedirect("checkout");
            return;
        }
        
        try {
            BigDecimal subtotal = BigDecimal.ZERO;
            List<OrderItem> orderItems = new ArrayList<>();
            
            for (Cart cartItem : cartItems) {
                OrderItem item = new OrderItem(0, cartItem.getProduct().getId(), cartItem.getQuantity(), 
                                             BigDecimal.valueOf(cartItem.getProduct().getPrice()));
                orderItems.add(item);
                
                BigDecimal itemTotal = BigDecimal.valueOf(cartItem.getProduct().getPrice())
                                     .multiply(BigDecimal.valueOf(cartItem.getQuantity()));
                subtotal = subtotal.add(itemTotal);
            }
            
            BigDecimal shippingFee = BigDecimal.valueOf(30000);
            BigDecimal total = subtotal.add(shippingFee);
            
            Order order = new Order(user.getId(), total, shippingFee, paymentMethod, shippingAddress, phone);
            int orderId = Database.getOrderDAO().createOrder(order);
            
            if (orderId > 0) {
                Database.getOrderDAO().addOrderItems(orderId, orderItems);
                
                Database.getCartItemDAO().clearCart(user.getId());
                
                // Redirect to success page
                response.sendRedirect("order-success?id=" + orderId);
            } else {
                session.setAttribute("checkout_error", "Có lỗi xảy ra khi tạo đơn hàng");
                response.sendRedirect("checkout");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("checkout_error", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect("checkout");
        }
    }
}