extends Control

var can_click: bool = false
var user_in := ""
var ans := ""
var choices := "rgbv"
var rounds := 3
var curr_round := 1

func make_random(n: int):
	ans = ""
	for i in range(n):
		ans += choices[randi_range(0, len(choices)-1)]

func next_round():
	rounds += 1
	if curr_round > rounds:
		pass # TODO add win!
	make_random(curr_round)

func start():
	make_random(1)
