extends RigidBody2D

class_name Ball

@export var stats = {
	"speed": 200
}

@onready var directions := {
	"left_up" : Vector2(-1, -1),
	"right_up" : Vector2(1, -1),
	#"left_down" : Vector2(-1, 1),
	#"right_down" : Vector2(1, 1)
}

var initial_velocity
var ball_launched
var paddle_position

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(linear_velocity * delta)
	if ball_launched == true:
		ball_in_play(collision)
		if linear_velocity.y == 0:
			_random_velocity()
	else:
		initial_ball_behavior(paddle_position)
		
	#var contact = $CollectionArea.get_overlapping_areas()
	#for body in contact:
		#if body is Mod:
			#mod_change(body.mods)

func _input(event):
	# Use is_action_pressed to only accept single taps as input instead of mouse drags.
	if ball_launched == false and event.is_action("launch"):
		_random_velocity()
		ball_launched = true

func _random_velocity():
	var initial_velocity = directions.values()[randi() % directions.size()]
	linear_velocity = initial_velocity.normalized()
	linear_velocity = linear_velocity * stats["speed"]

func initial_ball_behavior(paddle_position):
	position = Vector2(paddle_position.x , position.y)
	
func ball_in_play(collision):
	if collision:
		var collision_object = collision.get_collider()
		if collision and collision_object is Paddle:
			linear_velocity = self.global_position - collision_object.global_position
			linear_velocity = linear_velocity.normalized() * stats["speed"]
		else:
			linear_velocity = linear_velocity.bounce(collision.get_normal())

func mod_change(mods):
	for stat in stats:
		stats[stat] += mods[stat]
		linear_velocity = linear_velocity.normalized() * stats["speed"]

func kill_ball():
	queue_free()
