package data.dao;

import model.Order;
import model.OrderItem;
import java.util.List;

public interface OrderDAO {
    
    // Create new order and return order ID
    int createOrder(Order order);
    
    // Add items to order
    void addOrderItems(int orderId, List<OrderItem> items);
    
    // Get order by ID
    Order getOrderById(int orderId);
    
    // Get orders by user ID
    List<Order> getOrdersByUserId(int userId);
    
    // Get order items by order ID
    List<OrderItem> getOrderItemsByOrderId(int orderId);
    
    // Update order status
    void updateOrderStatus(int orderId, String status);
    
    // Get all orders (for admin)
    List<Order> getAllOrders();
}