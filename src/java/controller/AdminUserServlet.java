package controller;

import data.impl.UserImpl;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

@WebServlet(name = "AdminUserServlet", urlPatterns = {"/admin-users"})
public class AdminUserServlet extends HttpServlet {

    private UserImpl userDAO = new UserImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean success = userDAO.delete(id);
            
            if (success) {
                response.sendRedirect("admin-users?success=delete");
            } else {
                response.sendRedirect("admin-users?error=delete");
            }
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            User user = userDAO.findById(id);
            request.setAttribute("user", user);
            request.setAttribute("title", "SoundHub - Sửa người dùng");
            request.getRequestDispatcher("/views/admin/edit-user.jsp").forward(request, response);
        } else {
            List<User> users = userDAO.findAll();
            request.setAttribute("users", users);
            request.setAttribute("title", "SoundHub - Quản lý người dùng");
            request.getRequestDispatcher("/views/admin/user-list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("role".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String currentRole = request.getParameter("currentRole");
            String newRole = "admin".equals(currentRole) ? "user" : "admin";
            boolean success = userDAO.updateRole(id, newRole);
            
            if (success) {
                response.sendRedirect("admin-users?success=edit");
            } else {
                response.sendRedirect("admin-users?error=edit");
            }
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String role = request.getParameter("role");
            String newPassword = request.getParameter("newPassword");
            
            User user = new User(id, name, email, phone, "", role);
            try {
                userDAO.updateUser(user);
                
                // Cập nhật mật khẩu nếu có
                if (newPassword != null && !newPassword.trim().isEmpty()) {
                    userDAO.updatePassword(id, newPassword);
                }
                
                response.sendRedirect("admin-users?success=edit");
            } catch (Exception e) {
                response.sendRedirect("admin-users?error=edit");
            }
        }
    }
}