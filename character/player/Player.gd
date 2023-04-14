extends Area2D
class_name Player

signal spawn_laser(PlayerLaser, location)
signal player_took_damage(hp_left)
signal player_died(location)

export (int) var speed = 300
export (int) var hp = 3
export (int) var damage = 1

var input_vector = Vector2.ZERO

var PlayerLaser = preload("res://character/projectiles/PlayerLaser.tscn")
onready var hitSound = $HitSound
onready var laserSound = $LaserSound

onready var muzzle = $Muzzle

func _process(delta):
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	position += input_vector * speed * delta
	
	position.x = clamp(position.x, 0, 540)
	position.y = clamp(position.y, 0, 960)
	
	if Input.is_action_just_pressed("shoot"):
		shoot_laser()

func shoot_laser():
	emit_signal("spawn_laser", PlayerLaser, muzzle.global_position)
	laserSound.play()

func _on_Player_area_entered(area):
	if area.is_in_group("enemies"):
		take_damage(damage)

func take_damage(_damage):
	hp -= _damage
	hitSound.play()
	emit_signal("player_took_damage", hp)
	if hp <= 0:
		queue_free()
		emit_signal("player_died", position)
	
