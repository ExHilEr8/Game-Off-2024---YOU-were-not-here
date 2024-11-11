extends Node
class_name LootComponent

@export_category("General")
@export var sprite : Sprite2D 

@export_category("Loot Properties")
@export var loot_name : String = "Unnamed"
@export var loot_weight : float = 50
@export var loot_allows_sprinting : bool = true
@export var loot_value : float = 0 :
	get:
		return loot_value
	set(set_value):
		## limits value to two decimal places
		loot_value = snapped(set_value, 0.01)


