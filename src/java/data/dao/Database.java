package data.dao;

import data.impl.CartItemImpl;
import data.impl.CategoryImpl;
import data.impl.OrderImpl;
import data.impl.ProductImpl;
import data.impl.UserImpl;

public class Database {
    public static CategoryDAO getCategoryDAO() {
        return new CategoryImpl();
    }
    
    public static ProductDAO getProductDAO() {
        return new ProductImpl();
    }
    
    public static OrderDAO getOrderDAO() {
        return new OrderImpl();
    }
    
    public static UserDAO getUserDAO() {
        return new UserImpl();
    }
    
    public static CartItemDAO getCartItemDAO() {
        return new CartItemImpl();
    }
}
