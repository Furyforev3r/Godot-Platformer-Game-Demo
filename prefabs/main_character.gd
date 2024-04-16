extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -400.0
var double_jump = true

var mirror = false

@onready var sprite_2d = $Sprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if velocity.x > 1 or velocity.x < -1:
		sprite_2d.animation = "running"	
	else:
		sprite_2d.animation = "default"	
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.animation = "jumping"

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		double_jump = true
	
	if Input.is_action_just_pressed("jump") and not is_on_floor() and double_jump:	
		velocity.y = JUMP_VELOCITY
		double_jump = false

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("left"):
		mirror = true
	elif Input.is_action_just_pressed("right"):
		mirror = false

	move_and_slide()
	
	sprite_2d.flip_h = mirror
