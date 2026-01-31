extends GdUnitTestSuite
# Test suite for GameState
# This is a spec-driven test following BDD style

func before_test():
	# Setup before each test
	pass

func after_test():
	# Cleanup after each test
	pass

# Spec: Game should start in PLAYING state
func test_game_starts_in_playing_state():
	var game_state = GameState.new()
	game_state.start_game()
	
	assert_bool(game_state.is_playing()).is_true()
	assert_int(game_state.current_state).is_equal(GameState.State.PLAYING)

# Spec: Game should initialize with correct default values
func test_game_initializes_with_defaults():
	var game_state = GameState.new()
	game_state.start_game()
	
	assert_int(game_state.current_level).is_equal(1)
	assert_float(game_state.survival_time).is_equal(0.0)
	assert_int(game_state.lives).is_equal(3)
	assert_int(game_state.score).is_equal(0)

# Spec: Player death should reduce lives
func test_player_death_reduces_lives():
	var game_state = GameState.new()
	game_state.start_game()
	
	var initial_lives = game_state.lives
	game_state.trigger_death()
	
	assert_int(game_state.lives).is_equal(initial_lives - 1)

# Spec: Game should transition to DYING state when lives reach zero
func test_game_transitions_to_dying_when_no_lives():
	var game_state = GameState.new()
	game_state.start_game()
	
	# Use up all lives
	for _i in range(game_state.max_lives):
		game_state.trigger_death()
		await get_tree().create_timer(0.1).timeout
	
	assert_bool(game_state.is_playing()).is_false()
	assert_int(game_state.current_state).is_equal(GameState.State.DYING)

# Spec: Adding score should emit score_changed signal
func test_adding_score_emits_signal():
	var game_state = GameState.new()
	game_state.start_game()
	
	monitor_signals(game_state)
	game_state.add_score(100)
	
	assert_signal(game_state).is_emitted("score_changed")
	assert_int(game_state.score).is_equal(100)

# Spec: State changes should emit state_changed signal
func test_state_change_emits_signal():
	var game_state = GameState.new()
	
	monitor_signals(game_state)
	game_state.start_game()
	
	assert_signal(game_state).is_emitted("state_changed")
	assert_signal(game_state).is_emitted("game_started")
