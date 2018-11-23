package Modele;


import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import javax.sql.DataSource;
import org.hsqldb.cmdline.SqlFile;
import org.hsqldb.cmdline.SqlToolError;
import org.junit.After;
import org.junit.Before;
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
        System.out.println(sqlFilePath);
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
        System.out.println(c);
        assertEquals("Apple",c.getName());
    }

    private DataSource getDataSource() {
        org.hsqldb.jdbc.JDBCDataSource ds = new org.hsqldb.jdbc.JDBCDataSource();
	ds.setDatabase("jdbc:hsqldb:mem:testcase;shutdown=true");
	ds.setUser("sa");
	ds.setPassword("sa");
	return ds;
    }
    
    @Test
    public void CustomerNameTest() throws SQLException {
        String name = myDAO.nameOfCustomer(30);
        assertEquals("IBM",name);
    }
    
    @Test
    public void NumberCustomerTest() throws SQLException {
        int n = myDAO.numberCustomer();
        assertEquals(3,n);
    }
    
    @Test
    public void AllEmailsTest() throws SQLException {
        List<String> email = myDAO.allEmails();
        assertEquals(myDAO.numberCustomer(),email.size());
    }
    
    @Test
    public void UpdateNameTest() throws SQLException {
        String name1 = myDAO.nameOfCustomer(10);
        assertEquals("Apple",name1);
        myDAO.updateName("Google", 10);
        String name2 = myDAO.nameOfCustomer(10);
        assertEquals("Google",name2);
    }
    
    @Test
    public void ListCustomerIDTest() throws SQLException {
        List<Integer> id = myDAO.listCustomerID();
        assertEquals(myDAO.numberCustomer(),id.size());
    }
    
    @Test
    public void NumberProductTest() throws SQLException {
        int n = myDAO.numberProduct();
        assertEquals(2,n);
    }
    
//    @Test
//    public void NumberDiscountTest() throws SQLException {
//        int n = myDAO.numberDiscount();
//        assertEquals(2,n);
//    }
//    
//    @Test
//    public void insertProductTest() throws SQLException{
//        myDAO.insertProduct(45, 666, "SW", 5.5, 20, 5.5, true, "Description en cours");
//        
//        assertEquals(myDAO.numberProduct(),3);
//    }
//    
//    @Test
//    public void deleteProductTest() throws SQLException{
//        myDAO.insertProduct(45, 666, "SW", 5.5, 20, 5.5, true, "Description en cours");
//        myDAO.deleteProduct(45);
//        assertEquals(myDAO.numberProduct(),2);
//    }
    
    @Test
    public void AllCodesTest() throws SQLException {
        List<Discount> codes = myDAO.allCodes();
        assertEquals(myDAO.numberDiscount(),codes.size());
    }
    
    @Test
    public void insertDiscountTest() throws Exception{
        myDAO.addDiscount_Code("F", 45);
        assertEquals(myDAO.numberDiscount(),3);
    }
    
    @Test
    public void deleteDiscountTest() throws Exception{
        myDAO.addDiscount_Code("F", 45);
        myDAO.deleteDiscount_Code("F");
        assertEquals(myDAO.numberDiscount(),2);
    }
}



