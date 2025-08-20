package data.dao;

import model.Category;
import java.util.List;

public interface CategoryDAO {
    List<Category> findAll();
    Category findById(int id);
    boolean insert(String name);
    boolean update(int id, String name);
    boolean delete(int id);
}