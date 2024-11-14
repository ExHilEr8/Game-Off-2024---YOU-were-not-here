extends Node
class_name TweenComponent

var tweener : Tween
var sprite : Sprite2D

func _ready():
	var parent = get_parent()

	if parent is Sprite2D:
		sprite = parent
	
	tweener = create_tween()

func modulate(color: Color, time: float, ease_type: Tween.EaseType, kill_tweener : bool = true):
	if tweener and kill_tweener:
		tweener.kill()

	tweener = create_tween()
	tweener.tween_property(sprite, "modulate", color, time).set_ease(ease_type)