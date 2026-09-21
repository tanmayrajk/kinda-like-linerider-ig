extends Node2D

@export var cusor_node: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cusor_node.global_position = get_global_mouse_position()
	#pass
