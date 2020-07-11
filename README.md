# Defold Metrics
Calculate and display performance metrics in Defold games.


# Installation
You can use Defold Metrics in your own project by adding this project as a [Defold library dependency](http://www.defold.com/manuals/libraries/). Open your game.project file and in the dependencies field under project add:

	https://github.com/britzl/defold-metrics/archive/master.zip

Or point to the ZIP file of a [specific release](https://github.com/britzl/defold-metrics/releases).


# Usage
* In your game.project settings, go to Dependencies,and add https://github.com/britzl/defold-metrics/archive/master.zip.
* In the outline in your scene, right-click and "Add Game Object File" and choose "/metrics/fps.go"

Demo: https://britzl.github.io/Metrics/


## FPS
The FPS counter uses socket.gettime() to get an accurate timestamp and calculates an average FPS based on a sequence of samples. The FPS counter can be used in several ways:

1. Using fps.go() - Draw FPS counter at game object world position using draw text
2. Using fps.script - Draw FPS counter at game object world position using draw text
3. Using fps.lua - Draw FPS counter at specified position or get current FPS


### fps.create(samples)
Create an instance of the FPS counter

**PARAMETERS**
* `samples` (number) - Optional sample count. This is the number of samples required before the module will calculate FPS. Defaults to 60.

**RETURNS**
* `instance` (table) - An FPS counter instance


### fps.update()
Call this once per frame. Once enough samples have been collected it is possible to call fps() to get the current FPS.


### fps.fps()
Get the current FPS, based on collected samples.

**RETURNS**
* `fps` (number) - The calculated FPS


### fps.draw(format, position, color)
Draw fps count text using `draw_debug_text`.

**PARAMETERS**
* `format` (string) - Optional format to draw FPS in. Defaults to "FPS %.2f"
* `position` (string) - Optional position to draw FPS at. Defaults to v3(10, 20, 0)
* `color` (string) - Optional color to use when drawing FPS text. Defaults to v4(0,0,1,1)
