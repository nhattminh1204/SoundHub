/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.dao;

import model.User;

public interface UserDAO {
    public User find(String emailphone, String password);
    public User find(String emailphone);
    public void insertUser(String name, String email, String phone, String password);
    public void updateUser(User user);
    public void updatePassword(int id, String newPassword);
    public java.util.List<User> findAll();
    public boolean delete(int id);
    public boolean updateStatus(int id, boolean status);
    public boolean updateRole(int id, String role);
    public User findById(int id);
    
}
