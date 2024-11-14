extends Node2D
var mfirst_names:Array[String] = [
	"John", "Bob", "Ian", "Jake",
	"George", "Edward", "James", "Jules",
	"Paul", "Jude", "Isaiah", "Mike",
	"Ringo", "Robert", "Ron", "Jeff",
	"Virgil", "Dante", "Ned", "Philip",
	"Tom", "Zach", "Dexter", "Wally"
]
var ffirst_names:Array[String] = [
	"Jane", "Janet", "Julie", "Beth", "Cassandra",
	"Patricia", "Molly", "Serena", "Sarah", "Alexis",
	"Debra", "Stephanie", "Domino", "Octopussy", "Natalie",
	"Marie", "Gwen", "Victoria", "Felicia", "Sophia",
	"Karen", "Kaye", "Isobel", "Chealsea", "Francheska"
	]
var last_names:Array[String] = [
	"Doe", "Bond", "Palmer", "Smith", "Park",
	"Anderson", "Andrews", "Connors", "Lee",
	"Schaffer", "Hudson", "Sullivan", "Harper",
	"Rivers", "Richards", "Turner", "Buckley", "Moss",
	"Morrison", "Motley", "Greenwood", "Ward", "Gibbs"
]

func get_random_name(gender: int) -> String:
	'''
	0 for male
	1 for female
	'''
	if gender == 0:
		return mfirst_names.pick_random() + " " + last_names.pick_random()
	else:
		return ffirst_names.pick_random() + " " + last_names.pick_random()
	
