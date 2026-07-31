extends Node2D

var world_mouse_pos

@export var player:Node2D
func _ready() -> void:
	world_mouse_pos = get_global_mouse_position()


func _process(_delta: float) -> void:
	queue_redraw()
	if Input.is_action_just_pressed("grapple"):
		var local_mouse = to_local(get_global_mouse_position())
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
	var local_mouse = to_local(get_global_mouse_position())
	
	draw_circle(local_mouse, 5, Color.BLUE_VIOLET)
