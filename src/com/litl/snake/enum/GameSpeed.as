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
package com.litl.snake.enum {
    /** specifies the time interval between game loop iterations/turns */
    public class GameSpeed {
        /** FAST:  40 turns per second */
        public static const FAST:GameSpeed = new GameSpeed("fast", 25);

        /** NORMAL:  20 turns per second */
        public static const NORMAL:GameSpeed = new GameSpeed("normal", 50);

        /** SLOW:  10 turns per second */
        public static const SLOW:GameSpeed = new GameSpeed("slow", 100);

        /** an array of all speeds */
        public static const ALL_SPEEDS:Array = [ FAST, NORMAL, SLOW ];

        /** name */
        public var name:String;

        /** the delay in ms between game loop turns */
        public var delay:int;

        public function GameSpeed(name:String, delay:int) {
            this.name = name;
            this.delay = delay;
        }

        /** to string.  mostly used for the options view list */
        public function toString():String {
            return name;
        }
    }
}
