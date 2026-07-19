package utils;

import java.sql.Connection;

public class TestConnection {
    public static void main(String[] args) {
        try {
            Connection conn = DBCPUtils.getConnection();
            if (conn != null) {
                System.out.println("Connection Successful!");
                conn.close();
            }
        } catch (Exception e) {
            System.out.println("Connection Failed!");
            e.printStackTrace();
        }
    }
}