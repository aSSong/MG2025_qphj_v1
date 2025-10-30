extends Node
class_name HealthComponent

signal on_unit_hit
signal on_unit_died
signal on_health_changed(current:float,max:float)

var max_health := 1.0
var current_health := 1.0

func setup(stats:UnitStats) ->void:
	if stats == null: # Add this check
		print("Warning: stats is null in HealthComponent setup. Using default health.")
		max_health = 1.0 # Default health if stats is null
	else:	
		max_health = stats.health
		print("HealthComponent setup: %s, max_health = %f" % [stats.name, max_health])
	current_health = max_health
	on_health_changed.emit(current_health,max_health)
	pass
	
func take_damage(value:float) -> void:
	if current_health <= 0:
		print("HealthComponent: 已经死亡，无法再次受伤")
		return
	
	print("HealthComponent: take_damage被调用，伤害值: %f, 当前血量: %f, 最大血量: %f" % [value, current_health, max_health])
	
	current_health -= value
	current_health = max(current_health,0)
	
	on_unit_hit.emit()
	on_health_changed.emit(current_health,max_health)
	
	print("HealthComponent: 受伤后血量: %f" % current_health)
	
	if current_health <= 0:
		current_health = 0
		print("HealthComponent: 单位死亡!")
		on_unit_died.emit()
		die()
	pass
	
func heal(amount:float)->void:
	if current_health <= 0:
		return
	current_health += amount
	current_health = min(current_health,max_health) 
	on_health_changed.emit(current_health,max_health)
	pass


func die() -> void:
	owner.queue_free() 
	pass
