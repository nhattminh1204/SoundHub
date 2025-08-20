package controller;

import data.dao.Database;
import model.Cart;
import model.Product;
import model.User;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        User user = (User) request.getSession().getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Lấy ra giỏ hàng theo user
        List<Cart> cartItems = getCartItems(user);
        double total = cartItems.stream().mapToDouble(Cart::getSubTotal).sum();
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("total", total);
        request.setAttribute("title", "SoundHub - Giỏ hàng");
        request.getRequestDispatcher("/views/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy dữ liệu action ()
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        if ("remove".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            removeFromCart(session, productId);
            response.sendRedirect("cart");
            
        } else if ("update".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            updateCart(session, productId, quantity);
            response.sendRedirect("cart");
            
        }
    }
    
    private List<Cart> getCartItems(User user) {
        if (user != null) {
            return Database.getCartItemDAO().getCartItems(user.getId());
        }
        return new ArrayList<>();
    }
    
    private void removeFromCart(HttpSession session, int productId) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            Database.getCartItemDAO().removeFromCart(user.getId(), productId);
        }
    }
    
    private void updateCart(HttpSession session, int productId, int quantity) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            if (quantity <= 0) {
                Database.getCartItemDAO().removeFromCart(user.getId(), productId);
            } else {
                Database.getCartItemDAO().updateQuantity(user.getId(), productId, quantity);
            }
        }
    }
}