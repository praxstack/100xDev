# SQL Assignment: Booking System

**Difficulty:** 2/10
**Time Required:** 1-2 Hours
**Mode:** SQL Queries Only
**Platform:** PostgreSQL (Neon SQL Editor)

---

## Objective

In this assignment, you will practice:

- Creating tables with proper schema design
- Inserting seed data
- Writing basic SQL queries
- Understanding `SELECT`, `WHERE`, `JOIN`, `COUNT`, `GROUP BY`
- Working with relationships between tables

You will run **only SQL commands** inside the **Neon SQL Editor**.

**No backend or frontend is required.**

---

## Tech Stack

- **Database**: PostgreSQL
- **Editor**: Neon SQL Editor (or any PostgreSQL client)

---

## Database Schema

We are building a **simple booking system** where users can book events.

### Entities

1. **users** – people using the platform
2. **events** – events that can be booked
3. **bookings** – mapping between users and events

---

## Part 1: Database Setup

### 1.1 Create Tables

Run the following SQL **exactly in order**.

#### users table

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);
```

---

#### events table

```sql
CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    price INTEGER NOT NULL
);
```

---

#### bookings table

```sql
CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    event_id INTEGER REFERENCES events(id),
    booking_date DATE NOT NULL
);
```

---

### 1.2 Insert Seed Data

#### Insert users

```sql
INSERT INTO users (name, email) VALUES
('Amit', 'amit@gmail.com'),
('Riya', 'riya@gmail.com'),
('Kunal', 'kunal@gmail.com'),
('Sneha', 'sneha@gmail.com');
```

---

#### Insert events

```sql
INSERT INTO events (title, location, price) VALUES
('Music Concert', 'Delhi', 2000),
('Tech Conference', 'Bangalore', 3000),
('Startup Meetup', 'Mumbai', 1000);
```

---

#### Insert bookings

```sql
INSERT INTO bookings (user_id, event_id, booking_date) VALUES
(1, 1, '2025-01-10'),
(1, 2, '2025-01-12'),
(2, 1, '2025-01-11'),
(3, 3, '2025-01-15');
```

---

## Part 2: Assignment Queries

Write **SQL queries only** for the following questions.

---

### Q1. Get all users

**Expected Output:**

| id | name | email |
|----|------|-------|
| 1 | Amit | amit@gmail.com |
| 2 | Riya | riya@gmail.com |
| 3 | Kunal | kunal@gmail.com |
| 4 | Sneha | sneha@gmail.com |

**Your Query:**

```sql
-- Write your query here

```

---

### Q2. Get all events happening in **Delhi**

**Expected Output:**

| id | title | location | price |
|----|-------|----------|-------|
| 1 | Music Concert | Delhi | 2000 |

**Your Query:**

```sql
-- Write your query here

```

---

### Q3. Find all bookings done by **Amit**

**Expected Output:**

| booking_id | event_title | booking_date |
|------------|-------------|--------------|
| 1 | Music Concert | 2025-01-10 |
| 2 | Tech Conference | 2025-01-12 |

**Your Query:**

```sql
-- Write your query here

```

**Hint:** You'll need to JOIN `bookings`, `users`, and `events` tables.

---

### Q4. List all users who have **never booked any event**

**Expected Output:**

| name |
|------|
| Sneha |

**Your Query:**

```sql
-- Write your query here

```

**Hint:** Use `LEFT JOIN` and filter where booking is NULL.

---

### Q5. Count total bookings for each event

**Expected Output:**

| title | total_bookings |
|-------|----------------|
| Music Concert | 2 |
| Tech Conference | 1 |
| Startup Meetup | 1 |

**Your Query:**

```sql
-- Write your query here

```

**Hint:** Use `GROUP BY` and `COUNT()`.

---

### Q6. Find users who booked events costing **more than 1500**

**Expected Output:**

| name |
|------|
| Amit |
| Riya |

**Your Query:**

```sql
-- Write your query here

```

**Hint:** JOIN users, bookings, and events, then filter by price.

---

### Q7. Show all bookings with user name and event title

**Expected Output:**

| user_name | event_title | booking_date |
|-----------|-------------|--------------|
| Amit | Music Concert | 2025-01-10 |
| Amit | Tech Conference | 2025-01-12 |
| Riya | Music Concert | 2025-01-11 |
| Kunal | Startup Meetup | 2025-01-15 |

**Your Query:**

```sql
-- Write your query here

```

**Hint:** Three-table JOIN.

---

## Part 3: TypeScript Practice

### Objective

Practice core TypeScript concepts:

- `interface`
- `type`
- `enum`
- Optional & readonly properties
- Arrays of typed objects
- Basic type safety

You **must NOT use any database or API**.

All data should be stored in **in-memory variables**.

---

### Context: Booking Application

You are working on a **booking application**.

You will define **TypeScript types** to represent users, events, and bookings.

---

### Question 1: Create an `enum` for Booking Status

**Task:**

Create an `enum` called `BookingStatus` with the following values:

- `PENDING`
- `CONFIRMED`
- `CANCELLED`

**Your Code:**

```typescript
// Write your enum here

```

---

### Question 2: Create a `User` interface

**Requirements:**

Create an `interface` called `User` with:

| Property | Type | Required |
|----------|------|----------|
| id | number | ✅ |
| name | string | ✅ |
| email | string | ✅ |
| isActive | boolean | ❌ (optional) |

**Your Code:**

```typescript
// Write your interface here

```

---

### Question 3: Create an `Event` type

**Requirements:**

Create a `type` called `Event` with:

| Property | Type |
|----------|------|
| id | number |
| title | string |
| location | string |
| price | number |
| isPaid | boolean |

**Your Code:**

```typescript
// Write your type here

```

---

### Question 4: Create a `Booking` interface using previous types

**Requirements:**

Create an `interface` called `Booking` that:

- Uses `User` for the user
- Uses `Event` for the event
- Uses `BookingStatus` enum for status
- Has a `bookingDate` of type `Date`

**Your Code:**

```typescript
// Write your interface here

```

---

### Question 5: Create in-memory data using the above types

**Task:**

1. Create an **array of users**
2. Create an **array of events**
3. Create an **array of bookings**

**Rules:**

- All arrays must be **strongly typed**
- At least:
  - 2 users
  - 2 events
  - 2 bookings
- Booking must reference user & event objects
- TypeScript should show **no type errors**

**Your Code:**

```typescript
// Write your in-memory data here
const users: User[] = [
  // ...
];

const events: Event[] = [
  // ...
];

const bookings: Booking[] = [
  // ...
];
```

---

### Question 6: Create a function to confirm booking

**Task:**

Create a function called `confirmBooking` that:

- Takes a `bookingId` (number) as parameter
- Finds the booking in the `bookings` array
- Updates its status to `CONFIRMED`
- Returns the updated booking

**Function Signature:**

```typescript
function confirmBooking(bookingId: number): Booking | undefined {
  // Write your implementation here
}
```

**Requirements:**

- Must have proper TypeScript types
- Should handle case where booking is not found
- Must mutate the original booking object's status

**Example Usage:**

```typescript
const confirmedBooking = confirmBooking(1);
console.log(confirmedBooking?.status); // Should print: CONFIRMED
```

---

## Solution Template

Here's a complete template to get you started:

```typescript
// ========================================
// PART 3: TypeScript Practice
// ========================================

// Q1: Enum for Booking Status
enum BookingStatus {
  PENDING = "PENDING",
  CONFIRMED = "CONFIRMED",
  CANCELLED = "CANCELLED"
}

// Q2: User Interface
interface User {
  id: number;
  name: string;
  email: string;
  isActive?: boolean;
}

// Q3: Event Type
type Event = {
  id: number;
  title: string;
  location: string;
  price: number;
  isPaid: boolean;
};

// Q4: Booking Interface
interface Booking {
  id: number;
  user: User;
  event: Event;
  status: BookingStatus;
  bookingDate: Date;
}

// Q5: In-Memory Data
const users: User[] = [
  { id: 1, name: "Amit", email: "amit@gmail.com", isActive: true },
  { id: 2, name: "Riya", email: "riya@gmail.com" }
];

const events: Event[] = [
  { id: 1, title: "Music Concert", location: "Delhi", price: 2000, isPaid: true },
  { id: 2, title: "Tech Conference", location: "Bangalore", price: 3000, isPaid: false }
];

const bookings: Booking[] = [
  {
    id: 1,
    user: users[0],
    event: events[0],
    status: BookingStatus.PENDING,
    bookingDate: new Date("2025-01-10")
  },
  {
    id: 2,
    user: users[1],
    event: events[1],
    status: BookingStatus.PENDING,
    bookingDate: new Date("2025-01-12")
  }
];

// Q6: Confirm Booking Function
function confirmBooking(bookingId: number): Booking | undefined {
  const booking = bookings.find(b => b.id === bookingId);
  if (booking) {
    booking.status = BookingStatus.CONFIRMED;
  }
  return booking;
}

// Test the function
const confirmedBooking = confirmBooking(1);
console.log(confirmedBooking?.status); // Output: CONFIRMED
```

---

## Submission Checklist

### SQL Part
- [ ] All tables created with proper constraints
- [ ] All seed data inserted
- [ ] All 7 queries written and tested
- [ ] Query results match expected output

### TypeScript Part
- [ ] `BookingStatus` enum created
- [ ] `User` interface with optional `isActive`
- [ ] `Event` type defined
- [ ] `Booking` interface using previous types
- [ ] In-memory arrays created with proper types
- [ ] `confirmBooking` function implemented and working
- [ ] No TypeScript errors

---

## Learning Outcomes

After completing this assignment, you should understand:

1. **SQL Fundamentals**
   - Creating tables with relationships
   - Primary keys and foreign keys
   - INSERT, SELECT, WHERE clauses
   - JOINs (INNER, LEFT)
   - Aggregate functions (COUNT, GROUP BY)

2. **TypeScript Fundamentals**
   - Enums for fixed sets of values
   - Interfaces vs Types
   - Optional properties
   - Strongly-typed arrays
   - Type safety in functions
   - Finding and mutating objects in arrays

---

## Next Steps

Once you complete this assignment:

1. **Extend the Schema**: Add a `payments` table
2. **Complex Queries**: Calculate revenue per event
3. **TypeScript Advanced**: Add generics to make `confirmBooking` work for any status transition
4. **Bonus**: Add indexes on frequently queried columns

---

**Good luck!** 🚀

---

## Bonus Challenge (Optional)

### Advanced SQL Query

Write a query that shows:
- Event title
- Total bookings
- Total revenue
- Average price per booking

Ordered by total revenue (descending).

**Your Query:**

```sql
-- Write your advanced query here

```

---

### Advanced TypeScript Function

Create a function that:
- Filters bookings by status
- Returns array of booking summaries with just: user name, event title, status

**Your Code:**

```typescript
interface BookingSummary {
  userName: string;
  eventTitle: string;
  status: BookingStatus;
}

function getBookingsByStatus(status: BookingStatus): BookingSummary[] {
  // Write your implementation here
}
```

---

**End of Assignment**
