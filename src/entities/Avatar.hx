package entities;

import luxe.Entity;
import luxe.Vector;
import phoenix.Texture.FilterType;
import phoenix.Texture;

import components.*;

import luxe.Vector;
import luxe.Rectangle;
import luxe.options.EntityOptions;

import io.InputManager;


typedef AvatarOptions = {

  >EntityOptions,

  @:optional var aim : MouseAim;
  @:optional var anim : MechAnimation;
  @:optional var movement : TopdownMovement;
  @:optional var camera : CameraFollow;
}

typedef DeathEvent = {
  @:optional var enemy:Int;
}


class Avatar extends Entity {


  @:isVar public var aim (default, default): MouseAim = new MouseAim({ name:'mouse'});

  @:isVar public var anim (default, default): MechAnimation = new MechAnimation({ name:'anim' });

  @:isVar public var movement (default, default): TopdownMovement = new TopdownMovement({ name:'movement' });
  @:isVar public var camera (default, default): CameraFollow = new CameraFollow({ name:'camera' });


  public function new(options:AvatarOptions) {

    if(options.aim != null) {
      aim = new MouseAim(options.aim);
    }
    if(options.movement != null) {
      movement = new TopdownMovement(options.movement);
    }


     if(options.anim != null) {
      anim = new MechAnimation(options.anim);
    }
    
    if(options.camera != null) {
      camera = new CameraFollow(options.camera);
    }

   // options.size = ;



    super( options );
  }



  override function init(){
  	
    if(aim != null){
        add(aim);
    }
    if(movement != null){
        add(movement);
    }
    if(camera != null){
        add(camera);
    }

    if(camera != null){
        add(anim);
    }

    add(new KeepInBounds({name:"keepinbounds"}));

    add(new SimpleGun( {name:"gun1"}));

    add(new Resources({name:"resources"}));

    //event listeners

    this.events.listen("player.die", die);


  }//init


  override function update(dt:Float){
  	super.update(dt);




  }//update

  function die(death:DeathEvent){
    trace( "Death");
  }

}//Avatar
