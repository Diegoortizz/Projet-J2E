package Modele;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.sql.DataSource;

public class DAO {

    private final DataSource myDataSource;

    public DAO(DataSource dataSource) {
        this.myDataSource = dataSource;
    }

    //Méthodes
    public Customer Customer(String email) throws SQLException {
        Customer c = null;
        String sql = "SELECT * FROM Customer WHERE email = ?";
        try (Connection myConnection = myDataSource.getConnection();
                PreparedStatement statement = myConnection.prepareStatement(sql)) {
            statement.setString(1, email); // On fixe le 1° paramètre de la requête
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    int id = rs.getInt("CUSTOMER_ID");
                    String name = rs.getString("NAME");
                    String adress = rs.getString("ADDRESSLINE1");
                    String city = rs.getString("CITY");
                    String state = rs.getString("STATE");
                    String phone = rs.getString("PHONE");
                    String fax = rs.getString("FAX");
                    int credit = rs.getInt("CREDIT_LIMIT");
                    c = new Customer(id,name,adress,city,state,phone,fax,email,credit);
                }
            }
        }
        return c;
    }
    
    public String nameOfCustomer(int id) throws SQLException {
        String result = null;
        String sql = "SELECT Name FROM Customer WHERE CUSTOMER_ID = ?";
        try (Connection myConnection = myDataSource.getConnection();
                PreparedStatement statement = myConnection.prepareStatement(sql)) {
            statement.setInt(1, id); // On fixe le 1° paramètre de la requête
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    result = resultSet.getString("Name");
                }
            }
        }
        return result;
    }
    
    

    public List<String> allEmails() throws SQLException {
        List<String> result = new LinkedList<>();
        String sql = "SELECT EMAIL FROM Customer";
        try (Connection connection = myDataSource.getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String email = rs.getString("EMAIL");
                
                result.add(email);
            }
        }
        return result;
    }
    
    public List<Integer> listCustomerID() throws SQLException {
        List<Integer> list = new LinkedList();
        String sql = "SELECT Customer_ID FROM Customer AS Liste";
        try (Connection connection = myDataSource.getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(rs.getInt("Customer_ID"));
            }
        }
        return list;
    }

    public List<Discount> allCodes() throws SQLException {

        List<Discount> result = new LinkedList<>();

        String sql = "SELECT * FROM DISCOUNT_CODE ORDER BY DISCOUNT_CODE";
        try (Connection connection = myDataSource.getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String id = rs.getString("DISCOUNT_CODE");
                float rate = rs.getFloat("RATE");
                Discount c = new Discount(id, rate);
                result.add(c);
            }
        }
        return result;
    }

    public Product findProduct(int productId) throws SQLException {
        Product result = null;

        String sql = "SELECT * FROM PRODUCT WHERE PRODUCT_ID = ?";
        try (Connection myConnection = myDataSource.getConnection();
                PreparedStatement statement = myConnection.prepareStatement(sql)) {
            statement.setInt(1, productId); // On fixe le 1° paramètre de la requête
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    // est-ce qu'il y a un résultat ? (pas besoin de "while", 
                    // il y a au plus un enregistrement)
                    // On récupère les champs de l'enregistrement courant
                    result = new Product(productId,
                            resultSet.getString("Description"));
                }
            }
        }
        return result;
    }
    
    
    
    public int updateName(String name, int id) throws Exception {

        // Une requête SQL paramétrée
        String sql = "UPDATE CUSTOMER SET NAME=? WHERE CUSTOMER_ID=?";
        try (Connection connection = myDataSource.getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            // Définir la valeur du paramètre
            stmt.setString(1, name);
            stmt.setInt(2, id);

            return stmt.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }
    //Faut que le man_id soit dans MANUFACTURER et que le code soit dans PRODUCT_CODE
    public void insertProduct(int id, int man_id, String code, float Purchase, int quantity, float markup, boolean available, String Description) throws SQLException {
        // Une requête SQL paramétrée
        String sql = "INSERT INTO PRODUCT VALUES(?, ?, ?,?,?,?,?,?)";
        try (Connection connection = myDataSource.getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            // Définir la valeur du paramètre
            stmt.setInt(1, id);
            stmt.setInt(2, man_id);
            stmt.setString(3, code);
            stmt.setFloat(4, Purchase);
            stmt.setInt(5, quantity);
            stmt.setFloat(6, markup);
            stmt.setBoolean(7,available);
            stmt.setString(8,Description);

            stmt.executeUpdate();
        }
    }

    public int deleteProduct(int id) throws Exception {

        // Une requête SQL paramétrée
        String sql = "DELETE FROM PRODUCT WHERE PRODUCT_ID= ?";
        try (Connection connection = myDataSource.getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            // Définir la valeur du paramètre
            stmt.setInt(1, id);

            return stmt.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }
    
    public int deleteDiscount_Code(String Code) throws Exception {

        // Une requête SQL paramétrée
        String sql = "DELETE FROM DISCOUNT_CODE AS AUX WHERE DISCOUNT_CODE= ?";
        try (Connection connection = myDataSource.getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            // Définir la valeur du paramètre
            stmt.setString(1, Code);

            return stmt.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    public int updateDiscount_Code(String code, Float taux) throws Exception {

        // Une requête SQL paramétrée
        String sql = "UPDATE APP.DISCOUNT_CODE SET RATE = ? WHERE DISCOUNT_CODE = ?";
        try (Connection connection = myDataSource.getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            // Définir la valeur du paramètre
            stmt.setFloat(1, taux);
            stmt.setString(2, code);

            return stmt.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    public int addDiscount_Code(String Code, float Taux) throws Exception {

        // Une requête SQL paramétrée
        String sql = "INSERT INTO DISCOUNT_CODE VALUES (?,?)";
        try (Connection connection = myDataSource.getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            // Définir la valeur du paramètre
            stmt.setString(1, Code);
            stmt.setFloat(2, Taux);

            return stmt.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }
    
}
