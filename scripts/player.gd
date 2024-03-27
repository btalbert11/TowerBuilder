class_name Player
extends CharacterBody2D

@export var grid: Grid

@export var SPEED: float = 500.0

func _process(delta):
	pass

func _physics_process(delta: float) -> void:
	var dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if dir:
		velocity = dir.normalized() * SPEED
	else:
		velocity = Vector2.ZERO
	
	#var collision = move_and_collide(velocity)
	var collision = move_and_slide()
