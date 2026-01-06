class_name Key
extends Node2D

const ani_spd : float = 0.5

func _on_area_body_entered(body: Node2D):
	if body is Player:
		body.pickup_key()
		var  ani = get_tree().create_tween()
		ani.tween_property(self, "global_position", body.global_position, ani_spd)
		ani.parallel()
		ani.tween_property(self, "scale", Vector2.ZERO, ani_spd)
		await ani.finished
		queue_free()
