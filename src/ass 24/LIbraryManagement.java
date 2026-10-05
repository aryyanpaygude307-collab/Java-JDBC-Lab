import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.sql.*;

class LibraryManagement extends JFrame {

    JTextField bookIdField, titleField, authorField, quantityField;
    JTable table;
    DefaultTableModel model;

    String url = "jdbc:mysql://localhost:3306/javalab";
    String user = "root";
    String password = "ARYYAN@307";

    public LibraryManagement() {

        setTitle("Library Management System");
        setSize(800, 550);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        JPanel formPanel = new JPanel(new GridLayout(4, 2, 10, 10));

        formPanel.add(new JLabel("Book ID:"));
        bookIdField = new JTextField();
        formPanel.add(bookIdField);

        formPanel.add(new JLabel("Book Title:"));
        titleField = new JTextField();
        formPanel.add(titleField);

        formPanel.add(new JLabel("Author:"));
        authorField = new JTextField();
        formPanel.add(authorField);

        formPanel.add(new JLabel("Quantity:"));
        quantityField = new JTextField();
        formPanel.add(quantityField);

        JButton addButton = new JButton("Add Book");
        JButton updateButton = new JButton("Update Book");
        JButton deleteButton = new JButton("Delete Book");
        JButton clearButton = new JButton("Clear");

        JPanel buttonPanel = new JPanel();

        buttonPanel.add(addButton);
        buttonPanel.add(updateButton);
        buttonPanel.add(deleteButton);
        buttonPanel.add(clearButton);

        model = new DefaultTableModel();

        model.addColumn("Book ID");
        model.addColumn("Title");
        model.addColumn("Author");
        model.addColumn("Quantity");

        table = new JTable(model);

        JScrollPane scrollPane = new JScrollPane(table);

        add(formPanel, BorderLayout.NORTH);
        add(buttonPanel, BorderLayout.CENTER);
        add(scrollPane, BorderLayout.SOUTH);

        addButton.addActionListener(e -> addBook());
        updateButton.addActionListener(e -> updateBook());
        deleteButton.addActionListener(e -> deleteBook());
        clearButton.addActionListener(e -> clearFields());

        table.getSelectionModel().addListSelectionListener(e -> {

            if (!e.getValueIsAdjusting()) {

                int row = table.getSelectedRow();

                if (row >= 0) {

                    bookIdField.setText(model.getValueAt(row, 0).toString());
                    titleField.setText(model.getValueAt(row, 1).toString());
                    authorField.setText(model.getValueAt(row, 2).toString());
                    quantityField.setText(model.getValueAt(row, 3).toString());
                }
            }
        });

        loadBooks();

        setVisible(true);
    }

    Connection getConnection() throws Exception {

        Class.forName("com.mysql.cj.jdbc.Driver");

        return DriverManager.getConnection(
                url,
                user,
                password
        );
    }

    void loadBooks() {

        model.setRowCount(0);

        try {

            Connection con = getConnection();

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery(
                    "SELECT * FROM books"
            );

            while (rs.next()) {

                model.addRow(new Object[]{
                        rs.getInt("book_id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getInt("quantity")
                });
            }

            rs.close();
            stmt.close();
            con.close();

        } catch (Exception e) {

            JOptionPane.showMessageDialog(
                    this,
                    "Error: " + e.getMessage()
            );
        }
    }

    void addBook() {

        try {

            Connection con = getConnection();

            String query =
                    "INSERT INTO books VALUES (?, ?, ?, ?)";

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, Integer.parseInt(bookIdField.getText()));
            ps.setString(2, titleField.getText());
            ps.setString(3, authorField.getText());
            ps.setInt(4, Integer.parseInt(quantityField.getText()));

            ps.executeUpdate();

            JOptionPane.showMessageDialog(
                    this,
                    "Book added successfully!"
            );

            ps.close();
            con.close();

            loadBooks();
            clearFields();

        } catch (Exception e) {

            JOptionPane.showMessageDialog(
                    this,
                    "Error: " + e.getMessage()
            );
        }
    }

    void updateBook() {

        try {

            Connection con = getConnection();

            String query =
                    "UPDATE books SET title=?, author=?, quantity=? WHERE book_id=?";

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setString(1, titleField.getText());
            ps.setString(2, authorField.getText());
            ps.setInt(3, Integer.parseInt(quantityField.getText()));
            ps.setInt(4, Integer.parseInt(bookIdField.getText()));

            int result = ps.executeUpdate();

            if (result > 0) {

                JOptionPane.showMessageDialog(
                        this,
                        "Book updated successfully!"
                );

            } else {

                JOptionPane.showMessageDialog(
                        this,
                        "Book not found!"
                );
            }

            ps.close();
            con.close();

            loadBooks();
            clearFields();

        } catch (Exception e) {

            JOptionPane.showMessageDialog(
                    this,
                    "Error: " + e.getMessage()
            );
        }
    }

    void deleteBook() {

        try {

            Connection con = getConnection();

            String query =
                    "DELETE FROM books WHERE book_id=?";

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(
                    1,
                    Integer.parseInt(bookIdField.getText())
            );

            int result = ps.executeUpdate();

            if (result > 0) {

                JOptionPane.showMessageDialog(
                        this,
                        "Book deleted successfully!"
                );

            } else {

                JOptionPane.showMessageDialog(
                        this,
                        "Book not found!"
                );
            }

            ps.close();
            con.close();

            loadBooks();
            clearFields();

        } catch (Exception e) {

            JOptionPane.showMessageDialog(
                    this,
                    "Error: " + e.getMessage()
            );
        }
    }

    void clearFields() {

        bookIdField.setText("");
        titleField.setText("");
        authorField.setText("");
        quantityField.setText("");

        table.clearSelection();
    }

    public static void main(String[] args) {

        SwingUtilities.invokeLater(
                () -> new LibraryManagement()
        );
    }
}