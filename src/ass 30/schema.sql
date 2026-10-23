-- ==============================================================
-- Assignment 30: Database Setup Script
-- Database: javalab
-- ==============================================================

CREATE DATABASE IF NOT EXISTS javalab;
USE javalab;

-- Sub-operation 1: Employee Table
CREATE TABLE IF NOT EXISTS employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DOUBLE NOT NULL
);

-- Sample Data for Employee Table
INSERT IGNORE INTO employee (emp_id, name, department, salary) VALUES
(101, 'Aryyan Paygude', 'Software Engineering', 95000.00),
(102, 'Rohan Sharma', 'Data Analytics', 72000.00),
(103, 'Pooja Kulkarni', 'Human Resources', 65000.00);

-- Sub-operation 2: Patient Table
CREATE TABLE IF NOT EXISTS patient (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    disease VARCHAR(100) NOT NULL,
    treatment_status VARCHAR(50) NOT NULL
);

-- Sample Data for Patient Table
INSERT IGNORE INTO patient (patient_id, name, age, disease, treatment_status) VALUES
(501, 'Amit Patil', 34, 'Viral Fever', 'Discharged'),
(502, 'Sneha Joshi', 28, 'Hypertension', 'Under Treatment'),
(503, 'Rajesh Deshmukh', 52, 'Type 2 Diabetes', 'Under Observation'),
(504, 'Kavita Rao', 45, 'Pneumonia', 'Admitted');
