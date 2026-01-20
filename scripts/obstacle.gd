extends Area2D
class_name Obstacle

## Simple obstacle that scrolls and kills player on contact

@export var scroll_speed: float = 400.0

var is_moving: bool = true

@onready var game_state: GameState = get_node("/root/Main/GameState")

func _ready():
	body_entered.connect(_on_body_entered)
	game_state.player_died.connect(_on_player_died)

func _process(delta):
	if not is_moving or not game_state.is_playing():
		return
	
	# Scroll left
	position.x -= scroll_speed * delta
	
	# Remove if off-screen
	if position.x < -200:
		queue_free()

func _on_body_entered(body):
	if body is Runner:
		body.die()

func _on_player_died():
	is_moving = false

