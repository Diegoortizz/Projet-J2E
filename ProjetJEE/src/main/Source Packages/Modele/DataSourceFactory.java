
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.sql.DataSource;


public class DataSourceFactory {
    
    static {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(com.mycompany.exercice_jspmvc.DataSourceFactory.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static DataSource getDataSource() throws SQLException {
	org.apache.derby.jdbc.ClientDataSource ds = new org.apache.derby.jdbc.ClientDataSource();
        ds.setDatabaseName("sample");
	ds.setUser("app");
	ds.setPassword("app");
	ds.setServerName("localhost");
	ds.setPortNumber(1527);
	return ds;
    }
    
}
