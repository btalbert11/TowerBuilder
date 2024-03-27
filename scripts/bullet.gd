extends Node2D

@export var bullet_speed: float = 50

var target: Vector2
var attack: Attack

var hit_ground_delete: bool = false



# Called when the node enters the scene tree for the first time.
func _ready():
	if attack == null:
		attack = Attack.new()
		attack.damage = 10
	rotation = global_position.direction_to(target).angle() + PI/2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
func _physics_process(delta):
	if hit_ground_delete:
		delete_self()
	#var movement_dir = (target - global_position).normalized() #Vector to target
	#global_position += movement_dir * bullet_speed * delta
	global_position = global_position.move_toward(target, bullet_speed*delta)
	if global_position.is_equal_approx(target):
		hit_ground_delete = true # Set to free next frame

func _on_hitbox_component_area_entered(area):
	if area is HurtboxComponent:
		area.take_attack(attack)
		delete_self()

func delete_self():
	queue_free()
