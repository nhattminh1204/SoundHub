/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getSession().getAttribute("user") != null) {
            // Lưu cart trước khi xóa session
            Object cart = request.getSession().getAttribute("cart");
            
            // Xóa user và các attributes khác
            request.getSession().removeAttribute("user");
            request.getSession().removeAttribute("login_error");
            request.getSession().removeAttribute("profile_error");
            request.getSession().removeAttribute("profile_success");
            request.getSession().removeAttribute("password_error");
            request.getSession().removeAttribute("password_success");
            
            // Giữ lại cart
            if (cart != null) {
                request.getSession().setAttribute("cart", cart);
            }
        }
        response.sendRedirect("home");
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }


}
