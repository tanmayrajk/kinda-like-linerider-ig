extends Node2D

var top_wall_line: Line2D
var bottom_wall_line: Line2D

@onready var moving_world: Node2D = $"../moving_world"
@export var playerNode: CharacterBody2D

func _ready() -> void:
	top_wall_line = Line2D.new()
	bottom_wall_line = Line2D.new()
	
	top_wall_line.width = 10.0
	top_wall_line.begin_cap_mode = Line2D.LINE_CAP_ROUND
	top_wall_line.end_cap_mode = Line2D.LINE_CAP_ROUND
	top_wall_line.joint_mode = Line2D.LINE_JOINT_ROUND
	
	bottom_wall_line.width = 10.0
	bottom_wall_line.begin_cap_mode = Line2D.LINE_CAP_ROUND
	bottom_wall_line.end_cap_mode = Line2D.LINE_CAP_ROUND
	bottom_wall_line.joint_mode = Line2D.LINE_JOINT_ROUND
	
	moving_world.add_child(bottom_wall_line)
	moving_world.add_child(top_wall_line)

var x := 0.0

func _process(delta: float) -> void:
	x += 2.0
	var rand_y = randf_range(-167, -100)
	var pos = top_wall_line.to_local(playerNode.global_position)
	top_wall_line.add_point(Vector2(x, rand_y))
	
	#print(playerNode.position.x)
	
	#bottom_wall_line.add_point(Vector2(0, 500))
	#bottom_wall_line.add_point(Vector2(500, 500))
