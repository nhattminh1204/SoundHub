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

        // Nhận dữ liệu được truyền vào
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String repassword = request.getParameter("confirmPassword");

        // Validation dữ liệu, xem dữ liệu có hợp lệ hay không
        // Hợp lệ: trả về null
        // Không hợp lệ: trả về lỗi
        String nameError = ValidationUtils.getNameError(name);
        String emailError = ValidationUtils.getEmailError(email);
        String phoneError = ValidationUtils.getPhoneError(phone);
        String passwordError = ValidationUtils.getPasswordError(password);

        // Check password và repassword có khớp hay không
        if (!repassword.equals(password)) {
            passwordError = "Mật khẩu xác nhận không khớp!";
        }

        // Nếu có lỗi thì lưu lỗi lại
        boolean hasError = nameError != null || emailError != null || phoneError != null || passwordError != null;

        if (nameError != null) {
            request.getSession().setAttribute("err_name", nameError);
        } else {
            request.getSession().removeAttribute("err_name");
        }

        if (emailError != null) {
            request.getSession().setAttribute("err_email", emailError);
        } else {
            request.getSession().removeAttribute("err_email");
        }

        if (phoneError != null) {
            request.getSession().setAttribute("err_phone", phoneError);
        } else {
            request.getSession().removeAttribute("err_phone");
        }

        if (passwordError != null) {
            request.getSession().setAttribute("err_password", passwordError);
        } else {
            request.getSession().removeAttribute("err_password");
        }

        // Nếu có lỗi, gửi lại giữ liệu trong form (value)
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

            // Kiểm tra xem email, phone đã có trong DB chưa
            // Tồn tại
            if (Database.getUserDAO().find(email) != null || Database.getUserDAO().find(phone) != null) {
                request.getSession().setAttribute("exist_user", "Email hoặc số điện thoại đã tồn tại trong hệ thống!");
                response.sendRedirect("register");
                // Chưa tồn tại
            } else {
                // Thêm user vào DB
                Database.getUserDAO().insertUser(name, email, phone, password);
                // Lấy ra user hiện tại để đăng nhập
                User user = Database.getUserDAO().find(email);
                request.getSession().setAttribute("user", user);
                request.getSession().removeAttribute("exist_user");
                response.sendRedirect("home");
            }
        }
    }

}
