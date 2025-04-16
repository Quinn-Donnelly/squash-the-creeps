extends CharacterBody3D

@export var min_speed = 10
@export var max_speed = 18

signal squahsed

func initalize(start_position, player_position) -> void:
	look_at_from_position(start_position, player_position, Vector3.UP)
	rotate_y(randf_range(-PI/4, PI/4))
	velocity = randi_range(min_speed, max_speed) * Vector3.FORWARD
	velocity =  velocity.rotated(Vector3.UP ,rotation.y)
	
func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()

func squash():
	squahsed.emit()
	queue_free()
