extends CharacterBody2D
class_name Runner

## The player character - auto-runs forward, flips gravity on tap
## Does NOT know about replay, UI, ads, or subscriptions

@export var speed: float = 400.0
@export var gravity_strength: float = 980.0

var gravity_direction: float = 1.0  # 1 = down, -1 = up
var is_alive: bool = true

@onready var game_state: GameState = get_node("/root/Main/GameState")
@onready var sprite: Sprite2D = $Sprite2D
@onready var camera: Camera2D = get_node("/root/Main/Camera2D")

signal died
signal gravity_flipped(direction: float)

func _ready():
	is_alive = true
	gravity_direction = 1.0
	print("Runner ready! Position: ", position)
	print("GameState node: ", game_state)
	if game_state:
		print("GameState.is_playing(): ", game_state.is_playing())

func _input(event):
	if not is_alive:
		print("Input blocked - player is dead")
		return

	if not game_state or not game_state.is_playing():
		print("Input blocked - game_state: ", game_state, " is_playing: ", game_state.is_playing() if game_state else "N/A")
		return

	# Tap/click to flip gravity
	if event is InputEventScreenTouch and event.pressed:
		print("Touch detected!")
		flip_gravity()
	elif event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Click detected!")
		flip_gravity()

func _physics_process(delta):
	if not is_alive:
		return

	# Auto-forward motion
	velocity.x = speed

	# Apply gravity
	velocity.y += gravity_strength * gravity_direction * delta

	# Move and check collisions
	var was_on_surface = is_on_floor() or is_on_ceiling()
	move_and_slide()

	# Camera follows player horizontally
	if camera:
		camera.position.x = position.x

	# Rotate sprite based on gravity
	sprite.rotation = lerp_angle(sprite.rotation, PI if gravity_direction < 0 else 0, delta * 10.0)

	# Check for collisions with obstacles
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		# If we hit something tagged as an obstacle, die
		if collider and collider.is_in_group("obstacle"):
			print("Hit obstacle!")
			die()
			break

func flip_gravity():
	gravity_direction *= -1
	gravity_flipped.emit(gravity_direction)

	# Visual feedback (squash and stretch)
	var tween = create_tween()
	tween.tween_property(sprite, "scale", Vector2(1.2, 0.8), 0.1)
	tween.tween_property(sprite, "scale", Vector2(1.0, 1.0), 0.1)

func die():
	if not is_alive:
		return
	
	is_alive = false
	died.emit()
	game_state.trigger_death()
	
	# Freeze in place
	velocity = Vector2.ZERO

