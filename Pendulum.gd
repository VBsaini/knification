extends Node2D





class_name Pendulum

@export var grapple_anchor: StaticBody2D
@export var player_anchor: RigidBody2D
@export var rope: Line2D





@export var max_radius:float = 512



func _ready() -> void:
	add_to_group("grappling-hook-system")
	rope.visible = true
	player_anchor.visible = true
	




func _process(_delta: float) -> void:
	rope.set_point_position(0, $GrappleAnchor.global_position * rope.global_transform)
	rope.set_point_position(1, player_anchor.global_position * rope.global_transform)
	#rope.points[0] = $GrappleAnchor.global_position * rope.global_transform
	#rope.points[1] = player_anchor.global_position * rope.global_transform
	
	for child in player_anchor.get_children():
		if "position" in child:
			child.position = Vector2(0,0)
	
	if Input.is_action_pressed("right"):
		if player_anchor.linear_velocity.length() < 200:
			player_anchor.apply_central_impulse(
				player_anchor.global_transform.x * -32
			)
	elif Input.is_action_pressed("left"):
		if player_anchor.linear_velocity.length() < 200:
			player_anchor.apply_central_impulse(
				player_anchor.global_transform.x * 32
			)
	
	
	queue_redraw()
	


var player_original_parent: Node = null

func attach_player(player: Node2D) -> int:
	if get_global_mouse_position().distance_to(player.global_position) > max_radius or player_original_parent != null:
		return -1;
	$GrappleAnchor.position = to_local(get_global_mouse_position())
	player_original_parent = player.get_parent()
	player_anchor.position = player.global_position
	player.reparent(player_anchor)
	player.position = Vector2.ZERO
	var launch_dist = player_anchor.position.distance_to($GrappleAnchor.position)
	print(launch_dist)
	var parent = $PinJoint2D.get_parent()
	parent.remove_child($PinJoint2D)
	var joint = PinJoint2D.new()
	joint.set_name("PinJoint2D")
	joint.position = grapple_anchor.position
	joint.node_a = grapple_anchor.get_path()
	joint.node_b = player_anchor.get_path()
	parent.add_child(joint)
	
	
	rope.visible = true
	player_anchor.visible = true
	
	return 0

func detach_player(player: Node2D) -> int:
	if player_original_parent == null:
		return -1
	player.reparent(player_original_parent)
	player.velocity = player_anchor.linear_velocity
	player_original_parent = null
	rope.visible = false
	player_anchor.visible = false
	return 0
	
