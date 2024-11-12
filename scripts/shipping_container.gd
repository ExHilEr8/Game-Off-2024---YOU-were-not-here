extends Node

@export var main_controller : Area2D
@export var inside_controller : Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if main_controller:
		main_controller.set_collision_mask_value(1, false)
		main_controller.set_collision_mask_value(2, true)
		main_controller.set_collision_mask_value(3, false)
		main_controller.set_collision_mask_value(4, false)
		main_controller.set_collision_mask_value(5, true)
		main_controller.set_collision_mask_value(6, true)
	
	if inside_controller:
		inside_controller.set_collision_mask_value(1, false)
		inside_controller.set_collision_mask_value(2, true)
		inside_controller.set_collision_mask_value(3, false)
		inside_controller.set_collision_mask_value(4, false)
		inside_controller.set_collision_mask_value(5, true)
		inside_controller.set_collision_mask_value(6, true)
