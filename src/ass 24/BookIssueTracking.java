import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.sql.*;

class BookIssueTracking extends JFrame {

    JTextField bookIdField;
    JTextField studentNameField;
    JTextField issueDateField;
    JTextField returnDateField;

    JTable table;
    DefaultTableModel model;

    String url = "jdbc:mysql://localhost:3306/javalab";
    String user = "root";
    String password = "ARYYAN@307";

    BookIssueTracking() {

        setTitle("Book Issue Tracking System");
        setSize(850, 550);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        JPanel formPanel = new JPanel(
                new GridLayout(4, 2, 10, 10)
        );

        formPanel.add(new JLabel("Book ID:"));

        bookIdField = new JTextField();
        formPanel.add(bookIdField);

        formPanel.add(new JLabel("Student Name:"));

        studentNameField = new JTextField();
        formPanel.add(studentNameField);

        formPanel.add(new JLabel("Issue Date (YYYY-MM-DD):"));

        issueDateField = new JTextField();
        formPanel.add(issueDateField);

        formPanel.add(new JLabel("Return Date (YYYY-MM-DD):"));

        returnDateField = new JTextField();
        formPanel.add(returnDateField);

        JButton addButton = new JButton("Issue Book");
        JButton updateButton = new JButton("Update");
        JButton deleteButton = new JButton("Delete");
        JButton clearButton = new JButton("Clear");

        JPanel buttonPanel = new JPanel();

        buttonPanel.add(addButton);
        buttonPanel.add(updateButton);
        buttonPanel.add(deleteButton);
        buttonPanel.add(clearButton);

        model = new DefaultTableModel();

        model.addColumn("Book ID");
        model.addColumn("Student Name");
        model.addColumn("Issue Date");
        model.addColumn("Return Date");

        table = new JTable(model);

        JScrollPane scrollPane =
                new JScrollPane(table);

        JPanel topPanel = new JPanel(
                new BorderLayout()
        );

        topPanel.add(formPanel, BorderLayout.NORTH);
        topPanel.add(buttonPanel, BorderLayout.SOUTH);

        add(topPanel, BorderLayout.NORTH);
        add(scrollPane, BorderLayout.CENTER);

        addButton.addActionListener(
                e -> addRecord()
        );

        updateButton.addActionListener(
                e -> updateRecord()
        );

        deleteButton.addActionListener(
                e -> deleteRecord()
        );

        clearButton.addActionListener(
                e -> clearFields()
        );

        table.getSelectionModel().addListSelectionListener(e -> {

            if (!e.getValueIsAdjusting()) {

                int row = table.getSelectedRow();

                if (row >= 0) {

                    bookIdField.setText(
                            model.getValueAt(row, 0).toString()
                    );

                    studentNameField.setText(
                            model.getValueAt(row, 1).toString()
                    );

                    issueDateField.setText(
                            model.getValueAt(row, 2).toString()
                    );

                    Object returnDate =
                            model.getValueAt(row, 3);

                    returnDateField.setText(
                            returnDate == null
                                    ? ""
                                    : returnDate.toString()
                    );
                }
            }
        });

        loadRecords();

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

    void loadRecords() {

        model.setRowCount(0);

        try {

            Connection con = getConnection();

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery(
                    "SELECT * FROM book_issue"
            );

            while (rs.next()) {

                model.addRow(new Object[]{
                        rs.getInt("book_id"),
                        rs.getString("student_name"),
                        rs.getDate("issue_date"),
                        rs.getDate("return_date")
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

    void addRecord() {

        try {

            Connection con = getConnection();

            String query =
                    "INSERT INTO book_issue " +
                    "(book_id, student_name, issue_date, return_date) " +
                    "VALUES (?, ?, ?, ?)";

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(
                    1,
                    Integer.parseInt(bookIdField.getText())
            );

            ps.setString(
                    2,
                    studentNameField.getText()
            );

            ps.setDate(
                    3,
                    Date.valueOf(issueDateField.getText())
            );

            if (returnDateField.getText().trim().isEmpty()) {

                ps.setNull(4, Types.DATE);

            } else {

                ps.setDate(
                        4,
                        Date.valueOf(
                                returnDateField.getText()
                        )
                );
            }

            ps.executeUpdate();

            JOptionPane.showMessageDialog(
                    this,
                    "Book issue record added successfully!"
            );

            ps.close();
            con.close();

            loadRecords();
            clearFields();

        } catch (Exception e) {

            JOptionPane.showMessageDialog(
                    this,
                    "Error: " + e.getMessage()
            );
        }
    }

    void updateRecord() {

        try {

            Connection con = getConnection();

            String query =
                    "UPDATE book_issue " +
                    "SET student_name=?, issue_date=?, return_date=? " +
                    "WHERE book_id=?";

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setString(
                    1,
                    studentNameField.getText()
            );

            ps.setDate(
                    2,
                    Date.valueOf(issueDateField.getText())
            );

            if (returnDateField.getText().trim().isEmpty()) {

                ps.setNull(3, Types.DATE);

            } else {

                ps.setDate(
                        3,
                        Date.valueOf(
                                returnDateField.getText()
                        )
                );
            }

            ps.setInt(
                    4,
                    Integer.parseInt(bookIdField.getText())
            );

            int result = ps.executeUpdate();

            if (result > 0) {

                JOptionPane.showMessageDialog(
                        this,
                        "Record updated successfully!"
                );

            } else {

                JOptionPane.showMessageDialog(
                        this,
                        "Record not found!"
                );
            }

            ps.close();
            con.close();

            loadRecords();
            clearFields();

        } catch (Exception e) {

            JOptionPane.showMessageDialog(
                    this,
                    "Error: " + e.getMessage()
            );
        }
    }

    void deleteRecord() {

        try {

            Connection con = getConnection();

            String query =
                    "DELETE FROM book_issue WHERE book_id=?";

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
                        "Record deleted successfully!"
                );

            } else {

                JOptionPane.showMessageDialog(
                        this,
                        "Record not found!"
                );
            }

            ps.close();
            con.close();

            loadRecords();
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
        studentNameField.setText("");
        issueDateField.setText("");
        returnDateField.setText("");

        table.clearSelection();
    }

    public static void main(String[] args) {

        SwingUtilities.invokeLater(
                () -> new BookIssueTracking()
        );
    }
}