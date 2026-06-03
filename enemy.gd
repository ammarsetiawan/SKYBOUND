extends CharacterBody2D

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const speed : float  = 0.9


func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.play("green_enemy")
	if !is_on_floor():
		velocity += get_gravity() 
	
	velocity.x += speed if animated_sprite_2d.flip_h == false else -speed
	flip()
	move_and_slide()

func flip():
	if ray_cast_2d.is_colliding() == false or is_on_wall() == true:
		velocity.x = 0
		animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
		ray_cast_2d.position.x = -ray_cast_2d.position.x


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.respawn()


func _on_hit_enemy_body_entered(body: Node2D) -> void:
	if body.name == "player":
		velocity.x = 0
		$hit_enemy.queue_free()
		$AnimatedSprite2D.hide()
		$animasi_hit.play("hit")
		await $animasi_hit.animation_finished
		queue_free()
