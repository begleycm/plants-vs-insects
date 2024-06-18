extends Node

@export var path_tile:PackedScene

@export var map_length:int = 16
@export var map_height:int = 9
@onready var tile_map = $NavigationRegion2D/TileMap

var _pg:PathGenerator

# Called when the node enters the scene tree for the first time.
func _ready():
	_pg = PathGenerator.new(map_length, map_height)
	print(_pg.generate_path())
	_display_path()

func _display_path():
	var _path:Array[Vector2i] = _pg.generate_path()
	print(_path)
	# Places a dirt block
	tile_map.set_cell(0, Vector2i(0, 0), 0, (Vector2i(3, 1)))
