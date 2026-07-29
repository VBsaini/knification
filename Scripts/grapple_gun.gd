extends Node2D

var grapple: Pendulum = Pendulum.new()
var world_mouse_pos:= get_global_mouse_position()
var screen_mouse_pos

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("grapple"):
		world_mouse_pos = get_global_mouse_position()
		grapple.position = get_global_mouse_position() - global_position
		grapple.set_start_position(global_position, world_mouse_pos)
		queue_redraw()
		add_child(grapple)
		#look_at(get_global_mouse_position())
	if Input.is_action_just_released("grapple"):
		remove_child(grapple)
	pass


func _draw() -> void:
	draw_circle(get_global_mouse_position() - global_position, 5, Color.AQUA)
