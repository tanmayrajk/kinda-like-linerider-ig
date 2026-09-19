extends CharacterBody2D

const SPEED = 200.0
const ACCELERATION = 1500.0
const FRICTION = 2000.0
const JUMP_VELOCITY = -350.0
const JUMP_CUT = 0.5
var run = true
var gravity = 980
var fall_margin = 100

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		
		

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= JUMP_CUT

	var direction := 1.0 
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		
	$AnimatedSprite2D.play("idle")
		
	if direction != 0:
		$AnimatedSprite2D.flip_h = direction < 0

	move_and_slide()
	
	var camera = get_viewport().get_camera_2d()
	var half_window = get_viewport_rect().size / 2 / camera.zoom
	var is_outside = global_position.y > camera.global_position.y + half_window.y + fall_margin or global_position.x < camera.global_position.x - half_window.x - fall_margin
	if is_outside:
		get_tree().reload_current_scene() 
	
	
	
	
	

	
	
	
