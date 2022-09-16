# Copyright (c) 2022 Nicolas ROBERT.
# Distributed under MIT license. Please see LICENSE for details.

namespace eval ::implottk {}

proc ::implottk::cbFuncPlot {data idx pPoint} {
    upvar 1 coords values ; # values is list in caller's context. Could be global also.
    
    lassign [lindex $values $idx] x y; # Co-ords of idx'th point
    cffi::pointer safe $pPoint;
    ImPlotPoint tonative $pPoint [list x $x y $y]
    cffi::pointer dispose $pPoint
    
    return $pPoint
}

proc ::implottk::dataLine {num options} {

    if {[dict exists $options -name]} {
        set name [dict get $options -name]
    } else {
        set name $num
    }

    if {[dict exists $options -dataX] && ![dict exists $options -dataY]} {
        error "'-dataY' key should be set when '-dataX' is present..."
    }
    
    if {![dict exists $options -dataX] && [dict exists $options -dataY]} {
        error "'-dataX' key should be set when '-dataY' is present..."
    }
    
    if {[dict exists $options -dataX] && [dict exists $options -dataY]} {
        set dataX [dict get $options -dataX]
        set dataY [dict get $options -dataY]
        
        if {[llength $dataX] != [llength $dataY]} {
            error "length '-dataX' should be equal to length '-dataY'..."
        }
        
        set xs [implottk::doubleToPointer $dataX]
        set ys [implottk::doubleToPointer $dataY]
                
        set cmdplot [list implot::PlotLine_doublePtrdoublePtr $name $xs $ys [llength $dataX]]
        
    }
    
    if {[dict exists $options -data]} {
        # not supported yet
        error "not implanted... yet use -dataX -dataY flags"
        
        set data [dict get $options -data]
            
        if {[llength $data] != 2} {
            
        }
    }
    
    return $cmdplot
}