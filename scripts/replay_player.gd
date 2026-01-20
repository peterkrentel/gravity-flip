extends Node2D
class_name EnemySpawner

## Spawns funny enemies - chickens, toasters, etc.

@export var base_spawn_interval: float = 2.0  # Start slow
@export var spawn_width: float = 900.0

var spawn_interval: float = 2.0
@export var difficulty_ramp: float = 0.95  # Multiply spawn interval each second

var spawn_timer: float = 0.0
var is_spawning: bool = true
var enemy_scenes: Array[PackedScene] = []

@onready var game_state: GameState = get_node("/root/Main/GameState")

func _ready():
	game_state.player_died.connect(_on_player_died)
	game_state.level_up.connect(_on_level_up)
	spawn_timer = 1.0  # Initial delay
	spawn_interval = base_spawn_interval

	# Load enemy scenes - ALIEN DRONES
	enemy_scenes.append(load("res://scenes/enemy_chicken.tscn"))  # Wobbler
	enemy_scenes.append(load("res://scenes/enemy_toaster.tscn"))  # Spike
	enemy_scenes.append(load("res://scenes/enemy_orb.tscn"))      # Pulse Orb

	print("EnemySpawner ready! Will spawn every ", spawn_interval, " seconds")

func _on_level_up(new_level: int):
	# Spawn faster as level increases (1:1 with bullets)
	# Level 1 = 2.0s, Level 2 = 1.0s, Level 3 = 0.66s, etc.
	spawn_interval = base_spawn_interval / new_level
	print("Spawn interval now: ", spawn_interval, " (Level ", new_level, ")")

func _process(delta):
	if not is_spawning or not game_state.is_playing():
		return

	spawn_timer -= delta

	if spawn_timer <= 0:
		spawn_obstacle()
		spawn_timer = spawn_interval

func spawn_obstacle():
	if enemy_scenes.is_empty():
		return

	# Pick random enemy type
	var enemy_scene = enemy_scenes[randi() % enemy_scenes.size()]
	var enemy = enemy_scene.instantiate()
	add_child(enemy)

	# Spawn at random X position at top of screen
	enemy.position.x = randf_range(100, spawn_width)
	enemy.position.y = -50

	print("Spawned enemy at ", enemy.position)

func _on_player_died():
	is_spawning = false

