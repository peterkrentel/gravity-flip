extends Node2D
class_name ObstacleSpawner

## Spawns obstacles for the player to avoid

@export var obstacle_scene: PackedScene
@export var spawn_interval: float = 2.0
@export var min_spawn_interval: float = 0.8
@export var difficulty_increase_rate: float = 0.95  # Multiply interval by this each spawn

var spawn_timer: float = 0.0
var current_interval: float = 2.0

@onready var runner: Runner = get_node("/root/Main/Runner")
@onready var game_state: GameState = get_node("/root/Main/GameState")

func _ready():
	current_interval = spawn_interval
	print("ObstacleSpawner ready!")

func _process(delta):
	if not game_state or not game_state.is_playing():
		return
	
	spawn_timer += delta
	
	if spawn_timer >= current_interval:
		spawn_obstacle()
		spawn_timer = 0.0
		# Gradually increase difficulty
		current_interval = max(min_spawn_interval, current_interval * difficulty_increase_rate)

func spawn_obstacle():
	if not obstacle_scene or not runner:
		return
	
	var obstacle = obstacle_scene.instantiate()
	
	# Spawn ahead of the player
	var spawn_x = runner.position.x + 1200
	
	# Randomly choose floor or ceiling
	var on_ceiling = randf() > 0.5
	var spawn_y = -50 if on_ceiling else 1970
	
	obstacle.position = Vector2(spawn_x, spawn_y)
	
	# Add to world
	get_parent().add_child(obstacle)
	
	print("Spawned obstacle at ", obstacle.position)

