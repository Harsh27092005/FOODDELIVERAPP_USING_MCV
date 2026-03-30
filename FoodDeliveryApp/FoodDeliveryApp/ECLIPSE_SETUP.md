# 🚀 Running Urban Eats in Eclipse IDE

## Prerequisites
- **Eclipse IDE for Enterprise Java Developers** (2021-09 or newer)
  - Download: https://www.eclipse.org/downloads/packages/ → "Eclipse IDE for Enterprise Java and Web Developers"
- **Java 11** installed (already set up)
- **Apache Tomcat 9.x** configured in Eclipse
- **m2e plugin** (bundled with Eclipse EE edition — check via *Help → About → Installation Details*)
- **Oracle DB** running locally on port 1521

---

## Step 1 – Import the Project into Eclipse

1. Open Eclipse
2. Go to **File → Import → Maven → Existing Maven Projects**
3. Click **Browse** → select `/Users/harshsingh/Downloads/javafyp/FoodDeliveryApp`
4. Check the `pom.xml` entry → click **Finish**
5. Wait for Maven to download dependencies (bottom-right progress bar)

> If you see **"Plugin execution not covered by lifecycle mapping"** warnings, right-click them → *Quick Fix → Mark as Ignored* (pom.xml already has the ignore config).

---

## Step 2 – Configure Tomcat Server in Eclipse

1. Go to **Window → Preferences → Server → Runtime Environments**
2. Click **Add** → select **Apache Tomcat v9.0** → click **Next**
3. Set the **Tomcat installation directory** — download Tomcat 9 from https://tomcat.apache.org/download-90.cgi if needed
4. Click **Finish**

> ⚠️ Use **Tomcat 9.x** (not 10+). Tomcat 10+ uses Jakarta namespace; this project uses `javax.*`.

---

## Step 3 – Add Project to Tomcat

1. In the **Servers** tab (bottom panel), right-click your Tomcat → **Add and Remove…**
2. Select **FoodDeliveryApp** → click **Add** → **Finish**

If the project is not listed, try:
- Right-click project → **Properties → Project Facets** → ensure **Dynamic Web Module 4.0** and **Java 11** are checked

---

## Step 4 – Set Oracle JDBC Driver

The Oracle JDBC jar is downloaded by Maven. If Eclipse shows a classpath error:

1. Right-click project → **Build Path → Configure Build Path**
2. Go to **Libraries** tab — **Maven Dependencies** should already include `ojdbc8.jar`
3. If missing, run in terminal:
   ```
   mvn dependency:resolve
   ```
   Then right-click project → **Maven → Update Project** (`Alt+F5`)

---

## Step 5 – Run on Tomcat

1. Right-click project → **Run As → Run on Server**
2. Select your Tomcat 9 server → click **Finish**
3. Eclipse will deploy and open the app at:
   **http://localhost:8080/FoodDeliveryApp**

---

## ⚡ Alternate: Run via Maven in Terminal (no Tomcat setup needed)

```bash
cd /Users/harshsingh/Downloads/javafyp/FoodDeliveryApp
/usr/local/bin/mvn clean tomcat7:run
```
Then open: http://localhost:8080/FoodDeliveryApp

---

## Troubleshooting

| Problem | Fix |
|---|---|
| "Table does not exist" error | DB initialised automatically on first run |
| Port 8080 already in use | Kill old process: `lsof -i :8080` then `kill -9 <PID>` |
| Red X on project in Eclipse | Right-click → Maven → Update Project (`Alt+F5`) |
| "Dynamic Web Module facet" error | Window → Preferences → search "Facets" → ensure JST Web 4.0 selected |
| Compilation errors on new Java files | Right-click → Build Project |
