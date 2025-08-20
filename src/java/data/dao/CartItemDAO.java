package data.dao;

import java.util.List;
import model.Cart;

public interface CartItemDAO {
    void addToCart(int userId, int productId, int quantity);
    List<Cart> getCartItems(int userId);
    void updateQuantity(int userId, int productId, int quantity);
    void removeFromCart(int userId, int productId);
    void clearCart(int userId);
}