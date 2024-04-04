extends CharacterBody2D

@export var _health_component: HealthComponent
@export var _hurtbox: HurtboxComponent
@export var max_health: float = 100
@export var _health_bar: ColorRect

var health_bar_size: float = 48

# Called when the node enters the scene tree for the first time.
func _ready():
	_health_component.set_max_health(max_health, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	velocity = Vector2(0, 75);
	
	var collision = move_and_slide()


func _on_hurtbox_component_attacked(attack):
	_health_component.take_damage(attack)
	_health_bar.visible = true
	_health_bar.size.x = health_bar_size * (_health_component.get_current_health() / _health_component.get_max_health())
	


func _on_health_component_no_health(current_health):
	queue_free()
