extends RigidBody2D

class_name Ball

@export var speed := 100

@onready var directions := {
	"left_up" : Vector2(-1, -1),
	"right_up" : Vector2(1, -1),
	#"left_down" : Vector2(-1, 1),
	#"right_down" : Vector2(1, 1)
}

@onready var initial_velocity
@onready var in_kill_area = false 

func _ready() -> void:
	_random_velocity()
	
func _process(delta: float) -> void:
	if in_kill_area == true:
		kill_ball()

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(linear_velocity * delta)
	if collision and collision.get_collider() is Paddle:
		linear_velocity = self.global_position - collision.get_collider().global_position
		linear_velocity = linear_velocity.normalized() * speed
	elif collision:
		linear_velocity = linear_velocity.bounce(collision.get_normal())
	
func _random_velocity():
	var initial_velocity = directions.values()[randi() % directions.size()]
	linear_velocity = initial_velocity * speed

func kill_ball():
	queue_free()
