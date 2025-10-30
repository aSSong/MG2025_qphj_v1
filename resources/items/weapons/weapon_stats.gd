extends Resource
class_name WeaponStats

@export var damage := 1.0
@export_range(0.0,1.0) var accuracy := 0.9
@export_range(0.1,3.0) var cooldown := 0.9
@export_range(0.0,1.0) var crit_chance := 0.05
@export var crit_damage := 1.5
@export var max_range := 150.0
@export var knockback := 0.0
@export_range(0.0,1.0) var life_steal := 0.0

#动画部分
#后坐力
@export var recoil := 25
#后坐力持续时间
@export_range(0.1,3.0) var recoil_duration := 0.1
#攻击动画持续时间
@export_range(0.1,3.0) var attack_duration := 0.2
#攻击回撤动画持续时间
@export_range(0.1,3.0) var back_duration := 0.15
@export var projectile_scene:PackedScene
@export var projectile_speed:=1600.0
