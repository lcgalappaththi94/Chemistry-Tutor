package com.codex.dialog.mapper;

import com.codex.dialog.model.Leaderboard;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class LeaderboardMapper implements RowMapper<Leaderboard> {

    @Override
    public Leaderboard mapRow(ResultSet rs, int i) throws SQLException {
        Leaderboard leaderboard = new Leaderboard(rs.getString("username"), rs.getInt("score"),
                rs.getInt("rank"));
        return leaderboard;
    }
}
