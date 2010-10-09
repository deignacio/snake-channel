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
    import com.litl.snake.enum.GameLoopStage;
    import com.litl.snake.enum.GameSpeed;

    import flash.events.TimerEvent;
    import flash.utils.Dictionary;
    import flash.utils.Timer;

    /**
     * The Game Loop is how the channel steps through the game, and where
     * all of the logic is run.  based on the delay specified by the speed
     * property, the game loop runs through the different stages of a turn,
     * as defined in GameLoopStage.  as IGameLoopMembers are added to the
     * game loop, the stages of the GameLoop that they participate in are
     * specified, and registered.  this in turn causes the member.onStage(stage)
     * to be executed.
     *
     * @see com.litl.snake.enum.GameLoopStage GameLoopStage
     */
    public class GameLoop {
        private var _speed:GameSpeed;
        private var timer:Timer;
        private var members:Dictionary;
        private var currentStage:String;

        public function GameLoop(speed:GameSpeed) {
            members = new Dictionary();

            timer = new Timer(0, 0);
            timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);

            this.speed = speed;
        }

        /** the rate of the game loop */
        public function get speed():GameSpeed {
            return _speed;
        }

        /** sets the rate of the game loop */
        public function set speed(value:GameSpeed):void {
            if (_speed != value) {
                _speed = value;

                timer.delay = _speed.delay;
            }
        }

        /** if the game loop is currently running */
        public function get running():Boolean {
            return timer.running;
        }

        public function pause():void {
            if (timer.running) {
                timer.stop();
            }
        }

        public function resume():void {
            if (!timer.running) {
                timer.start();
            }
        }

        /**
         * adds the IGameLoopMember to the game loop.
         *
         * this means that the member's appropriate stage
         * logic be executed, and that the member has the ability
         * to cause the game loop to skip/unskip stages
         */
        public function addMember(member:IGameLoopMember):void {
            var stages:Array = member.stages;
            var stage:String;
            for (var i:int = 0; i < stages.length; i++) {
                stage = stages[i];
                if (members[stage] == null) {
                    members[stage] = new Array();
                }

                var tier:Array = members[stage];
                if (tier.indexOf(member) == -1) {
                    tier.push(member);
                }
            }
        }

        /** run through the game loop members */
        protected function onTimer(e:TimerEvent):void {
            for (var i:int = 0; i < GameLoopStage.ALL_STAGES.length; i++) {
                currentStage = GameLoopStage.ALL_STAGES[i];
                var tier:Array = members[currentStage];
                if (tier != null) {
                    tier.forEach(onStage);
                }
            }
        }

        /** execute a member's logic for the current stage */
        protected function onStage(member:IGameLoopMember, index:int, arr:Array):void {
            member.onStage(currentStage);
        }
    }
}
