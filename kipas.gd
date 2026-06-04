extends Node2D

@export var kekuatan_dorong: float = 600.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$StaticBody2D/AnimatedSprite2D.play("kipas")


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
		if body.name == "player":
			body.velocity.y = -kekuatan_dorong
