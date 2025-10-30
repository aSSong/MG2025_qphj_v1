extends CharacterBody2D
class_name Unit

@export var stats: UnitStats

@onready var visuals: Node2D = %Visuals
@onready var sprite: Sprite2D = %Sprite
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var health_component: HealthComponent = $HealthComponent

func _ready() -> void:
	health_component.setup(stats)
	pass


func _on_hurtbox_component_on_damaged(hitbox: HitboxComponet) -> void:
	if health_component.current_health <= 0:
		return
	
	var damage_dealt = hitbox.damage
	var health_before = health_component.current_health
	print("Player受到伤害! 伤害值: %f, 当前血量: %f" % [damage_dealt, health_before])
	
	health_component.take_damage(damage_dealt)
	
	var health_after = health_component.current_health
	print("%s: 受到伤害 %f, 血量从 %f 减少到 %f" % [name, damage_dealt, health_before, health_after])
	pass # Replace with function body.
