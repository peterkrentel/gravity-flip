extends CanvasLayer
class_name TouchControls

## On-screen controls for mobile/touch

@onready var shoot_button: Button = $ShootButton
@onready var player_ship: PlayerShip = get_node("/root/Main/PlayerShip")

var is_touching: bool = false
var touch_position: Vector2 = Vector2.ZERO

signal shoot_pressed

func _ready():
	# Connect shoot button
	shoot_button.pressed.connect(_on_shoot_pressed)
	
	# Show/hide based on platform
	if OS.has_feature("mobile") or DisplayServer.is_touchscreen_available():
		visible = true
	else:
		visible = false  # Hide on desktop (use keyboard)

func _input(event):
	# Handle touch movement (anywhere on screen except button)
	if event is InputEventScreenTouch:
		if event.pressed:
			is_touching = true
			touch_position = event.position
		else:
			is_touching = false
	
	elif event is InputEventScreenDrag:
		is_touching = true
		touch_position = event.position

func _process(_delta):
	# Send touch position to player
	if is_touching and player_ship:
		player_ship.set_touch_target(touch_position)

func _on_shoot_pressed():
	shoot_pressed.emit()
	if player_ship:
		player_ship.try_shoot()

