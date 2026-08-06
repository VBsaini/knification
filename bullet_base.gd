extends Node2D
class_name bullet_base

var  cooldown_timer:int
var bullet:Node2D

func _init(time:int):
	cooldown_timer = time

func shoot(position) -> void:
	pass

func get_cooldown_time():
	return cooldown_timer

func set_cooldown_time(time:int):
	cooldown_timer = time
