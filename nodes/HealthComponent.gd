# This node represts a generic health attribute that can be used by various entities,
# including the player, enemies, structures, etc. Provides functions to take damage, 
# set health, signal when health is less than 0, etc.
class_name HealthComponent
extends Node

@export var MAX_HEALTH: float = 10
@export var invulnerability_time: float = 0
var health: float

signal no_health(current_health)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_current_health(MAX_HEALTH)

func take_damage(attack: Attack):
	health -= attack.damage
	if health <= 0:
		no_health.emit(health)

func get_current_health() -> float:
	return health

func get_max_health() -> float:
	return MAX_HEALTH
	
func set_max_health(new_max_health: float, heal: bool = true):
	if new_max_health > 0:
		MAX_HEALTH = new_max_health
		if health:
			set_current_health(MAX_HEALTH)

func set_current_health(new_current_health: float):
	if new_current_health > 0 && new_current_health <= MAX_HEALTH:
		health = new_current_health
