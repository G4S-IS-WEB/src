package hr_info_system_java;

import java.util.Date;

public class Employee {

    private String employee_id;
    private String employee_password;
    private String employee_fullname;
    private Date   employee_dateofbirth;
    private String employee_gender;
    private String employee_role;

    // Constructor 

    public Employee(String employee_id, String employee_password, String employee_fullname, 
    Date employee_dateofbirth, String employee_gender, String employee_role) {
        this.employee_id = employee_id;
        this.employee_password = employee_password;
        this.employee_fullname = employee_fullname;
        this.employee_dateofbirth = employee_dateofbirth;
        this.employee_gender = employee_gender;
        this.employee_role = employee_role;
    }


    // Setters and Getters

    public String getEmployeeId() {
        return employee_id;
    }

    public void setEmployeeId(String employee_id) {
        this.employee_id = employee_id;
    }

    public String getEmployee_password() {
        return employee_password;
    }

    public void setEmployee_password(String employee_password) {
        this.employee_password = employee_password;
    }

    public String getEmployee_fullname() {
        return employee_fullname;
    }

    public void setEmployee_fullname(String employee_fullname) {
        this.employee_fullname = employee_fullname;
    }

    public Date getEmployee_dateofbirth() {
        return employee_dateofbirth;
    }

    public void setEmployee_dateofbirth(Date employee_dateofbirth) {
        this.employee_dateofbirth = employee_dateofbirth;
    }

    public String getEmployee_gender() {
        return employee_gender;
    }

    public void setEmployee_gender(String employee_gender) {
        this.employee_gender = employee_gender;
    }

    public String getEmployee_role() {
        return employee_role;
    }

    public void setEmployee_role(String employee_role) {
        this.employee_role = employee_role;
    }
}
