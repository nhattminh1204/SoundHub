package data.utils;

public class StringUtils {
    
    /**
     * Lấy tên cuối từ họ tên đầy đủ
     * Ví dụ: "Nguyễn Văn Minh Nhật" -> "Nhật"
     * @param fullName họ tên đầy đủ
     * @return tên cuối
     */
    public static String getLastName(String fullName) {
        if (fullName == null || fullName.trim().isEmpty()) {
            return "";
        }
        
        String trimmed = fullName.trim();
        String[] parts = trimmed.split("\\s+");
        
        if (parts.length == 0) {
            return trimmed;
        }
        
        return parts[parts.length - 1];
    }
    
    /**
     * Format tên hiển thị thân thiện
     * @param fullName họ tên đầy đủ
     * @return tên cuối hoặc "Bạn" nếu rỗng
     */
    public static String getDisplayName(String fullName) {
        String lastName = getLastName(fullName);
        return lastName.isEmpty() ? "Bạn" : lastName;
    }
}
