# Example from implot_demo.cpp
# void Demo_LinePlots()

proc sincb {l t} {

    set xs2 {}
    set ys2 {}
    
    for {set i 0} {$i < $l} {incr i} {
        set x [expr {$i * 0.001}] 
        set y [expr {0.5 + 0.5 * sin(50 * ($x + $t / 10.))}]
        lappend xs2 $x
        lappend ys2 $y
    }
    
    return [list $xs2 $ys2]
}

proc funccb {l} {

    set xs2 {}
    set ys2 {}

    for {set i 0} {$i < $l} {incr i} {
        set x [expr {$i * (1 / 19.0)}] 
        set y [expr {$x * $x}]
        lappend xs2 $x
        lappend ys2 $y
    }
    
    return [list $xs2 $ys2]
}

lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req implottk
catch {console show}

# Set Tk frame
set f [implottk::implotFrame .f1 -width 500 -height 400]

# add options
$f options -fonts     {{C:\Windows\Fonts\segoeui.ttf} 16} \
           -color     {windowBackground {240 240 240} text {0 0 0}} \
           -colorPlot {legendBackground {240 240 240} frameBackground {240 240 240}} \
           -title "LinePlots"

# Transform list data to cffi::memory
lassign [funccb 20] dataX2 dataY2
set xs2 [implottk::doubleToPointer $dataX2]
set ys2 [implottk::doubleToPointer $dataY2]

# add cmds 'ImPlot' on the fly   
$f addLinePlotCmds {

    lassign [sincb 1001 [imgui::GetTime]] dataX dataY
    
    set xs [implottk::doubleToPointer $dataX]
    set ys [implottk::doubleToPointer $dataY]
    
    implot::SetupAxes x y
    
    implot::PlotLine_doublePtrdoublePtr "f(x)" $xs $ys 1001
    implot::SetNextMarkerStyle ImPlotMarker_Circle
    implot::PlotLine_doublePtrdoublePtr "g(x)" $::xs2 $::ys2 20 ImPlotLineFlags_Segments
}

# Map Tk Frame
pack .f1 -fill both -expand 1
