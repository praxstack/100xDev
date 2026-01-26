# 📐 The Complete CSS Grid Guide - From Zero to Hero

**Last Updated:** January 2026  
**Difficulty:** Beginner to Advanced  
**Time to Master:** 3-4 hours of focused study + practice

---

## 🎯 Table of Contents

1. [What is CSS Grid and Why Does It Exist?](#what-is-grid)
2. [Grid vs Flexbox: When to Use Which?](#grid-vs-flexbox)
3. [The Mental Model: Tracks, Lines, Cells, and Areas](#mental-model)
4. [Container Properties (Grid Parent)](#container-properties)
5. [Item Properties (Grid Children)](#item-properties)
6. [Advanced Patterns](#advanced-patterns)
7. [Real-World Layouts](#real-world-layouts)
8. [Common Gotchas and Debugging](#gotchas)
9. [Practice Exercises](#exercises)
10. [Additional Resources](#resources)

---

## 🌟 What is CSS Grid and Why Does It Exist? {#what-is-grid}

### The Evolution of CSS Layouts

```
1990s: Tables (for layout) 😱
  ↓
2000s: Floats + Clearfix hacks 😓
  ↓
2010s: Flexbox (1D layouts) 🎉
  ↓
2017+: CSS Grid (2D layouts) 🚀
```

### The Problem Grid Solves

**Before Grid, creating 2D layouts required:**
- Complex float calculations
- Nested divs everywhere
- Brittle positioning logic
- Separate HTML structure for different screen sizes

**Example: A simple 3×3 grid**

**Pre-Grid (float-based):**
```html
<div class="row">
  <div class="col">1</div>
  <div class="col">2</div>
  <div class="col">3</div>
</div>
<div class="row">
  <div class="col">4</div>
  <div class="col">5</div>
  <div class="col">6</div>
</div>
<div class="row">
  <div class="col">7</div>
  <div class="col">8</div>
  <div class="col">9</div>
</div>
```

```css
.row::after {
  content: "";
  display: table;
  clear: both; /* Clearfix hack */
}

.col {
  float: left;
  width: 33.333%;
}
```

**With Grid:**
```html
<div class="grid">
  <div>1</div>
  <div>2</div>
  <div>3</div>
  <div>4</div>
  <div>5</div>
  <div>6</div>
  <div>7</div>
  <div>8</div>
  <div>9</div>
</div>
```

```css
.grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1rem;
}
```

**Result: Cleaner HTML, simpler CSS, more powerful!**

---

### Grid vs Flexbox: When to Use Which? {#grid-vs-flexbox}

| Feature | Flexbox | Grid |
|---------|---------|------|
| **Dimension** | 1D (row OR column) | 2D (rows AND columns) |
| **Direction** | Content → Layout | Layout → Content |
| **Use Case** | Components, small layouts | Page layouts, complex grids |
| **Item Control** | Content size dictates | Layout dictates content size |
| **Best For** | Navigation, toolbars, centering | Page structure, image galleries |

**Visual comparison:**

```
FLEXBOX (1D):
┌─────────────────────────────────────────────┐
│ [Item 1] [Item 2] [Item 3] [Item 4] →      │  Single axis
└─────────────────────────────────────────────┘

or

┌────────┐
│[Item 1]│
│[Item 2]│  Single axis (vertical)
│[Item 3]│
│[Item 4]│
│   ↓    │
└────────┘

GRID (2D):
┌─────────────────────────────────────────────┐
│ [Item 1] [Item 2] [Item 3]                  │
│ [Item 4] [Item 5] [Item 6]                  │  Both axes
│ [Item 7] [Item 8] [Item 9]                  │  simultaneously
└─────────────────────────────────────────────┘
```

**Decision tree:**

```
Need layout in ONE direction only?
└─ Use Flexbox

Need 2D grid of rows AND columns?
└─ Use Grid

Need items to wrap based on content?
└─ Flexbox with flex-wrap

Need precise control over placement?
└─ Grid

Building a navbar/toolbar?
└─ Flexbox

Building page layout?
└─ Grid

Still not sure?
└─ Use both! Grid for overall page, Flexbox for components
```

---

## 🧠 The Mental Model: Tracks, Lines, Cells, and Areas {#mental-model}

### The Grid Anatomy

```
┌─────────────────────────────────────────────────────────────┐
│                    Grid Container                           │
│                                                             │
│   Line 1          Line 2         Line 3         Line 4      │
│     │               │              │              │         │
│     ↓               ↓              ↓              ↓         │
│   ┌─────────────┬─────────────┬─────────────┐             │
│   │   Cell 1    │   Cell 2    │   Cell 3    │  ← Row 1    │
│   │  (1,1)      │  (1,2)      │  (1,3)      │             │
│   ├─────────────┼─────────────┼─────────────┤             │
│   │   Cell 4    │   Cell 5    │   Cell 6    │  ← Row 2    │
│   │  (2,1)      │  (2,2)      │  (2,3)      │             │
│   ├─────────────┼─────────────┼─────────────┤             │
│   │   Cell 7    │   Cell 8    │   Cell 9    │  ← Row 3    │
│   │  (3,1)      │  (3,2)      │  (3,3)      │             │
│   └─────────────┴─────────────┴─────────────┘             │
│       ↑             ↑             ↑                         │
│     Column 1      Column 2      Column 3                    │
│                                                             │
│   ◄─── Track ───►                                          │
│   (Column Track = vertical space between 2 column lines)    │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Key Terminology

**1. Grid Lines**
- The dividing lines that create rows and columns
- Numbered from 1 (not 0!)
- Can be named for easier reference

**2. Grid Tracks**
- The space between two adjacent grid lines
- **Column track** = vertical space (between two column lines)
- **Row track** = horizontal space (between two row lines)

**3. Grid Cells**
- The space between two adjacent row AND column lines
- The smallest unit you can place an item into

**4. Grid Areas**
- One or more cells combined
- Can span multiple rows/columns
- Can be named

**Example with named lines:**

```css
.grid {
  display: grid;
  grid-template-columns: [start] 1fr [middle] 1fr [end];
  grid-template-rows: [top] 100px [center] 100px [bottom];
}
```

```
     [start]      [middle]       [end]
        │            │             │
[top]   ├────────────┼─────────────┤
        │            │             │
[center]├────────────┼─────────────┤
        │            │             │
[bottom]└────────────┴─────────────┘
```

---

## 🎛️ Container Properties (Grid Parent) {#container-properties}

### 1. `display`

```css
.container {
  display: grid;        /* Block-level grid */
  /* OR */
  display: inline-grid; /* Inline-level grid */
}
```

**Difference:**
- `grid` - Container is block-level (takes full width)
- `inline-grid` - Container is inline (only as wide as content)

---

### 2. `grid-template-columns` and `grid-template-rows`

**Defines the tracks (columns and rows).**

```css
.grid {
  display: grid;
  
  /* Fixed sizes */
  grid-template-columns: 200px 300px 400px;
  
  /* Flexible sizes */
  grid-template-columns: 1fr 2fr 1fr;
  
  /* Mixed */
  grid-template-columns: 200px 1fr 2fr;
  
  /* Repeat */
  grid-template-columns: repeat(3, 1fr);
  
  /* Auto-fill */
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
}
```

#### Understanding `fr` (Fraction Unit)

**`fr` = fraction of available space**

```css
.grid {
  width: 600px;
  grid-template-columns: 1fr 2fr 1fr;
}
```

**The math:**

```
Total width: 600px
Total fr units: 1 + 2 + 1 = 4

1fr = 600px / 4 = 150px

Column 1: 1fr = 150px
Column 2: 2fr = 300px
Column 3: 1fr = 150px

Visual:
┌─────────────────────────────────────────┐
│ ◄─150px─► ◄───300px───► ◄─150px─►     │
│   Col 1       Col 2        Col 3        │
└─────────────────────────────────────────┘
```

**With fixed + flexible:**

```css
.grid {
  width: 600px;
  grid-template-columns: 100px 1fr 2fr;
}
```

```
Total width: 600px
Fixed columns: 100px
Remaining: 600px - 100px = 500px
Total fr: 1 + 2 = 3

1fr = 500px / 3 = 166.67px

Column 1: 100px (fixed)
Column 2: 1fr = 166.67px
Column 3: 2fr = 333.33px
```

#### `repeat()` Function

**Syntax:** `repeat(count, track-size)`

```css
/* Instead of: */
grid-template-columns: 1fr 1fr 1fr 1fr;

/* Use: */
grid-template-columns: repeat(4, 1fr);

/* Complex pattern: */
grid-template-columns: repeat(3, 100px 1fr);
/* Expands to: 100px 1fr 100px 1fr 100px 1fr */
```

#### `minmax()` Function

**Sets minimum and maximum size for a track.**

```css
.grid {
  grid-template-columns: minmax(200px, 1fr) 1fr 1fr;
}
```

```
Column 1: At least 200px, can grow to 1fr
Columns 2-3: Always 1fr

Small container (400px):
┌──────────────────────────────────┐
│ ◄─200px─► ◄100px► ◄100px►       │  Col 1 at minimum
└──────────────────────────────────┘

Large container (900px):
┌──────────────────────────────────┐
│ ◄─300px─► ◄300px► ◄300px►       │  Col 1 grows to 1fr
└──────────────────────────────────┘
```

#### `auto-fit` vs `auto-fill`

**Create responsive grids without media queries!**

```css
/* auto-fit: Collapse empty tracks */
.grid {
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
}

/* auto-fill: Keep empty tracks */
.grid {
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
}
```

**Visual difference:**

```
Container: 650px, Items: 3

auto-fit:
┌──────────────────────────────────────────────┐
│ ◄──216px──► ◄──216px──► ◄──216px──►         │  Items stretch
│   [Item 1]    [Item 2]    [Item 3]           │  to fill space
└──────────────────────────────────────────────┘

auto-fill:
┌──────────────────────────────────────────────┐
│ ◄─200px─► ◄─200px─► ◄─200px─► ◄─empty─►     │  Empty track
│  [Item 1]  [Item 2]  [Item 3]   (space)      │  remains
└──────────────────────────────────────────────┘
```

**Use cases:**
- `auto-fit` - Items should fill available space
- `auto-fill` - Maintain consistent item size

---

### 3. `grid-template-areas`

**Create named grid areas for intuitive layouts.**

```css
.grid {
  display: grid;
  grid-template-columns: 1fr 3fr 1fr;
  grid-template-rows: auto 1fr auto;
  grid-template-areas:
    "header  header  header"
    "sidebar main    aside"
    "footer  footer  footer";
}

.header  { grid-area: header; }
.sidebar { grid-area: sidebar; }
.main    { grid-area: main; }
.aside   { grid-area: aside; }
.footer  { grid-area: footer; }
```

**Visual result:**

```
┌──────────────────────────────────────────────┐
│              header                          │
├─────────┬─────────────────────┬──────────────┤
│ sidebar │       main          │    aside     │
│         │                     │              │
│         │                     │              │
├─────────┴─────────────────────┴──────────────┤
│              footer                          │
└──────────────────────────────────────────────┘
```

**Rules:**
- Use quotes for each row
- Same name creates merged cells
- `.` (dot) = empty cell
- Names must be rectangular (no L-shapes)

**Example with empty cells:**

```css
.grid {
  grid-template-areas:
    "header header  header"
    "sidebar main   ."
    "footer footer  footer";
}
```

---

### 4. `grid-template` (Shorthand)

**Combines rows, columns, and areas.**

```css
/* Longhand: */
.grid {
  grid-template-rows: auto 1fr auto;
  grid-template-columns: 1fr 3fr 1fr;
  grid-template-areas:
    "header header header"
    "sidebar main aside"
    "footer footer footer";
}

/* Shorthand: */
.grid {
  grid-template:
    "header  header  header" auto
    "sidebar main    aside"  1fr
    "footer  footer  footer" auto
    / 1fr 3fr 1fr;
    /* ↑ Column sizes after slash */
}
```

---

### 5. `gap`, `row-gap`, `column-gap`

**Sets spacing between grid items.**

```css
.grid {
  display: grid;
  gap: 1rem;              /* 1rem gap everywhere */
  /* OR */
  row-gap: 1rem;          /* Gap between rows */
  column-gap: 2rem;       /* Gap between columns */
  /* OR */
  gap: 1rem 2rem;         /* row-gap column-gap */
}
```

**Visual:**

```
gap: 1rem;
┌──────────────────────────────┐
│ [Item 1] ◄1rem► [Item 2]     │
│    ↕1rem                      │
│ [Item 3] ◄1rem► [Item 4]     │
└──────────────────────────────┘

gap: 1rem 2rem; (row 1rem, column 2rem)
┌──────────────────────────────┐
│ [Item 1] ◄2rem► [Item 2]     │
│    ↕1rem                      │
│ [Item 3] ◄2rem► [Item 4]     │
└──────────────────────────────┘
```

**Note:** Old syntax was `grid-gap`, now just `gap`.

---

### 6. `justify-items`

**Aligns items HORIZONTALLY within their cells.**

```css
.grid {
  justify-items: start;   /* Default: align to left */
  justify-items: end;     /* Align to right */
  justify-items: center;  /* Center horizontally */
  justify-items: stretch; /* Fill cell width */
}
```

**Visual:**

```
start (default):
┌──────────────────────────────┐
│ [Item]│        │        │    │  ← Items at left
└──────────────────────────────┘

center:
┌──────────────────────────────┐
│    [Item]  [Item]  [Item]    │  ← Items centered
└──────────────────────────────┘

stretch:
┌──────────────────────────────┐
│ [─Item─]│[─Item─]│[─Item─]   │  ← Items fill width
└──────────────────────────────┘
```

---

### 7. `align-items`

**Aligns items VERTICALLY within their cells.**

```css
.grid {
  align-items: start;     /* Align to top */
  align-items: end;       /* Align to bottom */
  align-items: center;    /* Center vertically */
  align-items: stretch;   /* Default: fill cell height */
}
```

**Visual:**

```
start:
┌─────────────┬─────────────┐
│ [Item]      │ [Item]      │  ← Items at top
│             │             │
└─────────────┴─────────────┘

center:
┌─────────────┬─────────────┐
│             │             │
│ [Item]      │ [Item]      │  ← Items centered
│             │             │
└─────────────┴─────────────┘

stretch (default):
┌─────────────┬─────────────┐
│ ┌─────────┐ │ ┌─────────┐ │
│ │  Item   │ │ │  Item   │ │  ← Items fill height
│ └─────────┘ │ └─────────┘ │
└─────────────┴─────────────┘
```

---

### 8. `place-items` (Shorthand)

**Combines `align-items` and `justify-items`.**

```css
.grid {
  place-items: center;         /* Both centered */
  /* OR */
  place-items: start end;      /* align justify */
}
```

---

### 9. `justify-content`

**Aligns the ENTIRE GRID within the container (horizontal).**

*Only works if grid is smaller than container.*

```css
.grid {
  justify-content: start;        /* Default */
  justify-content: end;
  justify-content: center;
  justify-content: space-between;
  justify-content: space-around;
  justify-content: space-evenly;
}
```

**Visual:**

```
Container wider than grid:

start:
┌────────────────────────────────────────┐
│ [Grid]                                 │
└────────────────────────────────────────┘

center:
┌────────────────────────────────────────┐
│           [Grid]                       │
└────────────────────────────────────────┘

end:
┌────────────────────────────────────────┐
│                          [Grid]        │
└────────────────────────────────────────┘
```

---

### 10. `align-content`

**Aligns the ENTIRE GRID within the container (vertical).**

```css
.grid {
  align-content: start;
  align-content: end;
  align-content: center;
  align-content: space-between;
  align-content: space-around;
  align-content: space-evenly;
}
```

---

### 11. `place-content` (Shorthand)

**Combines `align-content` and `justify-content`.**

```css
.grid {
  place-content: center;        /* Center grid in container */
  /* OR */
  place-content: start end;     /* align justify */
}
```

---

### 12. `grid-auto-columns` and `grid-auto-rows`

**Defines size of IMPLICIT tracks** (auto-generated).

```css
.grid {
  display: grid;
  grid-template-columns: 200px 200px; /* 2 explicit columns */
  grid-auto-columns: 100px;           /* Additional columns: 100px */
}
```

**Example:**

```html
<div class="grid">
  <div>1</div>
  <div>2</div>
  <div style="grid-column: 4">3</div> <!-- Creates implicit column 3 & 4 -->
</div>
```

```
Explicit      Implicit
┌──────┬──────┬──────┬──────┐
│ 200  │ 200  │ 100  │ 100  │
│  1   │  2   │      │  3   │
└──────┴──────┴──────┴──────┘
        ↑              ↑
  Template cols    Auto cols
```

---

### 13. `grid-auto-flow`

**Controls how auto-placed items flow.**

```css
.grid {
  grid-auto-flow: row;      /* Default: fill rows first */
  grid-auto-flow: column;   /* Fill columns first */
  grid-auto-flow: dense;    /* Fill gaps (reorder items!) */
}
```

**Visual:**

```
row (default):
┌──────┬──────┬──────┐
│  1   │  2   │  3   │
├──────┼──────┼──────┤
│  4   │  5   │  6   │
└──────┴──────┴──────┘

column:
┌──────┬──────┐
│  1   │  4   │
├──────┼──────┤
│  2   │  5   │
├──────┼──────┤
│  3   │  6   │
└──────┴──────┘

dense (with spanning item):
Normal:                    Dense:
┌──────┬──────┬──────┐    ┌──────┬──────┬──────┐
│  1   │  2   │      │    │  1   │  2   │  4   │  ← 4 fills gap!
│      ├──────┼──────┤    │      ├──────┼──────┤
│      │  3   │      │    │      │  3   │  5   │  ← 5 fills gap!
└──────┴──────┴──────┘    └──────┴──────┴──────┘
         ↑                          ↑
       Gaps                    No gaps
```

**Warning:** `dense` changes visual order (accessibility issue!).

---

## 🎯 Item Properties (Grid Children) {#item-properties}

### 1. `grid-column-start` / `grid-column-end`

**Defines which column lines an item spans.**

```css
.item {
  grid-column-start: 1;
  grid-column-end: 3; /* Spans from line 1 to line 3 */
}
```

**Visual:**

```
Lines:    1       2       3       4
          │       │       │       │
          ├───────┴───────┤       │
          │     Item      │       │  ← Spans 2 columns
          ├───────────────┼───────┤
```

**Shorthand:**

```css
.item {
  grid-column: 1 / 3; /* start / end */
}
```

**Span syntax:**

```css
.item {
  grid-column: 1 / span 2; /* Start at 1, span 2 columns */
  /* Same as: grid-column: 1 / 3; */
}
```

---

### 2. `grid-row-start` / `grid-row-end`

**Defines which row lines an item spans.**

```css
.item {
  grid-row-start: 1;
  grid-row-end: 4; /* Spans from line 1 to line 4 */
}
```

**Shorthand:**

```css
.item {
  grid-row: 1 / 4; /* start / end */
}
```

---

### 3. `grid-column` and `grid-row` Combined

```css
.item {
  grid-column: 2 / 4;  /* Columns 2-3 */
  grid-row: 1 / 3;     /* Rows 1-2 */
}
```

**Visual:**

```
        1       2       3       4
      ┌───────┬───────┬───────┬───────┐
    1 │       │ ┌─────┴─────┐ │       │
      │       │ │    Item    │ │       │
    2 │       │ │            │ │       │
      │       │ └─────┬─────┘ │       │
    3 │       │       │       │       │
      └───────┴───────┴───────┴───────┘
```

---

### 4. `grid-area`

**Three uses:**

**1. Reference named area:**
```css
.header {
  grid-area: header; /* Reference from grid-template-areas */
}
```

**2. Shorthand for placement:**
```css
.item {
  grid-area: 1 / 2 / 3 / 4;
  /* row-start / col-start / row-end / col-end */
}
```

**3. Create named area:**
```css
.item {
  grid-area: my-area;
}
```

---

### 5. `justify-self`

**Override `justify-items` for a single item (horizontal).**

```css
.grid {
  justify-items: start; /* All items left-aligned */
}

.special-item {
  justify-self: end; /* This one right-aligned */
}
```

**Values:**
- `start`
- `end`
- `center`
- `stretch`

---

### 6. `align-self`

**Override `align-items` for a single item (vertical).**

```css
.grid {
  align-items: start; /* All items top-aligned */
}

.special-item {
  align-self: center; /* This one centered */
}
```

---

### 7. `place-self` (Shorthand)

**Combines `align-self` and `justify-self`.**

```css
.item {
  place-self: center;        /* Both centered */
  /* OR */
  place-self: start end;     /* align justify */
}
```

---

## 🔥 Advanced Patterns {#advanced-patterns}

### Pattern 1: Responsive Grid Without Media Queries

```css
.grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1rem;
}
```

**How it works:**
- Creates as many columns as fit
- Each column at least 250px
- Columns grow to fill space
- Automatically responsive!

**Visual:**

```
Large screen (900px):
┌────────────────────────────────────────────┐
│ [Item 1] [Item 2] [Item 3]                 │
│   300px    300px    300px                  │
└────────────────────────────────────────────┘

Medium screen (600px):
┌────────────────────────┐
│ [Item 1] [Item 2]      │
│   300px    300px       │
│ [Item 3]               │
│   600px                │
└────────────────────────┘

Small screen (300px):
┌─────────────┐
│  [Item 1]   │
│  [Item 2]   │
│  [Item 3]   │
│   300px     │
└─────────────┘
```

---

### Pattern 2: Perfect Centering

```css
.grid {
  display: grid;
  place-items: center; /* Shorter than flexbox! */
  height: 100vh;
}
```

---

### Pattern 3: Holy Grail Layout

```css
.page {
  display: grid;
  grid-template-areas:
    "header header header"
    "sidebar main aside"
    "footer footer footer";
  grid-template-columns: 200px 1fr 200px;
  grid-template-rows: auto 1fr auto;
  min-height: 100vh;
}

.header  { grid-area: header; }
.sidebar { grid-area: sidebar; }
.main    { grid-area: main; }
.aside   { grid-area: aside; }
.footer  { grid-area: footer; }
```

---

### Pattern 4: Responsive Holy Grail

```css
.page {
  display: grid;
  grid-template-areas:
    "header"
    "main"
    "sidebar"
    "aside"
    "footer";
  gap: 1rem;
}

@media (min-width: 768px) {
  .page {
    grid-template-areas:
      "header header header"
      "sidebar main aside"
      "footer footer footer";
    grid-template-columns: 200px 1fr 200px;
  }
}
```

---

### Pattern 5: Masonry-Like (Card) Layout

```css
.grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  grid-auto-rows: 10px; /* Small base unit */
  gap: 1rem;
}

.card {
  /* Each card spans based on content height */
  grid-row-end: span 30; /* Adjust per card */
}

.card.tall {
  grid-row-end: span 50;
}
```

---

### Pattern 6: Overlapping Elements

```css
.grid {
  display: grid;
  grid-template-columns: 1fr;
  grid-template-rows: 1fr;
}

.background {
  grid-column: 1;
  grid-row: 1;
  z-index: 1;
}

.content {
  grid-column: 1;
  grid-row: 1;
  z-index: 2; /* Overlaps background */
}
```

---

## 🏗️ Real-World Layouts {#real-world-layouts}

### Layout 1: Dashboard

```html
<div class="dashboard">
  <header class="header">Header</header>
  <nav class="sidebar">Sidebar</nav>
  <main class="main">Main Content</main>
  <aside class="widgets">Widgets</aside>
  <footer class="footer">Footer</footer>
</div>
```

```css
.dashboard {
  display: grid;
  grid-template-areas:
    "header header header"
    "sidebar main widgets"
    "footer footer footer";
  grid-template-columns: 250px 1fr 300px;
  grid-template-rows: 60px 1fr 40px;
  height: 100vh;
  gap: 1rem;
}

.header  { grid-area: header; }
.sidebar { grid-area: sidebar; }
.main    { grid-area: main; }
.widgets { grid-area: widgets; }
.footer  { grid-area: footer; }
```

---

### Layout 2: Magazine/Blog

```css
.article {
  display: grid;
  grid-template-columns: 1fr minmax(auto, 65ch) 1fr;
  gap: 2rem;
}

.article > * {
  grid-column: 2; /* All content in middle column */
}

.article .full-width {
  grid-column: 1 / -1; /* Span all columns */
}

.article .wide {
  grid-column: 1 / 3; /* Span left + middle */
}
```

**Result:**

```
┌──────────────────────────────────────────┐
│          [Full Width Image]              │
├───────┬────────────────────┬─────────────┤
│       │  Article Text      │             │
│       │  [Wide Image]      │             │
│       │  More text         │             │
└───────┴────────────────────┴─────────────┘
```

---

### Layout 3: Photo Gallery

```css
.gallery {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  grid-auto-rows: 200px;
  gap: 10px;
}

.gallery-item:nth-child(3n) {
  grid-column: span 2; /* Every 3rd item spans 2 columns */
}

.gallery-item:nth-child(5n) {
  grid-row: span 2; /* Every 5th item spans 2 rows */
}
```

---

### Layout 4: Form Layout

```html
<form class="form-grid">
  <label>Name</label>
  <input type="text">
  
  <label>Email</label>
  <input type="email">
  
  <label>Message</label>
  <textarea></textarea>
  
  <button>Submit</button>
</form>
```

```css
.form-grid {
  display: grid;
  grid-template-columns: 150px 1fr;
  gap: 1rem;
  align-items: start;
}

.form-grid label {
  justify-self: end; /* Right-align labels */
}

.form-grid textarea {
  grid-column: 2; /* Input in second column */
  min-height: 100px;
}

.form-grid button {
  grid-column: 2; /* Button in second column */
  justify-self: start;
}
```

---

## 🐛 Common Gotchas and Debugging {#gotchas}

### Gotcha 1: Grid Lines Are 1-Indexed (Not 0!)

```css
.item {
  grid-column: 0 / 2; /* ❌ WRONG! No line 0 */
  grid-column: 1 / 2; /* ✅ Correct */
}
```

---

### Gotcha 2: End Line is Exclusive

```css
.item {
  grid-column: 1 / 3; /* Spans columns 1 and 2 (not 3!) */
}
```

```
Lines:  1       2       3       4
        ├───────┴───────┤
        │     Item      │  ← Spans to line 3 (exclusive)
```

---

### Gotcha 3: Negative Line Numbers Count from End

```css
.item {
  grid-column: 1 / -1; /* From first to last line */
}
```

```
Lines:  1       2       3      -2      -1
        ├───────┴───────┴───────┴───────┤
        │          Item                  │
```

---

### Gotcha 4: `fr` Doesn't Work with Auto-Sized Tracks

```css
.grid {
  grid-template-columns: auto 1fr; /* ❌ 'auto' can grow indefinitely */
  grid-template-columns: 200px 1fr; /* ✅ Fixed size works */
}
```

---

### Gotcha 5: Items Overlap by Default

```css
.item-1 { grid-area: 1 / 1 / 2 / 2; }
.item-2 { grid-area: 1 / 1 / 2 / 2; } /* Same cell! */
```

**Solution:** Use `z-index` to control stacking.

---

### Gotcha 6: `gap` Affects Size Calculations

```css
.grid {
  width: 300px;
  grid-template-columns: 1fr 1fr 1fr;
  gap: 10px; /* Total gap: 20px (2 gaps) */
}

/* Each column: (300px - 20px) / 3 = 93.33px */
```

---

### Gotcha 7: Implicit vs Explicit Tracks

```css
.grid {
  grid-template-columns: 200px 200px; /* 2 explicit columns */
}

.item {
  grid-column: 3; /* Creates implicit 3rd column! */
}
```

**Solution:** Use `grid-auto-columns` to control implicit track size.

---

## 🎓 Practice Exercises {#exercises}

### Exercise 1: Responsive Card Grid

**Create a card grid that:**
- Shows 4 cards per row on desktop (>1200px)
- Shows 3 cards per row on tablet (>768px)
- Shows 1 card per row on mobile
- Cards have equal height
- Uses NO media queries

**Hint:** Use `repeat(auto-fit, minmax(...))`.

---

### Exercise 2: Dashboard Layout

**Create a dashboard with:**
- Header (full width, 60px tall)
- Sidebar (200px wide, fixed)
- Main content (flexible)
- Widget area (300px wide, on right)
- Footer (full width, 40px tall)

**Bonus:** Make sidebar collapse on mobile.

---

### Exercise 3: Magazine Layout

**Create an article layout with:**
- Centered content column (max 65 characters wide)
- Full-width images that can break out
- Pull quotes that span half the content + margin

---

### Exercise 4: Photo Gallery

**Create a gallery where:**
- Images are at least 200px wide
- Every 3rd image spans 2 columns
- Every 5th image spans 2 rows
- Grid is responsive

---

## 📚 Additional Resources {#resources}

### Interactive Learning
- **[Grid Garden](https://cssgridgarden.com/)** - Game to learn CSS Grid
- **[Grid Critters](https://gridcritters.com/)** - Story-based Grid learning
- **[Grid by Example](https://gridbyexample.com/)** - Real examples by Rachel Andrew

### Visual Guides
- **[CSS-Tricks Complete Guide to Grid](https://css-tricks.com/snippets/css/complete-guide-grid/)** - The definitive guide
- **[Grid Cheatsheet](https://grid.malven.co/)** - Quick visual reference
- **[CSS Grid Playground](https://www.cssgridplayground.com/)** - Interactive tool

### Deep Dives
- **[MDN CSS Grid](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout)** - Comprehensive docs
- **[W3C Grid Spec](https://www.w3.org/TR/css-grid-1/)** - Official specification
- **[Smashing Magazine Grid Articles](https://www.smashingmagazine.com/guides/css-layout/)** - In-depth guides

### Video Tutorials
- **[Wes Bos - CSS Grid](https://cssgrid.io/)** - Free video course
- **[Layout Land (Jen Simmons)](https://www.youtube.com/c/LayoutLand)** - Grid expert's channel
- **[Kevin Powell - Grid Tutorials](https://www.youtube.com/kepowob)** - Practical examples

### Tools
- **[CSS Grid Generator](https://cssgrid-generator.netlify.app/)** - Visual grid builder
- **[Griddy](https://griddy.io/)** - Interactive grid designer
- **[Firefox Grid Inspector](https://firefox-source-docs.mozilla.org/devtools-user/page_inspector/how_to/examine_grid_layouts/index.html)** - Best DevTools for Grid

### Books
- **"CSS Grid Layout" by Rachel Andrew** - The Grid expert
- **"Every Layout" by Heydon Pickering & Andy Bell** - Modern layout patterns

---

## ✅ Checklist: Do You Understand Grid?

- [ ] Can you explain the difference between Grid and Flexbox?
- [ ] Do you understand grid lines, tracks, cells, and areas?
- [ ] Can you create a basic 3×3 grid?
- [ ] Do you know the difference between `fr` and `%`?
- [ ] Can you use `grid-template-areas` to create named layouts?
- [ ] Do you understand `repeat()`, `minmax()`, `auto-fit`, and `auto-fill`?
- [ ] Can you make an item span multiple rows/columns?
- [ ] Can you create a responsive grid without media queries?
- [ ] Do you understand implicit vs explicit tracks?
- [ ] Can you debug grid layouts using browser DevTools?

If you answered YES to all, you've mastered CSS Grid! 🎉

---

## 🎯 Grid vs Flexbox: Final Decision Matrix

| Scenario | Use... |
|----------|--------|
| Navigation bar | **Flexbox** |
| Page layout | **Grid** |
| Photo gallery | **Grid** |
| Centering one thing | **Flexbox** or **Grid** (both work!) |
| Card layout | **Grid** |
| Toolbar with buttons | **Flexbox** |
| Magazine layout | **Grid** |
| Responsive columns | **Grid** with `auto-fit` |
| Dynamic content size | **Flexbox** |
| Fixed grid structure | **Grid** |

**Pro tip:** Use both! Grid for page structure, Flexbox for components.

```css
.page {
  display: grid; /* Overall layout */
  grid-template-areas: "header" "main" "footer";
}

.header {
  display: flex; /* Component layout */
  justify-content: space-between;
}
```

---

**Next Steps:**
1. Complete the [Flexbox Guide](./01-CSS-Flexbox-Complete-Guide.md) if you haven't
2. Build real layouts using both Grid and Flexbox
3. Explore [Every Layout](https://every-layout.dev/) for modern patterns
4. Practice with [Grid Garden](https://cssgridgarden.com/)

**Remember:** The best way to learn is by building! 🚀
