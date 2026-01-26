# 📘 The Complete CSS Flexbox Guide - From Zero to Hero

**Last Updated:** January 2026  
**Difficulty:** Beginner to Advanced  
**Time to Master:** 2-3 hours of focused study + practice

---

## 🎯 Table of Contents

1. [What is Flexbox and Why Does It Exist?](#what-is-flexbox)
2. [The Flex Container vs Flex Items](#container-vs-items)
3. [The Mental Model: Main Axis vs Cross Axis](#mental-model)
4. [Container Properties (Parent)](#container-properties)
5. [Item Properties (Children)](#item-properties)
6. [Real-World Patterns](#real-world-patterns)
7. [Common Gotchas and Debugging](#gotchas)
8. [Practice Exercises](#exercises)
9. [Additional Resources](#resources)

---

## 🌟 What is Flexbox and Why Does It Exist? {#what-is-flexbox}

### The Problem Before Flexbox

Before Flexbox (pre-2012), CSS had THREE layout systems:
1. **Normal Flow** (block/inline)
2. **Floats** (originally for text wrapping images)
3. **Position** (absolute/relative/fixed)

**None of these were designed for app-style layouts!**

Common tasks that were HARD:
- ❌ Vertical centering
- ❌ Equal-height columns
- ❌ Distributing space evenly
- ❌ Reordering elements without changing HTML
- ❌ Creating responsive layouts

### The Solution: Flexible Box Layout

Flexbox is a **one-dimensional layout model** designed for:
- ✅ Arranging items in a row OR column
- ✅ Distributing space automatically
- ✅ Aligning items along multiple axes
- ✅ Handling dynamic/unknown sizes

**Key Insight:** Flexbox treats children as "flexible" — they can grow, shrink, and align within available space.

---

## 🎭 The Flex Container vs Flex Items {#container-vs-items}

### Basic Setup

```html
<div class="container">
  <div class="item">1</div>
  <div class="item">2</div>
  <div class="item">3</div>
</div>
```

```css
.container {
  display: flex; /* ← This ONE line activates Flexbox! */
}
```

**What `display: flex` does:**

```
BEFORE (Normal Flow):
┌────────────────────────────────────┐
│ Container                          │
│ ┌────────────────────────────────┐ │
│ │ Item 1                         │ │  ← Block elements stack
│ └────────────────────────────────┘ │
│ ┌────────────────────────────────┐ │
│ │ Item 2                         │ │
│ └────────────────────────────────┘ │
│ ┌────────────────────────────────┐ │
│ │ Item 3                         │ │
│ └────────────────────────────────┘ │
└────────────────────────────────────┘

AFTER (Flexbox):
┌────────────────────────────────────┐
│ Container                          │
│ ┌───────┐┌───────┐┌───────┐       │
│ │Item 1 ││Item 2 ││Item 3 │       │  ← Items flow horizontally!
│ └───────┘└───────┘└───────┘       │
└────────────────────────────────────┘
```

**Two levels of control:**
1. **Container properties** - Control HOW items are arranged
2. **Item properties** - Control HOW individual items behave

---

## 🧠 The Mental Model: Main Axis vs Cross Axis {#mental-model}

**THIS IS THE MOST IMPORTANT CONCEPT IN FLEXBOX!**

### The Two Axes

Every flex container has TWO axes:

```
┌───────────────────────────────────────────────────────────┐
│                    FLEX CONTAINER                         │
│                                                           │
│    Main Axis (Primary direction) →                        │
│    ═══════════════════════════════════════════            │
│                                                           │
│  C │  ┌──────┐  ┌──────┐  ┌──────┐                       │
│  r │  │Item 1│  │Item 2│  │Item 3│                       │
│  o │  └──────┘  └──────┘  └──────┘                       │
│  s │                                                      │
│  s │                                                      │
│    │                                                      │
│  A │                                                      │
│  x │                                                      │
│  i │                                                      │
│  s │                                                      │
│    ▼                                                      │
└───────────────────────────────────────────────────────────┘
```

**Default behavior:**
- **Main Axis:** Horizontal (left to right) → Items line up in a ROW
- **Cross Axis:** Vertical (top to bottom) → Items stretch/align vertically

### Rotating the Axes with `flex-direction`

```css
.container {
  display: flex;
  flex-direction: column; /* ← Rotates main axis to vertical! */
}
```

```
┌──────────────────────────┐
│   FLEX CONTAINER         │
│                          │
│  Main Axis ↓             │   ← Now vertical!
│     ║                    │
│     ║  ┌──────────┐      │
│     ║  │  Item 1  │      │
│     ║  └──────────┘      │
│     ║                    │
│     ║  ┌──────────┐      │
│     ║  │  Item 2  │      │
│     ║  └──────────┘      │
│     ║                    │
│     ║  ┌──────────┐      │
│     ║  │  Item 3  │      │
│     ║  └──────────┘      │
│     ▼                    │
│                          │
│  Cross Axis → → →        │
└──────────────────────────┘
```

**Critical rule:**
- **`justify-content`** ALWAYS controls the **MAIN axis**
- **`align-items`** ALWAYS controls the **CROSS axis**

When you rotate with `flex-direction: column`:
- `justify-content` now controls VERTICAL alignment
- `align-items` now controls HORIZONTAL alignment

---

## 🎛️ Container Properties (Parent) {#container-properties}

These properties go on the **flex container** (parent element).

### 1. `display`

```css
.container {
  display: flex;        /* Block-level flex container */
  /* OR */
  display: inline-flex; /* Inline-level flex container */
}
```

**Difference:**
- `flex` - Container behaves like a block (takes full width)
- `inline-flex` - Container behaves like inline-block (only as wide as content)

---

### 2. `flex-direction`

**Controls the MAIN AXIS direction.**

```css
.container {
  flex-direction: row;            /* Default: left to right */
  flex-direction: row-reverse;    /* Right to left */
  flex-direction: column;         /* Top to bottom */
  flex-direction: column-reverse; /* Bottom to top */
}
```

**Visual comparison:**

```
row:
┌─────────────────────────┐
│ [1] [2] [3] →           │
└─────────────────────────┘

row-reverse:
┌─────────────────────────┐
│           ← [3] [2] [1] │
└─────────────────────────┘

column:
┌─────┐
│ [1] │
│  ↓  │
│ [2] │
│  ↓  │
│ [3] │
└─────┘

column-reverse:
┌─────┐
│ [3] │
│  ↑  │
│ [2] │
│  ↑  │
│ [1] │
└─────┘
```

---

### 3. `flex-wrap`

**Controls whether items wrap to multiple lines.**

```css
.container {
  flex-wrap: nowrap;      /* Default: all items on one line */
  flex-wrap: wrap;        /* Wrap to multiple lines */
  flex-wrap: wrap-reverse;/* Wrap in reverse direction */
}
```

**Visualization:**

```
nowrap (default):
┌──────────────────────────────────────────────┐
│ [1] [2] [3] [4] [5] [6] [7] → (overflows)    │
└──────────────────────────────────────────────┘

wrap:
┌──────────────────────────────┐
│ [1] [2] [3] [4]              │  ← First line
│ [5] [6] [7]                  │  ← Wraps to second line
└──────────────────────────────┘

wrap-reverse:
┌──────────────────────────────┐
│ [5] [6] [7]                  │  ← Second line appears first
│ [1] [2] [3] [4]              │  ← First line below
└──────────────────────────────┘
```

**Common use case:**
```css
.responsive-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
}

.responsive-grid > * {
  flex: 1 1 300px; /* Grow, shrink, minimum 300px width */
}
```

---

### 4. `flex-flow` (Shorthand)

**Combines `flex-direction` and `flex-wrap`.**

```css
.container {
  /* Instead of: */
  flex-direction: row;
  flex-wrap: wrap;
  
  /* Use: */
  flex-flow: row wrap;
}
```

---

### 5. `justify-content`

**Aligns items along the MAIN AXIS** (distributes free space).

```css
.container {
  justify-content: flex-start;    /* Default: pack to start */
  justify-content: flex-end;      /* Pack to end */
  justify-content: center;        /* Center items */
  justify-content: space-between; /* Equal space BETWEEN items */
  justify-content: space-around;  /* Equal space AROUND items */
  justify-content: space-evenly;  /* Truly equal spacing */
}
```

**Visual comparison (main axis = horizontal):**

```
flex-start (default):
┌─────────────────────────────────────┐
│ [1] [2] [3]                         │
└─────────────────────────────────────┘

flex-end:
┌─────────────────────────────────────┐
│                         [1] [2] [3] │
└─────────────────────────────────────┘

center:
┌─────────────────────────────────────┐
│           [1] [2] [3]               │
└─────────────────────────────────────┘

space-between:
┌─────────────────────────────────────┐
│ [1]        [2]        [3]           │
└─────────────────────────────────────┘
  ^          ^          ^
  No space   Equal      No space
  at edges   spacing    at edges

space-around:
┌─────────────────────────────────────┐
│   [1]      [2]      [3]             │
└─────────────────────────────────────┘
   ↑         ↑         ↑
   Half     Full      Half
   space    space     space

space-evenly:
┌─────────────────────────────────────┐
│    [1]     [2]     [3]              │
└─────────────────────────────────────┘
    ↑        ↑        ↑
    Equal    Equal    Equal
    everywhere
```

**The math:**

For `space-between` with 3 items:
```
Container width: 600px
Total items width: 300px (100px each)
Free space: 600px - 300px = 300px

Gaps needed: 2 (between 3 items)
Each gap: 300px / 2 = 150px

Result: [Item] 150px [Item] 150px [Item]
```

---

### 6. `align-items`

**Aligns items along the CROSS AXIS** (perpendicular to main axis).

```css
.container {
  align-items: stretch;     /* Default: stretch to fill container */
  align-items: flex-start;  /* Align to start of cross axis */
  align-items: flex-end;    /* Align to end of cross axis */
  align-items: center;      /* Center on cross axis */
  align-items: baseline;    /* Align baselines of text */
}
```

**Visual (main axis = horizontal, cross axis = vertical):**

```
stretch (default):
┌─────────────────────────────┐
│ ┌────┐ ┌────┐ ┌────┐       │
│ │ 1  │ │ 2  │ │ 3  │       │  ← All same height
│ │    │ │    │ │    │       │
│ └────┘ └────┘ └────┘       │
└─────────────────────────────┘

flex-start:
┌─────────────────────────────┐
│ ┌────┐ ┌──┐ ┌────┐          │  ← Aligned to top
│ │ 1  │ │2 │ │ 3  │          │
│ │    │ └──┘ │    │          │
│ └────┘      └────┘          │
└─────────────────────────────┘

center:
┌─────────────────────────────┐
│        ┌──┐                 │
│ ┌────┐ │2 │ ┌────┐          │  ← Centered vertically
│ │ 1  │ └──┘ │ 3  │          │
│ │    │      │    │          │
│ └────┘      └────┘          │
└─────────────────────────────┘

baseline:
┌─────────────────────────────┐
│   ┌────────┐                │
│   │Heading │  ┌──┐          │
│ ┌───────┐ └──┘ │B │ ┌────┐ │  ← Text baselines align
│ │  Text │      └──┘ │More│ │
│ └───────┘           └────┘ │
└─────────────────────────────┘
```

---

### 7. `align-content`

**Aligns MULTIPLE LINES of items** (only works with `flex-wrap: wrap`).

```css
.container {
  flex-wrap: wrap;
  align-content: flex-start;   /* Pack lines to start */
  align-content: flex-end;     /* Pack lines to end */
  align-content: center;       /* Center lines */
  align-content: space-between;/* Space between lines */
  align-content: space-around; /* Space around lines */
  align-content: stretch;      /* Default: stretch lines */
}
```

**Visual:**

```
stretch (default):
┌──────────────────────┐
│ [1] [2] [3]          │  ← Line 1 stretched
│                      │
│ [4] [5]              │  ← Line 2 stretched
│                      │
└──────────────────────┘

center:
┌──────────────────────┐
│                      │
│ [1] [2] [3]          │  ← Lines packed
│ [4] [5]              │     in center
│                      │
└──────────────────────┘

space-between:
┌──────────────────────┐
│ [1] [2] [3]          │  ← Line 1 at top
│                      │
│                      │  ← Space distributed
│                      │
│ [4] [5]              │  ← Line 2 at bottom
└──────────────────────┘
```

**Common mistake:**
```css
/* This does NOTHING if there's only one line! */
.container {
  display: flex;
  align-content: center; /* ← Needs multiple lines to work */
}
```

---

### 8. `gap`, `row-gap`, `column-gap`

**Sets spacing between flex items** (modern, replaces margin hacks).

```css
.container {
  display: flex;
  gap: 1rem;              /* 1rem gap in all directions */
  /* OR */
  row-gap: 1rem;          /* Gap between rows (with wrap) */
  column-gap: 2rem;       /* Gap between columns */
  /* OR */
  gap: 1rem 2rem;         /* row-gap column-gap */
}
```

**Before `gap` (old way):**
```css
.container {
  display: flex;
  margin: -0.5rem; /* Negative margin hack */
}

.item {
  margin: 0.5rem; /* Margin on items */
}
```

**With `gap` (modern way):**
```css
.container {
  display: flex;
  gap: 1rem; /* Clean! */
}
```

**Browser support:** Modern browsers (2021+). Use margin fallback for older browsers.

---

## 🎯 Item Properties (Children) {#item-properties}

These properties go on **flex items** (children of flex container).

### 1. `order`

**Controls visual order** (without changing HTML).

```css
.item {
  order: 0; /* Default: all items have order: 0 */
}

.item-1 { order: 2; }
.item-2 { order: 1; }
.item-3 { order: 3; }
```

**Result:**
```html
<!-- HTML order: -->
<div class="item-1">1</div>
<div class="item-2">2</div>
<div class="item-3">3</div>

<!-- Visual order: -->
[2] [1] [3]
```

**Use cases:**
- Responsive reordering (mobile vs desktop)
- Accessibility: screen readers follow HTML order, not visual order!

**Warning:** Don't use for core content structure. Use semantic HTML.

---

### 2. `flex-grow`

**How much should item GROW to fill free space?**

```css
.item {
  flex-grow: 0; /* Default: don't grow */
  flex-grow: 1; /* Grow to fill available space */
  flex-grow: 2; /* Grow twice as much as flex-grow: 1 */
}
```

**Example:**

```css
.container {
  display: flex;
  width: 600px;
}

.item {
  width: 100px; /* Base size */
}

.item-1 { flex-grow: 1; }
.item-2 { flex-grow: 2; }
.item-3 { flex-grow: 1; }
```

**The math:**

```
Container: 600px
3 items at 100px each: 300px
Free space: 600px - 300px = 300px

Total flex-grow: 1 + 2 + 1 = 4 "units"

Item 1: 100px + (300px × 1/4) = 175px
Item 2: 100px + (300px × 2/4) = 250px
Item 3: 100px + (300px × 1/4) = 175px

Visual:
┌─────────────────────────────────────────────────────────────┐
│ ◄──── 175px ────► ◄────── 250px ──────► ◄──── 175px ────►  │
│      [Item 1]           [Item 2]            [Item 3]        │
└─────────────────────────────────────────────────────────────┘
```

**Common pattern:**
```css
.sidebar { flex-grow: 0; width: 200px; } /* Fixed sidebar */
.main { flex-grow: 1; }                   /* Main grows to fill */
```

---

### 3. `flex-shrink`

**How much should item SHRINK when space is tight?**

```css
.item {
  flex-shrink: 1; /* Default: can shrink */
  flex-shrink: 0; /* Don't shrink */
  flex-shrink: 2; /* Shrink twice as much as 1 */
}
```

**Example:**

```css
.container {
  display: flex;
  width: 400px; /* Not enough space! */
}

.item {
  width: 200px; /* Each wants 200px */
}

.item-1 { flex-shrink: 1; }
.item-2 { flex-shrink: 0; } /* Won't shrink! */
.item-3 { flex-shrink: 2; }
```

**The math:**

```
Container: 400px
3 items want 200px each: 600px
Overflow: 600px - 400px = 200px (need to shrink)

flex-shrink weights: 1 + 0 + 2 = 3 units

Item 1: 200px - (200px × 1/3) = 133px
Item 2: 200px - (200px × 0/3) = 200px (doesn't shrink!)
Item 3: 200px - (200px × 2/3) = 67px

Result: Items 1 and 3 shrink to fit, Item 2 stays 200px
```

**Use case:**
```css
.logo {
  flex-shrink: 0; /* Logo never shrinks */
  width: 100px;
}

.nav {
  flex-shrink: 1; /* Nav can shrink if needed */
}
```

---

### 4. `flex-basis`

**The STARTING size before growing/shrinking.**

```css
.item {
  flex-basis: auto;      /* Default: use width/height */
  flex-basis: 200px;     /* Start at 200px */
  flex-basis: 50%;       /* Start at 50% of container */
  flex-basis: 0;         /* Ignore content size, distribute evenly */
}
```

**Priority order:**
1. `flex-basis` (if set)
2. `width` or `height` (depending on flex-direction)
3. Content size (intrinsic size)

**Example:**

```css
/* These are different! */
.item-a {
  width: 200px;
  flex-basis: 300px; /* ← flex-basis wins! Item starts at 300px */
}

.item-b {
  width: 200px;
  /* flex-basis not set, uses width: 200px */
}
```

**Common values:**

```css
/* Equal-width items (ignoring content) */
.item {
  flex: 1 1 0%; /* ← flex-basis: 0% */
}

/* Items size by content, then grow */
.item {
  flex: 1 1 auto; /* ← flex-basis: auto */
}
```

---

### 5. `flex` (Shorthand)

**Combines `flex-grow`, `flex-shrink`, and `flex-basis`.**

```css
.item {
  /* flex: <grow> <shrink> <basis> */
  flex: 1 1 auto;  /* Default (can grow and shrink) */
  flex: 1;         /* Shorthand: 1 1 0% */
  flex: auto;      /* Shorthand: 1 1 auto */
  flex: none;      /* Shorthand: 0 0 auto (fixed size) */
}
```

**Common patterns:**

```css
/* Equal-width columns */
.item {
  flex: 1; /* flex-grow: 1, flex-shrink: 1, flex-basis: 0% */
}

/* Fixed-width sidebar, flexible main */
.sidebar {
  flex: 0 0 250px; /* Don't grow, don't shrink, 250px wide */
}
.main {
  flex: 1; /* Take remaining space */
}

/* Responsive cards */
.card {
  flex: 1 1 300px; /* Grow, shrink, min 300px */
}
```

**One-value syntax:**

| Syntax | Expands to | Use case |
|--------|-----------|----------|
| `flex: 1` | `1 1 0%` | Equal distribution |
| `flex: auto` | `1 1 auto` | Size by content, then grow |
| `flex: none` | `0 0 auto` | Fixed size |
| `flex: 2` | `2 1 0%` | Grow twice as much |

---

### 6. `align-self`

**Override `align-items` for a single item.**

```css
.container {
  align-items: flex-start; /* All items aligned to start */
}

.special-item {
  align-self: flex-end; /* This one aligned to end */
}
```

**Values:**
- `auto` (default: inherit from container's `align-items`)
- `flex-start`
- `flex-end`
- `center`
- `baseline`
- `stretch`

**Visual:**

```
Container: align-items: flex-start
┌────────────────────────────────┐
│ ┌───┐ ┌───┐          ┌───┐    │
│ │ 1 │ │ 2 │          │ 4 │    │  ← Item 4 at bottom
│ └───┘ └───┘          └───┘    │
│          ┌───┐                 │  ← Item 3 in center
│          │ 3 │                 │
│          └───┘                 │
└────────────────────────────────┘
  Item 3: align-self: center
  Item 4: align-self: flex-end
```

---

## 🔥 Real-World Patterns {#real-world-patterns}

### Pattern 1: Perfect Centering

```css
.center-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}
```

---

### Pattern 2: Header with Logo + Nav

```html
<header class="header">
  <div class="logo">Logo</div>
  <nav class="nav">Nav Links</nav>
</header>
```

```css
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
}

.logo {
  flex-shrink: 0; /* Never shrink logo */
}

.nav {
  display: flex;
  gap: 1rem;
}
```

---

### Pattern 3: Holy Grail Layout (Sidebar + Main + Sidebar)

```html
<div class="container">
  <aside class="sidebar-left">Left</aside>
  <main class="main">Main Content</main>
  <aside class="sidebar-right">Right</aside>
</div>
```

```css
.container {
  display: flex;
  min-height: 100vh;
}

.sidebar-left,
.sidebar-right {
  flex: 0 0 250px; /* Fixed width */
}

.main {
  flex: 1; /* Take remaining space */
}
```

---

### Pattern 4: Card Grid (Responsive)

```css
.card-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
}

.card {
  flex: 1 1 300px; /* Grow, shrink, min 300px */
  max-width: 400px; /* Optional: prevent too wide */
}
```

**How it works:**
- Cards try to be at least 300px
- If space available, they grow
- If not enough space, they wrap to next line
- Creates responsive grid without media queries!

---

### Pattern 5: Sticky Footer

```html
<div class="page">
  <header>Header</header>
  <main>Content</main>
  <footer>Footer</footer>
</div>
```

```css
.page {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

main {
  flex: 1; /* Push footer to bottom */
}
```

---

### Pattern 6: Space Between Items (Old Way vs New Way)

**Old way (margin hack):**
```css
.container {
  display: flex;
  margin: -0.5rem;
}

.item {
  margin: 0.5rem;
}
```

**New way (gap):**
```css
.container {
  display: flex;
  gap: 1rem;
}
```

---

## 🐛 Common Gotchas and Debugging {#gotchas}

### Gotcha 1: Items Not Centering Vertically

**Problem:**
```css
.container {
  display: flex;
  justify-content: center;
  align-items: center;
  /* Missing height! */
}
```

**Solution:**
```css
.container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh; /* ← Need height for vertical centering! */
}
```

**Why:** `align-items` needs available space to distribute. Without height, container shrinks to content.

---

### Gotcha 2: Items Overflowing Container

**Problem:**
```css
.item {
  flex-shrink: 0; /* Items won't shrink */
  width: 300px;
}
```

**Solution:**
```css
.item {
  flex: 1 1 300px; /* Allow shrinking */
  min-width: 0; /* Override default min-width: auto */
}
```

**Why:** Flexbox won't shrink below content size by default. `min-width: 0` allows it.

---

### Gotcha 3: `gap` Not Working

**Problem:**
```css
.container {
  display: flex;
  gap: 1rem; /* Not supported in old browsers */
}
```

**Solution (fallback):**
```css
.container {
  display: flex;
  gap: 1rem;
}

/* Fallback for old browsers */
@supports not (gap: 1rem) {
  .container {
    margin: -0.5rem;
  }
  
  .item {
    margin: 0.5rem;
  }
}
```

---

### Gotcha 4: Text Truncation Not Working

**Problem:**
```css
.item {
  overflow: hidden;
  text-overflow: ellipsis;
  /* Doesn't work! */
}
```

**Solution:**
```css
.item {
  min-width: 0; /* ← Critical! */
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
```

**Why:** Flex items have `min-width: auto` by default, preventing shrinking below content width.

---

### Gotcha 5: Margins Collapsing Weirdly

**Issue:** Flex containers don't collapse margins like normal flow.

```css
.item {
  margin: 1rem 0;
}
```

Result: Margins DON'T collapse between flex items (unlike block elements).

**Solution:** Use `gap` instead of margins for consistent spacing.

---

## 🎓 Practice Exercises {#exercises}

### Exercise 1: Navigation Bar

Create a responsive navigation with logo on left, links in center, button on right.

**HTML:**
```html
<nav class="navbar">
  <div class="logo">Logo</div>
  <ul class="nav-links">
    <li>Home</li>
    <li>About</li>
    <li>Contact</li>
  </ul>
  <button class="cta">Sign Up</button>
</nav>
```

**Your task:** Write the CSS using Flexbox.

**Hints:**
- Use `justify-content: space-between`
- `.nav-links` should also be a flex container
- Use `gap` for spacing

---

### Exercise 2: Card Layout

Create a responsive card grid that:
- Shows 3 cards per row on desktop
- Wraps to 2 cards on tablet
- Shows 1 card on mobile
- Cards have equal heights

**Hint:** Use `flex-wrap` and `flex: 1 1 300px`.

---

### Exercise 3: Holy Grail Layout

Create a layout with:
- Fixed header
- Sidebar (200px wide)
- Main content (grows)
- Fixed footer

**Bonus:** Make sidebar sticky on scroll.

---

## 📚 Additional Resources {#resources}

### Interactive Learning
- **[Flexbox Froggy](https://flexboxfroggy.com/)** - Game to learn Flexbox
- **[Flexbox Defense](http://www.flexboxdefense.com/)** - Tower defense game with Flexbox
- **[Flexbox Zombies](https://mastery.games/flexboxzombies/)** - Story-based learning

### Visual Guides
- **[CSS-Tricks Complete Guide to Flexbox](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)** - The definitive visual guide
- **[Flexbox Cheatsheet](https://yoksel.github.io/flex-cheatsheet/)** - Interactive reference
- **[Flexbox Playground](https://codepen.io/enxaneta/pen/adLPwv)** - Experiment with properties

### Deep Dives
- **[MDN Flexbox](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout)** - Comprehensive documentation
- **[W3C Flexbox Spec](https://www.w3.org/TR/css-flexbox-1/)** - Official specification
- **[Smashing Magazine Flexbox](https://www.smashingmagazine.com/2018/08/flexbox-display-flex-container/)** - In-depth articles

### Video Tutorials
- **[Wes Bos - What The Flexbox?](https://flexbox.io/)** - Free video course
- **[Kevin Powell - Flexbox](https://www.youtube.com/watch?v=u044iM9xsWU)** - YouTube tutorial series

### Tools
- **[Flexbox Generator](https://loading.io/flexbox/)** - Visual Flexbox builder
- **[Flexy Boxes](https://the-echoplex.net/flexyboxes/)** - Code generator

---

## ✅ Checklist: Do You Understand Flexbox?

- [ ] Can you explain main axis vs cross axis?
- [ ] Do you know what happens when you change `flex-direction`?
- [ ] Can you center something both horizontally and vertically?
- [ ] Do you understand the difference between `justify-content` and `align-items`?
- [ ] Can you explain `flex-grow`, `flex-shrink`, and `flex-basis`?
- [ ] Do you know when to use `flex: 1` vs `flex: auto` vs `flex: none`?
- [ ] Can you create a responsive layout without media queries using `flex-wrap`?
- [ ] Do you understand why `min-width: 0` is sometimes needed?

If you answered YES to all, you've mastered Flexbox! 🎉

---

**Next:** Check out the [Complete CSS Grid Guide](./02-CSS-Grid-Complete-Guide.md) to level up your layout skills even further!
