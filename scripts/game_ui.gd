extends CanvasLayer
class_name GameUI

## Simple UI - timer and death overlay

@onready var timer_label: Label = $HUD/TimerLabel
@onready var death_overlay: Control = $DeathOverlay
@onready var time_survived_label: Label = $DeathOverlay/TimeSurvivedLabel
@onready var restart_button: Button = $DeathOverlay/RestartButton

@onready var game_state: GameState = get_node("/root/Main/GameState")

var survival_time: float = 0.0
var is_counting: bool = true

func _ready():
	death_overlay.visible = false
	restart_button.pressed.connect(_on_restart_pressed)
	game_state.player_died.connect(_on_player_died)
	game_state.game_started.connect(_on_game_started)

func _process(delta):
	if is_counting and game_state.is_playing():
		survival_time += delta
		timer_label.text = "%.2f s" % survival_time

func _on_player_died():
	is_counting = false
	
	# Show death overlay after replay
	await game_state.replay_finished
	death_overlay.visible = true
	time_survived_label.text = "You survived %.2f seconds" % survival_time

func _on_game_started():
	survival_time = 0.0
	is_counting = true
	death_overlay.visible = false

func _on_restart_pressed():
	game_state.restart_game()

