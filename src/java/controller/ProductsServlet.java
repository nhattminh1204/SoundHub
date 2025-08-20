
package controller;

import data.dao.Database;
import data.impl.CartItemImpl;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Product;
import model.Category;
import model.User;

@WebServlet(name = "ProductServlet", urlPatterns = {"/products"})
public class ProductsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("title", "SoundHub - Sản phẩm");

        List<Category> listCate = Database.getCategoryDAO().findAll();
        request.setAttribute("listCate", listCate);

        List<Product> products = Database.getProductDAO().findAll();
        request.setAttribute("products", products);

        // Category filter
        String categoryParam = request.getParameter("category");
        String idCategoryParam = request.getParameter("idCategory");

        if (categoryParam != null && !categoryParam.isEmpty()) {
            List<Product> filteredProducts = ((data.impl.ProductImpl) Database.getProductDAO()).findByCategory(categoryParam);
            request.setAttribute("products", filteredProducts);
            request.setAttribute("selectedCategory", categoryParam);
        } else if (idCategoryParam != null && !idCategoryParam.isEmpty()) {
            Integer idCategory = Integer.parseInt(idCategoryParam);
            request.setAttribute("idCategory", idCategory);
        }

        addProductToCart(request);

        request.getRequestDispatcher("./views/products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    void addProductToCart(HttpServletRequest request) {
        int id_product;
        try {
            id_product = Integer.parseInt(request.getParameter("id_product"));
        } catch (Exception e) {
            id_product = 0;
        }

        // Get user from session
        User user = (User) request.getSession().getAttribute("user");

        if (id_product > 0 && user != null) {
            // Add to database cart
            CartItemImpl cartDAO = new CartItemImpl();
            cartDAO.addToCart(user.getId(), id_product, 1);
        }
    }
}
