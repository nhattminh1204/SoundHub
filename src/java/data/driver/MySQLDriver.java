package data.driver;

import data.utils.Constants;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class MySQLDriver {

    public static Connection getConnection() {
        try {
//            Class.forName("com.mysql.jdbc.Driver"); 
            Class.forName("com.mysql.cj.jdbc.Driver");

            try {
                return DriverManager.getConnection(Constants.DB_URL, Constants.USER, Constants.PASSWORD);
            } catch (SQLException ex) {
                Logger.getLogger(MySQLDriver.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(MySQLDriver.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
