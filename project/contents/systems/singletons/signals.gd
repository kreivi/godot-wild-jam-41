## Global signals.
extends Node

## Informs when player turns rudder
signal rudder_turned(new_value)
## Informs when player adjust sail
signal sail_adjusted(new_value)


## Add item to player inventory gui
signal on_trade_initiated(player, post)
