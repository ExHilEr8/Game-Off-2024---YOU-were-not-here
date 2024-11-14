extends Node

@export_group("General")
@export var opacity_controller : OpacityController
@export var lootable_component : LootableComponent

@export_group("Sprites")
@export var crate : Sprite2D
@export var crate_open : Sprite2D
@export var crate_loot : Sprite2D


func _ready():
	lootable_component.looted.connect(_on_lootable_component_looted)

func _on_interactable_component_interacted(_interactor:Node):
	crate.queue_free()
	remove_tween_component_from_opacity_controller(crate)

	crate_loot.show()
	for node in crate.get_children():
		node.show()

	crate_open.show()

func _on_lootable_component_looted():
	remove_tween_component_from_opacity_controller(crate_loot)

func remove_tween_component_from_opacity_controller(parent : Node2D):
	var index = opacity_controller.outer_sprite_tweeners.find(parent.get_node("TweenComponent"))
	opacity_controller.outer_sprite_tweeners.remove_at(index)
