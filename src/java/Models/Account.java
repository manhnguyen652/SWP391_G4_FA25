package Models;

import java.sql.Date;

public class Account {
    private int u_id;
    private String u_email;
    private String u_pass;
    private int permission_id;
    private String f_name;
    private String l_name;
    private Date dob;

    
    public int getU_id() { return u_id; }
    public void setU_id(int u_id) { this.u_id = u_id; }
    public String getU_email() { return u_email; }
    public void setU_email(String u_email) { this.u_email = u_email; }
    public String getU_pass() { return u_pass; }
    public void setU_pass(String u_pass) { this.u_pass = u_pass; }
    public int getPermission_id() { return permission_id; }
    public void setPermission_id(int permission_id) { this.permission_id = permission_id; }
    public String getF_name() { return f_name; }
    public void setF_name(String f_name) { this.f_name = f_name; }
    public String getL_name() { return l_name; }
    public void setL_name(String l_name) { this.l_name = l_name; }
    public Date getDob() { return dob; }
    public void setDob(Date dob) { this.dob = dob; }
}