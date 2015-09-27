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

import geometry.StencilWriteGeometry;

import phoenix.Shader;
import phoenix.Texture.FilterType;

import luxe.Input.MouseEvent;

import luxe.Rectangle;

import luxe.collision.shapes.*;
import luxe.collision.ShapeDrawerLuxe;








class PlayState extends State {

	var player:Avatar;
	var playerAnim : SpriteAnimation;
    var playerTexture:Sprite;
	var move_speed : Float = 0;

    var playerVision:SightLight;
    var walls:Array<Sprite> = new Array<luxe.Sprite>();

    var maskShader:Shader;

    public static var drawer: ShapeDrawerLuxe;
    public static var shapes: Array<Shape>;
    public static var rays: Array<Ray>;

    var layer1:Sprite;
    var layer2:Sprite;


	public function new(){
		 super({ name:'play' });

        drawer = new ShapeDrawerLuxe( );
        shapes = [];
        rays = [];



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

        /*for(n in 0...walls.length) {
            walls[n].shader = maskShader;
        }*/


	}//update

    function collisionUpdate(delta:Float){

    }

    override function onrender() {
        for(shape in shapes) drawer.drawShape(shape);
        for(ray in rays) drawer.drawLine(ray.start, ray.end);
    }
  
}//PlayState
