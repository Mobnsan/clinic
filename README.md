# Clinic EMR & Hospital Management System

An enterprise web-based Electronic Medical Record (EMR) and Hospital Management System (HMS). This application covers end-to-end medical operations including Patient Registration, Appointments, Billing, Accounting, Inventory, Pharmacy, Laboratory, ADT (Admission, Discharge, Transfer), and Radiology.

---

##  Option 1: Automatic Setup (Using AI Coding Assistant)

If you are using an AI-powered IDE (like Cursor, Windsurf, Antigravity, or Copilot), you can copy and paste the prompt below into the chat. The AI will handle the entire database restoration, dependency installation, and server startup automatically.

### Copy-Paste AI Prompt:
```text
Please set up and run this project for me by following these steps:
1. Locate "Database/2. EMR-Db/FromzaInternationalDB/Dev_DanpheEMR_INT1.bak" and restore it to my local SQL Server Express (.\SQLEXPRESS) or LocalDB as "DEV_FromzaEMR_INT".
2. Locate "Database/1. Admin-Db/1. FromzaAdmin_CompleteDB.sql" and run it to create and seed the "FromzaAdmin" database on the same SQL Server instance.
3. Check "Code/Websites/FromzaEMR/appsettings.json" and verify the connection strings point to my SQL Server instance.
4. Force reset the "admin" user's password in the "RBAC_User" table of the "DEV_FromzaEMR_INT" database by setting its "Password" column to "b/ECdMP/loE=" (this is the hash for "pass123").
5. Open a terminal in "Code/Websites/FromzaEMR/wwwroot/FromzaApp", ensure Node.js v14 is active, run "npm install" and then "npm start" to launch the Angular 7 frontend.
6. Open a second terminal in "Code/Websites/FromzaEMR" and run ".\kill_and_build.cmd" (or "dotnet run") to start the ASP.NET Core backend.
7. Once everything is running, verify I can access the app at http://localhost:5000 and log in with the credentials: admin / pass123.
```

---

##  Option 2: Manual Setup Guideline

Follow these step-by-step instructions to manually configure and run the application on your local machine.

###  Prerequisites
- **Database:** Microsoft SQL Server (Express or Developer Edition)
- **Backend:** .NET Core SDK v2.0 (or compatible)
- **Frontend Node Version:** Node.js **v14.x** (Required for Angular 7 compatibility)

---

### Step 1: Set Up the Databases
This application requires two databases on your local SQL Server instance (typically `localhost` or `.\SQLEXPRESS`):

1. **Restore EMR Database:**
   - Restore the database backup file located at:
     `Database/2. EMR-Db/FromzaInternationalDB/Dev_DanpheEMR_INT1.bak`
   - Name the restored database: **`DEV_FromzaEMR_INT`**

2. **Restore Admin Database:**
   - Open SQL Server Management Studio (SSMS).
   - Create a blank database named **`FromzaAdmin`**.
   - Open and execute the SQL script located at:
     `Database/1. Admin-Db/1. FromzaAdmin_CompleteDB.sql`

3. **Reset Default Admin Password:**
   Run the following query on the `DEV_FromzaEMR_INT` database to ensure the default admin credentials work:
   ```sql
   UPDATE RBAC_User 
   SET Password = 'b/ECdMP/loE=' 
   WHERE UserName = 'admin' OR UserName = 'Admin';
   ```
   *(This resets the password for the `admin` user to **`pass123`**)*

---

### Step 2: Configure Connection Strings
1. Open the file:
   `Code/Websites/FromzaEMR/appsettings.json`
2. Update the connection strings under `Connectionstring` and `ConnectionStringAdmin` to point to your local SQL Server instance. For Windows Authentication:
   ```json
   "Connectionstring": "Server=localhost;Database=DEV_FromzaEMR_INT;Integrated Security=True;TrustServerCertificate=True",
   "ConnectionStringAdmin": "Server=localhost;Database=FromzaAdmin;Integrated Security=True;TrustServerCertificate=True"
   ```

---

### Step 3: Run the Angular Frontend
1. Open your terminal and navigate to the frontend directory:
   ```powershell
   cd Code/Websites/FromzaEMR/wwwroot/FromzaApp
   ```
2. Ensure you are using **Node.js v14** (if you have NVM installed, run `nvm use 14`).
3. Install frontend dependencies:
   ```powershell
   npm install
   ```
4. Start the Angular development server:
   ```powershell
   npm start
   ```

---

### Step 4: Run the .NET Backend
1. Open a new terminal window and navigate to the backend directory:
   ```powershell
   cd Code/Websites/FromzaEMR
   ```
2. Build and start the backend:
   ```powershell
   .\kill_and_build.cmd
   ```
   *(Alternatively, you can run `dotnet build` followed by `dotnet run`)*

---

### Step 5: Log In
Once both servers are running:
1. Open your browser and go to: **`http://localhost:5000`**
2. Log in using the default admin credentials:
   - **Username:** `admin`
   - **Password:** `pass123`
