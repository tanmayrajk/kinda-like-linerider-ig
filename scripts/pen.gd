extends TileMapLayer
const atlas_coords = Vector2i(0,0)
var is_drawing = false
var click_offset = Vector2.ZERO
var last_cell_x = 0
var last_spawn_x = 0

var spawn_distance = 32
var click_world_y = 0 

func _process(delta):
	var cam = get_viewport().get_camera_2d()
	
	if Input.is_action_just_pressed("click"):
		is_drawing = true
		click_offset = get_global_mouse_position() - cam.global_position
		last_cell_x = local_to_map(to_local(cam.global_position + click_offset)).x
		last_spawn_x = get_global_mouse_position().x
		
		click_world_y = get_global_mouse_position().y
		set_cell(local_to_map(to_local(get_global_mouse_position())),0,atlas_coords)
	if Input.is_action_just_released("click"):
		is_drawing = false
		
		
	if not is_drawing:
		return 
		
	var cell_fill = local_to_map(to_local(cam.global_position + click_offset))
	var paint_x = cam.global_position.x + click_offset.x
	while paint_x - last_spawn_x >= spawn_distance:
		
		last_spawn_x +=  spawn_distance
		var spawn_cell = local_to_map(to_local(Vector2(last_spawn_x, click_world_y)))
		set_cell(spawn_cell,0,atlas_coords)
		
	
	last_cell_x = cell_fill.x
	
		
