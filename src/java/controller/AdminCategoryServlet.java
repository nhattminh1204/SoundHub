package controller;

import data.dao.Database;
import model.Category;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminCategoryServlet", urlPatterns = {"/admin-categories"})
public class AdminCategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            request.setAttribute("title", "Thêm danh mục");
            request.getRequestDispatcher("/views/admin/add-category.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Category category = Database.getCategoryDAO().findById(id);
            request.setAttribute("category", category);
            request.setAttribute("title", "Sửa danh mục");
            request.getRequestDispatcher("/views/admin/edit-category.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Category category = Database.getCategoryDAO().findById(id);
            List<model.Product> products = Database.getProductDAO().findByCategoryId(id);
            
            if (!products.isEmpty()) {
                request.setAttribute("category", category);
                request.setAttribute("products", products);
                request.setAttribute("title", "Xác nhận xóa danh mục");
                request.getRequestDispatcher("/views/admin/confirm-delete-category.jsp").forward(request, response);
            } else {
                boolean success = Database.getCategoryDAO().delete(id);
                response.sendRedirect("admin-categories?success=" + (success ? "delete" : "error"));
            }
        } else {
            List<Category> categories = Database.getCategoryDAO().findAll();
            request.setAttribute("categories", categories);
            request.setAttribute("title", "Quản lý danh mục");
            request.getRequestDispatcher("/views/admin/category-list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String name = request.getParameter("name");
        
        if ("add".equals(action)) {
            Database.getCategoryDAO().insert(name);
            response.sendRedirect("admin-categories?success=add");
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Database.getCategoryDAO().update(id, name);
            response.sendRedirect("admin-categories?success=edit");
        } else if ("confirm_delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            // Xóa tất cả sản phẩm trong danh mục
            Database.getProductDAO().deleteByCategoryId(id);
            // Xóa danh mục
            boolean success = Database.getCategoryDAO().delete(id);
            response.sendRedirect("admin-categories?success=" + (success ? "delete" : "error"));
        }
    }
}