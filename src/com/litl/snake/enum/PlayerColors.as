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
    /** when drawing players, map these colors to player ids */
    public class PlayerColors {
        private static const COLORS:Array = [
            0xe50000, 0x0343df, 0x15b01a,
            0xffffff, 0x9AD7DB, 0xae7181,
            0xceb301, 0xf97306, 0xcae2fd,
            0xff028d, 0x029386, 0x650021,
            0x06c2ac, 0x7e1e9c, 0x89fe05,
            0xd1b26f, 0x06470c, 0xff028d
        ];

        /** return a player id's color */
        public static function getColor(playerId:int):uint {
            return COLORS[playerId % COLORS.length];
        }
    }
}
