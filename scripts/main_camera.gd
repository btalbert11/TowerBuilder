class_name MainCamera
extends Camera2D

@export var max_zoom: Vector2 = Vector2(1.8, 1.8)
@export var min_zoom: Vector2 = Vector2(0.5, 0.5)
@export var max_drag: float = 0.08
@export var min_drag: float = 0.08
@export var zoom_speed: float = 0.1
@export var camera_speed: float = 1000


func _process(delta):
	var dir = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if dir:
		var velocity = dir * camera_speed
		global_position += velocity * delta

func _unhandled_input(event):
		# SCROLL FOR CAMERA ZOOM
	if event.is_action_pressed("camera_zoom_in"):
		zoom = zoom.move_toward(max_zoom, zoom_speed)
	if event.is_action_pressed("camera_zoom_out"):
		zoom = zoom.move_toward(min_zoom, zoom_speed)
