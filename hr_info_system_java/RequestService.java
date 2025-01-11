package hr_info_system_java;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RequestService {

    public String maxRequestId() throws Exception {
        Connection con = null;
        String sql = "SELECT MAX(max_id) AS request_id\n" + //
                "FROM (\n" + //
                "    SELECT MAX(complaint_id) AS max_id FROM Complaint\n" + //
                "    UNION\n" + //
                "    SELECT MAX(meeting_id) AS max_id FROM Meeting\n" + //
                "    UNION\n" + //
                "    SELECT MAX(dayoff_id) AS max_id FROM DayOff\n" + //
                ") AS request_ids;";
        DB db = new DB();
        String request_id = null;
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                request_id = rs.getString("request_id");
            }
            if (request_id == null) {
                request_id = "R0000001";
            }
            rs.close();
            stmt.close();
            db.close();
            return request_id;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {
                System.err.println("Failed to close the database connection: " + e.getMessage());
            }
        }
    } // end of maxRequestId

    public List<Request> getComplaints() throws Exception {
        Connection con = null;
        String sql = "SELECT * FROM Complaint";
        DB db = new DB();
        List<Request> Complaints = new ArrayList<Request>();
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Complaints.add(new Request(rs.getString("complaint_id"),
                        rs.getString("complaint_text"),
                        rs.getString("employee_id")));
            }
            rs.close();
            stmt.close();
            db.close();
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {
                System.err.println("Failed to close the database connection: " + e.getMessage());
            }
        }
        return Complaints;
    } // End of getComplaints

    public List<Request> getMeetings() throws Exception {
        Connection con = null;
        String sql = "SELECT * FROM Meeting";
        DB db = new DB();
        List<Request> meetings = new ArrayList<Request>();
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                meetings.add(new Request(rs.getString("meeting_id"),
                        rs.getDate("meeting_date"),
                        rs.getTime("meeting_time"),
                        rs.getString("meeting_participants"),
                        rs.getString("meeting_subject"),
                        rs.getString("employee_id")));
            }

            rs.close();
            stmt.close();
            db.close();
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {
                System.err.println("Failed to close the database connection: " +
                        e.getMessage());
            }
        }
        return meetings;
    } // End of getMeetings

    public List<Request> getDaysOff() throws Exception {
        Connection con = null;
        String sql = "SELECT * FROM dayoff";
        DB db = new DB();
        List<Request> daysOff = new ArrayList<Request>();
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                daysOff.add(new Request(rs.getString("dayoff_id"),
                        rs.getDate("startDate"),
                        rs.getDate("endDate"),
                        rs.getString("dayoff_text"),
                        rs.getString("employee_id")));
            }

            rs.close();
            stmt.close();
            db.close();
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {
                System.err.println("Failed to close the database connection: " +
                        e.getMessage());
            }
        }
        return daysOff;
    } // End of getDaysOff

    public void newComplaint(Request complaint, Employee employee) throws Exception {
        Connection con = null;
        String sql = "INSERT INTO complaint (complaint_id, complaint_text, employee_id)"
                + "VALUES (?, ?, ?)";
        DB db = new DB();
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, complaint.getRequestId());
            stmt.setString(2, complaint.getRequestBody());
            stmt.setString(3, employee.getEmployeeId());
            stmt.executeUpdate();
            stmt.close();
            db.close();
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {
                System.err.println("Failed to close the database connection: " + e.getMessage());
            }
        }
    }

    public void newMeeting(Request meeting, Employee employee) throws Exception {
        Connection con = null;
        String sql = "INSERT INTO meeting (meeting_id, meeting_date, meeting_time, meeting_participants, meeting_subject, employee_id)"
                + "VALUES (?, ?, ?, ?, ?, ?)";
        DB db = new DB();
        try {
            con = db.getConnection();
            String[] participants = meeting.getParticipants();
            String participants_string = String.join(",", participants);
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, meeting.getRequestId());
            stmt.setString(2, meeting.getDate());
            stmt.setString(3, meeting.getTime());
            stmt.setString(4, participants_string);
            stmt.setString(5, meeting.getRequestBody());
            stmt.setString(6, employee.getEmployeeId());
            stmt.executeUpdate();
            stmt.close();
            db.close();
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {
                System.err.println("Failed to close the database connection: " + e.getMessage());
            }
        }
    }

    public void newDayOff(Request dayOff, Employee employee) throws Exception {
        Connection con = null;
        String sql = "INSERT INTO dayoff (dayoff_id, startdate, enddate, dayoff_text, employee_id)"
                + "VALUES (?, ?, ?, ?, ?)";
        DB db = new DB();
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, dayOff.getRequestId());
            stmt.setString(2, dayOff.getStartDate());
            stmt.setString(3, dayOff.getEndDate());
            stmt.setString(4, dayOff.getRequestBody());
            stmt.setString(5, employee.getEmployeeId());
            stmt.executeUpdate();
            stmt.close();
            db.close();
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {
                System.err.println("Failed to close the database connection: " + e.getMessage());
            }
        }
    }

    public String findEmployeeNamebyComplaintId(Request complaint) throws Exception {
        Connection con = null;
        String sql = "SELECT DISTINCT employee_fullname FROM employee,complaint WHERE employee.employee_id = complaint.employee_id AND complaint.complaint_id=?";
        DB db = new DB();
        String employee_fullname = null;
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, complaint.getRequestId());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                employee_fullname = rs.getString("employee_fullname");
            }
            rs.close();
            stmt.close();
            db.close();
            return employee_fullname;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {
                System.err.println("Failed to close the database connection: " + e.getMessage());
            }
        }
    } // End of findEmployeeNamebyComplaintId

    public String findEmployeeIdbyComplaintId(Request complaint) throws Exception {
        Connection con = null;
        String sql = "SELECT employee_id FROM complaint WHERE complaint_id=?";
        DB db = new DB();
        String employee_id = null;
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, complaint.getRequestId());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                employee_id = rs.getString("employee_id");
            }
            rs.close();
            stmt.close();
            db.close();
            return employee_id;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {
                System.err.println("Failed to close the database connection: " + e.getMessage());
            }
        }
    } // end of findEmployeeIdbyComplaintId

    public Answer getAnswerComplaintbyComplaintId(String complaint_id) throws Exception {
        Connection con = null;
        String sql = "SELECT *\n" + //
                "FROM answercomplaint\n" + //
                "WHERE EXISTS (SELECT answer_id\n" + //
                "\t\t\t  FROM answercomplaint as ac,complaint as c\n" + //
                "\t\t\t  WHERE ac.complaint_id=c.complaint_id AND c.complaint_id=?);";
        DB db = new DB();
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, complaint_id);
            ResultSet rs = stmt.executeQuery();
            if (!rs.next()) {
                rs.close();
                stmt.close();
                db.close();
                return null;
            }
            Answer answer = new Answer(rs.getString("answer_id"),
                    rs.getString("answer_text"),
                    rs.getString("complaint_id"));
            rs.close();
            stmt.close();
            db.close();
            return answer;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {
                System.err.println("Failed to close the database connection: " + e.getMessage());
            }
        }
    } // End of getAnswerComplaintbyComplaintId

    public String findEmployeeNamebyMeetingId(Request meeting) throws Exception {
        Connection con = null;
        String sql = "SELECT DISTINCT employee_fullname FROM employee,meeting WHERE employee.employee_id = meeting.employee_id AND meeting.meeting_id=?";
        DB db = new DB();
        String employee_fullname = null;
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, meeting.getRequestId());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                employee_fullname = rs.getString("employee_fullname");
            }
            rs.close();
            stmt.close();
            db.close();
            return employee_fullname;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {
                System.err.println("Failed to close the database connection: " + e.getMessage());
            }
        }
    } // End of findEmployeeNamebyMeetingId

    public String findEmployeeIdbyMeetingId(Request meeting) throws Exception {
        Connection con = null;
        String sql = "SELECT employee_id FROM meeting WHERE meeting_id=?";
        DB db = new DB();
        String employee_id = null;
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, meeting.getRequestId());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                employee_id = rs.getString("employee_id");
            }
            rs.close();
            stmt.close();
            db.close();
            return employee_id;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {
                System.err.println("Failed to close the database connection: " + e.getMessage());
            }
        }
    } // end of findEmployeeIdbyMeetingId

    public Answer getAnswerMeetingbyMeetingId(String meeting_id) throws Exception {
        Connection con = null;
        String sql = "SELECT *\n" + //
                "FROM answermeeting\n" + //
                "WHERE EXISTS (SELECT answer_id\n" + //
                "\t\t\t  FROM answermeeting as am,meeting as m\n" + //
                "\t\t\t  WHERE am.meeting_id=m.meeting_id AND m.meeting_id=?);";
        DB db = new DB();
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, meeting_id);
            ResultSet rs = stmt.executeQuery();
            if (!rs.next()) {
                rs.close();
                stmt.close();
                db.close();
                return null;
            }
            Answer answer = new Answer(rs.getString("answer_id"),
                    rs.getString("answer_text"),
                    rs.getString("meeting_id"));
            rs.close();
            stmt.close();
            db.close();
            return answer;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {
                System.err.println("Failed to close the database connection: " + e.getMessage());
            }
        }
    } // End of getAnswerMeetingbyMeetingId

    public String findEmployeeNamebyDayoffId(Request dayoff) throws Exception {
        Connection con = null;
        String sql = "SELECT DISTINCT employee_fullname FROM employee,dayoff WHERE employee.employee_id = dayoff.employee_id AND dayoff.dayoff_id=?";
        DB db = new DB();
        String employee_fullname = null;
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, dayoff.getRequestId());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                employee_fullname = rs.getString("employee_fullname");
            }
            rs.close();
            stmt.close();
            db.close();
            return employee_fullname;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {
                System.err.println("Failed to close the database connection: " + e.getMessage());
            }
        }
    } // End of findEmployeeNamebyDayoffId

    public String findEmployeeIdbyDayoffId(Request dayoff) throws Exception {
        Connection con = null;
        String sql = "SELECT employee_id FROM dayoff WHERE dayoff_id=?";
        DB db = new DB();
        String employee_id = null;
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, dayoff.getRequestId());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                employee_id = rs.getString("employee_id");
            }
            rs.close();
            stmt.close();
            db.close();
            return employee_id;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {
                System.err.println("Failed to close the database connection: " + e.getMessage());
            }
        }
    } // end of findEmployeeIdbyDayoffId

    public Answer getAnswerDayoffbyDayoffId(String dayoff_id) throws Exception {
        Connection con = null;
        String sql = "SELECT *\n" + //
                "FROM answerdayoff\n" + //
                "WHERE EXISTS (SELECT answer_id\n" + //
                "\t\t\t  FROM answerdayoff as ad,dayoff as d\n" + //
                "\t\t\t  WHERE ad.dayoff_id=d.dayoff_id AND d.dayoff_id=?);";
        DB db = new DB();
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, dayoff_id);
            ResultSet rs = stmt.executeQuery();
            if (!rs.next()) {
                rs.close();
                stmt.close();
                db.close();
                return null;
            }
            Answer answer = new Answer(rs.getString("answer_id"),
                    rs.getString("answer_text"),
                    rs.getString("dayoff_id"));
            rs.close();
            stmt.close();
            db.close();
            return answer;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {
                System.err.println("Failed to close the database connection: " + e.getMessage());
            }
        }
    } // End of getAnswerDayoffbyDayoffId
}
