class_name Intro
extends Control



func _on_button_pressed():
	var ani = get_tree().create_tween()
	ani.tween_property($Content, "modulate:a", 0, 0.5)
	ani.tween_interval(1.5)
	await ani.finished
	get_tree().change_scene_to_file("res://Level/level.tscn")
