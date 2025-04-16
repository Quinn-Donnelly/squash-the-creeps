extends Label

var score = 0

func _on_mob_squahsed():
	score += 1
	text = "Score: %s" % score
