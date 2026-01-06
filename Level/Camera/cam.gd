class_name Cam
extends Camera2D

var target: Player
@export var auto_target : Player

const pan_thres : float = 5.0
const pan_spd : float = 1.5


### Public Methods ###

# Sets the target to follow
func set_target(new_target: Player) -> bool:
	if new_target != target:
		target = new_target
		global_position = target.global_position
		return true
	return false


### Built-in Methods ###

# Called on start
func _ready() -> void:
	if auto_target:
		set_target(auto_target)

# Called every physics tick
func _physics_process(delta) -> void:
	_tracking(delta)


### Private Methods ###

# Tracking to target
func _tracking(delta) -> void:
	if !target:
		return
	
	var dist = target.global_position - global_position
	if dist.length() >= pan_thres:
		global_position += dist * delta * pan_spd
	
