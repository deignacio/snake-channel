/* Copyright (c) 2010 litl, LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to
* deal in the Software without restriction, including without limitation the
* rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
* sell copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
* IN THE SOFTWARE.
*/
package com.litl.snake.view {
    import flash.display.Shape;

    /** this is a convenience class to make it simple to
     * draw the repetetive player shape.
     */
    public class PlayerShape extends Shape {
        public static const PLAYER_TAIL_RATIO:Number = 0.5;

        private var _id:int;
        private var _x:Number;
        private var _y:Number;

        /** the player's color */
        public var color:uint;

        /** the size of the player's sprite */
        public var radius:Number;

        public function PlayerShape(id:int,
                                    color:uint = 0,
                                    x:Number = 0, y:Number = 0,
                                    radius:Number = 0) {
            super();
            _id = id;
            this.color = color;
            _x = x;
            _y = y;
            this.radius = radius;

            redraw();
        }

        /** the player's id */
        public function get id():int {
            return _id;
        }

        override public function get x():Number {
            return _x;
        }

        override public function set x(value:Number):void {
            _x = value;
        }

        override public function get y():Number {
            return _y;
        }

        override public function set y(value:Number):void {
            _y = value;
        }

        /** updates the shape to new color, size, position */
        public function redraw():void {
            graphics.clear();
            graphics.beginFill(color);
            graphics.drawCircle(x, y, radius);
            graphics.endFill();
        }

        /** creates an identical player shape, but tail sized. */
        public function makeTailShape():PlayerShape {
            return new PlayerShape(id, color, x, y, radius * PLAYER_TAIL_RATIO);
        }
    }
}
