extends Node

@export var crate : Sprite2D
@export var crate_open : Sprite2D
@export var crate_loot : Sprite2D

func _on_interactable_component_interacted(_interactor:Node):
	if is_instance_valid(crate):
		crate.hide()
		
		for node in crate.get_children():
			crate.remove_child(node)
			node.queue_free() 

	if is_instance_valid(crate_open):
		crate_open.show()

	if is_instance_valid(crate_loot):
		crate_loot.show()

		for node in crate.get_children():
			node.show()