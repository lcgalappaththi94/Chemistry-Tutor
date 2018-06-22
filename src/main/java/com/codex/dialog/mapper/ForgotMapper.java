package com.codex.dialog.mapper;

import com.codex.dialog.model.Forgot;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ForgotMapper implements RowMapper<Forgot> {
    @Override
    public Forgot mapRow(ResultSet resultSet, int i) throws SQLException {
        Forgot forgot = new Forgot(resultSet.getString("userId"),
                resultSet.getString("uuid"), resultSet.getTimestamp("timestamp"), resultSet.getBoolean("used"));
        return forgot;
    }
}
