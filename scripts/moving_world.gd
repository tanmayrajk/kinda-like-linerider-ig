extends Node2D

var speed := 300.0

@export var playerNode: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	print(position.distance_to(playerNode.position))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.x -= speed * delta
