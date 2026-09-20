extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const JUMP_VELOCITY = -350.0
const JUMP_CUT = 0.5

func _ready() -> void:
	#position = get_viewport_rect().size / 2
	floor_max_angle = deg_to_rad(90.0)
	pass

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= JUMP_CUT
		
	if is_on_floor():
		var normal := get_floor_normal()
		var tangent := Vector2(-normal.y, normal.x)
		
		if tangent.x < 0:
			tangent = -tangent

		velocity.x = 0
		velocity.y = tangent.y * 300.0

		
	sprite.play("idle")

	move_and_slide()
