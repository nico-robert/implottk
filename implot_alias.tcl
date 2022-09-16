# Copyright (c) 2022 Nicolas ROBERT.
# Distributed under MIT license. Please see LICENSE for details.

cffi::alias define time_t ulong

cffi::Struct create ImPlotRange {
    Min double
    Max double
}

# callback implot
cffi::prototype function ImPlotLocator void {
    ticker         {pointer.ImPlotTicker unsafe}
    range          struct.ImPlotRange
    pixels         float
    vertical       int
    formatter      {pointer.ImPlotFormatter unsafe}
    formatter_data {pointer unsafe}
}

cffi::prototype function ImPlotFormatter int {
    value     double
    buff      string
    size      int
    user_data {pointer unsafe}
}

cffi::prototype function ImPlotTransform double {
    value     double
    user_data {pointer unsafe}
}