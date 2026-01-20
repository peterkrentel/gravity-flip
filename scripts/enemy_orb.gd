extends EnemyBase
class_name EnemyOrb

## Pulse Drone - slow, menacing, pulsing orb

var pulse_time: float = 0.0
var pulse_speed: float = 5.0
var base_scale: Vector2 = Vector2(1.0, 1.0)

func _ready():
	super._ready()
	max_health = 12  # VERY tanky
	health = max_health
	move_speed = 60.0  # Slower
	score_value = 20
	
	# Random death message
	var messages = [
		"The orb consumed you.",
		"Pulsed into oblivion.",
		"You stared too long.",
		"The void wins."
	]
	death_message = messages[randi() % messages.size()]

func custom_movement(delta):
	# Pulsing scale effect
	pulse_time += delta
	var pulse = 1.0 + sin(pulse_time * pulse_speed) * 0.2
	scale = base_scale * pulse

