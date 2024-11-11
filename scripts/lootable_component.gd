extends Node
class_name LootableComponent

@export_category("General")
@export var interactable : Interactable
@export var loot_component : LootComponent

static var lootbag_scene := preload("res://assets/loot/lootbag.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	interactable.interacted.connect(interacted)

func interacted(interactor : Node):
	var lootbag = lootbag_scene.instantiate().instantiate_with_component(loot_component)
	var loot_manager = interactor.get_node("LootManager")

	var operation_success = loot_manager.attempt_receive_loot_bag(lootbag)

	if operation_success == true:
		self.queue_free()
