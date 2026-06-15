extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("enter"):
		_on_play_pressed()
	elif Input.is_action_just_pressed("escape"):
		_on_exit_pressed()



func _on_play_pressed() -> void:
	#get_tree().change_scene_to_file("res://scene/level_1.tscn")
	get_tree().change_scene_to_file("res://scene/level_1.tscn")



func _on_exit_pressed() -> void:
	get_tree().quit()



func _on_credit_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/tamat.tscn")
	



func _on_credit_mouse_entered() -> void:
	$interct.play()
