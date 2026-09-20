extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const JUMP_VELOCITY = -350.0
const JUMP_CUT = 0.5

func _ready() -> void:
	#position = get_viewport_rect().size / 2
	pass

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= JUMP_CUT
		
	sprite.play("idle")

	move_and_slide()
