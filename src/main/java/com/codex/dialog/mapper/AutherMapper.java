package com.codex.dialog.mapper;

import com.codex.dialog.model.Auther;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class AutherMapper implements RowMapper<Auther> {

    @Override
    public Auther mapRow(ResultSet rs, int i) throws SQLException {
        Auther auther = new Auther("" + rs.getInt("authorId"), rs.getString("destination"), rs.getString("email"), rs.getString("password"), rs.getString("name"));
        return auther;
    }
}
