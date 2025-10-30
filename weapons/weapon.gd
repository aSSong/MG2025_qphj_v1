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
var waepon_spread: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	atk_start_pos = sprite.position
	
	pass # Replace with function body.

func setup_weapon(data: ItemWeapon) -> void:
	self.data = data
	collision.shape.radius = data.stats.max_range
	pass

func can_use_weapon() -> bool:
	return cooldown_timer.is_stopped() and closest_target
	#pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_range_area_area_entered(area: Area2D) -> void:
	targets.push_back(area)
	pass # Replace with function body.


func _on_range_area_area_exited(area: Area2D) -> void:
	targets.erase(area) 
	if targets.size() == 0:
		closest_target = null
	pass # Replace with function body.
