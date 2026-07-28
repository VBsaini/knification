extends Node2D

var grapple: Pendulum = Pendulum.new()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("grapple"):
		grapple.set_start_position(get_global_mouse_position(), global_position)
		grapple.position = get_global_mouse_position()
		add_child(grapple)
		look_at(get_global_mouse_position())
	if Input.is_action_just_released("grapple"):
		remove_child(grapple)
	pass
