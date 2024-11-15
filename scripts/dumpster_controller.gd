extends Node2D
class_name DumpsterController

@export_category("General")
@export var interactable : Interactable

@export_category("Sprites")
@export var dumpster_open_sprite : Sprite2D
@export var dumpster_closed_sprite : Sprite2D
@export var dumpster_full_sprite : Sprite2D

var current_sprite
var is_full : bool = false

func _ready():
	interactable.interacted.connect(dumpster_interacted)
	current_sprite = dumpster_open_sprite

func dumpster_interacted(_interactor):
	if current_sprite == dumpster_open_sprite or current_sprite == dumpster_full_sprite:
		current_sprite = dumpster_closed_sprite

	elif is_full == true and current_sprite == dumpster_closed_sprite:
			current_sprite = dumpster_full_sprite

	else:
		current_sprite = dumpster_open_sprite

	refresh_sprite()

func refresh_sprite():
	dumpster_open_sprite.hide()
	dumpster_closed_sprite.hide()
	dumpster_full_sprite.hide()

	current_sprite.show()


## TODO
var body_bag

func deposit_body_bag():
	pass