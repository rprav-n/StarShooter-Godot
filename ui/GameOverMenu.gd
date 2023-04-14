extends Control

onready var scoreLabel = $VBoxContainer/Score


func _on_RetryButton_pressed():
	get_tree().change_scene("res://World.tscn")

func _on_BackButton_pressed():
	get_tree().change_scene("res://ui/MainMenu.tscn")

func set_score(val):
	scoreLabel.text = "Score: %d" % val
