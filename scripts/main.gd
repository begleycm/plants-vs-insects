extends Node

@onready var tile_map = $TileMap
@onready var start_mark = $start_m

const map = preload("res://scripts/Map_Creator.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	var map_creator = map.new()
	# Creates the map, recursively makes it until a path to the end is made
	while true:
		map_creator.create_map(tile_map, start_mark)
	
		await get_tree().create_timer(0.05).timeout
	
		print(map_creator.is_end_reachable())
		if map_creator.is_end_reachable():
			break
			
