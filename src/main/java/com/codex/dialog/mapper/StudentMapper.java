package com.codex.dialog.mapper;

import com.codex.dialog.model.Student;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class StudentMapper implements RowMapper<Student> {

    @Override
    public Student mapRow(ResultSet rs, int i) throws SQLException {
        Student student = new Student(rs.getString("username"), rs.getString("email"),
                rs.getString("password"), rs.getString("contactNo"),
                rs.getString("score"), rs.getString("login"));
        return student;
    }
}
