extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_single_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/38f.tscn")
	pass # Replace with function body.
