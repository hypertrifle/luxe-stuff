package components;

import luxe.Component;
import luxe.Input.MouseEvent;

import luxe.Sprite;
import luxe.Vector;

import util.Screen;

class MouseAim extends Component {

	var sprite : Sprite;

    override function init() {
        //called when initialising the component
        sprite = cast entity;
    }

    override function update(dt:Float) {

    	//calculate angle from screen mouse, to center of avatar, rotate to look. 



        //called every frame for you
    }

    override function onmousemove( event:MouseEvent ) {

    	var mousepos = event.pos;

    	//sprite.pos = event.pos;


        //sprite.rotation_z = (180/Math.PI) * Math.atan2(event.pos.y  - Luxe.screen.height/2, event.pos.x - Luxe.screen.width/2) + 90;
    	var rel:Vector = Screen.toScreen(pos);

        sprite.rotation_z = (180/Math.PI) * Math.atan2(event.pos.y  - rel.y, event.pos.x - rel.x) + 90;
        //sprite.rotation_z = (180/Math.PI) * Math.atan2(event.pos.y  - (pos.y-Luxe.camera.pos.y), event.pos.x - (pos.x-Luxe.camera.pos.x)) + 90;
    	

	} //onmousemove

    override function onreset() {
        //called when the scene starts or restarts
    }

}
