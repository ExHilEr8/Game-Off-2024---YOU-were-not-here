extends Node
class_name Interactable

@export var interact_time: float = 1.0

signal interacted(interactor : Node)

func interact(interactor : Node):
	interacted.emit(interactor)
	print("interacted! :)")