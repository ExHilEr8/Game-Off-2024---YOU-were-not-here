extends Node2D
class_name OpacityController

@export_group("General")
@export var outer_sprite_tweeners : Array[TweenComponent]
@export var inner_sprite_tweeners : Array[TweenComponent]
@export var behind_area : Area2D
@export var inside_area : Area2D

@export_group("Tween Values When Behind Object")
@export var entered_opacity : float = 0.2
@export var entered_transition_time_seconds : float = 0.1
@export var entered_ease_type : Tween.EaseType = Tween.EASE_OUT

@export_group("Tween Values When Exiting Behind Object")
@export var exited_opacity : float = 1
@export var exited_transition_time_seconds : float = 0.2
@export var exited_ease_type : Tween.EaseType = Tween.EASE_IN

@export_group("Tween Values for Outer Sprites When Inside Object")
@export var outer_opacity_when_inside : float = 0.0
@export var outer_opacity_when_inside_transition_time_seconds : float = 0.2
@export var outer_opacity_when_inside_ease_type : Tween.EaseType = Tween.EASE_OUT

@export_group("Tween Values for Inside Sprites When Inside Object")
@export var inner_opacity_when_inside : float = 1.0
@export var inner_opacity_when_inside_transition_time_seconds : float = 0.0
@export var inner_opacity_when_inside_ease_type : Tween.EaseType = Tween.EASE_IN

var inside_exited_buffer_timer : Timer

func _ready():
	inside_exited_buffer_timer = Timer.new()
	inside_exited_buffer_timer.one_shot = true
	inside_exited_buffer_timer.wait_time = exited_transition_time_seconds
	add_child(inside_exited_buffer_timer)

func _behind_area_on_body_entered(_body:Node2D):
	var color = Color(1.0, 1.0, 1.0, entered_opacity)

	for tweener in outer_sprite_tweeners:
		tweener.modulate(color, entered_transition_time_seconds, entered_ease_type)

func _behind_area_on_body_exited(_body:Node2D):
	var color = Color(1.0, 1.0, 1.0, exited_opacity)

	for tweener in outer_sprite_tweeners:
		tweener.modulate(color, exited_transition_time_seconds, exited_ease_type)

func _inside_area_on_body_entered(_body:Node2D):
	var outer_color = Color(1.0, 1.0, 1.0, outer_opacity_when_inside)
	var inner_color = Color(1.0, 1.0, 1.0, inner_opacity_when_inside)

	for tweener in outer_sprite_tweeners:
		tweener.modulate(outer_color, outer_opacity_when_inside_transition_time_seconds, outer_opacity_when_inside_ease_type)

	for tweener in inner_sprite_tweeners:
		tweener.modulate(inner_color, inner_opacity_when_inside_transition_time_seconds, inner_opacity_when_inside_ease_type)

func _inside_area_on_body_exited(_body:Node2D):
	var color = Color(1.0, 1.0, 1.0, exited_opacity)

	## If exiting and there is no other bodies (lootbags) in the area
	if contains_other_bodies(inside_area) == false:
		for tweener in outer_sprite_tweeners:
			tweener.modulate(color, exited_transition_time_seconds, exited_ease_type)
			tweener.tweener.finished.connect(_outside_sprite_tweeners_finished_after_inside_area_left)

func _outside_sprite_tweeners_finished_after_inside_area_left():
	# if player not in container anymore
	if not is_overlapping(get_tree().get_root().get_node("Player"), inside_area.get_overlapping_bodies()):
		hide_inside_sprites()

func show_inside_sprites():
	for tweener in inner_sprite_tweeners:
		tweener.modulate(Color(1.0, 1.0, 1.0, 1.0), 0.0, Tween.EASE_OUT)

func hide_inside_sprites():
	for tweener in inner_sprite_tweeners:
		tweener.modulate(Color(1.0, 1.0, 1.0, 0.0), 0.0, Tween.EASE_OUT)


func is_overlapping(body : Node2D, bodies : Array[Node2D]):
	for item in bodies:
		if item == body:
			return true
	
	return false

func contains_other_bodies(area : Area2D) -> bool:
	for body in area.get_overlapping_bodies():
		if body.is_in_group("Lootbags"):
			return true

	return false
