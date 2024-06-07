class_name Bullet

extends CharacterBody2D

@export var damage :float = 1
@export var speed  :float = 1
@export var pierce :float = 1
@export var size   :float = 1
@export var direction: Vector2
var OnHitList: Array[BaseBulletOnHit]

signal hit_enemy

func _ready():
	velocity = speed * direction
	for effect in OnHitList:
		effect.on_attach(self)

func _process(delta):
	
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)

	if collision:
		hit_enemy.emit()
		for effect in OnHitList:
			effect.effect(self)

