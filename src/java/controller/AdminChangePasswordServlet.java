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

@WebServlet(name = "AdminChangePasswordServlet", urlPatterns = {"/admin-change-password"})
public class AdminChangePasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        User user = (User) session.getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }
        
        request.setAttribute("title", "SoundHub - Đổi mật khẩu Admin");
        request.getRequestDispatcher("./views/admin/admin-change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        User user = (User) session.getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }
        
        changePassword(request, response);
    }
    
    private void changePassword(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmNewPassword");
        
        User currentUser = (User) request.getSession().getAttribute("user");
        
        if (!currentUser.getPassword().equals(currentPassword)) {
            request.getSession().setAttribute("password_error", "Mật khẩu hiện tại không đúng");
            response.sendRedirect("admin-change-password");
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            request.getSession().setAttribute("password_error", "Mật khẩu mới và xác nhận mật khẩu không khớp");
            response.sendRedirect("admin-change-password");
            return;
        }
        
        String passwordError = ValidationUtils.getPasswordError(newPassword);
        if (passwordError != null) {
            request.getSession().setAttribute("password_error", passwordError);
            response.sendRedirect("admin-change-password");
            return;
        }
        
        currentUser.setPassword(newPassword);
        Database.getUserDAO().updatePassword(currentUser.getId(), newPassword);
        
        request.getSession().setAttribute("password_success", "Đổi mật khẩu thành công");
        response.sendRedirect("admin-change-password");
    }
}