# Contest Platform Backend Assignment

**Difficulty:** 4.5/10
**Time Limit:** 2–3 Hours
**Mode:** HTTP REST APIs only
**Evaluation:** Automated test cases will be run against your backend

---

## Tech Stack (PREFERRED)

- Node.js
- Express
- PostgreSQL
- JWT (Authentication)
- bcrypt (Password hashing)
- Zod (Validation)

---

## Objective

Build a **Contest Platform** backend where:

- **Creators** create contests with MCQ & DSA questions
- **Contestees** participate and submit answers
- All APIs follow **strict contracts** so automated tests can validate them

---

## User Roles

| Role | Description |
|------|-------------|
| `creator` | Creates contests, questions, problems |
| `contestee` | Participates in contests |

---

## Core Rules (Hard Rules)

1. One contest can have multiple MCQs and multiple DSA problems
2. Creators **cannot** submit to their own contests
3. Submissions allowed **only during contest time**
4. Hidden test cases must **never** be exposed to contestees
5. JWT required for **all APIs except signup/login**
6. Responses must match the format **exactly**

---

## Database Schema (PostgreSQL)

### users

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'contestee', -- 'creator' or 'contestee'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### contests

```sql
CREATE TABLE contests (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    creator_id INTEGER REFERENCES users(id),
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### mcq_questions

```sql
CREATE TABLE mcq_questions (
    id SERIAL PRIMARY KEY,
    contest_id INTEGER REFERENCES contests(id),
    question_text TEXT NOT NULL,
    options JSONB NOT NULL,
    correct_option_index INTEGER NOT NULL,
    points INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### dsa_problems

```sql
CREATE TABLE dsa_problems (
    id SERIAL PRIMARY KEY,
    contest_id INTEGER REFERENCES contests(id),
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    tags JSONB,
    points INTEGER DEFAULT 100,
    time_limit INTEGER DEFAULT 2000,
    memory_limit INTEGER DEFAULT 256,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### test_cases

```sql
CREATE TABLE test_cases (
    id SERIAL PRIMARY KEY,
    problem_id INTEGER REFERENCES dsa_problems(id),
    input TEXT NOT NULL,
    expected_output TEXT NOT NULL,
    is_hidden BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### mcq_submissions

```sql
CREATE TABLE mcq_submissions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    question_id INTEGER REFERENCES mcq_questions(id),
    selected_option_index INTEGER NOT NULL,
    is_correct BOOLEAN NOT NULL,
    points_earned INTEGER DEFAULT 0,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, question_id)
);
```

### dsa_submissions

```sql
CREATE TABLE dsa_submissions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    problem_id INTEGER REFERENCES dsa_problems(id),
    code TEXT NOT NULL,
    language VARCHAR(50),
    status VARCHAR(50),
    points_earned INTEGER DEFAULT 0,
    test_cases_passed INTEGER DEFAULT 0,
    total_test_cases INTEGER DEFAULT 0,
    execution_time INTEGER,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

## Global API Rules

### Auth Header

```
Authorization: Bearer <JWT_TOKEN>
```

### Response Format (STRICT)

**Success Response:**

```json
{
  "success": true,
  "data": {},
  "error": null
}
```

**Error Response:**

```json
{
  "success": false,
  "data": null,
  "error": "ERROR_CODE"
}
```

**RULES:**
- **No extra keys allowed**
- **No nested error objects**
- **Error must be a string code, not an object**

---

## API Endpoints (10 Total)

### 1. POST /api/auth/signup

Register a new user (creator or contestee)

**Request Body:**

```json
{
  "name": "Rahul Gujjar",
  "email": "rahul@example.com",
  "password": "rahul123",
  "role": "contestee"
}
```

**Success Response:** `201 Created`

```json
{
  "success": true,
  "data": {
    "id": 1,
    "name": "Rahul Gujjar",
    "email": "rahul@example.com",
    "role": "contestee"
  },
  "error": null
}
```

**Notes:**
- If no role is given, default is `contestee`

**Error Responses:**

**400 Bad Request** – Invalid schema

```json
{
  "success": false,
  "data": null,
  "error": "INVALID_REQUEST"
}
```

**400 Bad Request** – Email exists

```json
{
  "success": false,
  "data": null,
  "error": "EMAIL_ALREADY_EXISTS"
}
```

---

### 2. POST /api/auth/login

Login and receive JWT token

**Request Body:**

```json
{
  "email": "rahul@example.com",
  "password": "rahul123"
}
```

**Success Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "token": "JWT_TOKEN"
  },
  "error": null
}
```

**Error Responses:**

**400 Bad Request** – Invalid schema

```json
{
  "success": false,
  "data": null,
  "error": "INVALID_REQUEST"
}
```

**401 Unauthorized** – Wrong credentials

```json
{
  "success": false,
  "data": null,
  "error": "INVALID_CREDENTIALS"
}
```

---

### 3. POST /api/contests

*(Creator Only)*

Create a new contest

**Headers:** `Authorization: Bearer <token>`

**Request Body:**

```json
{
  "title": "Weekly Contest",
  "description": "MCQ + DSA",
  "startTime": "2026-01-20T10:00:00Z",
  "endTime": "2026-01-20T12:00:00Z"
}
```

**Success Response:** `201 Created`

```json
{
  "success": true,
  "data": {
    "id": 1,
    "title": "Weekly Contest",
    "description": "MCQ + DSA",
    "creatorId": 1,
    "startTime": "2026-01-20T10:00:00Z",
    "endTime": "2026-01-20T12:00:00Z"
  },
  "error": null
}
```

**Error Responses:**

**401 Unauthorized**

```json
{
  "success": false,
  "data": null,
  "error": "UNAUTHORIZED"
}
```

**403 Forbidden** – Not a creator

```json
{
  "success": false,
  "data": null,
  "error": "FORBIDDEN"
}
```

**400 Bad Request** – Invalid schema

```json
{
  "success": false,
  "data": null,
  "error": "INVALID_REQUEST"
}
```

---

### 4. GET /api/contests/:contestId

Get contest details with all MCQs and DSA problems

**Headers:** `Authorization: Bearer <token>`

**Success Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "id": 1,
    "title": "Weekly Contest",
    "description": "MCQ + DSA",
    "startTime": "2026-01-20T10:00:00Z",
    "endTime": "2026-01-20T12:00:00Z",
    "creatorId": 1,
    "mcqs": [
      {
        "id": 10,
        "questionText": "Binary search complexity?",
        "options": ["O(n)", "O(log n)"],
        "points": 1
      }
    ],
    "dsaProblems": [
      {
        "id": 20,
        "title": "Two Sum",
        "description": "Find two numbers that add up to target",
        "tags": ["array"],
        "points": 100,
        "timeLimit": 2000,
        "memoryLimit": 256
      }
    ]
  },
  "error": null
}
```

**NOTE:** `correctOptionIndex` is **NOT** included in MCQs for contestees

**Error Responses:**

**401 Unauthorized**

```json
{
  "success": false,
  "data": null,
  "error": "UNAUTHORIZED"
}
```

**404 Not Found**

```json
{
  "success": false,
  "data": null,
  "error": "CONTEST_NOT_FOUND"
}
```

---

### 5. POST /api/contests/:contestId/mcq

*(Creator Only)*

Add MCQ question to a contest

**Headers:** `Authorization: Bearer <token>`

**Request Body:**

```json
{
  "questionText": "Binary search complexity?",
  "options": ["O(n)", "O(log n)", "O(n^2)", "O(1)"],
  "correctOptionIndex": 1,
  "points": 1
}
```

**Success Response:** `201 Created`

```json
{
  "success": true,
  "data": {
    "id": 10,
    "contestId": 1
  },
  "error": null
}
```

**Error Responses:**

**401 Unauthorized**

```json
{
  "success": false,
  "data": null,
  "error": "UNAUTHORIZED"
}
```

**403 Forbidden** – Not a creator

```json
{
  "success": false,
  "data": null,
  "error": "FORBIDDEN"
}
```

**400 Bad Request** – Invalid schema

```json
{
  "success": false,
  "data": null,
  "error": "INVALID_REQUEST"
}
```

**404 Not Found** – Contest not found

```json
{
  "success": false,
  "data": null,
  "error": "CONTEST_NOT_FOUND"
}
```

---

### 6. POST /api/contests/:contestId/mcq/:questionId/submit

*(Contestee Only)*

Submit answer for an MCQ question

**Headers:** `Authorization: Bearer <token>`

**Request Body:**

```json
{
  "selectedOptionIndex": 1
}
```

**Success Response:** `201 Created`

```json
{
  "success": true,
  "data": {
    "isCorrect": true,
    "pointsEarned": 1
  },
  "error": null
}
```

**Error Responses:**

**401 Unauthorized**

```json
{
  "success": false,
  "data": null,
  "error": "UNAUTHORIZED"
}
```

**403 Forbidden** – Creator trying to submit to own contest

```json
{
  "success": false,
  "data": null,
  "error": "FORBIDDEN"
}
```

**400 Bad Request** – Already submitted

```json
{
  "success": false,
  "data": null,
  "error": "ALREADY_SUBMITTED"
}
```

**400 Bad Request** – Contest not active

```json
{
  "success": false,
  "data": null,
  "error": "CONTEST_NOT_ACTIVE"
}
```

**400 Bad Request** – Invalid schema

```json
{
  "success": false,
  "data": null,
  "error": "INVALID_REQUEST"
}
```

**404 Not Found** – Question not found

```json
{
  "success": false,
  "data": null,
  "error": "QUESTION_NOT_FOUND"
}
```

---

### 7. POST /api/contests/:contestId/dsa

*(Creator Only)*

Add DSA problem to a contest

**Headers:** `Authorization: Bearer <token>`

**Request Body:**

```json
{
  "title": "Two Sum",
  "description": "Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.",
  "tags": ["array", "hash-table"],
  "points": 100,
  "timeLimit": 2000,
  "memoryLimit": 256,
  "testCases": [
    {
      "input": "2\n4 9\n2 7 11 15\n3 6\n3 2 4",
      "expectedOutput": "0 1\n1 2",
      "isHidden": false
    },
    {
      "input": "3\n2 6\n3 3\n5 10\n1 4 5 6 9\n4 8\n2 2 2 2",
      "expectedOutput": "0 1\n0 2\n1 3",
      "isHidden": true
    }
  ]
}
```

**Input Format Example:**

```
2                    ← number of test cases
4 9                  ← test case 1: n=4, target=9
2 7 11 15           ← array elements
3 6                  ← test case 2: n=3, target=6
3 2 4               ← array elements
```

**Output Format Example:**

```
0 1                  ← answer for test case 1
1 2                  ← answer for test case 2
```

**NOTE:** Test cases are provided during problem creation itself

**Success Response:** `201 Created`

```json
{
  "success": true,
  "data": {
    "id": 20,
    "contestId": 1
  },
  "error": null
}
```

**Error Responses:**

**401 Unauthorized**

```json
{
  "success": false,
  "data": null,
  "error": "UNAUTHORIZED"
}
```

**403 Forbidden** – Not a creator

```json
{
  "success": false,
  "data": null,
  "error": "FORBIDDEN"
}
```

**400 Bad Request** – Invalid schema

```json
{
  "success": false,
  "data": null,
  "error": "INVALID_REQUEST"
}
```

**404 Not Found** – Contest not found

```json
{
  "success": false,
  "data": null,
  "error": "CONTEST_NOT_FOUND"
}
```

---

### 8. GET /api/problems/:problemId

Get DSA problem details with visible test cases only

**Headers:** `Authorization: Bearer <token>`

**Success Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "id": 20,
    "contestId": 1,
    "title": "Two Sum",
    "description": "Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.",
    "tags": ["array", "hash-table"],
    "points": 100,
    "timeLimit": 2000,
    "memoryLimit": 256,
    "visibleTestCases": [
      {
        "input": "2\n4 9\n2 7 11 15\n3 6\n3 2 4",
        "expectedOutput": "0 1\n1 2"
      }
    ]
  },
  "error": null
}
```

**CRITICAL:** Hidden test cases must **NEVER** be returned

**Error Responses:**

**401 Unauthorized**

```json
{
  "success": false,
  "data": null,
  "error": "UNAUTHORIZED"
}
```

**404 Not Found**

```json
{
  "success": false,
  "data": null,
  "error": "PROBLEM_NOT_FOUND"
}
```

---

### 9. POST /api/problems/:problemId/submit

*(Contestee Only)*

Submit code solution for a DSA problem

**Headers:** `Authorization: Bearer <token>`

**Request Body:**

```json
{
  "code": "function twoSum(nums, target) { /* solution */ }",
  "language": "javascript"
}
```

**NOTE:** You can use Judge0, exec, Docker, or any method to execute code. We only care about the response format.

**Success Response:** `201 Created`

**Case 1: All test cases passed**

```json
{
  "success": true,
  "data": {
    "status": "accepted",
    "pointsEarned": 100,
    "testCasesPassed": 5,
    "totalTestCases": 5
  },
  "error": null
}
```

**Case 2: Some test cases failed**

```json
{
  "success": true,
  "data": {
    "status": "wrong_answer",
    "pointsEarned": 60,
    "testCasesPassed": 3,
    "totalTestCases": 5
  },
  "error": null
}
```

**Case 3: Time limit exceeded**

```json
{
  "success": true,
  "data": {
    "status": "time_limit_exceeded",
    "pointsEarned": 0,
    "testCasesPassed": 0,
    "totalTestCases": 5
  },
  "error": null
}
```

**Case 4: Runtime error**

```json
{
  "success": true,
  "data": {
    "status": "runtime_error",
    "pointsEarned": 0,
    "testCasesPassed": 0,
    "totalTestCases": 5
  },
  "error": null
}
```

**Possible status values:**
- `"accepted"`
- `"wrong_answer"`
- `"time_limit_exceeded"`
- `"runtime_error"`

**Points Calculation:**

```javascript
pointsEarned = Math.floor((testCasesPassed / totalTestCases) * problemPoints)
```

**Error Responses:**

**401 Unauthorized**

```json
{
  "success": false,
  "data": null,
  "error": "UNAUTHORIZED"
}
```

**403 Forbidden** – Creator trying to submit to own contest

```json
{
  "success": false,
  "data": null,
  "error": "FORBIDDEN"
}
```

**400 Bad Request** – Contest not active

```json
{
  "success": false,
  "data": null,
  "error": "CONTEST_NOT_ACTIVE"
}
```

**400 Bad Request** – Invalid schema

```json
{
  "success": false,
  "data": null,
  "error": "INVALID_REQUEST"
}
```

**404 Not Found**

```json
{
  "success": false,
  "data": null,
  "error": "PROBLEM_NOT_FOUND"
}
```

---

### 10. GET /api/contests/:contestId/leaderboard

Get contest leaderboard with user rankings

**Headers:** `Authorization: Bearer <token>`

**Success Response:** `200 OK`

```json
{
  "success": true,
  "data": [
    {
      "userId": 2,
      "name": "Simran",
      "totalPoints": 250,
      "rank": 1
    },
    {
      "userId": 3,
      "name": "Anmo",
      "totalPoints": 180,
      "rank": 2
    },
    {
      "userId": 4,
      "name": "Rahul Gujjar",
      "totalPoints": 180,
      "rank": 2
    }
  ],
  "error": null
}
```

**Leaderboard Calculation Rules:**

1. Sum all MCQ points earned by the user
2. For each DSA problem, take the **maximum** points earned across all submissions
3. Total = MCQ points + sum of best DSA submissions
4. Sort by total points (descending)
5. Assign ranks (users with same points get same rank)

**Error Responses:**

**401 Unauthorized**

```json
{
  "success": false,
  "data": null,
  "error": "UNAUTHORIZED"
}
```

**404 Not Found**

```json
{
  "success": false,
  "data": null,
  "error": "CONTEST_NOT_FOUND"
}
```

---

## Implementation Guidelines

### Code Execution for DSA Problems

You have **complete freedom** in how you execute code:

1. **Judge0 API** – Use external service
2. **Child Process (exec)** – Run code locally
3. **Docker Containers** – Isolated execution
4. **Mock Evaluation** – Random pass/fail for testing

**We only care that:**
- Request/response format matches exactly
- Points calculation is correct: `Math.floor((passed / total) * points)`
- Status values are one of: `accepted`, `wrong_answer`, `time_limit_exceeded`, `runtime_error`

---

## Testing Preparation Checklist

- [ ] All responses match the format **exactly**
- [ ] No extra fields in responses
- [ ] Error must be a string, not an object
- [ ] All timestamps in ISO 8601 format
- [ ] JSONB fields properly serialized
- [ ] JWT authentication working
- [ ] bcrypt password hashing
- [ ] Zod validation on all inputs

---

## Critical Reminders

**Response Format (Non-Negotiable):**

```json
{
  "success": true/false,
  "data": {} or null,
  "error": "ERROR_CODE" or null
}
```

**Error Codes Must Be Strings:**

```json
// ✅ CORRECT
{ "success": false, "data": null, "error": "INVALID_REQUEST" }

// ❌ WRONG
{ "success": false, "data": null, "error": { "message": "Invalid" } }
```

---

**Good luck!** 🚀
