extends Area2D

@export_group("General")
@export var opposite_area : Area2D
@export var main_sprite : Sprite2D
@export var opposite_sprite : Sprite2D
@export var is_inside : bool = false

@export_group("Entered")
@export var entered_opacity : float = 0.2
@export var entered_time : float = 0.1
@export var entered_ease_type: Tween.EaseType = Tween.EASE_OUT

@export_group("Exited")
@export var exited_opacity : float = 1
@export var exited_time : float = 0.2
@export var exited_ease_type: Tween.EaseType = Tween.EASE_IN

var tween : Tween

func _on_body_entered(body:Node2D):
	var color = Color(1.0, 1.0, 1.0, entered_opacity)

	## when entering an "outside" sprite
	if is_inside == false:
		tween_modulate(main_sprite, body, color, entered_time, entered_ease_type)

		if opposite_sprite:
			tween_modulate(opposite_sprite, body, Color(1.0, 1.0, 1.0, 0.0), exited_time, entered_ease_type)

	## when entering an "inside" sprite
	if is_inside == true:

		## show inside sprite immediately
		tween_modulate(opposite_sprite, body, Color(1.0, 1.0, 1.0, 1.0), 0, entered_ease_type)

		## tween outside sprite to invisible
		tween_modulate(main_sprite, body, Color(1.0, 1.0, 1.0, 0), exited_time, entered_ease_type)


func _on_body_exited(body:Node2D):
	var color = Color(1.0, 1.0, 1.0, exited_opacity)

	for item in opposite_area.get_overlapping_bodies():
		if body == item and body.is_in_group("Player"):
			opposite_area.tween.kill()

	tween_modulate(main_sprite, body, color, exited_time, exited_ease_type)

func tween_modulate(sprite: Sprite2D, _body : Node2D, color : Color, time : float, ease_type: Tween.EaseType):
	tween = create_tween()
	tween.tween_property(sprite, "modulate", color, time).set_ease(ease_type)

func has_bodies_after_exit(body : Node2D):
	var index = 0
	var bodies = get_overlapping_bodies()

	for item in bodies:
		if body == item:
			bodies.remove_at(index)
			break
		
		index += 1

	if bodies.size() == 0:
		return false
	
	return true
