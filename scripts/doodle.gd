extends Node2D
@export var stroke_scene: PackedScene
var spawn_distance = 8
var max_slope_angle = 40
var follow_smoothness =0.35
var current_strokes = null
var is_drawing = false
var click_offset_x = 0
var last_spawn_x = 0
var pen_y = 0 
func _process(delta) :
	
	var camera = get_viewport().get_camera_2d()
	var mouse_position = get_global_mouse_position()
	
	
	if Input.is_action_just_pressed("click"):
		is_drawing = true
		click_offset_x = mouse_position.x - camera.global_position.x
		last_spawn_x = mouse_position.x
		pen_y = mouse_position.y
		current_strokes = stroke_scene.instantiate()
		get_parent().add_child(current_strokes)
		current_strokes.add_point_at(mouse_position)
	if Input.is_action_just_released("click"):
		is_drawing = false
		
	if not is_drawing:
		return
		
	var paint_x = camera.global_position.x + click_offset_x
	while paint_x - last_spawn_x >= spawn_distance:
		last_spawn_x += spawn_distance
		var max_step = tan(deg_to_rad(max_slope_angle))*spawn_distance
		var wanted_step = (mouse_position.y - pen_y) * follow_smoothness
		pen_y += clampf(wanted_step, -max_step, max_step)
		current_strokes.add_point_at(Vector2(last_spawn_x,pen_y))
		
	
