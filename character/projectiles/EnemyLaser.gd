extends "res://character/projectiles/Laser.gd"


func _on_EnemyLaser_area_entered(area):
	if area is Player:
		area.take_damage(damage)
		queue_free()
