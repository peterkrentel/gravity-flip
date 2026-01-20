extends CanvasLayer
class_name HUD

## Displays Lives, Score, Level

@onready var game_state: GameState = get_node("/root/Main/GameState")
@onready var lives_label: Label = $LivesLabel
@onready var score_label: Label = $ScoreLabel
@onready var level_label: Label = $LevelLabel

func _ready():
	# Connect to game state signals
	game_state.lives_changed.connect(_on_lives_changed)
	game_state.score_changed.connect(_on_score_changed)
	game_state.level_up.connect(_on_level_up)
	
	# Initial display
	update_display()

func update_display():
	lives_label.text = "LIVES: " + str(game_state.lives)
	score_label.text = "SCORE: " + str(game_state.score)
	level_label.text = "LEVEL: " + str(game_state.current_level)

func _on_lives_changed(new_lives: int):
	lives_label.text = "LIVES: " + str(new_lives)

func _on_score_changed(new_score: int):
	score_label.text = "SCORE: " + str(new_score)

func _on_level_up(new_level: int):
	level_label.text = "LEVEL: " + str(new_level)
	
	# Flash the level label
	var tween = create_tween()
	tween.tween_property(level_label, "modulate", Color(1, 1, 0, 1), 0.2)
	tween.tween_property(level_label, "modulate", Color(1, 1, 1, 1), 0.2)

