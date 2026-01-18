# 🛠️ Development Environment Setup Complete

## ✅ Installed Tools

| Tool | Version | Status | Purpose |
|------|---------|--------|---------|
| **Node.js** | v22.21.1 | ✅ Running | Backend runtime |
| **npm** | 11.7.0 | ✅ Running | Package manager |
| **PostgreSQL** | 16.11 | ✅ Running | Database |
| **TypeScript** | 5.9.3 | ✅ Installed | Type checking |
| **ts-node** | 10.9.2 | ✅ Installed | Run TS files directly |
| **nodemon** | Latest | ✅ Installed | Auto-restart on file changes |

---

## 📂 Databases Created

```sql
-- Database for SQL Booking System Assignment
booking_system

-- Database for Contest Platform Backend Assignment
contest_platform
```

**Connection Details:**
```
Host: localhost
Port: 5432
User: praxlannister
Password: (none - local development)
```

---

## 🔗 Quick Connection Commands

### Connect to Booking System Database
```bash
psql booking_system
```

### Connect to Contest Platform Database
```bash
psql contest_platform
```

### List all databases
```bash
psql postgres -c "\l"
```

### Check PostgreSQL status
```bash
brew services list | grep postgresql
```

### Stop PostgreSQL (if needed)
```bash
brew services stop postgresql@16
```

### Start PostgreSQL (if stopped)
```bash
brew services start postgresql@16
```

---

## 📝 Assignment-Specific Setup

### Assignment #2: SQL Booking System

**No additional setup needed!** You can start immediately with:

```bash
# Connect to database
psql booking_system

# Or use the assignment markdown file
# ./02-sql-booking-system.md
```

**What you'll do:**
1. Create tables (`users`, `events`, `bookings`)
2. Insert seed data
3. Write 7 SQL queries
4. Complete TypeScript type exercises

---

### Assignment #1: Contest Platform Backend

**Project initialization needed:**

```bash
# If you're following this repo structure, start by scaffolding the assignment:
./scaffold.sh assignment ai-ml "Contest Platform Backend"

# Then work inside the created assignment folder's ./sandbox directory.
# (Tip: the scaffold command prints the exact path it created.)

# Initialize npm project (inside sandbox/)
npm init -y

# Install dependencies
npm install express pg bcrypt jsonwebtoken zod
npm install -D @types/express @types/node @types/bcrypt @types/jsonwebtoken typescript nodemon

# Create tsconfig.json
npx tsc --init
```

**Environment variables needed:**
```env
DATABASE_URL=postgresql://praxlannister@localhost:5432/contest_platform
JWT_SECRET=your_super_secret_jwt_key_change_in_production
PORT=3000
```

---

## 🧪 Verification Commands

Run these to verify everything works:

```bash
# Check Node.js
node --version  # Should show: v22.21.1

# Check npm
npm --version   # Should show: 11.7.0

# Check PostgreSQL
psql --version  # Should show: psql (PostgreSQL) 16.11

# Check TypeScript
tsc --version   # Should show: Version 5.9.3

# Check ts-node
ts-node --version  # Should show: v10.9.2

# Check nodemon
nodemon --version  # Should show version number

# Test database connection
psql booking_system -c "SELECT version();"
```

---

## 🎯 What's Next?

### Option A: Start with SQL Booking System (Recommended)

**Why?**
- ✅ Simpler (2/10 difficulty)
- ✅ Builds SQL foundation
- ✅ Quick win (1-2 hours)
- ✅ No project setup needed

**How to start:**
1. Open terminal
2. Run: `psql booking_system`
3. Follow instructions in `02-sql-booking-system.md`
4. Create tables → Insert data → Write queries

---

### Option B: Start with Contest Platform Backend

**Why?**
- ✅ Full-stack backend experience
- ✅ Portfolio-worthy project
- ✅ More challenging (4.5/10)

**How to start:**
1. Initialize project (see "Assignment #1" section above)
2. Set up Express + TypeScript
3. Create database schema
4. Implement 10 API endpoints

---

## 🛠️ Optional Tools (Recommended)

### 1. **pgAdmin** (Database GUI)
```bash
brew install --cask pgadmin4
```
Then connect with:
- Host: localhost
- Port: 5432
- Database: booking_system / contest_platform
- User: praxlannister

### 2. **Thunder Client** (VS Code Extension)
- Install from VS Code marketplace
- Alternative to Postman
- Test APIs directly in VS Code

### 3. **PostgreSQL Explorer** (VS Code Extension)
- Visualize database schema
- Run queries from VS Code

---

## 🧠 Mental Model: Your Workflow

```
┌─────────────────────────────────────────────────────┐
│  SQL Assignment Workflow                            │
├─────────────────────────────────────────────────────┤
│                                                     │
│  1. psql booking_system                            │
│  2. CREATE TABLE users (...);                      │
│  3. INSERT INTO users VALUES (...);                │
│  4. SELECT * FROM users WHERE ...;                 │
│  5. Write TypeScript types                         │
│                                                     │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  Backend Assignment Workflow                        │
├─────────────────────────────────────────────────────┤
│                                                     │
│  1. npm init && install dependencies               │
│  2. Create tables in contest_platform DB           │
│  3. Write Express routes + controllers             │
│  4. Test with Thunder Client/Postman               │
│  5. Implement JWT auth                             │
│                                                     │
└─────────────────────────────────────────────────────┘
```

---

## 📌 Troubleshooting

### PostgreSQL won't start
```bash
brew services restart postgresql@16
```

### Can't connect to database
```bash
# Check if PostgreSQL is running
brew services list | grep postgresql

# If not running, start it
brew services start postgresql@16
```

### `psql` command not found in new terminal
```bash
# Add to PATH (already done, but run this if needed)
echo 'export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### TypeScript errors
```bash
# Reinstall TypeScript
npm install -g typescript ts-node --force
```

---

## ✅ Final Checklist

- [x] Node.js installed (v22.21.1)
- [x] npm installed (11.7.0)
- [x] PostgreSQL installed & running (16.11)
- [x] TypeScript installed globally (5.9.3)
- [x] ts-node installed (10.9.2)
- [x] nodemon installed
- [x] Databases created (`booking_system`, `contest_platform`)
- [x] PostgreSQL added to PATH

---

## 🚀 You're Ready!

**Everything is set up!** You can now start with either assignment.

**Gabriel's Recommendation:** Start with the SQL Booking System to build momentum, then tackle the Contest Platform Backend.

When you're ready, say:
- "Let's start the SQL assignment" → I'll guide you step-by-step
- "Let's initialize the Contest Platform" → I'll help set up the Express project

---

*Last Updated: January 16, 2026*
