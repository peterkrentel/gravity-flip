# CI/CD Documentation

## Overview

This project uses GitHub Actions for continuous integration and deployment. The workflows ensure code quality, security, and functionality.

## Workflows

### 1. Build and Test (`build-test.yml`)

**Triggers:**
- Push to `main` or `develop` branches
- Pull requests to `main` or `develop`
- Manual workflow dispatch

**Jobs:**

#### `build-and-test`
- Sets up Godot 4.3 in headless mode
- Imports the project
- Validates project export
- Runs GDUnit4 test suite (if available)
- Uploads test results and build artifacts

#### `lint-gdscript`
- Checks GDScript syntax for all `.gd` files
- Reports any syntax errors or warnings

**Status Badge:**
```markdown
![Build and Test](https://github.com/peterkrentel/gravity-flip/actions/workflows/build-test.yml/badge.svg)
```

---

### 2. Security Scan (`security-scan.yml`)

**Triggers:**
- Push to `main` or `develop` branches
- Pull requests to `main` or `develop`
- Weekly schedule (Mondays at 8:00 UTC)
- Manual workflow dispatch

**Jobs:**

#### `codeql`
- Runs GitHub CodeQL security analysis
- Scans for common security vulnerabilities
- Uses Python language configuration (closest to GDScript)

#### `dependency-review`
- Reviews dependencies in pull requests
- Fails on moderate or higher severity issues

#### `secret-scan`
- Uses TruffleHog to scan for leaked secrets
- Checks for API keys, tokens, passwords

#### `godot-security-check`
- Scans for sensitive data patterns in project files
- Validates `.gitignore` configuration
- Checks for hardcoded credentials

**Status Badge:**
```markdown
![Security Scan](https://github.com/peterkrentel/gravity-flip/actions/workflows/security-scan.yml/badge.svg)
```

---

## Dependabot

Configured in `.github/dependabot.yml` to:
- Update GitHub Actions dependencies weekly
- Auto-create PRs for security updates
- Labels: `dependencies`, `github-actions`

---

## Local Development

### Running Tests Locally

```bash
# Install GDUnit4 from Godot AssetLib first
# Then run from command line:
godot --headless --script res://addons/gdUnit4/bin/GdUnitCmdTool.gd --config=res://.gdunit_config.yml
```

### Manual Security Check

```bash
# Check for sensitive patterns
grep -r -E "(api[_-]?key|password|secret|token)" \
  --include="*.gd" --exclude-dir=".git" .

# Validate .gitignore
git check-ignore -v .godot/*.import
```

---

## Workflow Permissions

### Required GitHub Settings

For workflows to function properly:

1. **Actions Permissions** (Settings → Actions → General)
   - Allow all actions and reusable workflows

2. **Workflow Permissions** (Settings → Actions → General)
   - Read and write permissions
   - Allow GitHub Actions to create and approve pull requests

3. **Security Permissions** (Settings → Code security and analysis)
   - Enable Dependabot alerts
   - Enable Dependabot security updates
   - Enable CodeQL analysis

---

## Troubleshooting

### Tests Not Running

**Issue:** GDUnit4 tests are skipped
**Solution:** 
1. Open project in Godot Editor
2. Go to AssetLib tab
3. Search for "GDUnit4"
4. Download and install
5. Enable in Project Settings → Plugins
6. Commit the `addons/gdUnit4` directory

### Build Failing

**Issue:** Project export fails
**Solution:**
1. Check Godot version compatibility (requires 4.3+)
2. Ensure `project.godot` is valid
3. Check for scene/script errors locally first

### Security Scan Alerts

**Issue:** False positives in security scan
**Solution:**
1. Review the alert details
2. If legitimate, create an issue to fix
3. If false positive, document in code comments
4. Update security workflow patterns if needed

---

## Adding New Workflows

To add a new workflow:

1. Create `.github/workflows/your-workflow.yml`
2. Define triggers, jobs, and steps
3. Test with `workflow_dispatch` first
4. Document in this file
5. Add status badge to README

Example structure:
```yaml
name: Your Workflow
on:
  push:
    branches: [ main ]
jobs:
  your-job:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Your step
        run: echo "Hello"
```

---

## Best Practices

1. **Always test locally before pushing**
2. **Keep workflows fast** - Use caching when possible
3. **Fail fast** - Critical checks should run first
4. **Security first** - Never commit secrets or credentials
5. **Document changes** - Update this file when modifying workflows

---

## Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Godot CI/CD Guide](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_dedicated_servers.html)
- [GDUnit4 CI Documentation](https://github.com/MikeSchulze/gdUnit4)
- [CodeQL for Python](https://codeql.github.com/docs/codeql-language-guides/codeql-for-python/)
