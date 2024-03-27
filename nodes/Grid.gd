# Represents the grid used for player stucters and objects
# Contains size of grid, size of cells, and helper functions to convert from cell
# units to global units
class_name Grid
extends Resource

@export var grid_size: Vector2 = Vector2(200, 200)
@export var cell_size: Vector2 =  Vector2(400, 400)

# Converts a position on the grid to an absoulte global position. Uses the center
# of the cell
func from_grid_to_map_position(cell_position: Vector2) -> Vector2:
	return cell_position * cell_size + (cell_size / 2)

# Converts a position on the map to the cell that contains that position
func from_map_to_grid_cell(map_position: Vector2) -> Vector2:
	return (map_position / cell_size).floor()

# Takes a map position and returns the coordinates of the center of the cell that the positions
# are in.
func snap_to_grid(pos: Vector2) -> Vector2:
	var cell = from_map_to_grid_cell(pos)
	return from_grid_to_map_position(cell)
