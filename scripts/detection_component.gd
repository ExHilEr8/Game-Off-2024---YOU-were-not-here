extends Area2D
class_name DetectionComponent

@export_group("General")
@export var collision_polygon : CollisionPolygon2D
@export var progress_bar : ProgressBar

@export_group("Detection Parameters")
@export var detection_curve : Curve
@export var detection_area_size : int = 100
@export var detection_buffer_frames : int = 20
@export var detection_buffer_frames_reset_time_seconds : int = 3
@export var detection_decay_per_frame : float = 0.75
@export var detection_multiplier : float = 3.5

var player
var detected : bool = false

var current_buffer_frames : int = 0 :
	get: return current_buffer_frames
	set(value):
		current_buffer_frames = clamp(value, 0, detection_buffer_frames)
		
var current_detection : float = 0 :
	get: return current_detection
	set(value):
		current_detection = clamp(value, 0.0, 100.0)


signal player_detected

func _ready():
	player = get_tree().get_root().get_node("Node").get_node("Player")
	self.body_exited.connect(_on_body_exited)

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


func _physics_process(delta):
	progress_bar.value = current_detection

	if player not in get_overlapping_bodies():
		current_detection -= detection_decay_per_frame

	else:
		if current_buffer_frames < detection_buffer_frames:
			current_buffer_frames += 1

		else:
			var distance = (self.global_position - player.global_position).length() / detection_area_size
			current_detection += detection_curve.sample(clamp(distance, 0.0, 1.0)) * detection_multiplier
		
		if current_detection == 100:
			player_detected.emit()
	
	print(current_detection)
	

func _on_body_exited(body : Node2D):
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = detection_buffer_frames_reset_time_seconds
	timer.start()
	await timer.timeout

	if player not in get_overlapping_bodies():
		current_buffer_frames = 0
