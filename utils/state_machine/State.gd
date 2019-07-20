"""
This is the interface for all States. This class doesn't do anything except
define the methods that all state must implement.
"""
extends Node
#warning-ignore-all:unused_argument

#warning-ignore:unused_signal
signal finished(next_state)

func enter(controller): # having access to the attached player can be useful, for certain states
	return

func exit():
	return

func handle_input(event):
	return

func update(delta):
	return
