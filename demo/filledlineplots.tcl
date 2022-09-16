# Example from implot_demo.cpp
# void Demo_FilledLinePlots()

proc RandomRange {args} {

    set num [expr {rand()}]
    
	lassign $args lower upper
	set range [expr {$upper - $lower}]
    
	return [expr {int($num * $range) + $lower}]
}

lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req implottk

catch {console show}

set f [implottk::implotFrame .f1 -width 500 -height 400]

# configure options
$f options -fonts     {{C:\Windows\Fonts\segoeui.ttf} 16} \
           -color     {windowBackground {240 240 240} text {0 0 0}} \
           -colorPlot {legendBackground {240 240 240} frameBackground {240 240 240}} \
           -title     "filledlineplots"

set show_lines 1
set show_fills 1
set shade_mode 0
set fill_ref 0

# add cmds 'Imgui' on the fly
$f addImGUICmds {
    imgui::Checkbox "Lines" ::show_lines ; imgui::SameLine 0 5
    imgui::Checkbox "Fills" ::show_fills

    if {$::show_fills} {
        imgui::SameLine 0 5
        imgui::RadioButton_IntPtr "To -INF" ::shade_mode 0
        imgui::SameLine 0 5
        imgui::RadioButton_IntPtr "To +INF" ::shade_mode 1
        imgui::SameLine 0 5
        imgui::RadioButton_IntPtr "To Ref" ::shade_mode 2
        if {$::shade_mode == 2} {
            imgui::SameLine 0 5
            imgui::SetNextItemWidth 100
            imgui::DragFloat "##Ref" ::fill_ref 1 -100 500
        }
    }
}

for {set i 0} {$i < 101} {incr i} {
    lappend xs1 $i
    lappend ys1 [RandomRange 400 450]
    lappend ys2 [RandomRange 275 350]
    lappend ys3 [RandomRange 150 225]
}

set xs1 [implottk::doubleToPointer $xs1]
set ys1 [implottk::doubleToPointer $ys1]
set ys2 [implottk::doubleToPointer $ys2]
set ys3 [implottk::doubleToPointer $ys3]

# add cmds 'Implot' on the fly
$f addLinePlotCmds {

    implot::SetupAxes "Days" "Price"
    implot::SetupAxesLimits 0 100 0 500
    
    if {$::shade_mode == 0} {
        set yref -Inf
    } elseif {$::shade_mode == 1} {
        set yref Inf
    } else {
        set yref $::fill_ref
    }
    
    if {$::show_fills} {
        implot::PushStyleVar_Float ImPlotStyleVar_FillAlpha 0.25
        implot::PlotShaded_doublePtrdoublePtrInt "Stock 1" $::xs1 $::ys1 101 $yref
        implot::PlotShaded_doublePtrdoublePtrInt "Stock 2" $::xs1 $::ys2 101 $yref
        implot::PlotShaded_doublePtrdoublePtrInt "Stock 3" $::xs1 $::ys3 101 $yref
        implot::PopStyleVar
    }
    
    if {$::show_lines} {
        implot::PlotLine_doublePtrdoublePtr "Stock 1" $::xs1 $::ys1 101
        implot::PlotLine_doublePtrdoublePtr "Stock 2" $::xs1 $::ys2 101
        implot::PlotLine_doublePtrdoublePtr "Stock 3" $::xs1 $::ys3 101
    }

}

# Map Tk Frame
pack .f1 -fill both -expand 1
