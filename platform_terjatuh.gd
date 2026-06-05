extends Node2D

# Menentukan kecepatan jatuh platform
@export var kecepatan_jatuh : float = 500.0

# Variabel penanda apakah platform sudah harus jatuh
var sedang_jatuh : bool = false



func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	$StaticBody2D/AnimatedSprite2D.position.y = 4.0
	await get_tree().create_timer(0.10).timeout
	$StaticBody2D/AnimatedSprite2D.position.y = 0.0
	$StaticBody2D/Timer.start()
	

func _physics_process(delta):
	$StaticBody2D/AnimatedSprite2D.play("platform")
	if sedang_jatuh:
		# Menggeser posisi platform ke bawah
		position.y += kecepatan_jatuh * delta

# Fungsi ini otomatis mendeteksi ketika Timer habis
func _on_timer_timeout():
	sedang_jatuh = true
