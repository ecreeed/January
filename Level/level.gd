class_name Level
extends Node2D

@onready var exit = $Exit
@onready var door = $Tiles/Door
@onready var noise = $Overlay/Noise
@onready var cam = $Cam

@onready var monster = $Monster
@onready var player = $Player


func _ready() -> void:
	exit.visible = false
	monster.set_target(player)

func _on_player_all_keys() -> void:
	exit.visible = true
	door.visible = false


func _physics_process(_delta):
	noise.set_pos(monster.global_position - cam.global_position + noise.size*0.5)
