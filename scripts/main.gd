extends Node

@onready var tile_map = $TileMap
@onready var start_mark = $start_m

# Called when the node enters the scene tree for the first time.
func _ready():
	var map = Map_Creator.new(tile_map, start_mark)
	
	# Creates the map, recursively makes it until a path to the end is made
	while true:
		map.create_map()
	
		await get_tree().create_timer(0.1).timeout
		print(map.is_end_reachable())
		
		# If path is made, stop trying to make a new one
		if map.is_end_reachable():
			break
			
