# Example from implot_demo.cpp
# void Demo_AutoFittingData()

lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req implottk
catch {console show}

# set frame
set f [implottk::implotFrame .f1 -width 500 -height 400]

set xflags 0
set yflags [expr {512 | 1024}]

set xdata {}
set ydata {}

for {set i 0} {$i < 101} {incr i} {
    lappend xdata $i
    lappend ydata [expr {1 + sin($i / 10.0)}]

}

set xdata [implottk::doubleToPointer $xdata]
set ydata [implottk::doubleToPointer $ydata]

$f options -title "##DataFitting"

# add cmds 'Imgui' on the fly
$f addImGUICmds {
    imgui::BulletText "%s" {string "The Y-axis has been configured to auto-fit to only the data visible in X-axis range."}
    imgui::BulletText "%s" {string "Zoom and pan the X-axis. Disable Stems to see a difference in fit."}
    imgui::BulletText "%s" {string "If ImPlotAxisFlags_RangeFit is disabled, the axis will fit ALL data."}
    
    imgui::TextUnformatted "X: "
    imgui::SameLine
    imgui::CheckboxFlags_UintPtr "ImPlotAxisFlags_AutoFit##X"  ::xflags 512
    imgui::SameLine
    imgui::CheckboxFlags_UintPtr "ImPlotAxisFlags_RangeFit##X" ::xflags 1024
    
    imgui::TextUnformatted "Y: "
    imgui::SameLine
    imgui::CheckboxFlags_UintPtr "ImPlotAxisFlags_AutoFit##Y"  ::yflags 512
    imgui::SameLine
    imgui::CheckboxFlags_UintPtr "ImPlotAxisFlags_RangeFit##Y" ::yflags 1024
}

# add cmds 'Implot' on the fly
$f addLinePlotCmds {
    implot::SetupAxes "X" "Y" $::xflags $::yflags
    implot::SetupAxes "X" "Y" $::xflags $::yflags
    
    implot::PlotLine_doublePtrdoublePtr  "Line" $::xdata $::ydata 101
    implot::PlotStems_doublePtrdoublePtr "Stems" $::xdata $::ydata 101

}

pack .f1 -fill both -expand 1