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
	tween_modulate(tween, main_sprite, color, entered_transition_time_seconds, entered_ease_type)

func _on_body_exited(body:Node2D):
	var color = Color(1.0, 1.0, 1.0, exited_opacity)

	if inside_controller and not is_inside(body, inside_controller.get_overlapping_bodies()):
		tween_modulate(tween, main_sprite, color, entered_transition_time_seconds, entered_ease_type)
	else:
		tween_modulate(tween, main_sprite, color, exited_transition_time_seconds, exited_ease_type)

func tween_modulate(tweener : Tween, sprite: Sprite2D, color : Color, time : float, ease_type: Tween.EaseType):
	if tween:
		tween.kill()
	
	tweener = create_tween()
	tweener.tween_property(sprite, "modulate", color, time).set_ease(ease_type)

func is_inside(body : Node2D, bodies : Array[Node2D]):
	for item in bodies:
		if item == body:
			return true
	
	return false
