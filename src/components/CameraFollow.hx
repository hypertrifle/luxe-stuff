package components;

import luxe.Component;
import luxe.Sprite;
import io.InputManager;


class CameraFollow extends Component {
	var sprite : Sprite;
    override function init() {
        //called when initialising the component
        sprite = cast entity;    }

    override function update(dt:Float) {
        //called every frame for you

        Luxe.camera.pos.x = sprite.pos.x - Luxe.screen.w/2;
    	Luxe.camera.pos.y = sprite.pos.y - Luxe.screen.h/2;

    }

    override function onreset() {
        //called when the scene starts or restarts
    }

}
