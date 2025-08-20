package controller;

import data.impl.CartItemImpl;
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

    private CartItemImpl cartDAO = new CartItemImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login?error=session");
            return;
        }
        
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
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        if ("add".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            addToCart(session, productId, quantity);
            response.sendRedirect("cart?success=cart");
            
        } else if ("remove".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            removeFromCart(session, productId);
            response.sendRedirect("cart");
            
        } else if ("update".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            updateCart(session, productId, quantity);
            response.sendRedirect("cart");
            
        } else if ("clear".equals(action)) {
            clearCart(session);
            response.sendRedirect("cart?success=clear");
        }
    }
    
    private List<Cart> getCartItems(User user) {
        if (user != null) {
            return cartDAO.getCartItems(user.getId());
        }
        return new ArrayList<>();
    }
    
    private void addToCart(HttpSession session, int productId, int quantity) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            cartDAO.addToCart(user.getId(), productId, quantity);
        }
    }
    
    private void removeFromCart(HttpSession session, int productId) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            cartDAO.removeFromCart(user.getId(), productId);
        }
    }
    
    private void updateCart(HttpSession session, int productId, int quantity) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            if (quantity <= 0) {
                cartDAO.removeFromCart(user.getId(), productId);
            } else {
                cartDAO.updateQuantity(user.getId(), productId, quantity);
            }
        }
    }
    
    private void clearCart(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            cartDAO.clearCart(user.getId());
        }
    }
}