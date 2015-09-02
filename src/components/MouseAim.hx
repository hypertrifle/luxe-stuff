package components;

import luxe.Component;
import luxe.Input.MouseEvent;
import luxe.options.ComponentOptions;
import phoenix.Quaternion;
import luxe.utils.Maths;

import luxe.Sprite;
import luxe.Vector;

import util.Screen;

class MouseAim extends Component {

    var _rotation_euler : Vector;
    var _rotation_quat : Quaternion;

    override public function new(options:ComponentOptions) {
        _rotation_euler = new Vector();
        _rotation_quat = new Quaternion();


     super(options);   
    }



    override function init() {
        //called when initialising the component
    }

    override function update(dt:Float) {

    	//calculate angle from screen mouse, to center of avatar, rotate to look. 



        //called every frame for you
    }

    override function onmousemove( event:MouseEvent ) {

    	var mousepos = event.pos;

    	var rel:Vector = Screen.toScreen(pos);

        var radians = Maths.radians((180/Math.PI) * Math.atan2(event.pos.y  - rel.y, event.pos.x - rel.x) - 90);
        _rotation_euler.z = radians;
        _rotation_quat.setFromEuler( _rotation_euler );

        entity.rotation = _rotation_quat.clone();

        //sprite.rotation_z = (180/Math.PI) * Math.atan2(event.pos.y  - (pos.y-Luxe.camera.pos.y), event.pos.x - (pos.x-Luxe.camera.pos.x)) + 90;
    	

	} //onmousemove

    override function onreset() {
        //called when the scene starts or restarts
    }

}
