package com.litl.snake.view {
    import com.litl.helpers.view.ViewBase;

    /**
     * Extend the PausedViewBase class for views that are intended
     * to be shown as a child of the PauseOverlay.  Be sure to override
     * the refresh method, as it will be called before the overlay
     * is shown each time.
     *
     * @see com.litl.turfwar.view.PauseOverlay
     */
    public interface IPausedView {
        /**
         * called by the pause overlay before adding this
         * object to it's view.  meant to update
         * any data or displays that might have changed
         * since the last time it was shown.
         */
        function refresh():void;
    }
}
