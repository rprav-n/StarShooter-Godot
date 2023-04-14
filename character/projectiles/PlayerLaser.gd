extends "res://character/projectiles/Laser.gd"


func _on_PlayerLaser_area_entered(area):
	if area.is_in_group("enemies"):
		area.take_damage(damage)
		queue_free()
