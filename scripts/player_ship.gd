extends Area2D
class_name PlayerShip

## Space shooter player - moves left/right, auto-fires

@export var move_speed: float = 400.0
@export var base_fire_rate: float = 0.3  # Auto-fire rate
@export var base_bullets: int = 1  # Start with 1 bullet
@export var bullet_spacing: float = 30.0  # Space between parallel bullets
@export var bullet_scene: PackedScene

var fire_rate: float = 0.3  # Auto-fire rate
var fire_timer: float = 0.0

var is_alive: bool = true
var fire_timer: float = 0.0
var screen_width: float = 1080.0
var screen_height: float = 1920.0
var bullets_per_shot: int = 1  # Scales with level
var touch_target: Vector2 = Vector2.ZERO
var has_touch_target: bool = false

@onready var game_state: GameState = get_node("/root/Main/GameState")

signal died

func _ready():
	is_alive = true
	var viewport_size = get_viewport_rect().size
	screen_width = viewport_size.x
	screen_height = viewport_size.y
	bullets_per_shot = base_bullets
	fire_rate = base_fire_rate
	print("PlayerShip ready! Position: ", position)

	# Load bullet scene if not set
	if not bullet_scene:
		bullet_scene = load("res://scenes/bullet.tscn")

	# Connect collision
	area_entered.connect(_on_area_entered)

	# Connect to level up and death
	game_state.level_up.connect(_on_level_up)
	game_state.player_died.connect(_on_player_died_signal)

func set_touch_target(target: Vector2):
	touch_target = target
	has_touch_target = true

func try_shoot():
	# Manual shoot (for touch button)
	if is_alive:
		fire_bullet()

func _on_level_up(new_level: int):
	bullets_per_shot = new_level
	# Fire rate gets faster as you level up
	# Level 1 = 0.3s, Level 2 = 0.25s, Level 5 = 0.15s, Level 10 = 0.1s
	fire_rate = max(0.1, base_fire_rate - (new_level - 1) * 0.02)
	print("Level ", new_level, ": ", bullets_per_shot, " parallel bullets, fire rate: ", fire_rate, "s")

func _on_player_died_signal():
	# Respawn if we have lives left
	if game_state.lives > 0:
		await get_tree().create_timer(1.0).timeout
		respawn()

func respawn():
	is_alive = true
	position = Vector2(540, 1700)
	modulate = Color(1, 1, 1, 1)
	print("Player respawned! Lives remaining: ", game_state.lives)

func _process(delta):
	if not is_alive or not game_state.is_playing():
		return

	# Auto-fire
	fire_timer -= delta
	if fire_timer <= 0:
		fire_bullet()
		fire_timer = fire_rate

func _physics_process(delta):
	if not is_alive:
		return

	# Movement input
	var target_position = Vector2.ZERO
	var use_keyboard = false

	# Check for keyboard input first (WASD / Arrow keys)
	var keyboard_input = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		keyboard_input.x -= 1
		use_keyboard = true
	if Input.is_action_pressed("ui_right"):
		keyboard_input.x += 1
		use_keyboard = true
	if Input.is_action_pressed("ui_up"):
		keyboard_input.y -= 1
		use_keyboard = true
	if Input.is_action_pressed("ui_down"):
		keyboard_input.y += 1
		use_keyboard = true

	if use_keyboard:
		# Keyboard: direct movement
		if keyboard_input.length() > 0:
			keyboard_input = keyboard_input.normalized()
		position += keyboard_input * move_speed * delta
	else:
		# Mouse/Touch: follow cursor smoothly
		if has_touch_target:
			target_position = touch_target
		else:
			target_position = get_viewport().get_mouse_position()

		# Smooth lerp to target
		position = position.lerp(target_position, delta * 8.0)

	# Clamp to screen bounds (can move up/down in bottom area)
	position.x = clamp(position.x, 50, screen_width - 50)
	position.y = clamp(position.y, screen_height * 0.7, screen_height - 100)

func fire_bullet():
	if not bullet_scene:
		return

	# PARALLEL BULLETS - side by side
	# Calculate starting X offset to center the spread
	var total_width = (bullets_per_shot - 1) * bullet_spacing
	var start_x = -total_width / 2.0

	for i in range(bullets_per_shot):
		var bullet = bullet_scene.instantiate()
		get_parent().add_child(bullet)

		# Position bullets in parallel (evenly spaced horizontally)
		var x_offset = start_x + (i * bullet_spacing)
		bullet.position = position + Vector2(x_offset, -40)

		# All bullets go straight up (no spread)
		bullet.rotation_degrees = 0
		bullet.direction = Vector2(0, -1)

func die():
	if not is_alive:
		return

	is_alive = false
	died.emit()
	game_state.trigger_death()
	print("Player died!")

	# Visual feedback
	modulate = Color(1, 0.3, 0.3, 1)

func _on_area_entered(area):
	# Hit by enemy or enemy bullet
	if area.is_in_group("enemy") or area.is_in_group("enemy_bullet"):
		die()
