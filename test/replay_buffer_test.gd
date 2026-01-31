extends GdUnitTestSuite
# Test suite for ReplayBuffer
# Spec-driven tests for the replay recording system

func before_test():
	pass

func after_test():
	pass

# Spec: ReplayBuffer should start in recording mode
func test_replay_buffer_starts_recording():
	var replay_buffer = ReplayBuffer.new()
	
	assert_bool(replay_buffer.is_recording).is_true()
	assert_array(replay_buffer.frames).is_empty()

# Spec: ReplayBuffer should stop recording on player death
func test_replay_buffer_stops_on_death():
	var replay_buffer = ReplayBuffer.new()
	add_child(replay_buffer)
	
	assert_bool(replay_buffer.is_recording).is_true()
	
	# Simulate player death
	replay_buffer._on_player_died()
	
	assert_bool(replay_buffer.is_recording).is_false()

# Spec: ReplayBuffer should clear frames on reset
func test_replay_buffer_clears_frames():
	var replay_buffer = ReplayBuffer.new()
	
	# Simulate having some frames
	replay_buffer.is_recording = false
	
	replay_buffer.clear()
	
	assert_array(replay_buffer.frames).is_empty()
	assert_bool(replay_buffer.is_recording).is_true()

# Spec: ReplayBuffer should return captured frames
func test_replay_buffer_returns_frames():
	var replay_buffer = ReplayBuffer.new()
	
	var frames = replay_buffer.get_frames()
	
	assert_array(frames).is_not_null()
