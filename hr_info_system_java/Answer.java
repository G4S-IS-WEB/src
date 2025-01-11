package hr_info_system_java;

public class Answer {

    private String answer_id;
    private String answer_body;
    private String request_id;
    
        // Constructor Answer java
        //Used to get Parameters from forms
        public Answer(String answer_body) {
            AnswerService as = new AnswerService();
            this.answer_id = generateNextId(as);
            this.answer_body = answer_body;
        }
    
        //Constructor Answer DB
        //Used to get columns from DB tables and to show them on answers.jsp
    
        public Answer(String answer_id,String answer_body,String request_id) {
            this.answer_id = answer_id;
            this.answer_body = answer_body;
            this.request_id = request_id;
        }

        

    private static String holder="A0000001";
    private static String generateNextId(AnswerService as) {
        try {
        holder = as.maxAnswerId(); 
        if (holder == "A0000001") {
            return "A0000001";
        }
        int numericPart = Integer.parseInt(holder.substring(1));
        numericPart++;
        return String.format("A%07d", numericPart);
        } catch (Exception e) {
            return e.getMessage();
    }
}    

    // Setters and Getters

    public String getAnswerId() {
        return answer_id;
    }

    public void setAnswerId(String answer_id) {
        this.answer_id = answer_id;
    }

    public String getAnswerBody() {
        return answer_body;
    }

    public void setAnswerBody(String answer_body) {
        this.answer_body = answer_body;
    }

    public String getRequestId() {
        return request_id;
    }

    public void setRequestId(String request_id) {
        this.request_id = request_id;
    }
}