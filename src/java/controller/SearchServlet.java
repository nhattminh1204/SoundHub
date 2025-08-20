/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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

@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("title", "SoundHub - Tìm kiếm");
        
        // Nhận dữ liệu keyword
        String keyword = request.getParameter("keyword");
        
        // Nếu keyword có dữ liệu
        if (keyword != null && !keyword.trim().isEmpty()) {
            // Tìm kiếm danh sách sản phẩm theo keyword
            List<Product> searchResults = Database.getProductDAO().searchByKeyword(keyword);
            
            // Lưu các dữ liệu liên quan
            request.setAttribute("products", searchResults);
            request.setAttribute("keyword", keyword);
            request.setAttribute("resultCount", searchResults.size());
            
            request.getRequestDispatcher("./views/search-results.jsp").include(request, response);
        } else {
            response.sendRedirect("products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
} 