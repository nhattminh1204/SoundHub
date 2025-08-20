package data.impl;

import data.dao.CategoryDAO;
import data.dao.ProductDAO;
import data.driver.MySQLDriver;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;

public class ProductImpl implements ProductDAO {
    Connection con = MySQLDriver.getConnection();
    
    @Override
    public List<Product> findAll() {
        List<Product> listProduct = new ArrayList<>();
        try {
            String sql = "SELECT * FROM products";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String image = rs.getString("image");
                double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                boolean status = rs.getBoolean("status");
                int categoryId = rs.getInt("category_id");
                
                listProduct.add(new Product(id, name, image, price, quantity, status, categoryId));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoryImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listProduct;
    }

    @Override
    public Product search(int idProduct) {
        String sql = "SELECT * FROM products WHERE id='" + idProduct + "'";
        PreparedStatement ps;
        try {
            ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String image = rs.getString("image");
                double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                boolean status = rs.getBoolean("status");
                int categoryId = rs.getInt("category_id");
                
                return new Product(id, name, image, price, quantity, status, categoryId);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public boolean insert(String name, String image, double price, int quantity, boolean status, int categoryId) {
        try {
            String sql = "INSERT INTO products (name, image, price, quantity, status, category_id) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, image);
            ps.setDouble(3, price);
            ps.setInt(4, quantity);
            ps.setBoolean(5, status);
            ps.setInt(6, categoryId);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    @Override
    public boolean update(int id, String name, String image, double price, int quantity, boolean status, int categoryId) {
        try {
            String sql = "UPDATE products SET name=?, image=?, price=?, quantity=?, status=?, category_id=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, image);
            ps.setDouble(3, price);
            ps.setInt(4, quantity);
            ps.setBoolean(5, status);
            ps.setInt(6, categoryId);
            ps.setInt(7, id);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    @Override
    public boolean delete(int id) {
        try {
            String sql = "DELETE FROM products WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    @Override
    public List<Product> findByCategoryId(int categoryId) {
        List<Product> listProduct = new ArrayList<>();
        
        try {
            String sql = "SELECT * FROM products WHERE category_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String image = rs.getString("image");
                double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                boolean status = rs.getBoolean("status");
                int catId = rs.getInt("category_id");
                
                listProduct.add(new Product(id, name, image, price, quantity, status, catId));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listProduct;
    }
    
    @Override
    public List<Product> searchByKeyword(String keyword) {
        // Tạo  danh sách rỗng
        List<Product> listProduct = new ArrayList<>();
        
        // Truy vấn câu lệnh
        try {
            String sql = "SELECT * FROM products WHERE name LIKE ? AND status = 1";
            PreparedStatement ps = con.prepareStatement(sql);
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ResultSet rs = ps.executeQuery();
            
            // Duyệt qua từng dòng kết quả
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String image = rs.getString("image");
                double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                boolean status = rs.getBoolean("status");
                int categoryId = rs.getInt("category_id");
                
                // Thêm sản phẩm vào danh sách
                listProduct.add(new Product(id, name, image, price, quantity, status, categoryId));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listProduct;
    }
    
    @Override
    public boolean deleteByCategoryId(int categoryId) {
        try {
            String sql = "DELETE FROM products WHERE category_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, categoryId);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
}
