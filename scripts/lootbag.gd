extends RigidBody2D
class_name Lootbag

@export var loot_component : LootComponent
@export var speed = 200

var current_rotation

func _ready():
	current_rotation = rotation
	speed = speed - loot_component.loot_weight
	add_to_group("Lootbags")

func instantiate_with_component(component : LootComponent) -> Lootbag:
	var new_component = LootComponent.new()

	new_component.loot_name = component.loot_name 
	new_component.loot_weight = component.loot_weight 
	new_component.loot_allows_sprinting = component.loot_allows_sprinting 
	new_component.loot_value = component.loot_value 

	loot_component = new_component
	return self

func throw():
	var direction = get_tree().get_root().get_child(0).get_node("Player").get_local_mouse_position().normalized()
	var impulse = direction * speed
	apply_central_impulse(impulse)
	
