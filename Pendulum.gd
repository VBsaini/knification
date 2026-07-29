extends Node2D
class_name Pendulum

var pivot_point:Vector2
@export var end_position:Vector2
var arm_length:float
var angle

@export var gravity:float = 0.4 + 60 
@export var damping:float = 0.995 

var angular_velocity := 0.0
var angular_acceleration := 0.0


func set_start_position(startPos:Vector2, endPos:Vector2):
	pivot_point = startPos
	end_position = endPos
	arm_length = Vector2.ZERO.distance_to(end_position-pivot_point)
	angle = Vector2.ZERO.angle_to(end_position-pivot_point) - deg_to_rad(-90)
	angular_acceleration = 0.0
	angular_velocity = 0.0

#funatart_position(global_position, end_position)

func process_velocity(delta:float)->void:
	angular_acceleration = ((-gravity*delta) / arm_length) * sin(angle)
	angular_velocity += angular_acceleration
	angular_velocity *= damping
	angle += angular_velocity


func add_angular_velocity(force:float)->void:
	angular_velocity += force

func _physics_process(delta: float) -> void:
	game_input()
	end_position = pivot_point + Vector2(arm_length*sin(angle), arm_length*cos(angle))
	process_velocity(delta)
	queue_redraw()
	

func game_input() -> void:
	var dir:float = 0.0
	if Input.is_action_just_pressed("right"):
		dir += 1
	if Input.is_action_just_pressed("left"):
		dir -= 1
	add_angular_velocity(dir * 0.02)

func _draw() -> void:
	draw_line(Vector2.ZERO, end_position - pivot_point, Color.SADDLE_BROWN, 1.0, false)
	draw_circle(end_position-pivot_point, 3, Color.RED)
