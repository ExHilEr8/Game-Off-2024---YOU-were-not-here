extends Node
class_name LootableComponent

@export_category("General")
@export var interactable : Interactable
@export var loot_component : LootComponent
@export var is_bag : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	interactable.interacted.connect(interacted)

func interacted(interactor : Node):
	var loot_manager = interactor.get_node("LootManager")
	var operation_success : bool = loot_manager.attempt_receive_loot(loot_component)

	if operation_success == true:
		print("dawg")
		get_parent().queue_free()
