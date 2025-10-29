extends Area2D
class_name HurtboxComponent

signal on_damaged(hitbox:HitboxComponet)


func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponet:
		on_damaged.emit(area)
	pass # Replace with function body.
