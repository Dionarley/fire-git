#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FAILED=0
PASSED=0

log_pass() {
  echo "✅ PASS: $1"
  PASSED=$((PASSED + 1))
}

log_fail() {
  echo "❌ FAIL: $1"
  FAILED=$((FAILED + 1))
}

test_syntax() {
  echo "Testing syntax..."
  if bash -n "$SCRIPT_DIR/../src/firegit.sh"; then
    log_pass "Syntax check"
  else
    log_fail "Syntax check"
  fi
}

test_shebang() {
  echo "Testing shebang..."
  local shebang
  shebang=$(head -1 "$SCRIPT_DIR/../src/firegit.sh")
  if [ "$shebang" = "#!/usr/bin/env bash" ]; then
    log_pass "Shebang is portable"
  else
    log_fail "Shebang should be #!/usr/bin/env bash"
  fi
}

test_set_e() {
  echo "Testing error handling..."
  if grep -q "^set -e$" "$SCRIPT_DIR/../src/firegit.sh"; then
    log_pass "set -e enabled"
  else
    log_fail "set -e should be enabled"
  fi
}

test_variable_quoting() {
  echo "Testing variable quoting..."
  if grep -q 'git config --global user.name "$GIT_NAME"' "$SCRIPT_DIR/../src/lib/tui.sh" && \
     grep -q 'git config --global user.email "$GIT_EMAIL"' "$SCRIPT_DIR/../src/lib/tui.sh"; then
    log_pass "Variables are properly quoted"
  else
    log_fail "Variables should be quoted"
  fi
}

test_package_managers() {
  echo "Testing package manager detection..."
  local pm_count=0
  for pm in apt apt-get dnf yum pacman zypper microdnf eopkg apk swupd; do
    if grep -q "$pm" "$SCRIPT_DIR/../src/firegit.sh" || grep -q "$pm" "$SCRIPT_DIR/../src/lib/detect.sh"; then
      pm_count=$((pm_count + 1))
    fi
  done
  if [ "$pm_count" -ge 8 ]; then
    log_pass "Package managers detected: $pm_count found"
  else
    log_fail "Missing package managers (found $pm_count, expected 8+)"
  fi
}

test_help_flag() {
  echo "Testing help flag..."
  if grep -q -- "--help" "$SCRIPT_DIR/../src/firegit.sh" && \
     grep -q -- "-h" "$SCRIPT_DIR/../src/firegit.sh"; then
    log_pass "Help flags (-h, --help) present"
  else
    log_fail "Help flags missing"
  fi
}

test_check_flag() {
  echo "Testing check flag..."
  if grep -q -- "--check" "$SCRIPT_DIR/../src/firegit.sh"; then
    log_pass "Check flag (--check) present"
  else
    log_fail "Check flag missing"
  fi
}

test_reset_flag() {
  echo "Testing reset flag..."
  if grep -q -- "--reset" "$SCRIPT_DIR/../src/firegit.sh"; then
    log_pass "Reset flag (--reset) present"
  else
    log_fail "Reset flag missing"
  fi
}

test_email_validation() {
  echo "Testing email validation..."
  if grep -q "validate_email" "$SCRIPT_DIR/../src/lib/validate.sh"; then
    log_pass "Email validation function present"
  else
    log_fail "Email validation missing"
  fi
}

test_os_detection() {
  echo "Testing OS detection..."
  if grep -q "detect_os" "$SCRIPT_DIR/../src/lib/detect.sh" && \
     grep -q "/etc/os-release" "$SCRIPT_DIR/../src/lib/detect.sh"; then
    log_pass "OS detection present"
  else
    log_fail "OS detection missing"
  fi
}

test_environment_detection() {
  echo "Testing environment detection..."
  if grep -q "detect_environment" "$SCRIPT_DIR/../src/lib/detect.sh" && \
     grep -q "FLATPAK" "$SCRIPT_DIR/../src/lib/detect.sh"; then
    log_pass "Environment detection present"
  else
    log_fail "Environment detection missing"
  fi
}

test_tutorial_flag() {
  echo "Testing tutorial flag..."
  if grep -q -- "--tutorial" "$SCRIPT_DIR/../src/firegit.sh"; then
    log_pass "Tutorial flag (--tutorial) present"
  else
    log_fail "Tutorial flag missing"
  fi
}

test_additional_settings() {
  echo "Testing additional settings..."
  if grep -q "configure_additional_settings" "$SCRIPT_DIR/../src/lib/validate.sh"; then
    log_pass "Additional settings present"
  else
    log_fail "Additional settings missing"
  fi
}

test_existing_config_check() {
  echo "Testing existing config check..."
  if grep -q "check_existing" "$SCRIPT_DIR/../src/lib/validate.sh"; then
    log_pass "Existing config check present"
  else
    log_fail "Existing config check missing"
  fi
}

test_tui_menu() {
  echo "Testing TUI menu..."
  if grep -q "run_tui_menu" "$SCRIPT_DIR/../src/lib/tui.sh"; then
    log_pass "TUI menu present"
  else
    log_fail "TUI menu missing"
  fi
}

test_clear_screen() {
  echo "Testing clear screen support..."
  if grep -q "clear" "$SCRIPT_DIR/../src/lib/tui.sh"; then
    log_pass "Clear screen present"
  else
    log_fail "Clear screen missing"
  fi
}

test_flatpak_manifest() {
  echo "Testing Flatpak manifest..."
  if [ -f "$SCRIPT_DIR/../flatpak/com.github.dionarley.fire-git.yaml" ]; then
    if grep -q "org.freedesktop.Platform" "$SCRIPT_DIR/../flatpak/com.github.dionarley.fire-git.yaml" && \
       grep -q "filesystem=home" "$SCRIPT_DIR/../flatpak/com.github.dionarley.fire-git.yaml"; then
      log_pass "Flatpak manifest is valid"
    else
      log_fail "Flatpak manifest missing required fields"
    fi
  else
    log_fail "Flatpak manifest not found"
  fi
}

test_no_hardcoded_secrets() {
  echo "Testing for hardcoded secrets..."
  if grep -iE "(password|token|secret|key)" "$SCRIPT_DIR/../src/firegit.sh" | grep -v "^#" | grep -qv "git"; then
    log_fail "Possible hardcoded secret found"
  else
    log_pass "No obvious hardcoded secrets"
  fi
}

test_readme_exists() {
  echo "Testing documentation..."
  if [ -f "$SCRIPT_DIR/../README.md" ]; then
    log_pass "README exists"
  else
    log_fail "README missing"
  fi
}

echo "========================================"
echo "Running fire-git tests"
echo "========================================"

test_syntax
test_shebang
test_set_e
test_variable_quoting
test_package_managers
test_help_flag
test_check_flag
test_reset_flag
test_email_validation
test_os_detection
test_environment_detection
test_tutorial_flag
test_additional_settings
test_existing_config_check
test_tui_menu
test_clear_screen
test_flatpak_manifest
test_no_hardcoded_secrets
test_readme_exists

echo "========================================"
echo "Results: $PASSED passed, $FAILED failed"
echo "========================================"

if [ "$FAILED" -gt 0 ]; then
  exit 1
fi
exit 0