package components;

import luxe.Component;
import luxe.Sprite;
import io.InputManager;


class CameraFollow extends Component {

    override function init() {

           }

    override function update(dt:Float) {
        //called every frame for you

        Luxe.camera.pos.x = entity.pos.x - Luxe.screen.w/2;
    	Luxe.camera.pos.y = entity.pos.y - Luxe.screen.h/2;

    }

    override function onreset() {
        //called when the scene starts or restarts
    }

}
