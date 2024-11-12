extends OpacityController
class_name OpacityInsideController

@export_group("General")
@export var inside_sprite : Sprite2D
@export var sprite_controller : Area2D

func _on_body_entered(_body:Node2D):
	var color = Color(1.0, 1.0, 1.0, 1.0)
	tween_modulate(self, inside_sprite, color, 0, entered_ease_type)
	tween_modulate(sprite_controller, main_sprite, Color(1.0, 1.0, 1.0, 0.0), entered_transition_time_seconds, entered_ease_type)

func _on_body_exited(body:Node2D):
	var color = Color(1.0, 1.0, 1.0, 0.0)

	if contains_other_bodies() == false:
		tween_modulate(self, inside_sprite, color, exited_transition_time_seconds, exited_ease_type)

		if not is_inside(body, sprite_controller.get_overlapping_bodies()):
			tween_modulate(sprite_controller, main_sprite, Color(1.0, 1.0, 1.0, 1.0), exited_transition_time_seconds, exited_ease_type)

