## Description
<!-- Provide a brief description of your changes -->

## Type of Change
<!-- Check the relevant option(s) -->
- [ ] 🐛 Bug fix (non-breaking change which fixes an issue)
- [ ] ✨ New feature (non-breaking change which adds functionality)
- [ ] 💥 Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] 📝 Documentation update
- [ ] 🧪 Test update
- [ ] ♻️ Refactoring (no functional changes)

## Spec-Driven Development Checklist
<!-- Confirm you followed the spec-driven workflow -->
- [ ] I wrote tests **before** implementing the feature/fix
- [ ] All new and existing tests pass locally
- [ ] Tests cover the changes made
- [ ] Test names clearly describe the expected behavior

## Testing
<!-- Describe the tests you added/modified -->

**Tests added:**
- `test_...`

**How to verify:**
```bash
# Run tests
godot --headless --script res://addons/gdUnit4/bin/GdUnitCmdTool.gd
```

## Security Checklist
<!-- Ensure your changes don't introduce security issues -->
- [ ] No sensitive data (API keys, passwords, tokens) committed
- [ ] No hardcoded credentials
- [ ] Security scan passed (will be verified by CI)
- [ ] Dependencies checked for vulnerabilities (if applicable)

## Documentation
<!-- Check if documentation needs updating -->
- [ ] Code is self-documenting with clear variable/function names
- [ ] Complex logic has explanatory comments
- [ ] README.md updated (if needed)
- [ ] API documentation updated (if applicable)

## CI/CD Status
<!-- CI checks will run automatically -->
- [ ] Build and test workflow passes
- [ ] Security scan workflow passes
- [ ] No merge conflicts

## Additional Context
<!-- Add any other context, screenshots, or information about the PR -->

## Related Issues
<!-- Link any related issues -->
Closes #
Related to #

---

**Reviewer Notes:**
<!-- For reviewers: Focus on test coverage, spec alignment, and code clarity -->
