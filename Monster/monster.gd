class_name Monster
extends CharacterBody2D

var target : Player
@onready var pathfind : NavigationAgent2D = $Pathfind
@onready var tp = $TP

const speed : int = 2250
const speed_gain : int = 250
const tp_base : Vector2 = Vector2(-455, 1505)
const tp_gap : int = 176
var _alive : int = 1

# Sets up the tracking
func set_target(new_target: Player) -> void:
	target = new_target

# Called Every tick
func _physics_process(delta) -> void:
	if target:
		pathfind.target_position = target.global_position
		if !pathfind.is_navigation_finished():
			_movement(delta)

# Handles player movement
func _movement(delta) -> void:
	var curr_pos: Vector2 = global_position
	var next_pos: Vector2 = pathfind.get_next_path_position()

	velocity = curr_pos.direction_to(next_pos) * (speed + target.keys*speed_gain)*_alive * delta
	move_and_slide()

# TP Player on body entered
func _on_tp_body_entered(body):
	if body is Player:
		var tp_rng : Vector2 = Vector2(tp_gap*randi_range(0, 5), tp_gap*randi_range(0, 3))
		body.global_position = tp_base + tp_rng

# Kills the monster
func die() -> void:
	_alive = 0
	if tp:
		tp.queue_free()
