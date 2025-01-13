import java.sql.Connection;

import java.sql.DriverManager;

import java.sql.PreparedStatement;

import java.sql.ResultSet;

import java.sql.SQLException;

import java.sql.Timestamp;
 
public class Tiendita {

    // Información de conexión a la base de datos

    private static final String URL = "jdbc:mysql://localhost:3306/tienda_online";

    private static final String USER = "root";

    private static final String PASSWORD = "abdellah2005";
 
    // Método para insertar un nuevo cliente en la tabla clientes

    public void insertarCliente(String nombre, String email, String direccion, String dni) {

        String sql = "INSERT INTO clientes (nombre, email, direccion, dni) VALUES (?, ?, ?, ?)";
 
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);

             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, nombre);

            stmt.setString(2, email);

            stmt.setString(3, direccion);

            stmt.setString(4, dni);

            stmt.executeUpdate();

            System.out.println("Cliente insertado correctamente.");

        } catch (SQLException e) {

            System.err.println("Error al insertar cliente: " + e.getMessage());

        }

    }
 
    // Método para insertar un nuevo producto en la tabla productos

    public void insertarProducto(String nombre, String descripcion, double precio) {

        String sql = "INSERT INTO productos (nombre, descripcion, precio) VALUES (?, ?, ?)";
 
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);

             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, nombre);

            stmt.setString(2, descripcion);

            stmt.setDouble(3, precio);

            stmt.executeUpdate();

            System.out.println("Producto insertado correctamente.");

        } catch (SQLException e) {

            System.err.println("Error al insertar producto: " + e.getMessage());

        }

    }
 
    // Método para insertar un nuevo pedido en la tabla pedidos

    public void insertarPedido(int clienteId) {

        String sql = "INSERT INTO pedidos (cliente_id) VALUES (?)";
 
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);

             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, clienteId);

            stmt.executeUpdate();

            System.out.println("Pedido insertado correctamente.");

        } catch (SQLException e) {

            System.err.println("Error al insertar pedido: " + e.getMessage());

        }

    }
 
    // Método para insertar un nuevo detalle de pedido en la tabla detalles_pedido

    public void insertarDetallePedido(int pedidoId, int productoId, int cantidad, double precioUnitario) {

        String sql = "INSERT INTO detalles_pedido (pedido_id, producto_id, cantidad, precio_unitario) VALUES (?, ?, ?, ?)";
 
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);

             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, pedidoId);

            stmt.setInt(2, productoId);

            stmt.setInt(3, cantidad);

            stmt.setDouble(4, precioUnitario);

            stmt.executeUpdate();

            System.out.println("Detalle de pedido insertado correctamente.");

        } catch (SQLException e) {

            System.err.println("Error al insertar detalle de pedido: " + e.getMessage());

        }

    }
 
    // Método principal para probar los métodos de inserción

    public static void main(String[] args) {

        Tiendita tiendaOnlineDAO = new Tiendita();
 
        // Ejemplo de uso: insertar un cliente

        tiendaOnlineDAO.insertarCliente("Abde Sahad", "abde@gmail.com", "Calle Principal 123", "12345678A");
 
        // Ejemplo de uso: insertar un producto

        tiendaOnlineDAO.insertarProducto("Camiseta", "Camiseta de algodón de manga corta", 15.99);
 
        // Ejemplo de uso: insertar un pedido

        tiendaOnlineDAO.insertarPedido(1); // Aquí deberías pasar el ID del cliente que realizó el pedido
 
        // Ejemplo de uso: insertar un detalle de pedido

        tiendaOnlineDAO.insertarDetallePedido(1, 1, 2, 15.99); // Aquí deberías pasar el ID del pedido, el ID del producto, la cantidad y el precio unitario
 
        // Consultar pedidos de un cliente por su DNI

        System.out.println("\nPedidos del cliente con DNI :");

        tiendaOnlineDAO.consultarPedidosPorDNI("12345678A");
 
        // Consultar todos los productos

        System.out.println("\nTodos los productos:");

        tiendaOnlineDAO.consultarProductos();
 
        // Consultar todos los pedidos

        System.out.println("\nTodos los pedidos:");

        tiendaOnlineDAO.consultarPedidos();

    }
 
    // Método para consultar clientes

    public void consultarClientes() {

        String sql = "SELECT * FROM clientes";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {

                try (PreparedStatement stmt = conn.prepareStatement(sql);

                     ResultSet rs = stmt.executeQuery()) {
 
                    while (rs.next()) {

                        int id = rs.getInt("id");

                        String nombre = rs.getString("nombre");

                        String email = rs.getString("email");

                        String direccion = rs.getString("direccion");
 
                        System.out.println("ID: " + id + ", Nombre: " + nombre + ", Email: " + email + ", Dirección: " + direccion);

                    }

                }

        } catch (SQLException e) {

            System.err.println("Error al consultar clientes: " + e.getMessage());

        }

    }
 
    // Método para consultar todos los productos

    public void consultarProductos() {

        String sql = "SELECT * FROM productos";
 
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {

            if (conn != null) {

                try (PreparedStatement stmt = conn.prepareStatement(sql);

                     ResultSet rs = stmt.executeQuery()) {
 
                    while (rs.next()) {

                        int id = rs.getInt("id");

                        String nombre = rs.getString("nombre");

                        String descripcion = rs.getString("descripcion");

                        double precio = rs.getDouble("precio");
 
                        System.out.println("ID: " + id + ", Nombre: " + nombre + ", Descripción: " + descripcion + ", Precio: " + precio);

                    }

                }

            } else {

                System.err.println("No se pudo establecer la conexión con la base de datos.");

            }

        } catch (SQLException e) {

            System.err.println("Error al consultar productos: " + e.getMessage());

        }

    }
 
    // Método para consultar todos los pedidos

    public void consultarPedidos() {

        String sql = "SELECT * FROM pedidos";
 
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {

            if (conn != null) {

                try (PreparedStatement stmt = conn.prepareStatement(sql);

                     ResultSet rs = stmt.executeQuery()) {
 
                    while (rs.next()) {

                        int id = rs.getInt("id");

                        int clienteId = rs.getInt("cliente_id");

                        Timestamp fechaPedido = rs.getTimestamp("fecha_pedido");
 
                        System.out.println("ID: " + id + ", Cliente ID: " + clienteId + ", Fecha de pedido: " + fechaPedido);

                    }

                }

            } else {

                System.err.println("No se pudo establecer la conexión con la base de datos.");

            }

        } catch (SQLException e) {

            System.err.println("Error al consultar pedidos: " + e.getMessage());

        }

    }
 
// Método para consultar pedidos de un cliente por su DNI

    public void consultarPedidosPorDNI(String dni) {

        String sql = "SELECT p.* FROM pedidos p JOIN clientes c ON p.cliente_id = c.id WHERE c.dni = ?";
 
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);

             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Establecer el valor del parámetro en la consulta

            stmt.setString(1, dni);
 
            try (ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {

                    int idPedido = rs.getInt(1);

                    int cliente_id = rs.getInt(2);

                    String fecha_pedido = rs.getString(3);

                    System.out.println(idPedido + cliente_id + fecha_pedido);

                    // Otener y procesar los datos de los pedidos

                }

            }

        } catch (SQLException e) {

            System.err.println("Error al consultar pedidos por DNI: " + e.getMessage());

        }

    }
 
 
    private Connection getConnection1() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            return DriverManager.getConnection(URL, USER, PASSWORD);

        } catch (SQLException | ClassNotFoundException e) {

            System.err.println("Error al establecer la conexión con la base de datos: " + e.getMessage());

            return null;

        }

    }
 
 
  


		private Connection getConnection() {

			return null;

		}

}
