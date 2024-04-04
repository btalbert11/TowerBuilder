extends Node

var stone: int = 100 : set = _set_stone, get = _get_stone
signal stone_change(value)

func _set_stone(new_value: int):
	if new_value <= 0:
		stone = 0
	else:
		stone = new_value
	stone_change.emit(stone)

func _get_stone():
	return stone
