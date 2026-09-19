extends TileMapLayer
const atlas_coords = Vector2i(0,0)
var is_drawing = false
var click_offset = Vector2.ZERO
var last_cell_x = 0
func _process(delta):
	var cam = get_viewport().get_camera_2d()
	
	if Input.is_action_just_pressed("click"):
		is_drawing = true
		click_offset = get_global_mouse_position() - cam.global_position
		last_cell_x = local_to_map(to_local(cam.global_position + click_offset)).x
	if Input.is_action_just_released("click"):
		is_drawing = false
		
	if not is_drawing:
		return
		
	var cell_fill = local_to_map(to_local(cam.global_position + click_offset))
	for x in range(last_cell_x,cell_fill.x + 1):
		set_cell(Vector2i(x, cell_fill.x + 1), 0 , atlas_coords)
		
	last_cell_x = cell_fill.x
		
