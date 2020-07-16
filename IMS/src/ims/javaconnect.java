package ims;

import java.sql.*;
import javax.swing.JOptionPane;

public class javaconnect
{
    Connection conn=null;
    
    public  static Connection connerDb()
    {
        try {
           Class.forName("com.mysql.cj.jdbc.Driver");
           Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/institutemanagementsystem", "root","Sudhanshu29@");
           
            
            return conn;
        } catch (Exception e) {
            
            JOptionPane.showMessageDialog(null, "Database Conncetion Problem.");
        }
        return null;
    }
            
}
  