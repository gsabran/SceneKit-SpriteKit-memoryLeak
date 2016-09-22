This repo reproduces an important memory leak.

Conditions:
- on iOS 10
- on a real device that supports Metal
- use a SKScene as texture content on a SCNNode
- use Metal to render the SCNView

Issue:
- the SCNView is kept alive by the SKScene
- consequently all the parent views and everything strongly attached to them is kept alive

Test:
- run the project
- you can toogle between Metal and openGL in the SCNView settings in the storyboard
- set the SCNView to use Metal
- if you present/dismiss the Scene a couple of time, you will see that the number of SKScene alived that is logged increases
- set the SCNView to use OpenGL (and read the note below)
- present/dismiss as before, you'll see that the logs look fine

Notes:
- on iOS 10, SceneKit fails to render a node that uses a SKScene with openGL, so when you set things to use openGL, you'll just see a white page. This is a seperate issue.
