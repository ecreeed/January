class_name NoiseText
extends ColorRect


### Parameters ###

@onready var mat : ShaderMaterial = material
var curr_pos : Vector2 = Vector2.ZERO
var fx_speed : float = 50.0


###  Methods ###

# Called on start
func _ready() -> void:
	curr_pos = get_local_mouse_position()
	mat.set_shader_parameter("aspect", size)
	mat.set_shader_parameter("color", color)

# Called every tick
func _physics_process(_delta) -> void:
	mat.set_shader_parameter("fx_pos", curr_pos)

# Temp for testing
func mouse_distort(delta) -> void:
	var dir : Vector2 = get_local_mouse_position() - curr_pos
	if dir.length() < 5:
		dir = Vector2.ZERO
	curr_pos += dir.normalized() * (fx_speed * delta)

func set_pos(new_pos: Vector2) -> void:
	curr_pos = new_pos
