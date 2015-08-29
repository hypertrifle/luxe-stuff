
import io.InputManager.InputRemapper;
import luxe.Color;

import luxe.Parcel;
import luxe.ParcelProgress;
import luxe.States;
import luxe.Entity;
import luxe.Quaternion;
import luxe.Vector;
import luxe.utils.Maths;



class Main extends luxe.Game {

	public static var states:States;
	public static var controllers:Entity;

    override function ready() {
    	//fetch a list of assets to load from the json file
         var parcel = new Parcel({
            jsons:[ { id:'assets/playeranim.json' } ],
            textures : [
                { id: 'assets/avatar.png' }
            ],
            texts : [
                 { id: 'assets/test.ply' }
            ],
            shaders : [
                { id:'maskShader', frag_id:'assets/maskShader.glsl', vert_id:'default' }
]
        });

            //but, before we load it, we also want to
            //display a simple progress bar for the parcel,
            //this is a default one, you can create your own
        new ParcelProgress({
            parcel      : parcel,
            background  : new Color(1,1,1,0.85),
            oncomplete  : loaded
        });

            //go!
        parcel.load();
    } //ready

   

    function loaded(_){


    	states = new States({name:'states'});

        states.add(new states.PlayState());
        states.set('play');

     
    }

  
    override function update(dt:Float) {

    } //update



} //Main
