extends Node2D

#var grapple: Pendulum = Pendulum.new()
var world_mouse_pos:= get_global_mouse_position()
var screen_mouse_pos

@export var player:Node2D



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("grapple"):
		for grappling_hook_system in get_tree().get_nodes_in_group("grappling-hook-system"):
			var success = grappling_hook_system.attach_player(self.get_parent())
			if success == 0:
				print("attached")
				break
	elif Input.is_action_just_released("grapple"):
		for grappling_hook_system in get_tree().get_nodes_in_group("grappling-hook-system"):
			var success = grappling_hook_system.detach_player(self.get_parent())
			if success == 0:
				print("deattached")
				break
	pass


func _draw() -> void:
	draw_circle(position, 5, Color.AQUA)
