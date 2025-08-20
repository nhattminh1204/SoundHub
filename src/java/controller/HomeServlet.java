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
import java.util.ArrayList;
import model.Category;
import model.Product;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home", ""})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("title", "SoundHub - Trang chủ");
        
        List<Category> listCate = Database.getCategoryDAO().findAll();
        request.setAttribute("listCate", listCate);
        
        List<Product> allProducts = Database.getProductDAO().findAll();
        request.setAttribute("allProducts", allProducts);
        
        List<Product> bluetoothProducts = ((data.impl.ProductImpl) Database.getProductDAO()).findByCategory("truewireless");
        List<Product> wiredProducts = ((data.impl.ProductImpl) Database.getProductDAO()).findByCategory("coday");
        List<Product> speakerProducts = ((data.impl.ProductImpl) Database.getProductDAO()).findByCategory("chuptai");
        
        request.setAttribute("bluetoothProducts", bluetoothProducts.subList(0, Math.min(4, bluetoothProducts.size())));
        request.setAttribute("wiredProducts", wiredProducts.subList(0, Math.min(4, wiredProducts.size())));
        request.setAttribute("speakerProducts", speakerProducts.subList(0, Math.min(4, speakerProducts.size())));
        
        String id_category = (String) request.getParameter("id_category");
        request.setAttribute("id_category", id_category);
        
        request.getRequestDispatcher("./views/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
    
}
