extends EnemyBase
class_name EnemyToaster

## Spike Drone - bounces in sine wave, green spiky alien

var bounce_time: float = 0.0
var bounce_speed: float = 4.0
var bounce_amount: float = 150.0
var start_x: float = 0.0

func _ready():
	super._ready()
	max_health = 10  # Tankier
	health = max_health
	move_speed = 100.0
	start_x = position.x
	score_value = 15

	# Random death message
	var messages = [
		"Spike drone got you.",
		"Impaled by alien tech.",
		"The spiky one wins.",
		"You lasted longer than most."
	]
	death_message = messages[randi() % messages.size()]

func custom_movement(delta):
	# Sine wave bounce
	bounce_time += delta
	position.x = start_x + sin(bounce_time * bounce_speed) * bounce_amount

