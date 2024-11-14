extends Node

@export var behind_area : Area2D
@export var inside_area : Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if behind_area:
		behind_area.set_collision_mask_value(1, false)
		behind_area.set_collision_mask_value(2, true)
		behind_area.set_collision_mask_value(3, false)
		behind_area.set_collision_mask_value(4, false)
		behind_area.set_collision_mask_value(5, true)
		behind_area.set_collision_mask_value(6, false)
	
	if inside_area:
		inside_area.set_collision_mask_value(1, false)
		inside_area.set_collision_mask_value(2, true)
		inside_area.set_collision_mask_value(3, false)
		inside_area.set_collision_mask_value(4, false)
		inside_area.set_collision_mask_value(5, true)
		inside_area.set_collision_mask_value(6, false)
