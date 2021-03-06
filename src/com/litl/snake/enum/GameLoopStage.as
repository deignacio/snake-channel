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
    /**
     * specifies the different stages of a game loop turn.
     *
     * @see com.litl.snake.controls.GameLoop GameLoop
     * @see com.litl.snake.event.SkipStageEvent SkipStageEvent
     */
    public class GameLoopStage {
        /** any logic that involves moving players around */
        public static const MOVE:String = "move";

        /** put your viz/drawing code in this stage */
        public static const DRAW:String = "draw";

        /** clean up any state or reset stuff here */
        public static const CLEANUP:String = "cleanup";

        /** all of the stages, in order of execution */
        public static const ALL_STAGES:Array = [
            MOVE,
            DRAW,
            CLEANUP
        ];
    }
}
