package simpledragdrop;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.layout.VBox;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import java.util.Random;

def TITLE = "Simple Drag&Drop";
var r = new Random();

var header = Text {
    font : Font {
        size : 20
    }
    x: 10, y: 30
    content: TITLE
};

function randomColor() : Color {
    Color.rgb(r.nextInt(255), r.nextInt(255), r.nextInt(255))
}


function createRect() : Rectangle {
    Rectangle {
        width: 80
        height: 30
        fill: randomColor()
    }
}

var container1 = VBox {
    spacing: 10
    translateX: 10
    translateY: 50
    content: [
        createRect(), createRect(), createRect()
    ]
}
var container2 = VBox {
    spacing: 10
    translateX: 150
    translateY: 50
    content: [
        createRect(), createRect()
    ]
}

Stage {
    title: TITLE
    scene: Scene {
        width: 240
        height: 320
        content: [
            header,
            container1,
            container2
        ]
    }
}