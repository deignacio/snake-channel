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
package {
    import com.litl.helpers.channel.BaseChannel;
    import com.litl.helpers.view.ViewBase;
    import com.litl.sdk.enum.View;
    import com.litl.sdk.message.InitializeMessage;
    import com.litl.sdk.message.UserInputMessage;
    import com.litl.snake.controls.GameLoop;
    import com.litl.snake.enum.GameSpeed;
    import com.litl.snake.model.GameModel;
    import com.litl.snake.view.CardView;
    import com.litl.snake.view.GameViewManager;
    import com.litl.snake.view.OptionsView;
    import com.litl.snake.view.PauseOverlay;
    import com.litl.snake.view.Scoreboard;

    public class SnakeChannel extends BaseChannel {
        public static const CHANNEL_ID:String = "snake-channel";
        public static const CHANNEL_TITLE:String = "Snakes!";
        public static const CHANNEL_VERSION:String = "1.0";
        public static const CHANNEL_HAS_OPTIONS:Boolean = false;

        protected var gameLoop:GameLoop;
        protected var model:GameModel;
        protected var viewManager:GameViewManager;
        protected var pauseOverlay:PauseOverlay;

        public function SnakeChannel() {
            super();
        }

        /** @inheritDoc */
        override protected function setup():void {
            gameLoop = new GameLoop(GameSpeed.NORMAL);

            model = new GameModel(service);
            gameLoop.addMember(model);

            viewManager = new GameViewManager(model);
            gameLoop.addMember(viewManager);

            pauseOverlay = new PauseOverlay();
            gameLoop.pauseOverlay = pauseOverlay;
        }

        /** @inheritDoc */
        override protected function registerViews():void {
            var cardView:ViewBase = new CardView();
            views[View.CARD] = cardView;

            pauseOverlay.disableDimForViews([cardView]);

            var focusView:ViewBase = new ViewBase();
            views[View.FOCUS] = focusView;

            var channelView:ViewBase = new ViewBase();
            views[View.CHANNEL] = channelView;

            var optionsView:OptionsView = new OptionsView(gameLoop, model);
            pauseOverlay.addChildForViews(optionsView, [focusView]);

            var scoreboard:Scoreboard = new Scoreboard(model);
            pauseOverlay.addChildForViews(scoreboard, [focusView, channelView]);
        }

        /** @inheritDoc */
        override protected function connectToService():void {
            service.connect(CHANNEL_ID, CHANNEL_TITLE, CHANNEL_VERSION, CHANNEL_HAS_OPTIONS);
        }

        /**
         * sets the title, and hides the card view arrows
         *
         * @inheritDoc
         */
        override protected function handleInitialize(e:InitializeMessage):void {
            service.channelTitle = CHANNEL_TITLE;
            service.channelItemCount = 1;
        }

        /**
         * toggles pause/unpause of the gameloop
         *
         * @inheritDoc
         */
        override protected function handleGoReleased(e:UserInputMessage):void {
            if (gameLoop.running) {
                gameLoop.pause();
            } else {
                gameLoop.resume();
            }
        }

        /** @inheritDoc */
        override protected function onViewChanged(newView:String, newDetails:String, viewWidth:Number=0, viewHeight:Number=0):void {
            pauseOverlay.view = currentView;

            if (newView != View.CARD) {
                viewManager.view = currentView;
            }

            gameLoop.pause();
        }
    }
}
