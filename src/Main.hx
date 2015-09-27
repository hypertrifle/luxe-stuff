
import io.InputManager.InputRemapper;
import luxe.Color;

import luxe.Parcel;
import luxe.Text;
import luxe.ParcelProgress;
import luxe.States;
import luxe.Entity;
import luxe.Quaternion;
import luxe.Vector;
import luxe.utils.Maths;
import luxe.Input;


//mint stuff 
import mint.Control;
import mint.types.Types;
import mint.render.luxe.LuxeMintRender;
import mint.render.luxe.Convert;
import mint.layout.margins.Margins;

import phoenix.Batcher;
import phoenix.Camera;





class Main extends luxe.Game {


    @:isVar public var hud_batcher(default, null):Batcher;
    public var hud_camera:Camera;



    public static var disp : Text;
    //public static var canvas: mint.Canvas;
    //public static var rendering: LuxeMintRender;
    //public static var layout: Margins;



    public static var states:States;
    public static var controllers:Entity;


    override function config(config:luxe.AppConfig) {

            //if you have errors about the window being created,
            //lower this to 2, or 0. it can also be 8
        config.render.antialiasing = 4;

        return config;

    } //config



    override function ready() {
        //mint hook-ups
        Luxe.renderer.clear_color.rgb(0x121219);



        //create a hud camera
        hud_camera = new Camera({
            camera_name: 'hud_camera',
        });


        for(b in Luxe.renderer.batchers){
            if(b.name == 'hud_batcher'){
                trace('found hud_batcher');
                hud_batcher = b;
            }
        }
        if(hud_batcher == null){
            trace('couldnt find hud_batcher' );
            hud_batcher = Luxe.renderer.create_batcher({
                name : 'hud_batcher',
                layer : 5,
                no_add : false,
                camera: hud_camera,
            });
        }

        //create a renderer with are cameras batcher.
        //rendering = new LuxeMintRender({batcher:hud_batcher});
        
        //layout = new Margins();

        /*canvas = new mint.Canvas({
            name:'canvas',
            rendering: rendering,
            
            options: { color:new Color(1,1,1,0.0) },
            x: 0, y:0, w: Luxe.screen.w, h: Luxe.screen.h
        });*/





    	//fetch a list of assets to load from the json file
         var parcel = new Parcel({
            jsons:[ { id:'assets/playeranim.json' } ],
            textures : [
                { id: 'assets/avatar.png' },
                { id: 'assets/head-guns.png' },
                { id: 'assets/feet.png' },
                { id: 'assets/testlayer1.png' },
                { id: 'assets/testlayer2.png' }
            ],
            sounds : [
                {id: 'assets/gun.wav', name: "gun.fire", is_stream:false}
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
        //states.add(new states.MenuState());
        states.set('menu');

     
    }

   /* public function clearUI() {
         canvas.destroy_children();
    }

  
    override function update(dt:Float) {
         //canvas.update(dt);
    } //update

    override function onrender() {

       // canvas.render();

    }

    override function onmousemove(e) {

        canvas.mousemove( Convert.mouse_event(e) );
    } //onmousemove

    override function onmousewheel(e) {
        canvas.mousewheel( Convert.mouse_event(e) );
    }

    override function onmouseup(e) {
        canvas.mouseup( Convert.mouse_event(e) );
    }

    override function onmousedown(e) {
        canvas.mousedown( Convert.mouse_event(e) );
    }

    override function onkeydown(e:luxe.Input.KeyEvent) {
        canvas.keydown( Convert.key_event(e) );
    }

    override function ontextinput(e:luxe.Input.TextEvent) {
        canvas.textinput( Convert.text_event(e) );
    }*/

    override function onkeyup(e:luxe.Input.KeyEvent) {

        //canvas.keyup( Convert.key_event(e) );

        if(e.keycode == Key.escape) {
            if(states.current_state.name == "menu"){
                Luxe.shutdown();
            } else {
                trace("settings state to menu");
                states.set("menu");
            }
        }

    } //onkeyup





} //Main
