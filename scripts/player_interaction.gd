extends Area2D

var interactables : Array[Interactable]

func _physics_process(_delta):
	if is_interacting() == true:	
		var interactable = determine_interactable()

		if interactable:
			interactable.interact()

func _on_area_entered(area:Area2D):
	interactables.append(area)

func _on_area_exited(area:Area2D):
	var exited_interactable_index = interactables.find(area)

	if exited_interactable_index != -1:
		interactables.remove_at(exited_interactable_index)

func determine_interactable() -> Interactable:
	if interactables.size() == 0:
		return null
		
	return interactables[0]

func is_interacting() -> bool:
	if Input.is_action_pressed("interact") == true:
		return true

	return false