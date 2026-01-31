# Test Suite

This directory contains spec-driven tests for the Gravity Flip game.

## Testing Framework

We use **GDUnit4** for Godot 4.x testing. GDUnit4 is a behavior-driven development (BDD) test framework.

## Running Tests

### In Godot Editor

1. Install GDUnit4 plugin from AssetLib:
   - Go to **AssetLib** tab in Godot
   - Search for "GDUnit4"
   - Download and install
   - Enable in Project Settings → Plugins

2. Run tests:
   - Open **GDUnit4** panel (bottom of editor)
   - Click "Run All Tests" button
   - View results in the panel

### From Command Line (CI/CD)

```bash
# Using Godot headless mode
godot --headless --script res://addons/gdUnit4/bin/GdUnitCmdTool.gd --config=res://.gdunit_config.yml
```

### In GitHub Actions

Tests run automatically on:
- Every push to main branch
- Every pull request
- See `.github/workflows/build-test.yml` for details

## Writing Tests

Tests follow BDD/spec-driven development style:

```gdscript
extends GdUnitTestSuite

# Spec: Description of expected behavior
func test_specific_behavior():
    # Arrange: Set up test conditions
    var object = MyClass.new()
    
    # Act: Execute the action
    object.do_something()
    
    # Assert: Verify the outcome
    assert_bool(object.is_something()).is_true()
```

## Test Structure

- `game_state_test.gd` - Tests for game state management
- `replay_buffer_test.gd` - Tests for replay recording system
- More tests should be added as features are developed

## Spec-Driven Development Workflow

1. **Write the spec** - Define expected behavior as a test
2. **Run the test** - It should fail (red)
3. **Write the code** - Implement the feature
4. **Run the test** - It should pass (green)
5. **Refactor** - Clean up code while keeping tests green

## Test Coverage

Run with coverage reporting:
```bash
godot --headless --script res://addons/gdUnit4/bin/GdUnitCmdTool.gd --coverage
```

## Resources

- [GDUnit4 Documentation](https://github.com/MikeSchulze/gdUnit4)
- [GDUnit4 API Reference](https://mikeschulze.github.io/gdUnit4/)
- [Godot Testing Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/unit_testing.html)
