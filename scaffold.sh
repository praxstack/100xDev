#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'EOF'
100xDev Scaffold Helper

Usage:
  ./scaffold.sh [class|assignment|project|study] [ai-ml|devops|devops-webdev|web3] "Name"

Optional:
  Set `SCAFFOLD_DATE=YYYY-MM-DD` to backdate an entry.

Examples:
  ./scaffold.sh class ai-ml "Neural Networks & AI!"
  ./scaffold.sh assignment devops "Contest Platform Backend"
  ./scaffold.sh project devops "CI/CD Pipeline"
  ./scaffold.sh study web3 "Zero Knowledge Proofs"
EOF
}

TYPE="${1:-}"
COURSE="${2:-}"
shift $(( $# >= 2 ? 2 : $# ))
NAME="${*:-}"

if [[ -z "$TYPE" || -z "$COURSE" || -z "$NAME" ]]; then
  usage
  exit 1
fi

# Resolve the absolute path of the script directory so you can run it from anywhere.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/_Templates"

slugify() {
  local input="$1"
  local slug
  slug="$(printf '%s' "$input" \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//; s/-{2,}/-/g')"
  if [[ -z "$slug" ]]; then
    slug="untitled"
  fi
  printf '%s' "$slug"
}

escape_sed_replacement() {
  # Escape replacement chars for sed using '|' delimiter.
  printf '%s' "$1" | sed -e 's/[\\&|]/\\&/g'
}

render_template() {
  local src="$1"
  local dest="$2"
  local topic="$3"
  local date="$4"
  local course_label="$5"

  local topic_esc date_esc course_esc month_esc
  topic_esc="$(escape_sed_replacement "$topic")"
  date_esc="$(escape_sed_replacement "$date")"
  course_esc="$(escape_sed_replacement "$course_label")"
  month_esc="$(escape_sed_replacement "${date:0:7}")"

  sed \
    -e "s|{{Topic}}|$topic_esc|g" \
    -e "s|{{Name}}|$topic_esc|g" \
    -e "s|{{Date}}|$date_esc|g" \
    -e "s|{{YYYY-MM-DD}}|$date_esc|g" \
    -e "s|{{Month}}|$month_esc|g" \
    -e "s|{{Course}}|$course_esc|g" \
    -e "s|{{Bootcamp}}|$course_esc|g" \
    "$src" > "$dest"
}

# Convert course name to folder + label
case "$COURSE" in
  ai-ml|aiml)
    DIR="100xdev-ai-ml"
    COURSE_LABEL="AI & ML"
    ;;
  devops|devops-webdev)
    DIR="100xdev-devops-webdev"
    COURSE_LABEL="DevOps + WebDev"
    ;;
  web3)
    DIR="100xdev-web3"
    COURSE_LABEL="Web3"
    ;;
  *)
    echo "Error: Unknown course '$COURSE'." >&2
    usage
    exit 1
    ;;
esac

DATE="${SCAFFOLD_DATE:-$(date +"%Y-%m-%d")}"
if [[ ! "$DATE" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
  echo "Error: Invalid SCAFFOLD_DATE '$DATE' (expected YYYY-MM-DD)." >&2
  exit 1
fi
MONTH="${DATE:0:7}"
SLUG="$(slugify "$NAME")"

BASE_PATH="$SCRIPT_DIR/$DIR/$MONTH"

case $TYPE in
  class)
    TARGET="$BASE_PATH/01-Classes/$DATE-$SLUG"
    if [[ -e "$TARGET" ]]; then
      echo "Error: Already exists: $TARGET" >&2
      exit 2
    fi
    mkdir -p "$TARGET/sandbox"
    if [[ -f "$TEMPLATE_DIR/class-notes-template.md" ]]; then
      render_template "$TEMPLATE_DIR/class-notes-template.md" "$TARGET/notes.md" "$NAME" "$DATE" "$COURSE_LABEL"
    else
      touch "$TARGET/notes.md"
    fi
    touch "$TARGET/transcript.txt" "$TARGET/doubts.md"
    echo "✅ Created Class: $TARGET"
    ;;
  assignment)
    TARGET="$BASE_PATH/02-Assignments/A-$SLUG"
    if [[ -e "$TARGET" ]]; then
      echo "Error: Already exists: $TARGET" >&2
      exit 2
    fi
    mkdir -p "$TARGET/sandbox"
    if [[ -f "$TEMPLATE_DIR/assignment-template.md" ]]; then
      render_template "$TEMPLATE_DIR/assignment-template.md" "$TARGET/README.md" "$NAME" "$DATE" "$COURSE_LABEL"
    else
      touch "$TARGET/README.md"
    fi
    echo "✅ Created Assignment: $TARGET"
    ;;
  project)
    TARGET="$BASE_PATH/03-Projects/P-$SLUG"
    if [[ -e "$TARGET" ]]; then
      echo "Error: Already exists: $TARGET" >&2
      exit 2
    fi
    mkdir -p "$TARGET/sandbox"
    if [[ -f "$TEMPLATE_DIR/project-template.md" ]]; then
      render_template "$TEMPLATE_DIR/project-template.md" "$TARGET/README.md" "$NAME" "$DATE" "$COURSE_LABEL"
    else
      touch "$TARGET/README.md"
    fi
    echo "✅ Created Project: $TARGET"
    ;;
  study)
    TARGET="$BASE_PATH/04-Self-Study/$DATE-$SLUG"
    if [[ -e "$TARGET" ]]; then
      echo "Error: Already exists: $TARGET" >&2
      exit 2
    fi
    mkdir -p "$TARGET/playground"
    if [[ -f "$TEMPLATE_DIR/self-study-template.md" ]]; then
      render_template "$TEMPLATE_DIR/self-study-template.md" "$TARGET/notes.md" "$NAME" "$DATE" "$COURSE_LABEL"
    else
      touch "$TARGET/notes.md"
    fi
    echo "✅ Created Self-Study: $TARGET"
    ;;
  *)
    echo "Error: Unknown type '$TYPE'. Options: class, assignment, project, study" >&2
    usage
    exit 1
    ;;
esac
