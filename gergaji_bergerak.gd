extends Node2D


@export var kecepatan: float = 300.0  # Kecepatan gergaji bergerak ke kiri
var terpicu: bool = false

@onready var gergaji: Node2D = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if terpicu:
		# Koordinat X minus (-) berarti bergerak ke KIRI
		gergaji.position.x -= kecepatan * delta
		
		# Efek visual: Membuat gergaji berputar saat jalan
		gergaji.rotation -= 10 * delta 



func _on_triger_body_entered(body: CharacterBody2D) -> void:
	if body.name == "player":
		terpicu = true
		$StaticBody2D/triger.set_deferred("disable", true)


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.respawn()
