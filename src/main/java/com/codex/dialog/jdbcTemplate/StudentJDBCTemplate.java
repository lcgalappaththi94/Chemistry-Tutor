package com.codex.dialog.jdbcTemplate;

import com.codex.dialog.dao.StudentDAO;
import com.codex.dialog.mapper.LeaderboardMapper;
import com.codex.dialog.mapper.PasswordMapper;
import com.codex.dialog.mapper.StudentMapper;
import com.codex.dialog.model.Leaderboard;
import com.codex.dialog.model.Password;
import com.codex.dialog.model.Student;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

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
    public boolean addStudent(String username, String email, String password, String contactNo, String login) throws ClassNotFoundException, SQLException {
        String sql = "Insert into Student (username,email,password,contactNo,score,login) values (?,?,(select Password (?)),?,?,?)";
        return (jdbcTemplateObject.update(sql, username, email, password, contactNo, 0, login) > 0);
    }

    @Override
    public boolean updateScore(String username, String score, ArrayList<Double> questions) throws ClassNotFoundException, SQLException {
        String sql1 = "UPDATE Student SET score=? WHERE username=?";
        String sql2 = "INSERT INTO DoneQuestion (username,qNo) VALUES (?,?)";
        boolean isDoneUpdated = false;
        int updatedScore = Integer.parseInt(score);
        for (double question : questions) {
            isDoneUpdated = false;
            Student student = viewAccount(username);
            updatedScore = Integer.parseInt(student.getScore()) + Integer.parseInt(score);
            isDoneUpdated = (jdbcTemplateObject.update(sql2, username, (int) question) > 0);
        }
        if (questions.size() == 0) {
            Student student = viewAccount(username);
            updatedScore = Integer.parseInt(student.getScore()) + Integer.parseInt(score);
            isDoneUpdated = true;
        }
        return (jdbcTemplateObject.update(sql1, updatedScore, username) > 0) && isDoneUpdated;
    }

    @Override
    public boolean updateDetails(String username, String email, String password, String contactNo) throws ClassNotFoundException, SQLException {
        String sql = "UPDATE Student SET email=?,password=(select Password (?)),contactNo=? WHERE username=?";
        return jdbcTemplateObject.update(sql, email, password, contactNo, username) > 0;
    }

    @Override
    public boolean updateLoginTime(String username, String login) throws ClassNotFoundException, SQLException {
        String sql = "UPDATE Student SET login=? WHERE username=?";
        return jdbcTemplateObject.update(sql, login, username) > 0;
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
        } catch (EmptyResultDataAccessException ex) {
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
    public ArrayList<Leaderboard> getLeaderbord(String username) throws ClassNotFoundException, SQLException {
        String sql = "SELECT username,score,FIND_IN_SET( score, ( SELECT GROUP_CONCAT( score ORDER BY score DESC ) " +
                "FROM Student ) ) AS rank FROM Student ORDER BY score DESC LIMIT 20";
        String sql2 = "SELECT username,score,FIND_IN_SET( score, ( SELECT GROUP_CONCAT( score ORDER BY score DESC ) " +
                "FROM Student ) ) AS rank FROM Student WHERE username=?";
        try {
            Leaderboard currentStudent = jdbcTemplateObject.queryForObject(sql2, new LeaderboardMapper(), username);
            ArrayList<Leaderboard> top20 = new ArrayList<>();
            top20.add(currentStudent);
            top20.addAll(jdbcTemplateObject.query(sql, new LeaderboardMapper()));
            return top20;
        } catch (EmptyResultDataAccessException ex) {
            return null;
        }
    }
}
