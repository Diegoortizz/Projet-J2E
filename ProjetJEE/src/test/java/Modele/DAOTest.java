package Modele;


import Modele.DAO;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.sql.DataSource;
import org.hsqldb.cmdline.SqlFile;
import org.hsqldb.cmdline.SqlToolError;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

public class DAOTest {
    
    private static DataSource myDataSource; // La source de données à utiliser
    private static Connection myConnection ;	
    private DAO myDAO;
    
    @Before
    public void setUp() throws SQLException, IOException, SqlToolError {
        
        // On crée la connection vers la base de test "in memory"
        myDataSource = getDataSource();
	myConnection = myDataSource.getConnection();
        
        // On initialise la base avec le contenu d'un fichier de test
        String sqlFilePath = DAOTest.class.getResource("TestData.sql").getFile();
	SqlFile sqlFile = new SqlFile(new File(sqlFilePath));
	sqlFile.setConnection(myConnection);
	sqlFile.execute();
	sqlFile.closeReader();
        
        // On crée l'objet à tester
	myDAO = new DAO(myDataSource);
        
    }
    
    @After
    public void tearDown() throws SQLException {
        myConnection.close();
    }
    
    @Test
    public void CustomerTest() throws SQLException {
        Customer c = myDAO.Customer("apple@example.com");
        assertEquals("apple",c.getName());
    }

    private DataSource getDataSource() {
        org.hsqldb.jdbc.JDBCDataSource ds = new org.hsqldb.jdbc.JDBCDataSource();
	ds.setDatabase("jdbc:hsqldb:mem:testcase;shutdown=true");
	ds.setUser("sa");
	ds.setPassword("sa");
	return ds;
    }

}
