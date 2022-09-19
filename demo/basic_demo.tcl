proc gettercb {l} {

    set xs2 {}
    set ys2 {}

    for {set i 0} {$i < $l} {incr i} {
        set x [expr {$i * 0.1}] 
        set y [expr {$x * $x}]
        lappend xs2 $x
        lappend ys2 $y
    }
    
    return [list $xs2 $ys2]
}

# test plot line with options.
lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req implottk

catch {console show}

set len 100000
lassign [gettercb $len] xsdata ysdata

set f [implottk::implotFrame .f1 -width 500 -height 400]

# Configure options line serie
$f options -title     "Demo_LinePlots" \
           -axisName  {x y}

# Add serie
$f series 1 -dataX $xsdata \
            -dataY $ysdata \
            -lineStyle {color {255 0 0}} \
            -name "Line 1"

pack .f1 -fill both -expand 1
