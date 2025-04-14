extends CharacterBody3D


@export var speed = 14
@export var fall_acceleration = 75
var target_velocity = Vector3.ZERO

func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO
	print("i be tring move brother")
	if Input.is_action_pressed("move_left"):
		print("holy move")
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

	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	velocity = target_velocity
	move_and_slide()
