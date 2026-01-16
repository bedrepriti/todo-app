# TodoApp

A modern **Java-based web application** for managing personal notes.  
Built with **JSP, Servlets, and MySQL**, this project demonstrates full-stack Java web development concepts including MVC architecture, database connectivity, and session management.

---

## **Table of Contents**

- [Features](#features)  
- [Technology Stack](#technology-stack)  
- [Project Structure](#project-structure)  
- [Installation & Setup](#installation--setup)  
- [Usage](#usage)  
- [Future Enhancements](#future-enhancements)  
- [License](#license)  

---

## **Features**

- Add, edit, and delete notes  
- User authentication: Login & Logout  
- Session management to secure user data  
- Responsive web interface with JSP pages  
- Clean MVC architecture for easy maintenance  
- Cloud-ready configuration for deploying on servers like Render.com or AWS  

---

## **Technology Stack**

- **Backend:** Java Servlets, JSP  
- **Database:** MySQL  
- **Server:** Apache Tomcat  
- **Version Control:** Git & GitHub  

---

## **Project Structure**
TodoApp/
├── src/main/java/
│ ├── com/Controller/ # Servlets: AddNote, EditNote, DeleteNote, Logout
│ ├── com/Dao/ # DAO classes for database operations
│ ├── com/Model/ # Java beans like Note, User
│ └── com/ConnectionFactory/ # DB connection class
├── src/main/webapp/
│ ├── WEB-INF/
│ │ └── web.xml # Deployment descriptor
│ ├── home.jsp
│ ├── login.jsp
│ └── index.jsp
├── build/ # Compiled classes (ignored in Git)
└── .gitignore

---

## **Installation & Setup**

### **Prerequisites**

- Java 8 or higher  
- Apache Tomcat 9 or higher  
- MySQL Database  

### **Setup Steps**

1. Clone the repository:

```bash
git clone https://github.com/bedrepriti/todo-app.git
cd todo-app

import into Eclipse as an Existing Dynamic Web Project.

Create a MySQL database:

CREATE DATABASE todoapp;


Update ConnectionFactory.java with your database credentials:

String url = "jdbc:mysql://localhost:3306/todoapp";
String user = "your_mysql_username";
String password = "your_mysql_password";


Deploy project on Tomcat server in Eclipse.
Access the app via browser:
http://localhost:8080/TodoApp

Usage

Register/Login (if user auth is implemented)

Add a note with title and content

Edit or delete notes as needed

Changes are persisted in MySQL database

Future Enhancements

Add priority levels and categories for notes

Implement search and filtering

Add REST API endpoints for integration with mobile apps

Deploy to cloud hosting with live URL

License

This project is open-source under the MIT License.

Made with ❤️ by Priti Bedre


