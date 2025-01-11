package hr_info_system_java;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AnswerService {

    public String maxAnswerId() throws Exception {
        Connection con = null;
        String sql = "SELECT MAX(max_id) AS answer_id FROM ( SELECT MAX(answer_id) AS max_id FROM answercomplaint  UNION  SELECT MAX(answer_id) AS max_id FROM answermeeting  UNION  SELECT MAX(answer_id) AS max_id FROM answerdayoff ) AS answer_ids;";
        DB db = new DB();
        String answer_id = null;
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                answer_id = rs.getString("answer_id");
            }
            if (answer_id == null) {
                answer_id = "A0000001";
            }
            rs.close();
            stmt.close();
            db.close();
            return answer_id;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {
                System.err.println("Failed to close the database connection: " + e.getMessage());
            }
        }
    } // end of maxAnswerId

    public void newAnswerComplaint(Answer answer, String complaint_id) throws Exception {
        Connection con = null;
        String sql = "INSERT INTO answercomplaint (answer_id, answer_text, complaint_id)"
                + "VALUES (?, ?, ?)";
        DB db = new DB();
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, answer.getAnswerId());
            stmt.setString(2, answer.getAnswerBody());
            stmt.setString(3, complaint_id);
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

    public void newAnswerMeeting(Answer answer, String meeting_id) throws Exception {
        Connection con = null;
        String sql = "INSERT INTO answermeeting (answer_id, answer_text, meeting_id)"
                + "VALUES (?, ?, ?)";
        DB db = new DB();
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, answer.getAnswerId());
            stmt.setString(2, answer.getAnswerBody());
            stmt.setString(3, meeting_id);
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

    public void newAnswerDayOff(Answer answer, String dayoff_id) throws Exception {
        Connection con = null;
        String sql = "INSERT INTO answerdayoff (answer_id, answer_text, dayoff_id)"
                + "VALUES (?, ?, ?)";
        DB db = new DB();
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, answer.getAnswerId());
            stmt.setString(2, answer.getAnswerBody());
            stmt.setString(3, dayoff_id);
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

    public void deleteAnswerDayOff(String dayoff_id) throws Exception {
        Connection con = null;
        String sql = "DELETE FROM answerdayoff WHERE dayoff_id=?;";
        DB db = new DB();
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, dayoff_id);
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

    public void deleteAnswerMeeting(String meeting_id) throws Exception {
        Connection con = null;
        String sql = "DELETE FROM answermeeting WHERE meeting_id=?;";
        DB db = new DB();
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, meeting_id);
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

    public void deleteAnswerComplaint(String complaint_id) throws Exception {
        Connection con = null;
        String sql = "DELETE FROM answercomplaint WHERE complaint_id=?;";
        DB db = new DB();
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, complaint_id);
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

    public List<Answer> getAnswerComplaints(String employee_id) throws Exception {
        Connection con = null;
        String sql = "SELECT ac.answer_id,ac.answer_text,ac.complaint_id FROM AnswerComplaint ac INNER JOIN Complaint c ON ac.complaint_id = c.complaint_id INNER JOIN Employee e ON c.employee_id = e.employee_id WHERE e.employee_id = ?;";
        DB db = new DB();
        List<Answer> answercomplaints = new ArrayList<Answer>();
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, employee_id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                answercomplaints.add(new Answer(rs.getString("answer_id"),
                        rs.getString("answer_text"),
                        rs.getString("complaint_id")));
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
        return answercomplaints;
    } // End of getAnswerComplaints

    public List<Answer> getAnswerMeetings(String employee_id) throws Exception {
        Connection con = null;
        String sql = "SELECT am.answer_id,am.answer_text,am.meeting_id FROM AnswerMeeting am INNER JOIN Meeting m ON am.meeting_id = m.meeting_id INNER JOIN Employee e ON m.employee_id = e.employee_id WHERE e.employee_id = ?;";
        DB db = new DB();
        List<Answer> answermeetings = new ArrayList<Answer>();
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, employee_id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                answermeetings.add(new Answer(rs.getString("answer_id"),
                        rs.getString("answer_text"),
                        rs.getString("meeting_id")));
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
        return answermeetings;
    } // End of getAnswerMeetings

    public List<Answer> getAnswerDaysOff(String employee_id) throws Exception {
        Connection con = null;
        String sql = "SELECT ad.answer_id,ad.answer_text,ad.dayoff_id FROM AnswerDayoff ad INNER JOIN Dayoff d ON ad.dayoff_id = d.dayoff_id INNER JOIN Employee e ON d.employee_id = e.employee_id WHERE e.employee_id = ?;";
        DB db = new DB();
        List<Answer> answerdaysOff = new ArrayList<Answer>();
        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, employee_id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                answerdaysOff.add(new Answer(rs.getString("answer_id"),
                        rs.getString("answer_text"),
                        rs.getString("dayoff_id")));
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
        return answerdaysOff;
    } // End of getAnswerDaysOff
}
