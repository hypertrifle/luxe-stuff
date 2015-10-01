package states;

import luxe.States;
import luxe.Color;

import phoenix.Texture;
import phoenix.Batcher;
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

import physics.RectPhysics;

import luxe.tilemaps.Tilemap;

import luxe.importers.tiled.TiledMap;
import luxe.importers.tiled.TiledObjectGroup;









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

    //A hand made ortho Tilemap
    var small_tiles : Tilemap;



	public function new(){
		 super({ name:'play' });

        drawer = new ShapeDrawerLuxe( );
        shapes = [];
        rays = [];



        Luxe.physics.add_engine( RectPhysics );



	}

    function generate_tilemap() {
        var batcher:Batcher = Luxe.renderer.create_batcher({ name:'tilemap' });

            //random tile grid for foreground layer
        var small_tiles_grid = [
            [1+Std.random(70), 1+Std.random(70), 1+Std.random(70), 1+Std.random(70), 1+Std.random(70), 1+Std.random(70)],
            [1+Std.random(70), 1+Std.random(70), 1+Std.random(70), 1+Std.random(70), 1+Std.random(70), 1+Std.random(70)],
            [1+Std.random(70), 1+Std.random(70), 1+Std.random(70), 1+Std.random(70), 1+Std.random(70), 1+Std.random(70)],
            [1+Std.random(70), 1+Std.random(70), 1+Std.random(70), 1+Std.random(70), 1+Std.random(70), 1+Std.random(70)],
            [1+Std.random(70), 1+Std.random(70), 1+Std.random(70), 1+Std.random(70), 1+Std.random(70), 1+Std.random(70)],
            [1+Std.random(70), 1+Std.random(70), 1+Std.random(70), 1+Std.random(70), 1+Std.random(70), 1+Std.random(70)],
        ];

            //manually create ourselves an ortho tilemap
        small_tiles = new Tilemap({
                //world x/y position
            x           : 512,
            y           : 0,
                //tilemap width/height
            w           : 6,
            h           : 6,
                //tiles width/height
            tile_width  : 16,
            tile_height : 16,
                //orientation of map
            orientation : TilemapOrientation.ortho
        });

            //create a tileset for the map
        small_tiles.add_tileset({
            name:'tiles',
            texture:Luxe.resources.texture('assets/tileset.png'),
            tile_width: 16, tile_height: 16
        });

            //create some layers to add tiles in
            //note we add them out of order with the index, just for testing that
        small_tiles.add_layer({ name:'fg', layer:1, opacity:1, visible:true });
        small_tiles.add_layer({ name:'bg', layer:0, opacity:1, visible:true });
        small_tiles.add_layer({ name:'removed', layer:2, opacity:1, visible:true });

            //create them by filling the layer with a fixed id, in this case 21
        small_tiles.add_tiles_fill_by_id( 'bg', 21 );
        small_tiles.add_tiles_fill_by_id( 'removed', 2 );

            //create some tiles from a grid specified above
        small_tiles.add_tiles_from_grid( 'fg', small_tiles_grid );

            //before we display it, remove the "removed" layer so it's not there
        small_tiles.remove_layer('removed');

            //let's change a tile before we display it
        small_tiles.tile_at('fg', 0, 0).id = 1;

            //finally, tell it to display
        small_tiles.display({ scale:1, batcher:batcher, depth:2 });

            //and change a tile after we display it
        small_tiles.tile_at('fg', 1, 0).id = 1;
        small_tiles.tile_at('fg', 2, 0).id = 1;
        small_tiles.tile_at('fg', 3, 0).id = 1;
        small_tiles.tile_at('fg', 4, 0).id = 1;
        small_tiles.tile_at('fg', 5, 0).id = 1;

    } //generate_tilemap


	
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



           generate_tilemap();

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
