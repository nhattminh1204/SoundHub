package data.utils;

import java.util.regex.Pattern;

public class ValidationUtils {
    
    private static final String EMAIL_PATTERN = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
    private static final String PHONE_PATTERN = "^(0[3|5|7|8|9])+([0-9]{8})$";
    private static final String PASSWORD_PATTERN = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d@$!%*?&]{6,}$";
    
    private static final Pattern emailPattern = Pattern.compile(EMAIL_PATTERN);
    private static final Pattern phonePattern = Pattern.compile(PHONE_PATTERN);
    private static final Pattern passwordPattern = Pattern.compile(PASSWORD_PATTERN);
    

    public static boolean isValidEmail(String email) {
        return email != null && emailPattern.matcher(email).matches();
    }
    

    public static boolean isValidPhone(String phone) {
        return phone != null && phonePattern.matcher(phone).matches();
    }
    

    public static boolean isValidPassword(String password) {
        return password != null && passwordPattern.matcher(password).matches();
    }
    

    public static boolean isValidName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return false;
        }
        return name.trim().matches("^[a-zA-ZÀ-ỹ\\s]{2,50}$");
    }
    

    public static String getEmailError(String email) {
        if (email == null || email.trim().isEmpty()) {
            return "Email không được để trống";
        }
        if (!isValidEmail(email)) {
            return "Email không đúng định dạng";
        }
        return null;
    }
    

    public static String getPhoneError(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return "Số điện thoại không được để trống";
        }
        if (!isValidPhone(phone)) {
            return "Số điện thoại phải có 10 số và bắt đầu bằng 03, 05, 07, 08, 09";
        }
        return null;
    }
    

    public static String getPasswordError(String password) {
        if (password == null || password.trim().isEmpty()) {
            return "Mật khẩu không được để trống";
        }
        if (password.length() < 6) {
            return "Mật khẩu phải có ít nhất 6 ký tự";
        }
        if (!password.matches(".*[a-z].*")) {
            return "Mật khẩu phải có ít nhất 1 chữ thường";
        }
        if (!password.matches(".*[A-Z].*")) {
            return "Mật khẩu phải có ít nhất 1 chữ hoa";
        }
        if (!password.matches(".*\\d.*")) {
            return "Mật khẩu phải có ít nhất 1 số";
        }
        return null;
    }
    

    public static String getNameError(String name) {
        if (name == null || name.trim().isEmpty()) {
            return "Họ tên không được để trống";
        }
        if (name.trim().length() < 2) {
            return "Họ tên phải có ít nhất 2 ký tự";
        }
        if (name.trim().length() > 50) {
            return "Họ tên không được quá 50 ký tự";
        }
        if (!isValidName(name)) {
            return "Họ tên chỉ được chứa chữ cái và khoảng trắng";
        }
        return null;
    }
}