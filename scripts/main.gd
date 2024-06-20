extends Node

@export var path_tile:PackedScene

@export var map_length:int = 64
@export var map_height:int = 36
@onready var tile_map = $NavigationRegion2D/TileMap

var _pg:PathGenerator

# Called when the node enters the scene tree for the first time.
func _ready():
	_pg = PathGenerator.new(map_length, map_height)
	print(_pg.generate_path())
	display_grass()

func _display_path():
	var _path:Array[Vector2i] = _pg.generate_path()
	print(_path)
	
	# Places a dirt block
	tile_map.set_cell(0, Vector2i(0, 0), 0, (Vector2i(3, 1)))
	
func display_grass():
	# Places grass in the length x height(ex 16x9)
	for n in range (-map_length / 2, map_length / 2):
		for i in range (-map_height / 2, map_height / 2):
			tile_map.set_cell(0, Vector2i(n, i), 0, (Vector2i(3, 0)))
