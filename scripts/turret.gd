class_name Turret
extends Node2D

@export var bullet_type: PackedScene
@export var bullet_speed: float = 1000
@export var damage: float = 10
@export var accuracy_variance: float = 75
@export var fire_rate: float = 0.3
@export var attack_range: float = 550
@export var max_health: float = 10

@export var _timer: Timer
@export var _attack_collision: CollisionShape2D
@export var _health_component: HealthComponent

var targeting_queue: Array = []
var current_target: Node2D
var attack: Attack
var ACTIVE: bool = false

@export var grid: Grid

# Called when a turret is placed on the map. Activates animation, enables firing, etc.
func placement_initialize():
	global_position = grid.snap_to_grid(global_position)
	$StaticBody2D/CollisionShape2D.disabled = false
	ACTIVE = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$StaticBody2D/CollisionShape2D.disabled = true
	attack = Attack.new()
	attack.damage = damage
	attack.origin = global_position
	_timer.wait_time = fire_rate
	_timer.timeout.connect(fire)

	_attack_collision.shape.radius = attack_range
	_health_component.set_max_health(max_health)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fire():
	if current_target == null and !targeting_queue.is_empty(): # Need new target, still enemies in range
		current_target = targeting_queue[-1]
	if current_target != null: # Have a target
		var rng = RandomNumberGenerator.new()
		var bullet = bullet_type.instantiate()
		bullet.target = current_target.global_position + Vector2(rng.randf_range(-accuracy_variance, accuracy_variance), rng.randf_range(-accuracy_variance, accuracy_variance))
		bullet.global_position = global_position
		get_tree().get_root().get_node("Game").add_child(bullet)
		bullet.bullet_speed = bullet_speed
		bullet.attack = attack
		_timer.start()
	else: # No target, new enemies in range
		pass

func _on_attack_range_area_entered(area):
	if area is HurtboxComponent and area.get_owner().is_in_group("Enemies"):
		var enemy = area.get_owner()
		targeting_queue.append(enemy)
		if ACTIVE: 
			fire()



func _on_attack_range_area_exited(area):
	if area is HurtboxComponent and area.get_owner().is_in_group("Enemies"):
		var enemy = area.get_owner()
		targeting_queue.erase(enemy)
