extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


@onready var inv: Inventory = preload("res://scripts/inventory/Inventory.tres")

@onready var pickupArea: Area2D = get_node("PickUpArea")
@onready var areashape: CollisionShape2D = pickupArea.get_child(0)

func _ready():
	pickupArea.collision_mask = 2

func GetCloser(a: Node2D, b: Node2D) -> bool:
	return global_position.distance_squared_to(a.global_position) < global_position.distance_squared_to(b.global_position)


func GetClosestBody() -> Node2D:
	var bodies = pickupArea.get_overlapping_bodies()
	if bodies.size() == 0:
		return null
	bodies.sort_custom(GetCloser)
	return bodies[0]
	


func _process(delta) -> void:
#Pickup
	if Input.is_action_pressed("interact"):
		#We preobably don't need a check since the mask is #2
		var body :Node2D = GetClosestBody()
		if body != null:
			print("picked up!", body.name)
			inv.AddItem(body.item)#NOT CORRECT ARGUMENT
			print(inv.items)
			body.queue_free()


	if Input.is_action_just_pressed("click"):
		var bullet = preload("res://scenes/bullet.tscn").instantiate()
		get_parent().add_child(bullet)


		
func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	#print(direction)
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	
	move_and_slide()
