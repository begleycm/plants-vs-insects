extends Node

@onready var tile_map = $NavigationRegion2D/TileMap

const path = preload("PathCreator.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	var path_creator = path.new()
	path_creator.create_path(tile_map)
