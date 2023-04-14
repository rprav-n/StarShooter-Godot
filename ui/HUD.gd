extends Control

onready var scoreLabel = $ScoreLabel
onready var livesTexture = $LivesTexture

func update_score(val):
	scoreLabel.text = "Score: %d" % val

func update_lives(val):
	livesTexture.rect_size.x = val * 37
