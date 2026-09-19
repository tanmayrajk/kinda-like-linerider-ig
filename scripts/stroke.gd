extends Node2D

var max_points = 300 #max lenght at a time before deletion

var thickness = 8.0

var free_distance = 1500.0 # to let line delete withut camera
const pencil_path = "res://pencil_stroke.png" #

@onready var line = $Line2D
@onready var body = $StaticBody2D

func _ready() -> void:
	line.texture = load(pencil_path) 
	line.texture_mode = Line2D.LINE_TEXTURE_TILE
	line.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	line.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR

func add_point_at(world_position: Vector2) -> void:
	var count = line.get_point_count()
	if count > 0: 
		make_piece(line.get_point_position(count - 1), world_position)
	line.add_point(world_position)
	if line.get_point_count() > max_points:
		line.remove_point(0)
		var old_piece = body.get_child(0)
		body.remove_child(old_piece)
		old_piece.queue_free()

func make_piece(start_point: Vector2, end_point: Vector2) -> void:
	var piece = CollisionPolygon2D.new()
	var drop = Vector2(0, thickness)
	piece.polygon = PackedVector2Array([start_point, end_point, end_point + drop, start_point + drop])
	body.add_child(piece)

func _process(_delta: float) -> void:
	var count = line.get_point_count()
	if count == 0:
		return
	var camera = get_viewport().get_camera_2d()
	if camera.global_position.x - line.get_point_position(count - 1).x > free_distance:
		queue_free()
