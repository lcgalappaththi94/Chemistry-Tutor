package com.codex.dialog.jdbcTemplate;


import com.codex.dialog.dao.AuthorDAO;
import com.codex.dialog.mapper.AutherMapper;
import com.codex.dialog.mapper.ForgotMapper;
import com.codex.dialog.mapper.PasswordMapper;
import com.codex.dialog.model.Auther;
import com.codex.dialog.model.Forgot;
import com.codex.dialog.model.Password;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.Date;

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
        Password pass = null;
        try {
            pass = jdbcTemplateObject.queryForObject(sql, new PasswordMapper(), password, email);
        } catch (EmptyResultDataAccessException ex) {
            return "";
        }
        if (pass.getPassword().equals(pass.getNewPassword())) {
            return pass.getAuthId();
        } else {
            return "";
        }
    }

    @Override
    public Auther getAuthor(String authId) throws ClassNotFoundException, SQLException {
        String sql = "select * from Author where authorId = ?";
        return jdbcTemplateObject.queryForObject(sql, new AutherMapper(), authId);
    }

    @Override
    public Forgot getForgotUser(String uuid) {
        try {
            String sql = "select * from forgotPassword where uuid = ?";
            Forgot forgot = jdbcTemplateObject.queryForObject(sql, new ForgotMapper(), uuid);
            return forgot;
        } catch (Exception e) {
            return null;
        }

    }

    @Override
    public void used(String uuid) {
        String sql = "UPDATE forgotPassword SET used=? WHERE uuid=?";
        jdbcTemplateObject.update(sql, true, uuid);
    }

    @Override
    public boolean addForgotUser(Forgot forgot) {
        String sql = "Insert into forgotPassword (userId,uuid,timestamp,used) values (?,?,?,?)";
        return (jdbcTemplateObject.update(sql, forgot.getUserId(), forgot.getUuid(), forgot.getTimestamp(), forgot.isUsed()) > 0);
    }

    @Override
    public Auther getAuthorByEmail(String email) throws ClassNotFoundException, SQLException {
        String sql = "select * from Author where email = ?";
        Auther found;
        try {
            found = jdbcTemplateObject.queryForObject(sql, new AutherMapper(), email);
        } catch (Exception e) {
            found = null;
        }
        return found;
    }

    @Override
    public boolean updateAuthor(Auther auther) throws ClassNotFoundException, SQLException {
        String sql = "UPDATE Author SET destination=?,password=(select Password (?)),name=? WHERE authorId=?";
        return jdbcTemplateObject.update(sql, auther.getDesig(), auther.getPassword(), auther.getName(), auther.getAuthId()) > 0;
    }

    @Override
    public boolean resetPassword(String password, String id) throws ClassNotFoundException, SQLException {
        String sql = "UPDATE Author SET password=(select Password (?)) WHERE authorId=?";
        return jdbcTemplateObject.update(sql, password, id) > 0;
    }

    @Override
    public boolean updateAuthorWithoutPassword(Auther auther) throws ClassNotFoundException, SQLException {
        String sql = "UPDATE Author SET destination=?,name=? WHERE authorId=?";
        return jdbcTemplateObject.update(sql, auther.getDesig(), auther.getName(), auther.getAuthId()) > 0;
    }
}
