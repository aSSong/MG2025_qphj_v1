extends Area2D
class_name HitboxComponet

signal on_hit_hurtbox(hurbox:HitboxComponet)

var damage := 1.0
var critical := false
var knockbcak_power := 0.0
var source : Node2D

func enable() -> void:
	set_deferred("monitoring",true)
	set_deferred("monitorable",true)
	pass

func disable() -> void:
	set_deferred("monitoring",false)
	set_deferred("monitorable",false)
	pass
	
func setup(damage:float,critical:bool,knockback:float,source:Node2D) -> void:
	self.damage = damage
	self.critical = critical
	self.knockbcak_power = knockback
	self.source = source
	pass

func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		on_hit_hurtbox.emit(area)
		print(area.owner.name)
	
	pass # Replace with function body.
