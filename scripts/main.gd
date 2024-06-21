extends Node

@onready var tile_map = $Nav_Mesh/TileMap

const map = preload("res://scripts/Map_Creator.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	var map_creator = map.new()
	# Creates the map
	map_creator.create_map(tile_map)
