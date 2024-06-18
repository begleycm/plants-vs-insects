class_name InvItem
extends Resource

enum TypeOfItem {consumable, buff}

@export var name: String = ""
@export var texture: Texture2D 
@export var count: int = 0
@export var max_count: int

@export var effect: Resource = null

@export var type: TypeOfItem
