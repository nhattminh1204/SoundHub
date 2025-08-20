
package controller;

import data.dao.Database;
import data.utils.ValidationUtils;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;


@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("title", "SoundHub - Đăng ký");
        request.getRequestDispatcher("./views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Xóa lỗi khỏi session
        if ("true".equals(request.getParameter("clearErrors"))) {
            request.getSession().removeAttribute("err_name");
            request.getSession().removeAttribute("err_email");
            request.getSession().removeAttribute("err_phone");
            request.getSession().removeAttribute("err_password");
            return;
        }
        String err_name = "";
        String err_email = "";
        String err_phone = "";
        String err_password = "";

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String repassword = request.getParameter("confirmPassword");

        // Validation
        String nameError = ValidationUtils.getNameError(name);
        String emailError = ValidationUtils.getEmailError(email);
        String phoneError = ValidationUtils.getPhoneError(phone);
        String passwordError = ValidationUtils.getPasswordError(password);
        
        if (!repassword.equals(password)) {
            passwordError = "Mật khẩu xác nhận không khớp!";
        }
        
        boolean hasError = nameError != null || emailError != null || phoneError != null || passwordError != null;
        
        if (nameError != null) request.getSession().setAttribute("err_name", nameError);
        else request.getSession().removeAttribute("err_name");
        
        if (emailError != null) request.getSession().setAttribute("err_email", emailError);
        else request.getSession().removeAttribute("err_email");
        
        if (phoneError != null) request.getSession().setAttribute("err_phone", phoneError);
        else request.getSession().removeAttribute("err_phone");
        
        if (passwordError != null) request.getSession().setAttribute("err_password", passwordError);
        else request.getSession().removeAttribute("err_password");

        if (hasError) {
            // Giữ lại dữ liệu đã nhập
            request.getSession().setAttribute("form_name", name);
            request.getSession().setAttribute("form_email", email);
            request.getSession().setAttribute("form_phone", phone);
            response.sendRedirect("register");
        } else {
            // Xóa dữ liệu form cũ
            request.getSession().removeAttribute("form_name");
            request.getSession().removeAttribute("form_email");
            request.getSession().removeAttribute("form_phone");
            if (Database.getUserDAO().find(email) != null || Database.getUserDAO().find(phone) != null) {
                request.getSession().setAttribute("exist_user", "Email hoặc số điện thoại đã tồn tại trong hệ thống!");
                response.sendRedirect("register");
            } else {
                Database.getUserDAO().insertUser(name, email, phone, password);
                User user = Database.getUserDAO().find(email);
                if (user != null) {
                    request.getSession().setAttribute("user", user);
                    request.getSession().removeAttribute("exist_user");
                    request.getSession().setAttribute("register_success", "Đăng ký thành công! Chào mừng bạn đến với SoundHub!");
                    response.sendRedirect("home");
                } else {
                    request.getSession().setAttribute("register_error", "Đăng ký thành công nhưng không thể tìm thấy user!");
                    response.sendRedirect("register");
                }
            }
        }
    }

}
