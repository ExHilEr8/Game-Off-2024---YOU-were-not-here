extends Area2D

@export_group("General")
@export var sprite : Sprite2D

@export_group("Entered")
@export var entered_opacity : float = 0.2
@export var entered_time : float = 0.1
@export var entered_ease_type: Tween.EaseType = Tween.EASE_OUT

@export_group("Exited")
@export var exited_opacity : float = 1
@export var exited_time : float = 0.2
@export var exited_ease_type: Tween.EaseType = Tween.EASE_IN

var tween

func _on_body_entered(body:Node2D):
	var color = Color(1.0, 1.0, 1.0, entered_opacity)
	tween_modulate(body, color, entered_time, entered_ease_type)


func _on_body_exited(body:Node2D):
	var color = Color(1.0, 1.0, 1.0, exited_opacity)
	tween_modulate(body, color, exited_time, exited_ease_type)


func tween_modulate(body : Node2D, color : Color, time : float, ease_type: Tween.EaseType):
	var index = 0
	var bodies = get_overlapping_bodies()

	for item in bodies:
		if body == item:
			bodies.remove_at(index)
			break
		
		index += 1

	if bodies.size() == 0:
		tween = create_tween()
		tween.tween_property(sprite, "modulate", color, time).set_ease(ease_type)
	
