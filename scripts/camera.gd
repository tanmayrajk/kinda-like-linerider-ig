extends Camera2D

var shake_strength := 0.0
var shake_fade := 5.0

func shake(strength: float, duration: float) -> void:
	shake_strength = strength
	shake_fade = strength / duration

func _process(delta: float) -> void:
	if shake_strength > 0:
		shake_strength = move_toward(shake_strength, 0.0, shake_fade * delta)
		
		var shake_offset = Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
		
		offset = Vector2(56, 0) + shake_offset
	else:
		offset = Vector2(56, 0)
