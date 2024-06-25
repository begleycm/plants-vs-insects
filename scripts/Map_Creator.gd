extends Node2D
class_name Map_Creator

@export var map_length:int = 32
@export var map_height:int = 18

# Start and end locations for mobs
@export var start:Array = [-(map_length / 2), -(map_height / 2)]
@export var end:Array = [(map_length / 2) - 1, (map_height / 2) - 1]

# Defined here so we only have one nav at a time
var map_nav:NavigationAgent2D = NavigationAgent2D.new()

# Tile map to use for placing blocks in code
var tile_map:TileMap

# Start marker for where mobs spawn
var start_mark:Marker2D

# Constructor
func _init(tile_map:TileMap = null, start_mark:Marker2D = null):
	self.tile_map = tile_map
	self.start_mark = start_mark
	
# Called when the node enters the scene tree
func _ready():
	create_map()

func create_map() -> void:
	# Creates the base map of grass using length X width
	display_grass()

	# Layer 0 of the map has nav enabled, while others don't
	tile_map.set_layer_navigation_enabled(0, true)
	
	# Creates a random number and spawns blocks using that
	var rng:RandomNumberGenerator = RandomNumberGenerator.new()
	spawn_blocks(rng)
	
	# Sets the start and end block to a dirt block for visual aid
	tile_map.set_cell(0, Vector2i(start[0], start[1]), 0, Vector2i(3, 1))
	tile_map.set_cell(0, Vector2i(end[0], end[1]), 0, Vector2i(3, 1))
	
	# Spawns the start marker
	spawn_start()

func display_grass() -> void:
	for n in range(-map_length / 2, map_length / 2):
		for i in range(-map_height / 2, map_height / 2):
			tile_map.set_cell(0, Vector2i(n, i), 0, Vector2i(3, 0))

func spawn_blocks(rng:RandomNumberGenerator) -> void:
	# Spawns blocks equal to the grass divided by 4
	var amount_blocks:int = (map_height * map_length) / 4
	
	for i in range(0, amount_blocks):
		var rand_l:int = rng.randf_range((-map_length / 2) - 1, map_length / 2)
		var rand_h:int = rng.randf_range((-map_height / 2) - 1, map_height / 2)
		
		tile_map.set_cell(0, Vector2i(rand_l, rand_h), 0, Vector2i(6, 2))
			
func spawn_start() -> void:
	start_mark.position = Vector2i(start[0] * 16, start[1] * 16)

func is_end_reachable() -> bool:
	var vec:Vector2 = Vector2(end[0] * 16, end[1] * 16)
	map_nav.target_position = vec
	
	start_mark.add_child(map_nav)
	
	map_nav.debug_enabled = true
	
	return map_nav.is_target_reachable()
