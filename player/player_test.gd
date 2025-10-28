extends CharacterBody2D

var dir = Vector2.ZERO
var flip = false
var canMove = true
var stop = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var self_pos = position
	
	if mouse_pos.x >= self_pos.x:
		flip = false
	else:
		flip = true
		
	#flip_h = flip
	
	dir = (mouse_pos - self_pos).normalized()
	
	#if canMove and !stop:
	velocity = dir * 300
	move_and_slide()
	pass
