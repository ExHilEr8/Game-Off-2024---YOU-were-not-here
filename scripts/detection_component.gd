extends Area2D
class_name DetectionComponent


@export var detection_curve : Curve
@export var collision_polygon : CollisionPolygon2D
@export var detection_area_size : int = 100

var detected : bool = false
var current_detection : float = 0 :
	get: return current_detection
	set(value):
		current_detection = clamp(value, 0.0, 100.0)

signal player_detected

func _ready():
	var polygon = collision_polygon.polygon
	var offset = polygon[1] - polygon[0]

	polygon[3] *= detection_area_size

	## The math here acts as if this shape is a triangle, but we actually want it to be a trapezoid for pixel snapping and design reasons.
	##  This requires us to use an offset (picture the top vertice of a triangle), where we draw the sides of the trapezoid
	##  (lines AD and BC), where A and B overlap and then you shift line BC away from the overlap to get a trapezoid shape.
	polygon[2] -= offset
	polygon[2] *= detection_area_size
	polygon[2] += offset

	collision_polygon.polygon = polygon

	print(offset)

func _physics_process(delta):
	if get_tree():
		var player = get_tree().get_root().get_node("Node").get_node("Player")

		if player in get_overlapping_bodies():
			var distance = (player.global_position - self.global_position).length() / detection_area_size
			var distance_normalized = clamp(distance, 0.0, 1.0)

			current_detection = detection_curve.sample(distance_normalized)
			print(current_detection)
		

func on_player_detect():
	player_detected.emit()

