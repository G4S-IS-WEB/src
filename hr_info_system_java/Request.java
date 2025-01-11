package hr_info_system_java;

import java.sql.Time;
import java.util.Date;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;

public class Request {

    private String request_id;
    private String request_body;
    private String employee_id;
    private static String holder = "R0000001";
    private String[] participants;
    private String participants_sql;
    private String time;
    private String date;
    private Date date_sql;
    private Time time_sql;
    private Date startdate_sql;
    private Date enddate_sql;
    private String dayOffDate;

    // Complaint Constructor java
    // Used to get Parameters from forms

    public Request(String request_body) {
        RequestService rq = new RequestService();
        this.request_id = generateNextId(rq);
        this.request_body = request_body;// complaint text
    }

    // Complaint Constructor DB
    // Used to get columns from DB tables and to show them on HR

    public Request(String request_id, String request_body, String employee_id) {
        this.request_id = request_id;
        this.request_body = request_body;
        this.employee_id = employee_id;
    }

    public Request(String date, String time, String[] participants, String request_body) {
        RequestService rq = new RequestService();
        this.request_id = generateNextId(rq);
        this.date = date;
        this.time = time;
        this.participants = participants;
        this.request_body = request_body; // meeting subject
    }

    // Meeting Constructor DB

    public Request(String request_id, Date date_sql, Time time_sql, String participants_sql, String request_body,
            String employee_id) {
        this.request_id = request_id;
        this.date_sql = date_sql;
        this.time_sql = time_sql;
        this.participants_sql = participants_sql;
        this.request_body = request_body;
        this.employee_id = employee_id;
    }

    // Dayoff Constructor java
    // dayOffDate = startdate + enddate
    public Request(String dayOffDate, String request_body) {
        RequestService rq = new RequestService();
        this.request_id = generateNextId(rq);
        this.dayOffDate = dayOffDate;
        this.request_body = request_body;
    }

    // dayoff Constructor DB

    public Request(String request_id, Date startdate_sql, Date enddate_sql, String request_body, String employee_id) {
        this.request_id = request_id;
        this.startdate_sql = startdate_sql;
        this.enddate_sql = enddate_sql;
        this.request_body = request_body;
        this.employee_id = employee_id;
    }

    //Used for Schedule

    public Request(String request_id,String request_body, Date date_sql,Time time_sql) {
        this.request_id = request_id;
        this.request_body = request_body;
        this.date_sql = date_sql;
        this.time_sql = time_sql;
    }

    private static String generateNextId(RequestService rq) {
        try {
            holder = rq.maxRequestId();
            if (holder == "R0000001") {
                return "R0000001";
            }
            int numericPart = Integer.parseInt(holder.substring(1));
            numericPart++;
            return String.format("R%07d", numericPart);
        } catch (Exception e) {
            return e.getMessage();
        }
    }
    // Setters and Getters

    public String getRequestId() {
        return request_id;
    }

    public void setRequestId(String request_id) {
        this.request_id = request_id;
    }

    public String getRequestBody() {
        return request_body;
    }

    public void setRequestBody(String request_body) {
        this.request_body = request_body;
    }

    public String getEmployeeId() {
        return employee_id;
    }

    public void setEmployeeId(String employee_id) {
        this.employee_id = employee_id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public Date getDateSQL() {
        return date_sql;
    }

    public void setDateSQL(Date date_sql) {
        this.date_sql = date_sql;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public Time getTimeSQL() {
        return time_sql;
    }

    public void setTimeSQL(Time time_sql) {
        this.time_sql = time_sql;
    }

    public String[] getParticipants() {
        return participants;
    }

    public void setParticipants(String[] participants) {
        this.participants = participants;
    }

    public String getParticipantsSQL() {
        return participants_sql;
    }

    public void setParticipantsSQL(String participants_sql) {
        this.participants_sql = participants_sql;
    }

    // Χωρίζω το String που περιέχει και τις δυο ημερομηνίες
    public String getStartDate() {
        String[] parts = dayOffDate.split(" ", 2);
        return parts[0];
    }

    public String getEndDate() {
        String[] parts = dayOffDate.split(" ", 2);
        return parts[1];
    }

    public Date getStartDateSql() {
        return startdate_sql;
    }

    public Date getEndDateSql() {
        return enddate_sql;
    }

    public boolean checkdates(String startdate, String enddate) {
        
        boolean valid_dates = false;
        try {
            LocalDate date1 = LocalDate.parse(startdate); 
            LocalDate date2 = LocalDate.parse(enddate);
            if (!date1.isAfter(date2)) {
                valid_dates = true;
            }
        } catch (DateTimeParseException e) {
            System.out.println("Invalid date format: " + e.getMessage());
        }
        return valid_dates;
    }


    public boolean isDateAfterToday(String date) {
        
        LocalDate today = LocalDate.now();
        boolean isAfterToday = false ;

        try {
            LocalDate formatted_date = LocalDate.parse(date); 
            
            if (formatted_date.isAfter(today)) {
                isAfterToday = true; 
            }
        } catch (DateTimeParseException e) {
            System.out.println("Invalid date format: " + e.getMessage());
        }
        return isAfterToday;
    }

    public boolean isDateToday(String date) {
        
        LocalDate today = LocalDate.now();
        boolean isToday = false ;

        try {
            LocalDate formatted_date = LocalDate.parse(date); 
            
            if (formatted_date.isEqual(today)) {
                isToday = true; 
            }
        } catch (DateTimeParseException e) {
            System.out.println("Invalid date format: " + e.getMessage());
        }
        return isToday;
    }

    public boolean isTimeAfterOrNow(String time) {
        boolean isAfterOrNow = false;

        try {
        LocalTime formatted_time = LocalTime.parse(time);
        LocalTime now = LocalTime.now();

        if (formatted_time.isAfter(now)) {
            isAfterOrNow = true;
        }else if(formatted_time.equals(now)) {
            isAfterOrNow = true;
        }
    } catch (DateTimeParseException e) {
        System.out.println("Invalid time format: " + e.getMessage());
    }

        return isAfterOrNow;
    }

}
    

