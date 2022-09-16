# Copyright (c) 2022 Nicolas ROBERT.
# Distributed under MIT license. Please see LICENSE for details.

namespace eval ::implottk {}

proc ::implottk::rgbaToVec4 {rgb {a 255}} {
    # Transform rgb colors to struct.ImVec4 format.
    #
    # rgb - list colors rgb
    # a   - alpha state
    #
    # Returns A struct.ImVec4
    set rgba [linsert $rgb end $a]

    foreach value {x y z w} color $rgba {
        lappend vec4 $value [expr {$color / double(255)}]
    }
    
    return $vec4
}

proc ::implottk::arrayToFloat {data} {
    # Transform list data to cffi array float.
    #
    # data - list
    #
    # Returns A pointer
    set len [llength $data]
    return [cffi::memory new float\[$len\] $data]
}

proc ::implottk::doubleToPointer {data} {
    # Transform list data to cffi array double.
    #
    # data - list
    #
    # Returns A pointer.double
    set len [llength $data]
    return [cffi::memory new double\[$len\] $data ::implot::double]
}