extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().change_scene_to_file("res://scene/menu_home.tscn")


func _on_pindah_body_entered(body: CharacterBody2D) -> void:
	get_tree().change_scene_to_file("res://scene/level_5.tscn")
