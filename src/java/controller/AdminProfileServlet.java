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

@WebServlet(name = "AdminProfileServlet", urlPatterns = {"/admin-profile"})
public class AdminProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        User user = (User) session.getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }
        
        request.setAttribute("title", "SoundHub - Hồ sơ Admin");
        request.getRequestDispatcher("./views/admin/admin-profile.jsp").forward(request, response);
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
        
        String action = request.getParameter("action");
        
        if ("update_profile".equals(action)) {
            updateProfile(request, response);
        } else {
            response.sendRedirect("admin-profile");
        }
    }
    
    private void updateProfile(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        
        if (name == null || name.trim().isEmpty()) {
            request.getSession().setAttribute("profile_error", "Tên không được để trống");
            response.sendRedirect("admin-profile");
            return;
        }
        
        User currentUser = (User) request.getSession().getAttribute("user");
        
        currentUser.setName(name);
        currentUser.setEmail(email);
        currentUser.setPhone(phone);
        
        Database.getUserDAO().updateUser(currentUser);
        
        request.getSession().setAttribute("profile_success", "Cập nhật hồ sơ thành công");
        response.sendRedirect("admin-profile");
    }
}