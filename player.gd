extends CharacterBody3D


@export var speed = 14
@export var fall_acceleration = 75
@export var jump_impulse = 20
@export var bounce_impluse = 16
var target_velocity = Vector3.ZERO

signal hit

func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1

	if direction != Vector3.ZERO:
		direction.normalized()
		$pivot.basis = Basis.looking_at(direction)

	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		var collided_object = collision.get_collider()
		
		if collided_object == null:
			continue
			
		if collided_object.is_in_group("mob"):
			if Vector3.UP.dot(collision.get_normal()) > 0.1:
				collided_object.squash()
				target_velocity.y = bounce_impluse
				break
	
	velocity = target_velocity
	move_and_slide()

func die():
	hit.emit()
	queue_free()

func _on_mob_hitbox_body_entered(body: Node3D) -> void:
	die()
