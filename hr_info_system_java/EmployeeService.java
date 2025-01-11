package hr_info_system_java;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EmployeeService {
	public Employee authenticate(String username, String password) throws Exception {

		DB db = new DB();
		Connection con = null;
		String sqlquery = "SELECT * FROM employee WHERE employee_id=? AND employee_password=?;";
		try {
			con = db.getConnection();
			PreparedStatement stmt = con.prepareStatement(sqlquery);
			stmt.setString(1, username);
			stmt.setString(2, password);
			ResultSet rs = stmt.executeQuery();
			if (!rs.next()) {
				rs.close();
				stmt.close();
				db.close();
				throw new Exception("Wrong username or password");
			}
			Employee employee = new Employee(rs.getString("employee_id"),
					rs.getString("employee_password"),
					rs.getString("employee_fullname"),
					rs.getDate("employee_dateofbirth"),
					rs.getString("employee_gender"),
					rs.getString("employee_role"));
			rs.close();
			stmt.close();
			con.close();
			db.close();
			return employee;

		} catch (Exception e) {
			throw new Exception(e.getMessage());
		} finally {
			try {
				db.close();
			} catch (Exception e) {

			}
		}

	} // End of authenticate

	public List<Employee> getEmployees() throws Exception {
		Connection con = null;
		String sql = "SELECT * FROM employee";
		DB db = new DB();
		List<Employee> employees = new ArrayList<Employee>();
		try {
			con = db.getConnection();
			PreparedStatement stmt = con.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				employees.add(new Employee(rs.getString("employee_id"),
						rs.getString("employee_password"),
						rs.getString("employee_fullname"),
						rs.getDate("employee_dateofbirth"),
						rs.getString("employee_gender"),
						rs.getString("employee_role")));

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
		return employees;
	} // End of getEmployees

	public List<Request> getAcceptedRequestsbyEmployeeId(String employee_id) throws Exception {
		Connection con = null;
        String sql = "SELECT * " +
               "FROM ( " +
               "    SELECT dayoff_text AS request, startDate AS dates, NULL as times, d.dayoff_id AS id " +
               "    FROM dayoff AS d " +
               "    JOIN answerdayoff ad ON d.dayoff_id = ad.dayoff_id " +
               "    JOIN Employee e ON d.employee_id = e.employee_id " +
               "    WHERE ad.answer_text = 'accept' " +
               "      AND e.employee_id = ? " +
               "    UNION " +
               "    SELECT dayoff_text, endDate AS dates, NULL as times, d.dayoff_id " +
               "    FROM dayoff AS d " +
               "    JOIN answerdayoff ad ON d.dayoff_id = ad.dayoff_id " +
               "    JOIN Employee e ON d.employee_id = e.employee_id " +
               "    WHERE ad.answer_text = 'accept' " +
               "      AND e.employee_id = ? " +
               "    UNION " +
               "    SELECT m.meeting_subject AS request, m.meeting_date AS dates, m.meeting_time AS times, m.meeting_id AS id " +
               "    FROM Meeting m " +
               "    JOIN AnswerMeeting am ON m.meeting_id = am.meeting_id " +
               "    JOIN Employee e ON m.employee_id = e.employee_id " +
               "    WHERE am.answer_text = 'accept' " +
               "      AND e.employee_id = ? " +
               ") AS schedule " +
               "WHERE dates > CURRENT_DATE " +
               "   OR (dates = CURRENT_DATE AND (times IS NULL OR times >= CURRENT_TIME)) " +
               "ORDER BY dates, times;";

        DB db = new DB();
        List<Request> acceptedrequests = new ArrayList<Request>();
        try {
            con = db.getConnection();

            PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, employee_id);
			stmt.setString(2, employee_id);
			stmt.setString(3, employee_id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                acceptedrequests.add(new Request(rs.getString("id"),
						rs.getString("request"),
						rs.getDate("dates"),
						rs.getTime("times")));
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
        return acceptedrequests;

	}//end of getAcceptedRequestsbyEmployeeId

}
