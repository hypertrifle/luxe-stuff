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
    var lastPosition: Vector = new Vector(0,0);

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
        var rel:Vector = Screen.toScreen(pos);
        var radians = Maths.radians((180/Math.PI) * Math.atan2(lastPosition.y  - rel.y, lastPosition.x - rel.x) - 90);
        _rotation_euler.z = radians;
        _rotation_quat.setFromEuler( _rotation_euler );

        entity.rotation = _rotation_quat.clone();


    }

        override public function onmousedown( event:MouseEvent ) {
        entity.events.fire('player.fire',{});
        entity.events.fire('player.hit.test',{shieldDamage:5, healthDamage:10});

        }
        /** override this to get notified when a mouse button is pressed. only called if overridden. */
         override public function onmouseup( event:MouseEvent ) {
        entity.events.fire('player.endfire',{});

         }


    override function onmousemove( event:MouseEvent ) {
        lastPosition = event.pos;

        //sprite.rotation_z = (180/Math.PI) * Math.atan2(event.pos.y  - (pos.y-Luxe.camera.pos.y), event.pos.x - (pos.x-Luxe.camera.pos.x)) + 90;
    	

	} //onmousemove



    override function onreset() {
        //called when the scene starts or restarts
    }

}
