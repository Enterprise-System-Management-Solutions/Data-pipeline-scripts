import java.io.FileWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
public class DbToCSV {
    public static void main(String[] args) {
        String filename ="location.csv";
        String date = "1/13/2020";
        String datekey = "";
        String d = "13";
        String month = "01";
        String year = "2020";
        
        try {
            FileWriter fw = new FileWriter(filename);
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@192.168.61.240:1521:dwh01","dwh_user","dwh_user_123");
            
            
            String query = "select * from date_dim where days=" + d +
            		" and month_num=" + month + " and year=" + year;
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            rs.next();
            datekey = rs.getString(1);
            System.out.println("Found ittt -> " + datekey);
            
            
            query = "select * from L2_VOICE where ETL_DATE_KEY="+datekey;
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);
            int count = 20;
            while (rs.next()) {
            	
            	for(int i=1;i<20;i++) {
            		if(i==10) {
            			fw.append(rs.getString(i));
		        		fw.append(',');
            		} else {
		        		fw.append(rs.getString(i));
		        		fw.append(',');
            		}
            	}
            	fw.append('\n');
            	count--;
                if(count == 0) break;     
            }
            fw.flush();
            fw.close();
            conn.close();
            System.out.println("CSV File is created successfully.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
