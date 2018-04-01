package com.codex.dialog.Test;

import com.google.gson.Gson;

import java.util.ArrayList;

public class Test {
    public static void main(String[] args) {
        ArrayList<Integer> questions = new ArrayList<>();
        questions.add(1);
        questions.add(2);
        Gson gson = new Gson();
        String json = gson.toJson(questions);
        System.out.printf(json);
    }
}
