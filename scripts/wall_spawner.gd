extends Node2D

@onready var top_wall_anchor: Node2D = $anchors/top_wall
@onready var tom_wall_anchor: Node2D = $anchors/tom_wall

var terrain_x := 0.0

const WALL_WIDTH = 640.0
const POINT_SPACING = 5.0
const WALL_OVERLAP = 2.0

const WALL_HEIGHT = 77.0

var tom_noise := FastNoiseLite.new()
var top_noise := FastNoiseLite.new()

var tom_walls: Array[Node2D] = []
var top_walls: Array[Node2D] = []

func generate_wall():
	var tom_points := PackedVector2Array()
	var top_points := PackedVector2Array()
	
	for local_x in range(0, WALL_WIDTH + POINT_SPACING, POINT_SPACING):
		var tom_y := tom_noise.get_noise_1d(terrain_x + local_x) * WALL_HEIGHT
		tom_points.append(Vector2(local_x, tom_y))
		var top_y := top_noise.get_noise_1d(terrain_x + local_x) * WALL_HEIGHT
		top_points.append(Vector2(local_x, top_y))
	
	var tom_overlap_y := tom_noise.get_noise_1d(terrain_x + WALL_WIDTH + 2.0) * WALL_HEIGHT
	tom_points.append(Vector2(WALL_WIDTH + 2.0, tom_overlap_y))
	var top_overlap_y := top_noise.get_noise_1d(terrain_x + WALL_WIDTH + 2.0) * WALL_HEIGHT
	top_points.append(Vector2(WALL_WIDTH + 2.0, top_overlap_y))
	
	tom_points.append(Vector2(WALL_WIDTH + 2.0, 500))
	tom_points.append(Vector2(0, 500))
	top_points.append(Vector2(WALL_WIDTH + 2.0, -500))
	top_points.append(Vector2(0, -500))
	
	var tom_poly = Polygon2D.new()
	tom_poly.polygon = tom_points
	var tom_body := StaticBody2D.new()
	tom_body.collision_layer = 3
	var tom_collision := CollisionPolygon2D.new()
	tom_collision.polygon = tom_points
	tom_body.add_child(tom_collision)
	var tom_wall = Node2D.new()
	tom_wall.add_child(tom_poly)
	tom_wall.add_child(tom_body)
	add_child(tom_wall)
	var top_poly = Polygon2D.new()
	top_poly.polygon = top_points
	var top_body := StaticBody2D.new()
	top_body.collision_layer = 3
	var top_collision := CollisionPolygon2D.new()
	top_collision.polygon = top_points
	top_body.add_child(top_collision)
	var top_wall = Node2D.new()
	top_wall.add_child(top_poly)
	top_wall.add_child(top_body)
	add_child(top_wall)
	
	top_wall.global_position = top_wall_anchor.global_position
	tom_wall.global_position = tom_wall_anchor.global_position
	
	terrain_x += WALL_WIDTH
	
	top_walls.append(top_wall)
	tom_walls.append(tom_wall)
	
	return [top_wall, tom_wall]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tom_noise.frequency = 0.002
	tom_noise.seed = randi()
	
	top_noise.frequency = 0.002
	top_noise.seed = randi()
	
	generate_wall()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for wall in top_walls:
		wall.position.x -= 200 * delta
	
	for wall in tom_walls:
		wall.position.x -= 200 * delta
		
	var last_top_wall: Node2D = top_walls[-1]
	var last_tom_wall: Node2D = tom_walls[-1]
	
	if last_tom_wall.global_position.x + WALL_WIDTH <= tom_wall_anchor.global_position.x or last_top_wall.global_position.x + WALL_WIDTH <= top_wall_anchor.global_position.x:
		generate_wall()
