package com.codex.dialog.mapper;

import com.codex.dialog.model.Password;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class PasswordMapper implements RowMapper<Password> {

    @Override
    public Password mapRow(ResultSet rs, int i) throws SQLException {
        Password password = new Password("" + rs.getString(2), rs.getString(3), rs.getString(1));
        return password;
    }
}
