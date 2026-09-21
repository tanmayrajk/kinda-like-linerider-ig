extends Node2D

var drawing := false
var current_line: Line2D

@export var speed := 67
@export var cam: Camera2D

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			drawing = event.pressed
			
			if drawing:
				current_line = Line2D.new()
				current_line.width = 10.0
				current_line.begin_cap_mode = Line2D.LINE_CAP_ROUND
				current_line.end_cap_mode = Line2D.LINE_CAP_ROUND
				current_line.joint_mode = Line2D.LINE_JOINT_ROUND
				
				var body := StaticBody2D.new()
				body.collision_layer = 2
				#body.sync_to_physics = true
				current_line.add_child(body)
				
				add_child(current_line)
				
				var point := current_line.to_local(get_global_mouse_position())
				current_line.add_point(point)

func _process(delta: float) -> void:
	position.x -= speed * delta
	
	if not drawing:
		return
	
	$draw_sound.play()
	
	cam.shake(0.67, 0.01)
	
	var new_point := current_line.to_local(get_global_mouse_position())
	var old_point := current_line.points[-1]
	
	if (new_point.distance_to(old_point) < 5.0):
		return
	
	current_line.add_point(new_point)
	
#	add colliders and stuff
	
	var collision := CollisionShape2D.new()
	var capsule := CapsuleShape2D.new()
	
	capsule.radius = current_line.width / 2
	capsule.height = old_point.distance_to(new_point) + current_line.width
	
	collision.shape = capsule
	collision.position = (old_point + new_point) / 2
	collision.rotation = old_point.angle_to_point(new_point) - PI / 2.0
	
	current_line.get_child(0).add_child(collision)
