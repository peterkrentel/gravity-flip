extends Node2D
class_name Explosion

## Explosion effect - particles that fade out

var lifetime: float = 0.5
var time_alive: float = 0.0
var particles: Array[ColorRect] = []

func _ready():
	# Create explosion particles
	var particle_count = randi_range(15, 25)
	
	for i in range(particle_count):
		var particle = ColorRect.new()
		var size = randf_range(5, 15)
		particle.size = Vector2(size, size)
		particle.position = Vector2(randf_range(-20, 20), randf_range(-20, 20))
		
		# Random explosion color
		var colors = [
			Color(1, 0.3, 0.1, 1),   # Orange
			Color(1, 0.6, 0.1, 1),   # Yellow-orange
			Color(1, 0.9, 0.2, 1),   # Yellow
			Color(0.9, 0.2, 0.2, 1), # Red
		]
		particle.color = colors[randi() % colors.size()]
		
		add_child(particle)
		particles.append(particle)
		
		# Give each particle a velocity
		particle.set_meta("velocity", Vector2(randf_range(-200, 200), randf_range(-200, 200)))

func _process(delta):
	time_alive += delta
	
	# Move and fade particles
	for particle in particles:
		var velocity = particle.get_meta("velocity") as Vector2
		particle.position += velocity * delta
		
		# Fade out
		var alpha = 1.0 - (time_alive / lifetime)
		particle.modulate.a = alpha
	
	# Remove when done
	if time_alive >= lifetime:
		queue_free()

