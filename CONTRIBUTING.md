# Contributing to Gravity Flip

Thank you for your interest in contributing! This project follows spec-driven development practices.

## Development Philosophy

> **"Write the test first, then make it pass."**

We use behavior-driven development (BDD) with GDUnit4 to ensure quality and maintainability.

## Getting Started

### Prerequisites

1. **Godot 4.3+** - [Download here](https://godotengine.org/download/)
2. **GDUnit4** - Install from AssetLib in Godot Editor
3. **Git** - For version control

### Setup

```bash
# Clone the repository
git clone https://github.com/peterkrentel/gravity-flip.git
cd gravity-flip

# Open in Godot Editor
godot --editor .

# Install GDUnit4 from AssetLib
# (AssetLib tab → Search "GDUnit4" → Download → Enable)
```

## Spec-Driven Development Workflow

### 1. Write the Spec (Test First)

Before writing any code, define the expected behavior:

```gdscript
# test/my_feature_test.gd
extends GdUnitTestSuite

# Spec: Feature should do X when Y happens
func test_feature_does_x_when_y():
    # Arrange
    var my_object = MyClass.new()
    
    # Act
    my_object.do_something()
    
    # Assert
    assert_bool(my_object.is_correct()).is_true()
```

### 2. Run the Test (Should Fail)

```bash
# In Godot Editor: Open GDUnit4 panel → Run All Tests
# Should see RED (test fails)
```

### 3. Implement the Feature

Write the minimal code to make the test pass:

```gdscript
# scripts/my_class.gd
extends Node
class_name MyClass

func do_something():
    # Implementation here
    pass

func is_correct() -> bool:
    return true
```

### 4. Run the Test (Should Pass)

```bash
# Run tests again
# Should see GREEN (test passes)
```

### 5. Refactor

Clean up the code while keeping tests green.

## Pull Request Process

### Before Creating a PR

1. ✅ Write tests for your changes
2. ✅ Ensure all tests pass locally
3. ✅ Run security checks (see CI/CD docs)
4. ✅ Update documentation if needed
5. ✅ Follow the coding style

### Creating the PR

1. Create a feature branch:
   ```bash
   git checkout -b feature/my-feature
   ```

2. Commit with clear messages:
   ```bash
   git commit -m "feat: add gravity flip sound effect"
   ```

3. Push and create PR:
   ```bash
   git push origin feature/my-feature
   ```

4. Fill out the PR template
5. Wait for CI checks to pass
6. Request review

### PR Checklist

- [ ] Tests written and passing
- [ ] Code follows existing style
- [ ] Documentation updated
- [ ] No sensitive data committed
- [ ] CI checks passing
- [ ] Changes are minimal and focused

## Coding Standards

### GDScript Style

Follow [Godot's GDScript style guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html):

```gdscript
# Good
func calculate_damage(base_damage: int) -> int:
    return base_damage * 2

# Bad
func CalculateDamage(baseDamage):
    return baseDamage*2
```

### Test Style

- **Descriptive names**: `test_player_dies_when_hit_by_obstacle`
- **One assertion per test** (when possible)
- **Use BDD format**: Arrange, Act, Assert
- **Add comments**: Explain the spec being tested

### File Organization

```
gravity-flip/
├── scripts/           # Game logic
│   ├── game_state.gd
│   └── player.gd
├── test/             # Tests mirror scripts/
│   ├── game_state_test.gd
│   └── player_test.gd
├── scenes/           # Godot scenes
└── .github/          # CI/CD workflows
```

## Testing Guidelines

### What to Test

✅ **Do test:**
- Game state transitions
- Player input handling
- Collision detection logic
- Score calculation
- Replay buffer recording

❌ **Don't test:**
- Godot engine internals
- Third-party plugins
- Visual appearance (unless critical)

### Test Coverage

Aim for **80%+ coverage** on core gameplay systems:
- Game state management: 100%
- Player mechanics: 90%+
- Replay system: 100%
- UI logic: 70%+

## Security Guidelines

### Never Commit

- API keys or tokens
- Passwords or credentials
- Private keys
- Personal data

### Always

- Use `.gitignore` properly
- Review diffs before committing
- Run security scan locally
- Use environment variables for secrets

## Getting Help

- **Questions?** Open a [Discussion](https://github.com/peterkrentel/gravity-flip/discussions)
- **Bug found?** Create an [Issue](https://github.com/peterkrentel/gravity-flip/issues)
- **Feature idea?** Start with a Discussion first

## Code of Conduct

- Be respectful and constructive
- Focus on the code, not the person
- Assume good intentions
- Help others learn and grow

## License

By contributing, you agree that your contributions will be licensed under the Apache 2.0 License.

---

## Quick Reference

```bash
# Run all tests
godot --headless --script res://addons/gdUnit4/bin/GdUnitCmdTool.gd

# Run specific test file
godot --headless --script res://addons/gdUnit4/bin/GdUnitCmdTool.gd -s test/game_state_test.gd

# Check syntax
godot --headless --check-only --script scripts/my_script.gd

# Export for testing
godot --headless --export-debug "Linux/X11" build/test.x86_64
```

---

**Thank you for contributing! 🎮**
