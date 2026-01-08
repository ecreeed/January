class_name Outro
extends Control

@onready var score_lbl = $Margin/Time

# Called on start
func _ready() -> void:
	score_lbl.modulate.a = 0
	var time = Global.time
	var mins : String = str(roundi(time / 60.0))
	var secs : String = str(snappedf(fmod(time, 60.0), 0.01))
	score_lbl.text = "Time\n" + mins + ":" + secs
	
	await get_tree().create_timer(0.5).timeout
	get_tree().create_tween().tween_property(score_lbl, "modulate:a", 1, 1)

# Return to Start
func _on_return_pressed():
	get_tree().change_scene_to_file("res://Menus/intro.tscn")
