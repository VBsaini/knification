extends RigidBody2D

@export var player_position:Vector2 = Vector2.ZERO
@export var attach:bool = false

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if attach:
		state.transform.origin = player_position
		attach = false
