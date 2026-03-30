# Taaza Food Delivery Application

## Setup Instructions

### 1. Database Setup (Oracle)
- Connect to your Oracle database using SQL*Plus or SQL Developer as `system` user.
- Run the provided schema script located at `sql/schema.sql`.
- Update your database credentials in `src/main/java/com/fooddelivery/dao/DBConnection.java`.

### 2. Eclipse IDE Setup
- Open Eclipse IDE for Enterprise Java Web Developers.
- File -> Import -> General -> Existing Projects into Workspace.
- Select the `FoodDeliveryApp` directory.
- Add Apache Tomcat server runtime: Preferences -> Server -> Runtime Environments.

### 3. Add Libraries
- Add Oracle JDBC Driver (`ojdbc8.jar`) to `src/main/webapp/WEB-INF/lib`.
- If using standard Eclipse dynamic web project, right-click project -> Build Path -> Add Libraries -> Server Runtime -> Apache Tomcat.

### 4. Deploy and Run
- Right-click on `FoodDeliveryApp` project -> Run As -> Run on Server.
- Navigate to `http://localhost:8080/FoodDeliveryApp` (it will redirect to `login.jsp`).

### Features Implemented
- **MVC Architecture**, Servlets handling business logic, JSP and JSTL for views.
- **DAO Pattern** separating DB access logic.
- **Observer Pattern** for order notifications.
- **Oracle JDBC Connectivity** utilizing IDENTITY sequences.
- **Authentication Filter** enforcing login.
