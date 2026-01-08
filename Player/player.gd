class_name Player
extends CharacterBody2D


### Parameters ###

signal all_keys

var time : float = 0.0
var keys : int = 0
const speed : float = 5000.0
const light_clr : Color = Color(1.0, 0.675, 0.353)
const light_str  : float = 2.0
const light_fade : float = 0.5
const fade_spd : float = 2.0
const flashlight_off : int = 320

@onready var animation : AnimatedSprite2D= $Animation
@onready var lamp : PointLight2D = $Lamp
@onready var flashlight : PointLight2D = $Flashlight
@onready var keytext : Label = $Keys


### Built-in Methods ###

# On Start
func _ready() -> void:
	_light_setup()
	keytext.modulate.a = 0

# Called every physics tick
func _physics_process(delta) -> void:
	time += delta * fade_spd
	_movement(delta)
	_animation()
	_lighting()


### Public Methods ###

# Pickup a key
func pickup_key() -> void:
	keys += 1
	_key_display()
	if keys >= 4:
		all_keys.emit()


### Private Methods ###

# Sets up lighting values
func _light_setup() -> void:
	lamp.color = light_clr
	lamp.energy = 1
	flashlight.color = light_clr
	flashlight.energy = light_str
	flashlight.offset.y = flashlight_off

# Handles player movement
func _movement(delta) -> void:
	velocity *= 0
	var dir = Input.get_vector("left","right","up","down").normalized()
	velocity = dir * delta * speed
	
	move_and_slide()

# Handles sprite animation
func _animation() -> void:
	# Sets the current animation
	if velocity.length() == 0:
		animation.play("idle")
		animation.flip_h = get_global_mouse_position() < global_position
	else:
		animation.play("walk")
		animation.flip_h = !bool(sign(velocity.x)+1)

# Flashlight
func _lighting() -> void:
	flashlight.energy = light_str + light_fade * sin(time)
	var dir := get_global_mouse_position() - global_position
	flashlight.global_rotation = dir.angle() - PI/2

# Key Text animatio
func _key_display() -> void:
	var ani = get_tree().create_tween()
	keytext.text = str(keys) + "/4"
	ani.tween_property(keytext, "modulate:a", 1, .5)
	ani.tween_interval(1)
	ani.tween_property(keytext, "modulate:a", 0, .5)
