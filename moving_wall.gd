extends CharacterBody2D

class_name Paddle

@export var speed := 10

@onready var paddle_line = position.y
@onready var target = position

func _input(event):
	# Use is_action_pressed to only accept single taps as input instead of mouse drags.
	if event.is_action("click_to_move"):
		target = get_global_mouse_position()

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	# look_at(target)
	if position.distance_to(target) > 10:
		move_and_slide()

func _process(delta: float) -> void:
	#var velocity = Vector2.ZERO
	#if Input.is_action_pressed("move_left"):
		#velocity.x -= 1
	#if Input.is_action_pressed("move_right"):
		#velocity.x += 1
		#
	#position += velocity * speed * delta
	position.y = clamp(position.y,paddle_line,paddle_line)
