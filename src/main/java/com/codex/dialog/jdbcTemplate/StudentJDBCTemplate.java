package com.codex.dialog.jdbcTemplate;

import com.codex.dialog.dao.StudentDAO;
import com.codex.dialog.mapper.PasswordMapper;
import com.codex.dialog.mapper.StudentMapper;
import com.codex.dialog.model.Password;
import com.codex.dialog.model.Student;
import org.omg.CORBA.INTERNAL;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.persistence.criteria.CriteriaBuilder;
import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.ArrayList;

public class StudentJDBCTemplate implements StudentDAO {

    private DataSource dataSource;
    private JdbcTemplate jdbcTemplateObject;

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
        this.jdbcTemplateObject = new JdbcTemplate(dataSource);
    }

    @Override
    public boolean addStudent(String username, String email, String password, String contactNo) throws ClassNotFoundException, SQLException {
        String sql = "Insert into Student (username,email,password,contactNo,score) values (?,?,(select Password (?)),?,?)";
        return (jdbcTemplateObject.update(sql, username, email, password, contactNo, 0) > 0);
    }

    @Override
    public boolean updateScore(String username, String score, ArrayList<Double> questions) throws ClassNotFoundException, SQLException {
        String sql1 = "UPDATE Student SET score=? WHERE username=?";
        String sql2 = "INSERT INTO DoneQuestion (username,qNo) VALUES (?,?)";
        boolean isDoneUpdated = false;
        int updatedScore = Integer.parseInt(score);
        for (double question: questions) {
            isDoneUpdated =false;
            Student student = viewAccount(username);
            updatedScore = Integer.parseInt(student.getScore()) + Integer.parseInt(score);
            isDoneUpdated = (jdbcTemplateObject.update(sql2, username, (int)question) > 0);
        }
        return (jdbcTemplateObject.update(sql1, updatedScore, username) > 0) && isDoneUpdated;
    }

    @Override
    public boolean updateDetails(String username, String email, String password, String contactNo) throws ClassNotFoundException, SQLException {
        String sql = "UPDATE Student SET email=?,password=(select Password (?)),contactNo=? WHERE username=?";
        return jdbcTemplateObject.update(sql,email, password, contactNo, username) > 0;
    }

    @Override
    public boolean checkUsername(String username) throws ClassNotFoundException, SQLException {
        String sql = "select * from Student where username = ? limit 1";
        try {
            jdbcTemplateObject.queryForObject(sql, new StudentMapper(), username);
            return true;
        } catch (EmptyResultDataAccessException ex) {
            return false;
        }
    }

    @Override
    public boolean checkPass(String username, String password) throws ClassNotFoundException, SQLException {
        String sql = "select username,password,(select password(?))as NewPassword from Student where username = ? ";
        Password pass = null;
        try {
            pass = jdbcTemplateObject.queryForObject(sql, new PasswordMapper(), password, username);
        }catch (EmptyResultDataAccessException ex){
            return false;
        }
        if (pass.getPassword().equals(pass.getNewPassword())) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public Student viewAccount(String username) throws ClassNotFoundException, SQLException {
        String sql = "select * from Student where username = ? limit 1";
        Student student;
        try {
            student = jdbcTemplateObject.queryForObject(sql, new StudentMapper(), username);
            return student;
        } catch (EmptyResultDataAccessException ex) {
            return null;
        }
    }

    @Override
    public ArrayList<Student> getLeaderbord() throws ClassNotFoundException, SQLException {
        String sql = "select username,email,password,contactNo,score from Student ORDER BY score DESC";
        Student student;
        try {
            ArrayList<Student> studentList = (ArrayList<Student>) jdbcTemplateObject.query(sql, new StudentMapper());
            return studentList;
        } catch (EmptyResultDataAccessException ex) {
            return null;
        }
    }
}
