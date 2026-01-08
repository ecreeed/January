class_name Level
extends Node2D

@onready var exit = $ExitLight
@onready var door = $Tiles/Door
@onready var noise = $Overlay/Noise
@onready var outro = $Overlay/Outro

const intro_clr : Color = Color(0.137, 0.153, 0.2)
const outro_clr : Color = Color(1.0, 1.0, 1.0)

@onready var cam = $Cam

@onready var monster = $Monster
@onready var player = $Player

var time : float = 0.0


func _ready() -> void:
	outro.visible = true
	exit.visible = false
	
	outro.color = intro_clr
	var out_ani = get_tree().create_tween()
	out_ani.tween_property(outro, "modulate:a", 0, 0.9)
	monster.set_target(player)
	

func _on_player_all_keys() -> void:
	exit.visible = true
	if door:
		door.queue_free()

# Move the monster FX
func _physics_process(delta):
	noise.set_pos(monster.global_position - cam.global_position + noise.size*0.5)
	time += delta

# Player Exit
func _on_exit_area_body_entered(body):
	if body is Player:
		monster.die()
		Global.time = time
		outro.color = outro_clr
		var out_ani = get_tree().create_tween()
		out_ani.tween_property(outro, "modulate:a", 1, 0.9)
		await out_ani.finished
		get_tree().change_scene_to_file("res://Menus/outro.tscn")
