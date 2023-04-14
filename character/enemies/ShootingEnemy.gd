extends "res://character/enemies/Enemy.gd"

signal spawn_laser(EnemyLaser, location)

var EnemyLaser = preload("res://character/projectiles/EnemyLaser.tscn")

onready var muzzle = $Muzzle
onready var laserSound = $LaserSound

func _on_ShootTimer_timeout():
	emit_signal("spawn_laser", EnemyLaser, muzzle.global_position)
	laserSound.play()
