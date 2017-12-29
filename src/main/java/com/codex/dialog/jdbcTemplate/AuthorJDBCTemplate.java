package com.codex.dialog.jdbcTemplate;


import com.codex.dialog.dao.AuthorDAO;
import com.codex.dialog.mapper.AutherMapper;
import com.codex.dialog.mapper.PasswordMapper;
import com.codex.dialog.model.Auther;
import com.codex.dialog.model.Password;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.ArrayList;

public class AuthorJDBCTemplate implements AuthorDAO {

    private DataSource dataSource;
    private JdbcTemplate jdbcTemplateObject;

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
        this.jdbcTemplateObject = new JdbcTemplate(dataSource);
    }


    @Override
    public Auther getAuther(String email) throws ClassNotFoundException, SQLException {
        String sql = "select * from Author where email = ? limit 1";
        Auther a;
        try {
            a = jdbcTemplateObject.queryForObject(sql, new AutherMapper(), email);
            return a;
        } catch (EmptyResultDataAccessException ex) {
            return null;
        }
    }

    @Override
    public boolean addAuther(Auther auther) throws ClassNotFoundException, SQLException {
        String sql = "Insert into Author (destination,email,password,name) values (?,?,(select Password (?)),?)";//String sql = "insert into UserAccount Values('" + userName + "',(select Password ('" + newPassword + "'))," + x + ")";
        return (jdbcTemplateObject.update(sql, auther.getDesig(), auther.getEmail(), auther.getPassword(), auther.getName()) > 0);
    }

    @Override
    public boolean isAuther(String email) {
        String sql = "select * from Author where email = ? limit 1";
        Auther a;
        try {
            a = jdbcTemplateObject.queryForObject(sql, new AutherMapper(), email);
            return true;
        } catch (EmptyResultDataAccessException ex) {
            return false;
        }
    }

    public String authenticate(String password, String email) throws SQLException, ClassNotFoundException {

        String sql = "select authorId,password,(select Password(?))as NewPassword from Author where email = ? ";
        //question = jdbcTemplateObject.queryForObject(sql, new QuestionMapper(),quesNo);
        System.out.println(email+" "+password+" a");
        Password pass = null;
        try {
            pass = jdbcTemplateObject.queryForObject(sql, new PasswordMapper(), password, email);
        }catch (EmptyResultDataAccessException ex){
            return "";
        }

        if (pass.getPassword().equals(pass.getNewPassword())) {
            return pass.getAuthId();
        } else {
            return "";
        }

    }

    @Override
    public Auther getAuthor(String auhId) throws ClassNotFoundException, SQLException {
        String sql = "select * from Author where authorId = ?";
        return jdbcTemplateObject.queryForObject(sql, new AutherMapper(), auhId);
    }

    @Override
    public boolean updateAuthor(Auther auther) throws ClassNotFoundException, SQLException {
        String sql = "UPDATE Author SET destination=?,password=(select Password (?)),name=? WHERE authorId=?";
        return jdbcTemplateObject.update(sql,auther.getDesig(),auther.getPassword(),auther.getName(),auther.getAuthId())>0;
    }

    @Override
    public boolean updateAuthorWithoutPassword(Auther auther) throws ClassNotFoundException, SQLException {
        String sql = "UPDATE Author SET destination=?,name=? WHERE authorId=?";
        return jdbcTemplateObject.update(sql,auther.getDesig(),auther.getName(),auther.getAuthId())>0;
    }
}
