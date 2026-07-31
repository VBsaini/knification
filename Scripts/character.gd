extends CharacterBody2D



@export var SPEED = 300.0;
@export var JUMP_VELOCITY = -400.0;
@export var ACCELERATION = 1500.0;
@export var FRICTION = 2000.0;

enum State {IDLE, WALKING, JUMPING, KNIFE, GRAPPLING}
var currentState = State.IDLE


func _ready() -> void:
	$AnimatedSprite2D.animation_finished.connect(_on_animation_finished)



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if currentState != State.KNIFE:
			currentState = State.JUMPING
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("right", "left")
	if currentState != State.GRAPPLING:
		if direction:
			if currentState != State.KNIFE:
				currentState = State.WALKING
			if direction != 0:
				$AnimatedSprite2D.flip_h = (direction < 0)
				velocity.x = move_toward(velocity.x, direction*SPEED, ACCELERATION*delta)
		else:
			if currentState != State.KNIFE:
				currentState = State.IDLE
			velocity.x = move_toward(velocity.x, 0, FRICTION * delta)


	if Input.is_action_just_pressed("knife"):
		currentState = State.KNIFE
	if Input.is_action_just_pressed("grapple"):
		#global_rotation = 0
		currentState = State.GRAPPLING
	Handle_State(currentState)
	global_rotation = 0
	move_and_slide()


func Handle_State(current_state: State):
	match current_state:
		State.IDLE:
			$AnimatedSprite2D.play("Idle")
		State.WALKING:
			$AnimatedSprite2D.play("Walk")
		State.JUMPING:
			print("Jumping")
		State.KNIFE:
			$AnimatedSprite2D.play("Knife")

func _on_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Knife":
		currentState = State.IDLE
