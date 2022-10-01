lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req implottk
catch {console show}

set f [implottk::implotFrame .f1 -width 500 -height 400]

set x_data {}
set y_data1 {}
set y_data2 {}
set y_data3 {}
set sampling_freq 44100
set freq 500

for {set i 0} {$i < 512} {incr i} {
    set t [expr {$i / double($sampling_freq)}]
    lappend x_data $t
    set arg [expr {2 * 3.14 * $freq * $t}]
    set y_data1i [expr {sin($arg)}]
    lappend y_data1 $y_data1i
    set y_data12i [expr {$y_data1i * -0.6 + sin(2 * $arg) * 0.4}]
    lappend y_data2 $y_data12i
    lappend y_data3 [expr {$y_data12i * -0.6 + sin(3 * $arg) * 0.4}]
}

set flags 0


set x_data  [implottk::doubleToPointer $x_data]
set y_data1 [implottk::doubleToPointer $y_data1]
set y_data2 [implottk::doubleToPointer $y_data2]
set y_data3 [implottk::doubleToPointer $y_data3]

set rectXMin 0.0025
set rectYMin 0.0
set rectXMax 0.0045
set rectYMax 0.5

# add cmds 'Imgui' on the fly
$f addImGUICmds {
    imgui::BulletText "%s" {string "Click and drag the edges, corners, and center of the rect."}
    imgui::CheckboxFlags_UintPtr "NoCursors" ::flags 1 ; imgui::SameLine
    imgui::CheckboxFlags_UintPtr "NoFit"     ::flags 2 ; imgui::SameLine
    imgui::CheckboxFlags_UintPtr "NoInput"   ::flags 4
}

$f addLinePlotCmds { 

    implot::BeginPlot "##Main" {x -1 y 250}
    implot::SetupAxes "" "" ImPlotAxisFlags_NoTickLabels ImPlotAxisFlags_NoTickLabels
    implot::SetupAxesLimits 0 0.01 -1 1
    implot::PlotLine_doublePtrdoublePtr "Signal 1" $::x_data $::y_data1 512
    implot::PlotLine_doublePtrdoublePtr "Signal 2" $::x_data $::y_data2 512
    implot::PlotLine_doublePtrdoublePtr "Signal 3" $::x_data $::y_data3 512
    implot::DragRect 0 ::rectXMin ::rectYMin ::rectXMax ::rectYMax {x 1 y 0 z 1 w 1} $::flags
    implot::EndPlot
    
    implot::BeginPlot "##rect" {x -1 y -1} ImPlotFlags_CanvasOnly
    implot::SetupAxes "" "" ImPlotAxisFlags_NoTickLabels ImPlotAxisFlags_NoTickLabels
    implot::SetupAxesLimits $::rectXMin $::rectXMax $::rectYMin $::rectYMax ImPlotCond_Always
    implot::PlotLine_doublePtrdoublePtr "Signal 1" $::x_data $::y_data1 512
    implot::PlotLine_doublePtrdoublePtr "Signal 2" $::x_data $::y_data2 512
    implot::PlotLine_doublePtrdoublePtr "Signal 3" $::x_data $::y_data3 512
    implot::EndPlot
    
}

# Map Tk Frame
pack .f1 -fill both -expand 1