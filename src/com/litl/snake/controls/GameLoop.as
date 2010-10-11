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
    import com.litl.snake.event.SkipStageEvent;
    import com.litl.snake.view.PauseOverlay;

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
     * there are times however, where you might want to skip various stages
     * but not muck with starting and stopping the game loop.  for this reason
     * game loop members can dispatch SkipStageEvents.  this gives developers
     * the ability to isolate the game loop being paused/and unpaused only as
     * a result of a user interaction, and use SkipStageEvents to control times
     * when the game is actually doing some one-off/every once in a while
     * transition type of action.
     *
     * @see com.litl.snake.enum.GameLoopStage GameLoopStage
     * @see com.litl.snake.event.SkipStageEvent SkipStageEvent
     */
    public class GameLoop {
        private var _speed:GameSpeed;
        private var timer:Timer;
        private var members:Dictionary;
        private var currentStage:String;
        private var skipStages:Array;
        private var _pauseOverlay:PauseOverlay = null;

        public function GameLoop(speed:GameSpeed) {
            members = new Dictionary();
            skipStages = new Array();

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

        /**
         * a view to display when the game loop is paused
         *
         * @see com.litl.snake.view.PauseOverlay PauseOverlay
         */
        public function get pauseOverlay():PauseOverlay {
            return _pauseOverlay;
        }

        /**
         * sets the game loops pause overlay
         *
         * @see com.litl.snake.view.PauseOverlay PauseOverlay
         */
        public function set pauseOverlay(value:PauseOverlay):void {
            if (_pauseOverlay != value) {
                if (_pauseOverlay != null) {
                    _pauseOverlay.removeEventListener(TimerEvent.TIMER_COMPLETE, onUnpause);
                }

                _pauseOverlay = value;
                if (_pauseOverlay != null) {
                    _pauseOverlay.addEventListener(TimerEvent.TIMER_COMPLETE, onUnpause, false, 0, true);
                }
            }
        }

        /** if the game loop is currently running */
        public function get running():Boolean {
            return timer.running;
        }

        /** pause the game loop, shows the pause overlay */
        public function pause():void {
            if (timer.running) {
                timer.stop();
            }

            if (pauseOverlay != null) {
                pauseOverlay.pause();
            }
        }

        /** begin the pause overlay unpause countdown */
        public function resume():void {
            if (pauseOverlay != null) {
                pauseOverlay.unpause();
            } else if (!timer.running) {
                timer.start();
            }
        }

        /** restart the game loop when unpause is complete */
        protected function onUnpause(e:TimerEvent):void {
            timer.start();
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

            member.addEventListener(SkipStageEvent.SKIP_STAGE, onSkipStage, false, 0, true);
            member.addEventListener(SkipStageEvent.UNSKIP_STAGE, onUnskipStage, false, 0, true);
        }

        /** run through the game loop members */
        protected function onTimer(e:TimerEvent):void {
            for (var i:int = 0; i < GameLoopStage.ALL_STAGES.length; i++) {
                currentStage = GameLoopStage.ALL_STAGES[i];
                if (skipStages.indexOf(currentStage) != -1) {
                    continue;
                }

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

        /**
         * process the skip stage event
         *
         * NOTE:  skip/unskip stage events are not refcounted.  this means
         *     that 5 skips, and then 1 unskip results in an unskipped stage
         */
        protected function onSkipStage(e:SkipStageEvent):void {
            if (skipStages.indexOf(e.stage) == -1) {
                skipStages.push(e.stage);
            }
        }

        /**
         * process the unskip stage event
         *
         * NOTE:  skip/unskip stage events are not refcounted.  this means
         *     that 5 skips, and then 1 unskip results in an unskipped stage
         */
        protected function onUnskipStage(e:SkipStageEvent):void {
            var index:int = skipStages.indexOf(e.stage);
            if (index != -1) {
                skipStages.splice(index, 1);
            }
        }
    }
}
