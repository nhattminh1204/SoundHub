/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import data.dao.Database;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException  {
        request.setAttribute("title", "SoundHub - Đăng nhập");
        request.getRequestDispatcher("./views/login.jsp").include(request, response);
    }

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Nhận 2 giá trị emailphone và password
        String emailphone = request.getParameter("emailphone");
        String password = request.getParameter("password");
        
        // Kiểm tra dữ liệu hợp lệ?
        
        if (emailphone == null || emailphone.trim().isEmpty()) {
            request.getSession().setAttribute("err_emailphone", "Vui lòng nhập email hoặc số điện thoại");
            response.sendRedirect("login");
            return;
        }
        
        if (password == null || password.trim().isEmpty()) {
            request.getSession().setAttribute("err_password", "Vui lòng nhập mật khẩu");
            response.sendRedirect("login");
            return;
        }
        
        // Kiểm tra trong DB check xem emailphone và password đã khớp hay chưa
        User user = Database.getUserDAO().find(emailphone, password);
        
        // Nếu user không tồn tại, thông báo lỗi và trả về /login
        if (user == null) {
            request.getSession().setAttribute("login_error", "Email/SĐT hoặc mật khẩu không chính xác!");
            request.getSession().setAttribute("form_emailphone", emailphone);
            response.sendRedirect("login");
        // Ngược lại,    
        } else {
            // Xóa lỗi khi đăng nhập thành công
            request.getSession().removeAttribute("login_error");
            request.getSession().removeAttribute("err_emailphone");
            request.getSession().removeAttribute("err_password");
            request.getSession().removeAttribute("form_emailphone");
            // Nếu là user
            if (user.getRole().equals("user")) {
                request.getSession().removeAttribute("login_error");
                request.getSession().setAttribute("user", user);
                response.sendRedirect("home");
            // Nếu là admin    
            } else {
                request.getSession().removeAttribute("login_error");
                request.getSession().setAttribute("user", user);
                response.sendRedirect("admin-dashboard");
            }
                    
        }
    }

}
