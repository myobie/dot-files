claude() {
  if [ -x "$HOME/.claude/local/claude" ]; then
    "$HOME/.claude/local/claude" "$@"
  else
    command claude "$@"
  fi
}
