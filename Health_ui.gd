extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(3):
		var health_box = ColorRect.new()
		health_box.set_name("healthBox%d" % i)
		health_box.set_custom_minimum_size(Vector2(10, 5))
		health_box.color = Color.CRIMSON
		$HBoxContainer.add_child(health_box)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
