package com.codex.dialog.dao;

import com.codex.dialog.model.Auther;
import com.codex.dialog.model.Forgot;
import org.springframework.stereotype.Service;

import java.sql.SQLException;

@Service
public interface AuthorDAO {

    public Auther getAuther(String email) throws ClassNotFoundException, SQLException;

    public boolean addAuther(Auther auther) throws ClassNotFoundException, SQLException;

    public boolean isAuther(String email) throws ClassNotFoundException, SQLException;

    public String authenticate(String password, String email) throws ClassNotFoundException, SQLException;

    public Auther getAuthor(String authId) throws ClassNotFoundException, SQLException;

    public Auther getAuthorByEmail(String email) throws ClassNotFoundException, SQLException;

    public Forgot getForgotUser(String uuid);

    public boolean addForgotUser(Forgot forgot);

    public void used(String uuid);

    public boolean updateAuthor(Auther auther) throws ClassNotFoundException, SQLException;

    public boolean resetPassword(String password,String id) throws ClassNotFoundException, SQLException;

    public boolean updateAuthorWithoutPassword(Auther auther) throws ClassNotFoundException, SQLException;
}
