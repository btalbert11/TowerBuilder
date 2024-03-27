# This represts an object that highlights, selects, and moves player buildings and objects around the grid
class_name Selector
extends Node2D

@export var grid: Grid
var cell: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	cell = grid.from_map_to_grid_cell(global_position)
	global_position = grid.from_grid_to_map_position(cell)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = get_global_mouse_position()
	cell = grid.from_map_to_grid_cell(pos)
	global_position = grid.from_grid_to_map_position(cell)

# Outline the currently selected cell
func _draw() -> void:
	draw_rect(Rect2(-grid.cell_size/2, grid.cell_size), Color.ALICE_BLUE, false, 3)
