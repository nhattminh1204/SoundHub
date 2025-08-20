package controller;

import data.dao.Database;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import model.Category;
import model.User;

@WebServlet(name = "ProductServlet", urlPatterns = {"/products"})
public class ProductsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("title", "SoundHub - Sản phẩm");

        // Lấy ra tất cả danh mục
        List<Category> listCate = Database.getCategoryDAO().findAll();
        request.setAttribute("listCate", listCate);
        
        // Lấy ra tất cả sản phẩm
        List<Product> products = Database.getProductDAO().findAll();
        request.setAttribute("products", products);

        // Nhận dữ liệu idCategory (tìm sản phẩm theo danh mục)
        String idCategoryParam = request.getParameter("idCategory");

        // Nếu idcate có giá trị
        if (idCategoryParam != null && !idCategoryParam.isEmpty()) {
            Integer idCategory = Integer.parseInt(idCategoryParam);
            
            // Tìm kiếm sản phẩm theo danh mục
            List<Product> filteredProducts = Database.getProductDAO().findByCategoryId(idCategory);
            
            // Lưu danh sách sản phẩm đã lọc và idCategory
            request.setAttribute("products", filteredProducts);
            request.setAttribute("idCategory", idCategory);
        }

        // Thêm vào giỏ hàng
        addProductToCart(request);

        request.getRequestDispatcher("./views/products.jsp").include(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    void addProductToCart(HttpServletRequest request) {
        // Nhận dữ liệu id_product được truyền vào
        int id_product;
        try {
            id_product = Integer.parseInt(request.getParameter("id_product"));
        } catch (Exception e) {
            id_product = 0;
        }

        // Lấy user hiện tại
        User user = (User) request.getSession().getAttribute("user");

        // Nếu id_product thỏa mãn và đã đăng nhập
        if (id_product > 0 && user != null) {
            // Thêm sản phẩm vào giỏ hàng
            Database.getCartItemDAO().addToCart(user.getId(), id_product, 1);
        }
    }
}
