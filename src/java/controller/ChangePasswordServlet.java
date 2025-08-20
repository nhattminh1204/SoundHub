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

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/change-password"})
public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        
        request.setAttribute("title", "Đổi mật khẩu");
        request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmNewPassword");
        
        User currentUser = (User) request.getSession().getAttribute("user");
        
        if (!currentUser.getPassword().equals(currentPassword)) {
            response.sendRedirect("change-password?error=current");
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect("change-password?error=confirm");
            return;
        }
        
        String passwordError = ValidationUtils.getPasswordError(newPassword);
        if (passwordError != null) {
            response.sendRedirect("change-password?error=invalid");
            return;
        }
        
        try {
            Database.getUserDAO().updatePassword(currentUser.getId(), newPassword);
            
            // Cập nhật session user
            currentUser.setPassword(newPassword);
            request.getSession().setAttribute("user", currentUser);
            
            response.sendRedirect("change-password?success=password");
        } catch (Exception e) {
            response.sendRedirect("change-password?error=system");
        }
    }
}