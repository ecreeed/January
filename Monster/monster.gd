class_name Monster
extends CharacterBody2D

var target : Player
@onready var pathfind : NavigationAgent2D = $Pathfind
const speed : int = 2000

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

	velocity = curr_pos.direction_to(next_pos) * speed * delta
	move_and_slide()
