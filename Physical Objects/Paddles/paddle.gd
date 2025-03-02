extends CharacterBody2D

class_name Paddle

signal paddle_position(position)

@export var speed := 300

@onready var paddle_line = position.y
@onready var paddle_start_position = position
@onready var target = position

func _ready():
	hide()

func _input(event):
	# Use is_action_pressed to only accept single taps as input instead of mouse drags.
	if event.is_action("click_to_move"):
		target = get_global_mouse_position()

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	# look_at(target)
	if position.distance_to(target) > 10:
		move_and_slide()
	position.y = clamp(position.y,paddle_line,paddle_line)
	velocity.y = 0
	paddle_position.emit(position)

func _process(delta: float) -> void:
	pass
	#var velocity = Vector2.ZERO
	#if Input.is_action_pressed("move_left"):
		#velocity.x -= 1
	#if Input.is_action_pressed("move_right"):
		#velocity.x += 1
		#
	#position += velocity * speed * delta

func _on_main_game_start() -> void:
	show()
	process_mode = Node.PROCESS_MODE_INHERIT

func _on_main_reset_game() -> void:
	hide()
	process_mode = Node.PROCESS_MODE_DISABLED
	position = paddle_start_position
