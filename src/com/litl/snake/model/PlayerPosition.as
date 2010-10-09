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
package com.litl.snake.model {
    /** represents the player's position in the arena */
    public class PlayerPosition {
        private var _x:int;
        private var _y:int;

        public function PlayerPosition(x:int = -1, y:int = -1) {
            _x = x;
            _y = y;
        }

        /** the x coordinate of the position in the arena */
        public function get x():int {
            return _x;
        }

        /** sets the x coordinate of the position in the arena */
        public function set x(value:int):void {
            _x = value;
        }

        /** the y coordinate of the position in the arena */
        public function get y():int {
            return _y;
        }

        /** sets the y coordinate of the position in the arena */
        public function set y(value:int):void {
            _y = value;
        }

        public function toString():String {
            return "("+_x+","+_y+")";
        }
    }
}
