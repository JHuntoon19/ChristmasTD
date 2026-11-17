extends Enemy
#method called by animation player to start crawling animation again
func crawl():
	animation_player.play("Crawl")
	#method called from parent class to play hurt animation
func hitAnim():
	animation_player.play("Hurt")
