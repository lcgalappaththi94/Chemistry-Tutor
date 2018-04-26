package com.codex.dialog.Test;

import com.google.gson.Gson;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class Test {
    public static void main(String[] args) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Date date = new Date();

        String dateStart = "2018/02/03 02:48:47";
        String dateStop = "2018/02/03 11:48:47";
//        String dateStop = dateFormat.format(date);

        //HH converts hour in 24 hours format (0-23), day calculation
        SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");

        Date d1 = null;
        Date d2 = null;


        try {
            d1 = format.parse(dateStart);
            d2 = format.parse(dateStop);

        } catch (ParseException e) {
            e.printStackTrace();
        }


        //in milliseconds
        long diff = d2.getTime() - d1.getTime();

        final long diffSeconds = diff / 1000 % 60;
        final long diffMinutes = diff / (60 * 1000) % 60;
        final long diffHours = diff / (60 * 60 * 1000) % 24;
        final long diffDays = diff / (24 * 60 * 60 * 1000);


        System.out.println(diffDays);
        System.out.println(diffHours);
        System.out.println(diffMinutes);
        System.out.println(diffSeconds);
    }
}
