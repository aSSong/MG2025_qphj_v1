extends Node2D
class_name Weapon

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = %CollisionShape2D
@onready var cooldown_timer: Timer = $CooldownTimer


var data: ItemWeapon
var is_attacking: = false
var atk_start_pos: Vector2
var targets: Array[Enemy]
var closest_target: Enemy
var weapon_spread: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	atk_start_pos = sprite.position
	
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not is_attacking:
		if targets.size() > 0:
			update_closest_target()
		else:
			closest_target = null
	rotate_to_target()
	pass

func update_closest_target() -> void:
	closest_target = get_closest_target()
	pass

func rotate_to_target() -> void:
	if is_attacking:
		rotation = get_custum_rotation_to_target()
	else:
		rotation = get_rotation_to_target()
	pass

func get_custum_rotation_to_target() -> float:
	if not closest_target or not is_instance_valid(closest_target):
		return rotation
	var rot := global_position.direction_to(closest_target.global_position).angle()
	return rot + weapon_spread

func get_rotation_to_target() -> float:	
	if targets.size() == 0 or not closest_target or not is_instance_valid(closest_target):
		return get_idle_rotation()
	var rot := global_position.direction_to(closest_target.global_position).angle()
	return rot

func get_idle_rotation() -> float:
	if Global.player.is_facing_right():
		return 0
	else:
		return PI
	

func calculate_speed() -> void:
	weapon_spread += randf_range(-1 + data.stats.accuracy,1 - data.stats.accuracy)
	rotation += weapon_spread
	pass


func get_closest_target() -> Enemy:
	if targets.size() == 0:
		return null
	
	# 清理无效的目标
	var valid_targets: Array[Enemy] = []
	for target in targets:
		if is_instance_valid(target):
			valid_targets.append(target)
	targets = valid_targets
	
	if targets.size() == 0:
		return null
	
	var closest_enemy: Enemy = targets[0]
	var closest_distance := global_position.distance_to(closest_enemy.global_position)
	
	#所有目标组中的成员与0号位去比较
	for i in range(1, targets.size()):
		var target: Enemy = targets[i]
		if not is_instance_valid(target):
			continue
		var distance := global_position.distance_to(target.global_position)
	
		if distance < closest_distance:
			closest_enemy = target
			closest_distance = distance
	return closest_enemy

func setup_weapon(weapon_data: ItemWeapon) -> void:
	self.data = weapon_data
	collision.shape.radius = weapon_data.stats.max_range
	pass


func use_weapon() -> void:
	calculate_speed()


func can_use_weapon() -> bool:
	return cooldown_timer.is_stopped() and closest_target
	#pass


func _on_range_area_area_entered(area: Area2D) -> void:
	# 从area的owner获取Enemy对象
	if area.owner is Enemy:
		var enemy: Enemy = area.owner as Enemy
		if not targets.has(enemy):
			targets.append(enemy)
			print("Weapon: 检测到敌人 %s" % enemy.name)
	pass # Replace with function body.


func _on_range_area_area_exited(area: Area2D) -> void:
	# 从area的owner获取Enemy对象并移除
	if area.owner is Enemy:
		var enemy: Enemy = area.owner as Enemy
		if targets.has(enemy):
			targets.erase(enemy)
			print("Weapon: 敌人 %s 离开范围" % enemy.name)
	if targets.size() == 0:
		closest_target = null
	pass # Replace with function body.
