package com.codex.dialog.dao;

import com.codex.dialog.model.Auther;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;

@Service
public interface AuthorDAO {

    public Auther getAuther(String email) throws ClassNotFoundException, SQLException;

    public boolean addAuther(Auther auther) throws ClassNotFoundException, SQLException;

    public boolean isAuther(String email) throws ClassNotFoundException, SQLException;

    public String authenticate(String password, String email) throws ClassNotFoundException, SQLException;

    public Auther getAuthor(String auhId) throws ClassNotFoundException, SQLException;

    public boolean updateAuthor (Auther auther) throws ClassNotFoundException, SQLException;

    public boolean updateAuthorWithoutPassword (Auther auther) throws ClassNotFoundException, SQLException;
}
