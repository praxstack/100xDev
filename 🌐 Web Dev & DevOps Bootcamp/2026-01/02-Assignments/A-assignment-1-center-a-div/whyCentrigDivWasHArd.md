Good. You know flexbox exists — but "it works" isn't understanding. Let's drill down.

---

## 🎯 The Shape: Why Centering Was a CSS Nightmare

**Historical context (the "why" you're missing):**

```
┌─────────────────────────────────────────────────────────────────┐
│                     THE BROWSER'S DEFAULT MODEL                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  HTML flows like a DOCUMENT:                                    │
│                                                                 │
│  ┌─────────────────────────────────────┐                        │
│  │ Paragraph 1                         │ ← Block element        │
│  └─────────────────────────────────────┘   (takes full width)   │
│  ┌─────────────────────────────────────┐                        │
│  │ Paragraph 2                         │ ← Stacks VERTICALLY    │
│  └─────────────────────────────────────┘   by default           │
│  ┌────────┐┌────────┐                                           │
│  │ Inline ││ text   │ ← Inline flows HORIZONTALLY               │
│  └────────┘└────────┘                                           │
│                                                                 │
│  Content flows DOWN the page, never "knowing" how tall          │
│  the viewport is. Height is INFINITE (scroll forever).          │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

**Why horizontal centering was always easy:**

```css
.box {
  width: 300px;
  margin: 0 auto; /* Works! */
}
```

**Why this works:**

- Parent has a KNOWN width (viewport or container)
- `auto` on left + right margins = browser splits remaining space equally
- The math: `(parent_width - child_width) / 2` for each side

```
Parent: |◀─────────────── 1000px ────────────────▶|
Child:  |     ◀─── 300px ───▶     |
        |     ↑                   |
        | 350px auto    350px auto|
```

---

**Why vertical centering was HARD (before flexbox):**

```css
.box {
  height: 200px;
  margin: auto 0; /* DOESN'T WORK! WHY? */
}
```

**The problem:**

- Vertical `auto` margin doesn't work because the parent's height is often **UNKNOWN**
- A `<body>` or `<div>` doesn't have implicit height — it grows to fit content
- Without a defined height context, `auto` has nothing to calculate against

```
Parent height: ???  (Could be 100px, could be 10000px, depends on content)
Child height:  200px
Vertical auto: "Auto of WHAT?" — browser gives up, sets to 0
```

---

## 🔥 Enter Flexbox: The "Click" Moment

Flexbox changed the game because it creates a **new layout context** where:

1. **The parent becomes a "flex container"** — it controls its children's positioning
2. **Both axes are now controllable** — main axis AND cross axis
3. **`justify-content` and `align-items`** distribute space regardless of width/height

```css
.parent {
  display: flex;
  justify-content: center; /* Main axis (horizontal by default) */
  align-items: center; /* Cross axis (vertical by default) */
  height: 100vh; /* ← CRITICAL: Parent must have height! */
}
```

**Visualizing the flex container:**

```
┌───────────────────────────────────────────────────────────────┐
│                     FLEX CONTAINER (100vh)                    │
│                                                               │
│    Main Axis (horizontal) →                                   │
│    ─────────────────────────────────────────────────          │
│                                                               │
│  C │                    ┌───────────┐                         │
│  r │                    │   CHILD   │                         │
│  o │                    │           │                         │
│  s │ ← center →         │  (auto)   │          ← center →     │
│  s │                    │           │                         │
│    │                    └───────────┘                         │
│  A │                                                          │
│  x │                         ↑                                │
│  i │                      center                              │
│  s │                         ↓                                │
│    ▼                                                          │
└───────────────────────────────────────────────────────────────┘
```

---

## ❓ Verification Check

Before we write any code, tell me:

1. **Why does `height: 100vh` on the parent matter?** What happens if you remove it?

2. **What's the difference between `justify-content` and `align-items`?** Don't just say "horizontal vs vertical" — tell me which AXIS each one controls and why.

3. **If I rotate the flex direction with `flex-direction: column`, what happens to `justify-content` and `align-items`?**

Get these right and we'll build the ElevenLabs page. Get them wrong and we drill deeper.
