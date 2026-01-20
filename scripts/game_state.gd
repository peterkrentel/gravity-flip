extends Node
class_name GameState

## Central state controller - nothing else controls game state
## This is the single source of truth

enum State {
	PLAYING,
	DYING,
	REPLAYING,
	SHARE
}

var current_state: State = State.PLAYING
var current_level: int = 1
var time_in_level: float = 0.0
var level_duration: float = 5.0  # 5 seconds per level
var survival_time: float = 0.0
var lives: int = 3
var score: int = 0
var max_lives: int = 3

signal state_changed(new_state: State)
signal game_started
signal player_died
signal replay_started
signal replay_finished
signal level_up(new_level: int)
signal score_changed(new_score: int)
signal lives_changed(new_lives: int)

func _ready():
	print("GameState _ready() called")
	start_game()

func _process(delta):
	if current_state == State.PLAYING:
		survival_time += delta
		time_in_level += delta

		# Level up every 5 seconds
		if time_in_level >= level_duration:
			time_in_level = 0.0
			current_level += 1
			level_up.emit(current_level)
			print("LEVEL UP! Now level ", current_level)

func start_game():
	print("GameState.start_game() - setting state to PLAYING")
	current_state = State.PLAYING
	current_level = 1
	survival_time = 0.0
	time_in_level = 0.0
	lives = max_lives
	score = 0
	state_changed.emit(State.PLAYING)
	game_started.emit()
	lives_changed.emit(lives)
	score_changed.emit(score)
	print("GameState is now PLAYING: ", is_playing())

func trigger_death():
	if current_state != State.PLAYING:
		return

	lives -= 1
	lives_changed.emit(lives)
	print("Player died! Lives remaining: ", lives)

	if lives <= 0:
		# Game over
		current_state = State.DYING
		state_changed.emit(State.DYING)
		player_died.emit()

		# Short delay before replay
		await get_tree().create_timer(0.5).timeout
		start_replay()
	else:
		# Respawn - just emit signal but keep playing
		player_died.emit()
		await get_tree().create_timer(1.0).timeout
		# Player respawns automatically

func add_score(points: int):
	score += points
	score_changed.emit(score)
	print("Score: ", score)

func start_replay():
	current_state = State.REPLAYING
	state_changed.emit(State.REPLAYING)
	replay_started.emit()

func finish_replay():
	current_state = State.SHARE
	state_changed.emit(State.SHARE)
	replay_finished.emit()

func restart_game():
	get_tree().reload_current_scene()

func is_playing() -> bool:
	return current_state == State.PLAYING

func is_replaying() -> bool:
	return current_state == State.REPLAYING

