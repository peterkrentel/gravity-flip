extends Area2D
class_name EnemyBase

## Base class for all enemies - they take multiple hits and erode

@export var max_health: int = 5
@export var move_speed: float = 100.0
@export var death_message: String = "You died."
@export var shoot_interval: float = 2.0  # Seconds between shots
@export var bullet_scene: PackedScene
@export var score_value: int = 10  # Points for killing this enemy

var health: int = 5
var is_alive: bool = true
var shoot_timer: float = 0.0
var death_line_y: float = 1800.0  # If enemy reaches this, player dies

@onready var game_state: GameState = get_node("/root/Main/GameState")

signal enemy_died(death_message: String)
signal enemy_reached_bottom

func _ready():
	add_to_group("enemy")
	health = max_health
	area_entered.connect(_on_area_entered)
	shoot_timer = randf_range(0.5, shoot_interval)  # Random initial delay

	# Load bullet scene if not set
	if not bullet_scene:
		bullet_scene = load("res://scenes/enemy_bullet.tscn")

func _process(delta):
	if not is_alive:
		return
	
	# Move down
	position.y += move_speed * delta
	
	# Custom movement (override in subclasses)
	custom_movement(delta)
	
	# Remove if off-screen
	if position.y > 2000:
		queue_free()

func custom_movement(delta):
	# Override this in subclasses for unique movement
	pass

func take_damage():
	health -= 1

	# Visual feedback - flash and scale down
	modulate = Color(1, 0.5, 0.5, 1)
	scale = Vector2(1.0, 1.0) * (0.7 + (float(health) / max_health) * 0.3)

	# Fade back to normal
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 0.1)

	# Screen shake
	var camera = get_node_or_null("/root/Main/Camera2D")
	if camera and camera.has_method("shake"):
		camera.shake(3.0)

	print("Enemy hit! Health: ", health, "/", max_health)

	if health <= 0:
		die()

func die():
	if not is_alive:
		return

	is_alive = false
	enemy_died.emit(death_message)

	# Add score
	if game_state:
		game_state.add_score(score_value)

	# Spawn explosion
	spawn_explosion()

	print("Enemy destroyed! Message: ", death_message)

	queue_free()

func spawn_explosion():
	var explosion_script = load("res://scripts/explosion.gd")
	var explosion = Node2D.new()
	explosion.set_script(explosion_script)
	explosion.position = position
	get_parent().add_child(explosion)

func _on_area_entered(area):
	# Hit player
	if area is PlayerShip:
		area.die()

