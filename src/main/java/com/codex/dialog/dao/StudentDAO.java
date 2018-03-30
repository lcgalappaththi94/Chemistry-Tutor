package com.codex.dialog.dao;

import com.codex.dialog.model.Student;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;

@Service
public interface StudentDAO {
    public boolean addStudent(String username, String email, String password, String contactNo)
            throws ClassNotFoundException, SQLException;
    public boolean updateScore(String username, String score, ArrayList <Double> questions)
            throws ClassNotFoundException, SQLException;
    public boolean updateDetails(String username, String email, String password, String contactNo)
            throws ClassNotFoundException, SQLException;
    public boolean checkUsername(String username) throws ClassNotFoundException, SQLException;
    public boolean checkPass(String username, String password) throws ClassNotFoundException, SQLException;
    public Student viewAccount(String username) throws ClassNotFoundException, SQLException;
    public ArrayList<Student> getLeaderbord() throws ClassNotFoundException, SQLException;
}
