# 🚀 Quick Reference - Spec-Driven Development

## Test-Driven Development Cycle

```
1. 📝 Write Test (RED)
   └─> Test fails ❌

2. 💻 Write Code (GREEN)
   └─> Test passes ✅

3. 🔧 Refactor (REFACTOR)
   └─> Tests still pass ✅
```

---

## Common Test Patterns

### Basic Test Structure

```gdscript
extends GdUnitTestSuite

# Spec: Description of what should happen
func test_specific_behavior():
    # Arrange: Set up test data
    var object = MyClass.new()
    
    # Act: Perform the action
    var result = object.do_something()
    
    # Assert: Check the result
    assert_bool(result).is_true()
```

### Test Lifecycle Hooks

```gdscript
func before():
    # Runs once before all tests in suite
    pass

func before_test():
    # Runs before each individual test
    pass

func after_test():
    # Runs after each individual test
    pass

func after():
    # Runs once after all tests in suite
    pass
```

---

## GDUnit4 Assertions

### Boolean Assertions
```gdscript
assert_bool(value).is_true()
assert_bool(value).is_false()
```

### Integer/Float Assertions
```gdscript
assert_int(value).is_equal(10)
assert_int(value).is_not_equal(5)
assert_int(value).is_greater(5)
assert_int(value).is_less(20)
assert_float(value).is_equal(1.5)
assert_float(value).is_equal_approx(1.49, 0.1)
```

### String Assertions
```gdscript
assert_str(value).is_equal("hello")
assert_str(value).contains("world")
assert_str(value).starts_with("hello")
assert_str(value).ends_with("world")
assert_str(value).is_empty()
```

### Array Assertions
```gdscript
assert_array(arr).is_empty()
assert_array(arr).is_not_empty()
assert_array(arr).contains([1, 2, 3])
assert_array(arr).has_size(5)
```

### Object Assertions
```gdscript
assert_object(obj).is_null()
assert_object(obj).is_not_null()
assert_object(obj).is_instanceof(MyClass)
```

### Signal Assertions
```gdscript
# Monitor signals
monitor_signals(my_node)

# Assert signal was emitted
assert_signal(my_node).is_emitted("my_signal")
assert_signal(my_node).is_emitted("my_signal", [arg1, arg2])

# Assert signal was NOT emitted
assert_signal(my_node).is_not_emitted("my_signal")
```

---

## Async Testing (Awaiting)

```gdscript
func test_async_operation():
    var obj = MyClass.new()
    
    # Start async operation
    obj.start_async()
    
    # Wait for it to complete
    await get_tree().create_timer(0.5).timeout
    
    # Assert the result
    assert_bool(obj.is_done()).is_true()
```

---

## Mocking and Stubbing

### Spy on Methods
```gdscript
func test_method_called():
    var spy = spy(MyClass.new())
    
    spy.my_method("arg1")
    
    verify(spy).my_method("arg1")
```

### Mock Return Values
```gdscript
func test_mocked_return():
    var mock = mock(MyClass)
    
    do_return("mocked_value").on(mock).my_method()
    
    var result = mock.my_method()
    assert_str(result).is_equal("mocked_value")
```

---

## Running Tests

### Godot Editor
```
1. Open GDUnit4 panel (bottom)
2. Click ▶️ "Run All Tests"
3. View results
```

### Command Line
```bash
# All tests
godot --headless --script res://addons/gdUnit4/bin/GdUnitCmdTool.gd

# Specific file
godot --headless --script res://addons/gdUnit4/bin/GdUnitCmdTool.gd -s test/game_state_test.gd

# With config
godot --headless --script res://addons/gdUnit4/bin/GdUnitCmdTool.gd --config=res://.gdunit_config.yml
```

---

## Workflow Commands

### Git Workflow
```bash
# Create feature branch
git checkout -b feature/my-feature

# Run tests locally
godot --headless --script res://addons/gdUnit4/bin/GdUnitCmdTool.gd

# Commit with conventional commits
git commit -m "feat: add new feature"
git commit -m "test: add tests for feature"
git commit -m "fix: resolve bug"

# Push and create PR
git push origin feature/my-feature
```

### Check Status
```bash
# View changed files
git status

# View diff
git diff

# Check if tests pass
godot --headless --script res://addons/gdUnit4/bin/GdUnitCmdTool.gd
```

---

## Common Test Scenarios

### Testing State Changes
```gdscript
func test_state_changes():
    var game_state = GameState.new()
    assert_int(game_state.current_state).is_equal(GameState.State.INITIAL)
    
    game_state.start()
    assert_int(game_state.current_state).is_equal(GameState.State.PLAYING)
```

### Testing Signals
```gdscript
func test_signal_emission():
    var emitter = SignalEmitter.new()
    monitor_signals(emitter)
    
    emitter.do_action()
    
    assert_signal(emitter).is_emitted("action_done")
```

### Testing with Scene Tree
```gdscript
func test_node_in_tree():
    var node = MyNode.new()
    add_child(node)  # Add to test scene tree
    
    assert_bool(node.is_inside_tree()).is_true()
    
    remove_child(node)
    node.queue_free()
```

### Testing Collections
```gdscript
func test_array_operations():
    var list = [1, 2, 3, 4, 5]
    
    assert_array(list).has_size(5)
    assert_array(list).contains([2, 3])
    assert_int(list[0]).is_equal(1)
```

---

## CI/CD Status

Check workflow status:
```bash
# View workflows
gh workflow list

# View runs
gh run list

# View specific run
gh run view <run-id>
```

---

## Tips & Best Practices

✅ **Do:**
- Write tests before code (TDD)
- Keep tests simple and focused
- Use descriptive test names
- Test one thing per test
- Clean up in `after_test()`

❌ **Don't:**
- Test implementation details
- Write tests that depend on other tests
- Use sleep() - use proper async/await
- Ignore failing tests
- Test third-party code

---

## Getting Help

- 📖 [Full Documentation](test/README.md)
- 🔧 [GDUnit4 Docs](https://mikeschulze.github.io/gdUnit4/)
- 🤝 [Contributing Guide](CONTRIBUTING.md)
- 💬 [Open Discussion](https://github.com/peterkrentel/gravity-flip/discussions)

---

**Happy Testing! 🎮✨**
