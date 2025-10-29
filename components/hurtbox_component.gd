extends Area2D
class_name HurtboxComponent

signal on_damaged(hitbox:HitboxComponet)

@export var damage_interval: float = 0.5 # 伤害间隔，单位秒

var _hitboxes_in_range: Dictionary = {} # 存储在范围内的hitbox及其上次伤害时间

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponet:
		_hitboxes_in_range[area] = 0.0 # 初始上次伤害时间为0
		on_damaged.emit(area) # 第一次接触时立即造成伤害

func _on_area_exited(area: Area2D) -> void:
	if area is HitboxComponet:
		_hitboxes_in_range.erase(area)

func _process(delta: float) -> void:
	var hitboxes_to_remove = []
	for hitbox in _hitboxes_in_range.keys():
		if not is_instance_valid(hitbox):
			hitboxes_to_remove.append(hitbox)
			continue
		_hitboxes_in_range[hitbox] += delta
		if _hitboxes_in_range[hitbox] >= damage_interval:
			on_damaged.emit(hitbox)
			_hitboxes_in_range[hitbox] = 0.0 # 重置计时器

	for hitbox in hitboxes_to_remove:
		_hitboxes_in_range.erase(hitbox)
