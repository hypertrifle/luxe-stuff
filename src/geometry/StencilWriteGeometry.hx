package geometry;

import phoenix.Vector;
import phoenix.geometry.QuadGeometry;
import phoenix.geometry.TextureCoord;
import phoenix.Batcher;
import phoenix.Vector;
import luxe.Log.*;
import snow.modules.opengl.GL;


import luxe.options.GeometryOptions.QuadGeometryOptions;

class StencilWriteGeometry extends QuadGeometry {

    public function new( ?options : QuadGeometryOptions ) {
        super( options);
    }

   
    /*override function draw() {
        //the buffer pos length is favoured because if dirty is not flagged,
        //and the vertices change, then the size of the buffers becomes inconsistent
        //with the draw call and Bad Things happen like memory corruption
        //GL.depthMask(true);
        //GL.drawArrays( primitive_type, 0, Std.int(buffer_pos.length/4) );
    }*/

}
