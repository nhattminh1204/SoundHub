package data.dao;

import java.util.List;
import model.Product;

public interface ProductDAO {
    public List<Product> findAll();
    public Product search(int idProduct);
    public boolean insert(String name, String image, double price, int quantity, boolean status, int categoryId);
    public boolean update(int id, String name, String image, double price, int quantity, boolean status, int categoryId);
    public boolean delete(int id);
    public List<Product> findByCategory(String category);
    public List<Product> findByCategoryId(int categoryId);
    public List<Product> searchByKeyword(String keyword);
    public boolean deleteByCategoryId(int categoryId);
}
