/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ims;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.swing.JOptionPane;

/**
 *
 * @author ASUS
 */
public class IMS {
     public static Connection conn=conn=javaconnect.connerDb();;
        public static ResultSet rs=null;
        public static PreparedStatement pst=null;
        
     public static boolean Phone_validator(String p)
    {
      String regex = "(0/91)?[6-9][0-9]{9}";
      return p.matches(regex);
    }

    public static boolean ID_validator(String p)
    {
      String regex = "[0-9]{5}$";
      return p.matches(regex);
    }
    public static boolean Email_validator(String e)
    {
      String regex = "^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$";
      return e.matches(regex);
    }
    public static boolean Name_Validator(String a)
    {
      String regex = "^[\\p{L} .'-]+$";
      return a.matches(regex);
    }
  
    public static boolean Student_validator(String id){
        String sql=null;
        try{
         sql="select stu_id from student where stu_id="+id;
        pst=conn.prepareStatement(sql);
        rs=pst.executeQuery(sql);
       return rs.next();
        
        }catch(java.lang.NullPointerException w){
            JOptionPane.showMessageDialog(null, "Student Does not Exists");
        }
        catch(Exception e){
            JOptionPane.showMessageDialog(null, e.getMessage());
        }
        
       return true;
    }
    
    public static boolean Faculty_validator(String id){
        String sql=null;
        try{
         sql="select fac_id from faculty where fac_id="+id;
        pst=conn.prepareStatement(sql);
        rs=pst.executeQuery(sql);
       return rs.next();
        
        }catch(java.lang.NullPointerException w){
            JOptionPane.showMessageDialog(null, "Student Does not Exists");
        }
        catch(Exception e){
            JOptionPane.showMessageDialog(null, e.getMessage());
        }
        
       return true;
    }
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        new Login().show();
    }
    
}
