package states;

import luxe.States;
import luxe.Color;

import phoenix.Texture;
import luxe.Vector;
import luxe.Mesh;

import luxe.Sprite;
import luxe.components.sprite.SpriteAnimation;
import luxe.components.render.MeshComponent;

import entities.SightLight;

import components.MouseAim;
import entities.Avatar;

import phoenix.geometry.Geometry;
import phoenix.geometry.QuadGeometry;

import geometry.TriangleFanGeometry;
import options.TriangleFanGeometryOptions;

import phoenix.Shader;
import phoenix.Texture.FilterType;

import luxe.Input.MouseEvent;

import luxe.Rectangle;








class PlayState extends State {

	var player:Avatar;
	var playerAnim : SpriteAnimation;
    var playerTexture:Sprite;
	var move_speed : Float = 0;

    var playerVision:SightLight;
    var walls:Array<Sprite> = new Array<luxe.Sprite>();

    var maskShader:Shader;


	public function new(){
		 super({ name:'play' });

        // create a bunch of random obstacles
        for(n in 0...100) {
            var w:Float = Luxe.utils.random.float(8, 128);
            var h:Float = Luxe.utils.random.float(8, 128);

            walls.push(new Sprite({
                geometry: Luxe.draw.box({
                    x: w / -2,
                    y: h / -2,
                    w: w,
                    h: h
                }),
                color: new Color(0.25, 0.25, 0.25, 1),
                pos: Luxe.utils.geometry.random_point_in_unit_circle().multiplyScalar(Luxe.screen.h *8).add(Luxe.screen.mid),
                depth: 0,
                rotation_z: Luxe.utils.random.float(0, 360)
            }));
        }

	}

	
	override function init(){
            
           player = new Avatar({
            name: 'player'
        });


           var playArea = new Sprite({
            geometry: Luxe.draw.box({
                    x: 0,
                    y: 0,
                    w: Luxe.screen.w *8,
                    h: Luxe.screen.h *8
                }),
            color: new Color(0.5, 0.25, 0.25, 0.7),
            pos: new Vector(0,0),
            depth: -1
           });

           Luxe.camera.bounds = new Rectangle(0,0,Luxe.screen.w *8,Luxe.screen.h *8);



	}//init

    override function onmousemove( event:MouseEvent ) {

    }

	override function update(delta:Float){
       // Luxe.camera.center = player.pos;
        super.update(delta);
        collisionUpdate( delta );

	}//update

    function collisionUpdate(delta:Float){

    }
  
}//PlayState
