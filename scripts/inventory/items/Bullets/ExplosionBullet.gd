class_name ExplosionBullet
extends BaseBulletOnHit

func on_attach(_bullet: Bullet):
  pass

func on_hit(bullet: Bullet):
  var aoe = Area2D.new()
  aoe.collision_layer = bullet.collision_layer
  aoe.collision_mask = bullet.collision_mask

  var collisionshape = CollisionShape2D.new()
  collisionshape.shape = CircleShape2D
  aoe.add_child(collisionshape)
  
  bullet.add_child(aoe)
  
  for body in aoe.get_overlapping_bodies():
    print("Explosion hit!")

  pass