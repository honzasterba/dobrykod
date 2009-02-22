package backgroudfill;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.Node;
import javafx.scene.input.KeyCode;
import javafx.scene.shape.Rectangle;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.text.Text;

var nodes: Node[] = [
    Text {
        content: "Nahoru/dolů přidá/odebere element."
        y: 20
        wrappingWidth: 200
    }
];
var box: VBox;
def MARGIN = 5;

Stage {
    title: "Background Fill"
    scene: Scene {
        width: 240
        height: 320
        content: [
            Rectangle {
                x: bind box.boundsInParent.minX - MARGIN
                y: bind box.boundsInParent.minY - MARGIN
                width: bind box.boundsInParent.width + MARGIN*2
                height: bind box.boundsInParent.height + MARGIN*2
                fill: Color.RED
            },
            box = VBox {
                content: bind nodes
                spacing: 2*MARGIN
                translateX: MARGIN // Odsazení od kraje
                translateY: MARGIN // Odsazení od kraje
                onKeyPressed: function(e) {
                    if (e.code == KeyCode.VK_UP) {
                        insert
                        Rectangle {
                            width: 50
                            height: 50
                            fill: Color.GREEN
                        } into nodes;
                    }
                    if (e.code == KeyCode.VK_DOWN) {
                        if (sizeof(nodes) > 0) {
                            delete nodes[0] from nodes;
                        }
                    }
                }
            }
        ]
    }
}

box.requestFocus();