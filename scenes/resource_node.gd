class_name ResourceNode
extends Node2D

@export var gathering: bool = false
@export var gathering_speed: float = 1
var gathering_progress: float = 0
var max_gather: float = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if gathering:
		gathering_progress += gathering_speed * delta
		if gathering_progress >= max_gather:
			PlayerResources.stone += 1
			gathering_progress = 0
	# Update progress bar
	
