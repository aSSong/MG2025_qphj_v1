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
	health_component.take_damage(hitbox.damage)
	print("%s: %d" %[name,health_component.current_health])
	pass # Replace with function body.
