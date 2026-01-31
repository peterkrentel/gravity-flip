# GDUnit4 Installation Guide

## Quick Installation (Recommended)

### From Godot Editor (AssetLib)

1. **Open the project in Godot 4.3+**
   ```bash
   godot project.godot
   ```

2. **Access AssetLib**
   - Click the **AssetLib** tab at the top of the editor

3. **Search and Install**
   - Search for: `GDUnit4`
   - Click on the **GDUnit4** result
   - Click **Download**
   - Click **Install**
   - Select the destination (keep default: `res://addons/gdUnit4`)
   - Click **Install**

4. **Enable the Plugin**
   - Go to: **Project → Project Settings → Plugins**
   - Find **GDUnit4** in the list
   - Check the **Enable** checkbox
   - Restart the editor when prompted

5. **Verify Installation**
   - Look for **GDUnit4** panel at the bottom of the editor
   - If visible, installation is successful! ✅

---

## Alternative: Manual Installation

If AssetLib is unavailable:

1. **Download GDUnit4**
   ```bash
   git clone https://github.com/MikeSchulze/gdUnit4.git temp_gdunit
   ```

2. **Copy to addons folder**
   ```bash
   cp -r temp_gdunit/addons/gdUnit4 addons/
   rm -rf temp_gdunit
   ```

3. **Enable in Godot**
   - Open project in Godot
   - Project → Project Settings → Plugins
   - Enable GDUnit4

---

## Running Tests

### In Godot Editor

1. **Open GDUnit4 Panel**
   - Located at bottom of editor (next to Output, Debugger)

2. **Run Tests**
   - Click **"Run All Tests"** button (▶️)
   - Or right-click a test file → "Run Tests"

3. **View Results**
   - Green ✅ = Passed
   - Red ❌ = Failed
   - Click on tests to see details

### From Command Line

```bash
# Run all tests
godot --headless --script res://addons/gdUnit4/bin/GdUnitCmdTool.gd \
  --config=res://.gdunit_config.yml

# Run specific test file
godot --headless --script res://addons/gdUnit4/bin/GdUnitCmdTool.gd \
  -s test/game_state_test.gd

# Run with coverage report
godot --headless --script res://addons/gdUnit4/bin/GdUnitCmdTool.gd \
  --coverage
```

### In GitHub Actions (CI)

Tests run automatically on every push and pull request.
See `.github/workflows/build-test.yml` for configuration.

---

## Troubleshooting

### "GDUnit4 not found in AssetLib"

**Solution 1:** Check internet connection and try again

**Solution 2:** Use manual installation method above

**Solution 3:** Download from GitHub directly:
```bash
cd addons
git clone https://github.com/MikeSchulze/gdUnit4.git gdUnit4
```

### "Plugin not appearing in Project Settings"

1. Close and reopen Godot
2. Verify `addons/gdUnit4/plugin.cfg` exists
3. Check Godot version is 4.3 or higher

### "Tests not running / No output"

1. Ensure tests extend `GdUnitTestSuite`
2. Check test function names start with `test_`
3. Look for errors in Output panel
4. Verify `.gdunit_config.yml` exists

### "Scene dependencies errors in tests"

If tests need scene nodes:
```gdscript
func before_test():
    # Add to scene tree for tests that need it
    add_child(my_node)

func after_test():
    # Clean up
    remove_child(my_node)
    my_node.queue_free()
```

---

## Next Steps

After installation:

1. ✅ Run existing tests: `test/game_state_test.gd`
2. ✅ Read the test documentation: `test/README.md`
3. ✅ Write your first test for a new feature
4. ✅ Follow spec-driven development workflow

---

## Resources

- [GDUnit4 GitHub](https://github.com/MikeSchulze/gdUnit4)
- [GDUnit4 Documentation](https://mikeschulze.github.io/gdUnit4/)
- [GDUnit4 API Reference](https://mikeschulze.github.io/gdUnit4/api/)
- [Writing Tests Guide](https://mikeschulze.github.io/gdUnit4/tutorials/)

---

**Need help? Open an issue or discussion on GitHub!**
