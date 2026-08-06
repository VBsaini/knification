extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _ready() -> void:
	$Detection.body_entered.connect(player_detected)
	$Detection.body_exited.connect(player_not_in_sight)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()



func player_detected(body):
	$Timer.start()
	pass

func player_not_in_sight(body):
	$Timer.stop()
	pass


func _on_timer_timeout() -> void:
	$Single_Bullet.shoot(Vector2(0, 0))
	$Timer.start()
	pass # Replace with function body.
