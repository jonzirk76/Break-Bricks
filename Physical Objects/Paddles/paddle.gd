extends CharacterBody2D

class_name Paddle

signal paddle_position(position)

@export var speed := 300

@onready var paddle_line = position.y
@onready var paddle_start_position = position
@onready var target = position

var control_state : String
#enum c {MOUSE MODE, BUTTON MODE}

func _ready():
	hide()

func _input(event):
	if control_state == "MOUSE MODE":
		#if event.is_action("click_to_move"):
		target = get_global_mouse_position()
	elif control_state == "BUTTON MODE":
		var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = input_direction * speed

func _physics_process(delta):
	if control_state == "MOUSE MODE":
		velocity = position.direction_to(target) * speed
		# look_at(target)
		if position.distance_to(target) > 10:
			move_and_slide()
		velocity.y = 0
		paddle_position.emit(position)
	elif control_state == "BUTTON MODE":
		position += velocity * delta
		move_and_slide()
		paddle_position.emit(position)
	position.y = clamp(position.y,paddle_line,paddle_line)

func _process(delta: float) -> void:
	pass

func _on_main_game_start() -> void:
	show()
	process_mode = Node.PROCESS_MODE_INHERIT

func _on_main_reset_game() -> void:
	hide()
	process_mode = Node.PROCESS_MODE_DISABLED
	position = paddle_start_position
	target = paddle_start_position

func _on_main_control_state(main_control_state: Variant) -> void:
	control_state = main_control_state

func _on_ball_collision_check_body_entered(body: Node2D) -> void:
	if body is Ball:
			$SoundEffect.pitch_scale = randf_range(.75, 1.25)
			$SoundEffect.playing = true
			$AnimationPlayer.play("bump")
