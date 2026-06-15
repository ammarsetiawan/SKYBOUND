extends CharacterBody2D
@onready var partikel: CPUParticles2D = $partikel

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const MAX_JUMPS = 2

var jumps_left := MAX_JUMPS
var is_double_jumping := false  #  ini buat nandain double jump

func _ready() -> void:
	$effect_respawn.hide()

func respawn():	
	$dead_sound.play()
	$effect_respawn.show()
	$AnimatedSprite2D.hide()
	velocity = Vector2.ZERO  
	global_position = Vector2(88.0, 348.0) 
	print("✅ Respawn berhasil!")
	$effect_respawn.play("efek_respawn")
	await $effect_respawn.animation_finished
	$effect_respawn.hide()
	$AnimatedSprite2D.show()

func _physics_process(delta: float) -> void:
	
	# 1. GRAVITASI
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 2. LOGIKA JUMP + DOUBLE JUMP
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			jumps_left = MAX_JUMPS
			is_double_jumping = false          
		elif jumps_left < MAX_JUMPS:          
			is_double_jumping = true          
			
		if jumps_left > 0:
			$jump_sound.play()
			velocity.y = JUMP_VELOCITY
			jumps_left -= 1

	# 3. GERAK HORIZONTAL
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if  velocity.x < 0 || velocity.x > 0 || !is_on_floor():
		partikel.emitting = true
	elif velocity.x == 0:
		partikel.emitting = false
	
	



	move_and_slide()

	_update_animasi()


func _update_animasi():
	$AnimatedSprite2D.flip_h = velocity.x < 0  
	
	if is_on_floor():
		is_double_jumping = false 
		if abs(velocity.x) > 1.0:
			$AnimatedSprite2D.play("jalan")
		else:
			$AnimatedSprite2D.play("diam")
	else:
		if is_double_jumping:
			$AnimatedSprite2D.play("double_jump")  
		elif velocity.y > 0 :
			$AnimatedSprite2D.play("jatuh")
		else:
			$AnimatedSprite2D.play("lompat")    
