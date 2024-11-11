extends Node

@export var player : Node

var current_bag : Lootbag
var has_bag : bool = false

func _ready():
	print(current_bag)

func _physics_process(delta):
	if Input.is_action_just_released("throw_bag") and has_bag:
		throw_bag()

func attempt_receive_loot_bag(lootbag : Lootbag) -> bool:
	if has_bag == false:
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
	get_tree().root.add_child(current_bag)
	current_bag.position = player.position
	remove_loot_bag()

