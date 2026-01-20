extends Camera2D
class_name ShakeCamera

## Camera that shakes on impacts

var shake_amount: float = 0.0
var shake_decay: float = 5.0
var base_position: Vector2 = Vector2(540, 960)

@onready var game_state: GameState = get_node("/root/Main/GameState")

func _ready():
	position = base_position
	game_state.player_died.connect(_on_player_died)

func _process(delta):
	if shake_amount > 0:
		shake_amount = max(0, shake_amount - shake_decay * delta)
		
		# Random offset
		var offset = Vector2(
			randf_range(-shake_amount, shake_amount),
			randf_range(-shake_amount, shake_amount)
		)
		position = base_position + offset
	else:
		position = base_position

func shake(amount: float):
	shake_amount = amount

func _on_player_died():
	shake(30.0)  # BIG SHAKE on death

