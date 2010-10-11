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
package com.litl.snake.controls {
    import com.litl.snake.event.SkipStageEvent;

    import flash.events.IEventDispatcher;

    /**
     * emit this event if you want the game loop to skip a certain stage
     * for a while.  think about if you have a long crash tween or
     * start up sequence
     *
     * use this for game state transitions that are not triggered explicitly
     * by a user request to pause the game loop.  that way you don't get
     * stuck managing a game that randomly or unexpectedly pauses or starts.
     */
    [Event(type=SkipStageEvent.SKIP_STAGE, name="com.litl.snake.event.SkipStageEvent")]

    /**
     * when you're done doing whatever you needed to do while skipping that
     * stage, undo it w/unskip stage
     *
     * use this for game state transitions that are not triggered explicitly
     * by a user request to pause the game loop.  that way you don't get
     * stuck managing a game that randomly or unexpectedly pauses or starts.
     */
    [Event(type=SkipStageEvent.UNSKIP_STAGE, name="com.litl.snake.event.SkipStageEvent")]

    /**
     * specifies the interface for an object to participate in the game loop
     */
    public interface IGameLoopMember extends IEventDispatcher {
        /** stages that this game loop member participates in */
        function get stages():Array;

        /** the method called during a certain stage in the main loop. */
        function onStage(stage:String):void;
    }
}
