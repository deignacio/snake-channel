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
    import com.litl.control.VerticalList;
    import com.litl.helpers.view.ViewBase;
    import com.litl.snake.model.GameModel;
    import com.litl.snake.model.Player;
    import com.litl.snake.view.ScoreItemRenderer;

    /**
     * a paused view that displays the scoreboard
     * <li>player name
     * <li>times they have crashed
     * <li>times their tail caused a crash
     */
    public class Scoreboard extends ViewBase implements IPausedView {
        private var model:GameModel;

        private var scoreList:VerticalList;
        private var scores:Array;

        public function Scoreboard(model:GameModel) {
            super();

            height = 500;
            width = 500;
            x = 25;
            y = 200;

            this.model = model;

            scoreList = new VerticalList();
            scoreList.itemRenderer = ScoreItemRenderer;
            scoreList.verticalScrollPolicy = "off";
            scoreList.itemSize = 50;
            scoreList.setSize(400, 350);
            scoreList.move(0, 0);
            addChild(scoreList);

            refresh();
        }

        /** @inheritDoc */
        public function refresh():void {
            scores = new Array();
            model.forEachPlayer(getScore);
            scores.sort(scoreComparator);
            scoreList.dataProvider = scores;
        }

        private function getScore(player:Player):void {
            var score:Object = {
                "name": "Player " + player.id,
                "crashCount": player.crashCount,
                "causedCount": player.causedCount
            };

            scores.push(score);
        }

        private function scoreComparator(scoreA:Object, scoreB:Object):int {
            var diffA:int = scoreA.caused - scoreA.crashes;
            var diffB:int = scoreB.caused - scoreB.crashes;
            if (diffA > diffB) {
                return -1;
            } else if (diffA == diffB) {
                if (scoreA.crashes > scoreB.crashes) {
                    return -1;
                } else if (scoreA.crashes == scoreB.crashes) {
                    return 0;
                } else {
                    return 1;
                }
            } else {
                return 1;
            }
        }
    }
}
