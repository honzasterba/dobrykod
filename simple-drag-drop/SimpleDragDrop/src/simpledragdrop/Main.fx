package simpledragdrop;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.layout.VBox;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import java.util.Random;
import javafx.scene.Group;
import javafx.scene.CustomNode;
import javafx.scene.Node;

def TITLE = "Simple Drag&Drop";
var r = new Random();

var header = Text {
    font: Font {
        size: 20
    }
    x: 10,
    y: 30
    content: TITLE
};

// aktuálně tažený element
var dragged: Draggable;

class Draggable extends CustomNode {
    var startingContainer: Container;
    var container : Container on replace {
        if (container == null and startingContainer != null) {
            container = startingContainer;
        }
    };
    var drag = false;
    var rect = Rectangle {
        width: 80
        height: 30
        fill: randomColor()
    }
    override function create() {
            rect
        }
    function randomColor() : Color {
            Color.rgb(r.nextInt(255), r.nextInt(255), r.nextInt(255))
        }
    override var onMouseDragged = function(e) {
        if (not drag) {
            drag = true;
            delete this from container.nodes;
            dragged = this;
            // napozicovat element "pod myš"
            rect.x = e.sceneX - e.x;
            rect.y = e.sceneY - e.y;
            startingContainer = container;
        }
        // posunout element o relativní posun myši
        translateX = e.dragX;
        translateY = e.dragY;
    }
    override var onMouseReleased = function (e) {
        if (drag) {
            drag = false;
            // všechno se vrátí do původního stavu
            translateX = 0;
            translateY = 0;
            rect.x = 0;
            rect.y = 0;
            dragged = null;
            insert this into container.nodes;
        }
    }
    override var opacity = bind if (drag) 0.6 else 1
}

class Container extends CustomNode {
    var list: Group = Group {}
    var nodes: Node[] on replace {
        var t = 0;
        for (node in nodes) {
            node.translateY = t;
            t += node.layoutBounds.height + 10;
        }
        list.content = nodes;
    }
    override function create() {
        Group {
            content: [
                Rectangle {
                    x: bind list.boundsInParent.minX - 5
                    y: bind list.boundsInParent.minY - 5
                    width: bind list.boundsInParent.width + 10
                    height: bind list.boundsInParent.height + 10
                    fill: bind if (hover and dragged != null) Color.GREEN else Color.YELLOW
                },
                list
            ]
        }
    }
    override var onMouseEntered = function(e) {
        // já jsem teď tvůj nový container
        dragged.container = this;
    }
    override var onMouseExited = function(e) {
        // zapomeň na mě, vrať se odkud si přišel
        dragged.container = null;
    }
}

var container1 = Container {
    translateX: 10
    translateY: 50
}
container1.nodes = [
    Draggable { container: container1 },
    Draggable { container: container1 },
    Draggable { container: container1 },
    Draggable { container: container1 }
];
var container2 = Container {
    translateX: 150
    translateY: 50
}
container2.nodes = [
    Draggable { container: container2 },
    Draggable { container: container2 },
    Draggable { container: container2 }
];

Stage {
    title: TITLE
    scene: Scene {
        width: 240
        height: 320
        content: [
            header,
            container1,
            container2,
            Group {
                // zobrazuje aktuálně tažený element
                content: bind [dragged]
            }
        ]
    }
}