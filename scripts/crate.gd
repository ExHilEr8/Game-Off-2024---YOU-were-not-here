extends Node

@export var crate : Sprite2D
@export var crate_open : Sprite2D
@export var crate_loot : Sprite2D

func _on_interactable_component_interacted(_interactor:Node):
	crate.hide()
	
	for node in crate.get_children():
		crate.remove_child(node)
		node.queue_free() 

	crate_open.show()
	crate_loot.show()

	
