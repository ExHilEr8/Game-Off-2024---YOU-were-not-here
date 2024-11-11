extends Node
class_name Lootbag

@export var loot_component : LootComponent

func instantiate_with_component(component : LootComponent) -> Lootbag:
    loot_component = component
    return self