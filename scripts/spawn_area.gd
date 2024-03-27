extends Node2D

signal spawn_enemy(pos: Vector2, enemy: PackedScene)

@export var enemy_spawn: PackedScene
@export var _area: CollisionShape2D
@export var _timer: Timer

@export var spawn_time: float = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	_timer.wait_time = spawn_time
	_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawn_timer_timeout():
	var rect = _area.shape.get_rect().size
	var rng = RandomNumberGenerator.new()
	var rand_x = rng.randf_range(global_position.x, global_position.x + rect.x)
	var rand_y = rng.randf_range(global_position.y, global_position.y + rect.y)
	spawn_enemy.emit(Vector2(rand_x, rand_y), enemy_spawn)
