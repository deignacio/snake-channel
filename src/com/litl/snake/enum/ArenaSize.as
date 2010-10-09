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
    public class ArenaSize {
        /** large.  ~6pixel players at 1280x800 */
        public static const LARGE:ArenaSize = new ArenaSize("large", 133, 213);

        /** medium. ~8pixel players at 1280x800 */
        public static const MEDIUM:ArenaSize = new ArenaSize("medium", 90, 144);

        /** small.  ~16pixel players at 1280x800 */
        public static const SMALL:ArenaSize = new ArenaSize("small", 50, 80);

        public static const ALL_SIZES:Array = [ LARGE, MEDIUM, SMALL ];

        /** the name of the size */
        public var name:String;

        /** the rows/height dimension */
        public var rows:int;

        /** cols/width of the arena */
        public var cols:int;

        /** a convenient precalculation of the number of spots in the arena */
        public var numSpots:int;

        public function ArenaSize(name:String, rows:int, cols:int) {
            this.name = name;
            this.rows = rows;
            this.cols = cols;
            this.numSpots = rows * cols;
        }

        /** converts to string, mostly used for the options list */
        public function toString():String {
            return name;
        }
    }
}
