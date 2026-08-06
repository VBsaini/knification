extends bullet_base

const BULLET = preload("res://Bullet.tscn")

var player: Node2D

func _ready() -> void:
	cooldown_timer = 60
	player = get_tree().get_first_node_in_group("player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func shoot(position) -> void:
	bullet = BULLET.instantiate(0)
	bullet.global_position = position
	bullet.direction = global_position.direction_to(player.global_position)
	add_child(bullet)
	pass
