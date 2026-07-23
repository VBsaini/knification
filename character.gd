extends CharacterBody2D



@export var SPEED = 300.0;
@export var JUMP_VELOCITY = -400.0;
@export var ACCELERATION = 1500.0;
@export var FRICTION = 2000.0;


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("right", "left")
	if direction:
		velocity.x = move_toward(velocity.x, direction*SPEED, ACCELERATION*delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move_and_slide()
