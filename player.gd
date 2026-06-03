extends CharacterBody2D
@onready var partikel: CPUParticles2D = $partikel

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const MAX_JUMPS = 2

var jumps_left := MAX_JUMPS
var is_double_jumping := false  # 🔥 Tambahin ini buat nandain double jump

func respawn():
	velocity = Vector2.ZERO  # Stop semua gerakan biar nggak nyangkut
	global_position = Vector2(88.0, 348.0)  # Ganti koordinat ini sesuai posisi spawn lu
	print("✅ Respawn berhasil!")

func _physics_process(delta: float) -> void:
	
	
	# 1. GRAVITASI
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 2. LOGIKA JUMP + TANDAIN DOUBLE JUMP
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			jumps_left = MAX_JUMPS
			is_double_jumping = false          # Reset pas nyentuh tanah
		elif jumps_left < MAX_JUMPS:           # Artinya ini lompatan ke-2/3/dst
			is_double_jumping = true           # 🔥 Tandain double jump
			
		if jumps_left > 0:
			velocity.y = JUMP_VELOCITY
			jumps_left -= 1

	# 3. GERAK HORIZONTAL
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		#jump_effect
	if  velocity.x < 0 || velocity.x > 0 || !is_on_floor():
		partikel.emitting = true
	elif velocity.x == 0:
		partikel.emitting = false
	
	


	# 4. GERAKKAN KARAKTER
	move_and_slide()

	# 🔥 5. UPDATE ANIMASI (WAJIB SETELAH move_and_slide)
	_update_animasi()

# 👇🏼 INI TEMPAT ANIMASI DOUBLE JUMP NYA
func _update_animasi():
	$AnimatedSprite2D.flip_h = velocity.x < 0  # Flip ikut arah gerak
	
	if is_on_floor():
		is_double_jumping = false  # Pastiin reset pas mendarat
		if abs(velocity.x) > 1.0:
			$AnimatedSprite2D.play("jalan")
		else:
			$AnimatedSprite2D.play("diam")
	else:
		# 🔥 CEK DOUBLE JUMP DULUAN
		if is_double_jumping:
			$AnimatedSprite2D.play("double_jump")  # ← Ganti nama sesuai animasi kamu
		elif velocity.y > 0 :
			$AnimatedSprite2D.play("jatuh")
		else:
			$AnimatedSprite2D.play("lompat")       # Animasi lompatan biasa
