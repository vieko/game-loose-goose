extends Node

# Constants
const Modes = { WALK = "walk", POOP = "poop", HOVER = "hover" }
const Groups = { DAMAGEABLES =  "damageables" }

# Variables
var startHealth: int = 3
var walkingSpeed: float = 80
var cameraSpeed: float = 200

# Signals
signal on_player_health_changed(health)
