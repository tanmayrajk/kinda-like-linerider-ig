extends Node2D

@export var enemy_scene: PackedScene
@onready var timer: Timer = $Timer
@onready var moving_world: Node2D = $"../moving_world"

func spawn_enemy():
	var spawners = $spawn_points.get_children()
	var rand_spawner: Node2D = spawners.pick_random()
	var enemy: CharacterBody2D = enemy_scene.instantiate()
	moving_world.add_child(enemy)
	enemy.global_position = rand_spawner.global_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	spawn_enemy()
	
