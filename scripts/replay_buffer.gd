extends Node
class_name ReplayBuffer

## THE MOST IMPORTANT CLASS
## Circular buffer that always has the last ~3 seconds ready
## This is deterministic playback, NOT screen recording

class ReplayFrame:
	var position: Vector2
	var rotation: float
	var velocity: Vector2
	var gravity_direction: float
	var timestamp: float
	
	func _init(pos: Vector2, rot: float, vel: Vector2, grav: float, time: float):
		position = pos
		rotation = rot
		velocity = vel
		gravity_direction = grav
		timestamp = time

const BUFFER_DURATION: float = 3.5  # seconds
const CAPTURE_INTERVAL: float = 0.016  # ~60fps

var frames: Array[ReplayFrame] = []
var is_recording: bool = true
var recording_start_time: float = 0.0

@onready var game_state: GameState = get_node("/root/Main/GameState")

func _ready():
	recording_start_time = Time.get_ticks_msec() / 1000.0
	game_state.player_died.connect(_on_player_died)

func _process(_delta):
	# TODO: Re-implement for shooter
	return

func _on_player_died():
	# Freeze the buffer
	is_recording = false
	print("Replay buffer frozen. Frames captured: ", frames.size())

func get_frames() -> Array[ReplayFrame]:
	return frames

func clear():
	frames.clear()
	is_recording = true
	recording_start_time = Time.get_ticks_msec() / 1000.0
