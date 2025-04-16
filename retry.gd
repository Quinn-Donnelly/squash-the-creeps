extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and visible:
		get_tree().reload_current_scene()
