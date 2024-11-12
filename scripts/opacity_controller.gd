extends Area2D 
class_name OpacityController

@export_group("General")
@export var main_sprite : Sprite2D
@export var inside_controller : Area2D

@export_group("Entered")
@export var entered_opacity : float = 0.2
@export var entered_transition_time_seconds : float = 0.1
@export var entered_ease_type: Tween.EaseType = Tween.EASE_OUT

@export_group("Exited")
@export var exited_opacity : float = 1
@export var exited_transition_time_seconds : float = 0.2
@export var exited_ease_type: Tween.EaseType = Tween.EASE_IN

var tween : Tween

func _on_body_entered(_body:Node2D):
	var color = Color(1.0, 1.0, 1.0, entered_opacity)
	tween_modulate(self, main_sprite, color, entered_transition_time_seconds, entered_ease_type)

func _on_body_exited(body:Node2D):
	var color = Color(1.0, 1.0, 1.0, exited_opacity)

	if contains_other_bodies() == false:
		## Required to ensure that exiting the inside area into the "behind" area doesnt overwrite itself
		if inside_controller:
			if not is_inside(body, inside_controller.get_overlapping_bodies()):
				tween_modulate(self, main_sprite, color, entered_transition_time_seconds, entered_ease_type)
		else:
			tween_modulate(self, main_sprite, color, exited_transition_time_seconds, exited_ease_type)

func tween_modulate(opacity_controller : OpacityController, sprite: Sprite2D, color : Color, time : float, ease_type: Tween.EaseType):
	if opacity_controller.tween:
		opacity_controller.tween.kill()

	opacity_controller.tween = create_tween()
	opacity_controller.tween.tween_property(sprite, "modulate", color, time).set_ease(ease_type)

func is_inside(body : Node2D, bodies : Array[Node2D]):
	for item in bodies:
		if item == body:
			return true
	
	return false

func contains_other_bodies() -> bool:
	for body in get_overlapping_bodies():
		if body.is_in_group("Lootbags"):
			return true

	return false
