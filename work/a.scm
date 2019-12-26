(require 'javafx-defs)

(define-alias Canvas javafx.scene.canvas.Canvas)

(javafx-application)

(javafx-scene
 title: "Hello Canvas"
 width: 600 height: 450
 (let* ((canvas (Canvas
		 width: 600
		 height: 450))
	(gc (canvas:getGraphicsContext2D)))
   (gc:strokeLine 0 0 600 450)
   canvas))
