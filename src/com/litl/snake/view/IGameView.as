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
    import com.litl.helpers.view.ViewBase;
    import com.litl.snake.event.CrashSceneEvent;

    import flash.events.IEventDispatcher;

    /** dispatch this event when you start drawing a crash scene */
    [Event(name=CrashSceneEvent.BEGIN, type="com.litl.snake.event.CrashSceneEvent")]

    /** dispatch this event when your crash scene animation/tweens are done */
    [Event(name=CrashSceneEvent.END, type="com.litl.snake.event.CrashSceneEvent")]

    /** describes the interface for views that will be drawn by the game view manager */
    public interface IGameView extends IEventDispatcher {
        /** updates the game view to target this view base */
        function set view(value:ViewBase):void;

        /** clears/resets the display */
        function clear():void;

        /** draws an incremental move */
        function drawMove():void;

        /** draws the whole view */
        function refresh():void;

        /** begin any crash animations for this view */
        function drawCrash():void;
    }
}
