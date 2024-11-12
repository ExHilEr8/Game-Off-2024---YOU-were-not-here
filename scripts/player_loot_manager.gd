extends Node

@export var player : Node

var current_bag : Lootbag
var has_bag : bool = false

# Dependencies
static var lootbag_scene := preload("res://assets/loot/lootbag.tscn")

func _physics_process(_delta):
	if Input.is_action_just_released("throw_bag") and has_bag:
		throw_bag()

func attempt_receive_loot(loot_component : LootComponent) -> bool:
	if has_bag == false:
		var lootbag = lootbag_scene.instantiate().instantiate_with_component(loot_component)
		receive_loot_bag(lootbag)
		return true

	return false

func receive_loot_bag(lootbag : Lootbag):
	current_bag = lootbag
	has_bag = true

func remove_loot_bag():
	current_bag = null
	has_bag = false

func throw_bag():
	get_tree().root.get_child(0).add_child(current_bag)
	current_bag.position = player.position
	current_bag.throw()
	remove_loot_bag()
