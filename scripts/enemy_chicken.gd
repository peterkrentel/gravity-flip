extends EnemyBase
class_name EnemyChicken

## Wobbler Drone - wobbles side to side, ugly red alien

var wobble_time: float = 0.0
var wobble_speed: float = 3.0
var wobble_amount: float = 100.0

func _ready():
	super._ready()
	max_health = 8  # Takes more hits
	health = max_health
	move_speed = 80.0
	score_value = 10

	# Random death message
	var messages = [
		"Wobbler drone eliminated you.",
		"You got wobbled.",
		"Killed by the ugly one.",
		"That drone was barely trying."
	]
	death_message = messages[randi() % messages.size()]

func custom_movement(delta):
	# Wobble side to side
	wobble_time += delta
	var offset_x = sin(wobble_time * wobble_speed) * wobble_amount * delta
	position.x += offset_x

