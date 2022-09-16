# Example from implot_demo.cpp
# void Demo_ShadedPlots()

proc RandomRange {args} {

    set num [expr {rand()}]
    
	lassign $args lower upper
	set range [expr {$upper - $lower}]
    
	return [expr {double($num * $range) + $lower}]
}

lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req implottk

catch {console show}

# set frame
set f [implottk::implotFrame .f1 -width 500 -height 400]

# add options
$f options -fonts     {{C:\Windows\Fonts\segoeui.ttf} 16} \
           -color     {windowBackground {240 240 240} text {0 0 0}} \
           -colorPlot {legendBackground {240 240 240} frameBackground {240 240 240}} \
           -title "Shaded Plots"


set alpha 0.25

# add cmds 'Imgui' on the fly
$f addImGUICmds {
    imgui::DragFloat "Alpha" ::alpha 0.01 0 1
}

set len 1001

for {set i 0} {$i < $len} {incr i} {
    set xs  [expr {$i * 0.001}]
    set ys  [expr {0.25 + 0.25 * sin(25 * $xs) * sin(5 * $xs) + [RandomRange -0.01 0.01]}]
    
    lappend lxs $xs
    lappend lys $ys
    
    lappend ys1 [expr {$ys + [RandomRange 0.1 0.12]}]
    lappend ys2 [expr {$ys - [RandomRange 0.1 0.12]}]
    lappend ys3 [expr {0.75 + 0.2 * sin(25 * $xs)}]
    lappend ys4 [expr {0.75 + 0.1 * sin(25 * $xs)}]
}

# Transform data list Tcl to cffi memory.
set xs  [implottk::doubleToPointer $lxs]
set ys  [implottk::doubleToPointer $lys]
set ys1 [implottk::doubleToPointer $ys1]
set ys2 [implottk::doubleToPointer $ys2]
set ys3 [implottk::doubleToPointer $ys3]
set ys4 [implottk::doubleToPointer $ys4]

# add cmds 'Implot' on the fly
$f addLinePlotCmds {

    implot::PushStyleVar_Float ImPlotStyleVar_FillAlpha $::alpha
    implot::PlotShaded_doublePtrdoublePtrdoublePtr "Uncertain Data" $::xs $::ys1 $::ys2 $::len
    implot::PlotLine_doublePtrdoublePtr "Uncertain Data" $::xs $::ys $::len
    implot::PlotShaded_doublePtrdoublePtrdoublePtr "Overlapping" $::xs $::ys3 $::ys4 $::len
    implot::PlotLine_doublePtrdoublePtr "Overlapping" $::xs $::ys3 $::len
    implot::PlotLine_doublePtrdoublePtr "Overlapping" $::xs $::ys4 $::len
    implot::PopStyleVar

}

# Map Tk Frame
pack .f1 -fill both -expand 1