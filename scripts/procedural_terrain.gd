extends Node2D

var points := PackedVector2Array()

var bottom_noise := FastNoiseLite.new()
var top_noise := FastNoiseLite.new()

@onready var bottom_line: Line2D = $bottom_line
@onready var top_line: Line2D = $top_line

func generate_terrain(noise: FastNoiseLite):
	for x in range(0, 5000, 50):
		var y = noise.get_noise_1d(x) * 70.0
		
		points.append(Vector2(x, y))
	
	print(points)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bottom_noise.frequency = 0.01
	bottom_noise.seed = randi()
	top_noise.frequency = 0.01
	top_noise.seed = randi()
	generate_terrain(bottom_noise)
	for point in points:
		bottom_line.add_point(point)
	points.clear()
	generate_terrain(top_noise)
	for point in points:
		top_line.add_point(point)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir = Input.get_axis("move_right", "move_left")
	position.x += dir * 15
