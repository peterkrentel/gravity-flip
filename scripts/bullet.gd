extends Area2D
class_name Bullet

## Player bullet - flies up, kills enemies

@export var speed: float = 1200.0
var direction: Vector2 = Vector2(0, -1)  # Set by player ship

func _ready():
	add_to_group("player_bullet")
	area_entered.connect(_on_area_entered)

func _process(delta):
	position += direction * speed * delta

	# Remove if off-screen
	if position.y < -100 or position.x < -100 or position.x > 1200:
		queue_free()

func _on_area_entered(area):
	# Hit an enemy
	if area.is_in_group("enemy"):
		if area.has_method("take_damage"):
			area.take_damage()
		queue_free()

