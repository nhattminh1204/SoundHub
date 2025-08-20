/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import data.dao.Database;
import data.utils.ValidationUtils;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        String path = request.getServletPath();
        if ("/change-password".equals(path)) {
            request.setAttribute("title", "SoundHub - Đổi mật khẩu");
            request.getRequestDispatcher("./views/change-password.jsp").forward(request, response);
        } else {
            request.setAttribute("title", "SoundHub - Hồ sơ");
            request.getRequestDispatcher("./views/profile.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("update_profile".equals(action)) {
            updateProfile(request, response);
        } else if ("change_password".equals(action)) {
            changePassword(request, response);
        } else {
            response.sendRedirect("profile");
        }
    }
    
    private void updateProfile(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        
        if (name == null || name.trim().isEmpty()) {
            request.getSession().setAttribute("profile_error", "Tên không được để trống");
            response.sendRedirect("profile");
            return;
        }
        
        User currentUser = (User) request.getSession().getAttribute("user");
        
        currentUser.setName(name);
        currentUser.setEmail(email);
        currentUser.setPhone(phone);
        
        Database.getUserDAO().updateUser(currentUser);
        
        request.getSession().setAttribute("profile_success", "Cập nhật hồ sơ thành công");
        response.sendRedirect("profile");
    }
    
    private void changePassword(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmNewPassword");
        
        User currentUser = (User) request.getSession().getAttribute("user");
        
        if (!currentUser.getPassword().equals(currentPassword)) {
            request.getSession().setAttribute("password_error", "Mật khẩu hiện tại không đúng");
            response.sendRedirect("change-password");
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            request.getSession().setAttribute("password_error", "Mật khẩu mới và xác nhận mật khẩu không khớp");
            response.sendRedirect("change-password");
            return;
        }
        
        String passwordError = ValidationUtils.getPasswordError(newPassword);
        if (passwordError != null) {
            request.getSession().setAttribute("password_error", passwordError);
            response.sendRedirect("change-password");
            return;
        }
        
        currentUser.setPassword(newPassword);
        Database.getUserDAO().updatePassword(currentUser.getId(), newPassword);
        
        request.getSession().setAttribute("password_success", "Đổi mật khẩu thành công");
        response.sendRedirect("change-password");
    }
} 