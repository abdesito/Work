import java.sql.*;
import java.util.Scanner;

public class Delivery {
    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/Delivery";
    static final String USER = "root";
    static final String PASS = "abdellah2005";

    public static void main(String[] args) {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Scanner scanner = new Scanner(System.in);
        double costoTotal = 0;

        try {
            Class.forName(JDBC_DRIVER);
            System.out.println("Conectando a la base de datos...");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            System.out.println("Conexión exitosa!");
            
            // Consulta para obtener los restaurantes disponibles
            String sql = "SELECT id, nombre FROM Restaurantes";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            // Mostrar los restaurantes disponibles al usuario
            System.out.println("Restaurantes Disponibles:");
            System.out.println("=========================");
            while (rs.next()) {
                int id = rs.getInt("id");
                String nombre = rs.getString("nombre");
                System.out.println(id + ". " + nombre);
            }
            System.out.println("=========================");

            // Solicitar al usuario el ID del restaurante
            System.out.println("Ingrese el ID del restaurante:");
            int restauranteId = scanner.nextInt();
            
            

            do {


                // Consulta para obtener los platos del restaurante seleccionado
                sql = "SELECT id, nombre, precio FROM Platos WHERE restaurante_id = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, restauranteId);
                rs = pstmt.executeQuery();

                // Mostrar los platos del restaurante seleccionado al usuario
                System.out.println("Platos del Restaurante:");
                System.out.println("=========================");
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String nombre = rs.getString("nombre");
                    double precio = rs.getDouble("precio");
                    System.out.println(id + ". " + nombre + " - $" + precio);
                }
                System.out.println("=========================");

                // Solicitar al usuario el ID del plato que desea pedir
                System.out.println("Ingrese el ID del plato que desea pedir:");
                int platoId = scanner.nextInt();

                // Consulta para obtener los ingredientes del plato seleccionado
                sql = "SELECT i.id, i.nombre FROM Ingredientes i " +
                        "JOIN Platos_Ingredientes pi ON i.id = pi.ingrediente_id " +
                        "WHERE pi.plato_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, platoId);
                rs = pstmt.executeQuery();

                // Mostrar los ingredientes del plato seleccionado al usuario
                System.out.println("Ingredientes del Plato:");
                System.out.println("=========================");
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String nombre = rs.getString("nombre");
                    System.out.println(id + ". " + nombre);
                }
                System.out.println("=========================");

                // Solicitar al usuario un comentario para el pedido
                System.out.println("Ingrese un comentario para este pedido (o deje en blanco si no desea agregar ningún comentario):");
                scanner.nextLine(); // Limpiar el buffer del scanner
                String comentario = scanner.nextLine();

                // Insertar el pedido en la tabla Pedidos
                sql = "INSERT INTO Pedidos (plato_id, cantidad) VALUES (?, ?)";
                pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                pstmt.setInt(1, platoId);
                pstmt.setInt(2, 1); // Por ahora, asumiremos que el usuario solicita solo 1 plato
                pstmt.executeUpdate();

                // Obtener el ID del pedido recién insertado
                int pedidoId;
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    pedidoId = generatedKeys.getInt(1);
                } else {
                    throw new SQLException("No se pudo obtener el ID del pedido.");
                }

                // Insertar el pedido en la tabla Pedidos_Platos junto con el comentario
                sql = "INSERT INTO Pedidos_Platos (pedido_id, plato_id, comentario) VALUES (?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, pedidoId);
                pstmt.setInt(2, platoId);
                pstmt.setString(3, comentario);
                pstmt.executeUpdate();

                // Obtener el precio del plato y sumarlo al costo total
                sql = "SELECT precio FROM Platos WHERE id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, platoId);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    double precioPlato = rs.getDouble("precio");
                    costoTotal += precioPlato;
                }

                System.out.println("Pedido realizado exitosamente!");

                // Preguntar al usuario si desea pedir otro plato en el mismo pedido
                System.out.println("¿Desea pedir otro plato en el mismo pedido? (SI/NO)");
                String respuesta = scanner.next();
                if (!respuesta.equalsIgnoreCase("SI")) {
                    break;
                }

            } while (true);

            System.out.println("El costo total del pedido es: $" + costoTotal);

        } catch (SQLException se) {
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
                scanner.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }
}
