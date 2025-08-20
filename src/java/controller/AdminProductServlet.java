package controller;

import data.impl.ProductImpl;
import data.impl.CategoryImpl;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.Part;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import model.Category;

@WebServlet(name = "AdminProductServlet", urlPatterns = {"/admin-products"})
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // 5MB
public class AdminProductServlet extends HttpServlet {

    private ProductImpl productDAO = new ProductImpl();
    private CategoryImpl categoryDAO = new CategoryImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        List<Category> categories = categoryDAO.findAll();
        
        if ("add".equals(action)) {
            request.setAttribute("categories", categories);
            request.setAttribute("title", "SoundHub - Thêm sản phẩm");
            request.getRequestDispatcher("/views/admin/add-product.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = productDAO.search(id);
            request.setAttribute("product", product);
            request.setAttribute("categories", categories);
            request.setAttribute("title", "SoundHub - Sửa sản phẩm");
            request.getRequestDispatcher("/views/admin/edit-product.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean success = productDAO.delete(id);
            
            if (success) {
                response.sendRedirect("admin-products?success=delete");
            } else {
                response.sendRedirect("admin-products?error=delete");
            }
        } else {
            List<Product> products = productDAO.findAll();
            request.setAttribute("products", products);
            request.setAttribute("categories", categories);
            request.setAttribute("title", "SoundHub - Quản lý sản phẩm");
            request.getRequestDispatcher("/views/admin/product-list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            try {
                String name = request.getParameter("name");
                String priceStr = request.getParameter("price");
                String quantityStr = request.getParameter("quantity");
                String categoryIdStr = request.getParameter("categoryId");
                boolean status = "true".equals(request.getParameter("status"));
                
                // Validation
                boolean hasError = false;
                
                if (name == null || name.trim().isEmpty()) {
                    request.getSession().setAttribute("err_name", "Tên sản phẩm không được để trống");
                    hasError = true;
                }
                
                double price = 0;
                try {
                    price = Double.parseDouble(priceStr);
                    if (price <= 0) {
                        request.getSession().setAttribute("err_price", "Giá phải lớn hơn 0");
                        hasError = true;
                    }
                } catch (NumberFormatException e) {
                    request.getSession().setAttribute("err_price", "Giá phải là số");
                    hasError = true;
                }
                
                int quantity = 0;
                try {
                    quantity = Integer.parseInt(quantityStr);
                    if (quantity < 0) {
                        request.getSession().setAttribute("err_quantity", "Số lượng không được âm");
                        hasError = true;
                    }
                } catch (NumberFormatException e) {
                    request.getSession().setAttribute("err_quantity", "Số lượng phải là số nguyên");
                    hasError = true;
                }
                
                int categoryId = 0;
                try {
                    categoryId = Integer.parseInt(categoryIdStr);
                } catch (NumberFormatException e) {
                    request.getSession().setAttribute("err_category", "Vui lòng chọn danh mục");
                    hasError = true;
                }
                
                if (hasError) {
                    // Lưu dữ liệu đã nhập
                    request.getSession().setAttribute("form_name", name);
                    request.getSession().setAttribute("form_price", priceStr);
                    request.getSession().setAttribute("form_quantity", quantityStr);
                    request.getSession().setAttribute("form_categoryId", categoryIdStr);
                    response.sendRedirect("admin-products?action=add&error=validation");
                    return;
                }
                
                // Xử lý upload file
                Part filePart = request.getPart("image");
                String fileName = "default.jpg";
                
                if (filePart != null && filePart.getSize() > 0) {
                    String originalFileName = filePart.getSubmittedFileName();
                    String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                    fileName = System.currentTimeMillis() + fileExtension;
                    
                    String uploadPath = getServletContext().getRealPath("/assets/img/");
                    java.io.File uploadDir = new java.io.File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdirs();
                    
                    filePart.write(uploadPath + fileName);
                }
                
                boolean success = productDAO.insert(name, fileName, price, quantity, status, categoryId);
                
                if (success) {
                    // Xóa dữ liệu form cũ
                    request.getSession().removeAttribute("form_name");
                    request.getSession().removeAttribute("form_price");
                    request.getSession().removeAttribute("form_quantity");
                    request.getSession().removeAttribute("form_categoryId");
                    response.sendRedirect("admin-products?success=add");
                } else {
                    request.getSession().setAttribute("product_error", "Thêm sản phẩm thất bại");
                    response.sendRedirect("admin-products?action=add&error=add");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("admin-products?error=invalid");
            }
        } else if ("edit".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                boolean status = "true".equals(request.getParameter("status"));
                
                // Lấy ảnh cũ
                Product oldProduct = productDAO.search(id);
                String fileName = oldProduct.getImage();
                
                // Xử lý upload file mới nếu có
                Part filePart = request.getPart("image");
                if (filePart != null && filePart.getSize() > 0) {
                    String originalFileName = filePart.getSubmittedFileName();
                    String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                    fileName = System.currentTimeMillis() + fileExtension;
                    
                    String uploadPath = getServletContext().getRealPath("/assets/img/");
                    filePart.write(uploadPath + fileName);
                }
                
                boolean success = productDAO.update(id, name, fileName, price, quantity, status, categoryId);
                
                if (success) {
                    response.sendRedirect("admin-products?success=edit");
                } else {
                    response.sendRedirect("admin-products?error=edit");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("admin-products?error=invalid");
            }
        }
    }
}