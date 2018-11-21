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
    public String nameOfCustomer(int id) throws SQLException {
        String result = null;
        String sql = "SELECT Name FROM Customer WHERE ID = ?";
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

        String sql = "SELECT * FROM Product WHERE ID = ?";
        try (Connection myConnection = myDataSource.getConnection();
                PreparedStatement statement = myConnection.prepareStatement(sql)) {
            statement.setInt(1, productId); // On fixe le 1° paramètre de la requête
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    // est-ce qu'il y a un résultat ? (pas besoin de "while", 
                    // il y a au plus un enregistrement)
                    // On récupère les champs de l'enregistrement courant
                    result = new Product(productId,
                            resultSet.getString("Name"),
                            resultSet.getFloat("Price"));
                }
            }
        }
        return result;
    }

    public void insertProduct(Product product) throws SQLException {

        // Une requête SQL paramétrée
        String sql = "INSERT INTO PRODUCT VALUES(?, ?, ?)";
        try (Connection connection = myDataSource.getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            // Définir la valeur du paramètre
            stmt.setInt(1, product.getId());
            stmt.setString(2, product.getName());
            stmt.setFloat(3, product.getPrice());

            stmt.executeUpdate();

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
