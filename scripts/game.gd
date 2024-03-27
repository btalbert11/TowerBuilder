extends Node2D

@export var _camera: MainCamera
@export var basic_tower: PackedScene
@export var object_to_place: Node2D

var object_placement_mode: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _unhandled_input(event):
	if event.is_action_pressed("object_select") and object_placement_mode != null:
		if !object_to_place:
			push_error("Object hold is null")
			return
		else:
			var turret = object_to_place
			object_to_place = null
			$Selector.remove_child(turret)
			add_child(turret)
			turret.global_position = $Selector.global_position
			turret.placement_initialize()
			object_placement_mode = false
			
	# SCROLL FOR CAMERA ZOOM
	if event.is_action_pressed("camera_zoom_in"):
		_camera.zoom = _camera.zoom.move_toward(_camera.max_zoom, _camera.zoom_speed)
	if event.is_action_pressed("camera_zoom_out"):
		_camera.zoom = _camera.zoom.move_toward(_camera.min_zoom, _camera.zoom_speed)


func _on_build_ui_purchase_basic_tower():
	var tower = basic_tower.instantiate()
	object_to_place = tower
	object_placement_mode = true
	$Selector.add_child(tower)


func _on_spawn_area_spawn_enemy(pos: Vector2, enemy: PackedScene):
	var en = enemy.instantiate()
	en.global_position = pos
	add_child(en)
