extends RigidBody2D

class_name Ball

@export var stats = {
	"speed_mod": 200
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
		if linear_velocity.y <= 10 and linear_velocity.y >= -10:
			_random_velocity()
	#else:
		#initial_ball_behavior(paddle_position)
		
	#var contact = $CollectionArea.get_overlapping_areas()
	#for body in contact:
		#if body is Mod:
			#mod_change(body.mods)

func _input(event):
	# Use is_action_pressed to only accept single taps as input instead of mouse drags.
	if ball_launched == false and event.is_action("launch"):
		_random_velocity()
		collision_layer = 0b00000000_00000000_00000000_00000010
		collision_mask = 0b00000000_00000000_00000000_00001101
		ball_launched = true

func _random_velocity():
	var initial_velocity = directions.values()[randi() % directions.size()]
	linear_velocity = initial_velocity.normalized()
	linear_velocity = linear_velocity * stats["speed_mod"]

#func initial_ball_behavior(paddle_position):
	#position = paddle_position
	
func ball_in_play(collision):
	if collision:
		var collision_object = collision.get_collider()
		if collision and collision_object is Paddle:
			linear_velocity = self.global_position - collision_object.global_position
			linear_velocity = linear_velocity.normalized() * stats["speed_mod"]
		#elif collision_object is Brick:
			#linear_velocity = self.global_position - collision_object.global_position
			#linear_velocity = linear_velocity.normalized() * stats["speed"]
		else:
			linear_velocity = linear_velocity.bounce(collision.get_normal())

func mod_change(item_stats):
	for stat in stats:
		stats[stat] += item_stats[stat]
		linear_velocity = linear_velocity.normalized() * stats["speed_mod"]

func kill_ball():
	queue_free()
