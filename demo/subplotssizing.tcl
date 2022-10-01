# Example from implot_demo.cpp
# void Demo_SubplotsSizing()

proc sineWaveGetter {data len} {

    set l {}

    for {set i 0} {$i < $len} {incr i} {
        lappend l [list $i [expr {sin($data * $i)}]]
    }
    
    return $l
}

lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req implottk
catch {console show}

# set frame
set f [implottk::implotFrame .f1 -width 800 -height 600]

# add options
$f options -title "Subplots sizing"

set flags 0
set rows 3
set cols 3

# ImPlotSubplotFlags_NoResize = 8
# ImPlotSubplotFlags_NoTitle  = 1

set rratios [implottk::arrayToFloat {5 1 1 1 1 1}]
set cratios [implottk::arrayToFloat {5 1 1 1 1 1}]

# add cmds 'Imgui' on the fly
$f addImGUICmds {
    imgui::CheckboxFlags_UintPtr "ImPlotSubplotFlags_NoResize" ::flags 8
    imgui::CheckboxFlags_UintPtr "ImPlotSubplotFlags_NoTitle"  ::flags 1
    
    imgui::SliderInt "Rows" ::rows 1 5
    imgui::SliderInt "Cols" ::cols 1 5
    
    imgui::DragScalarN "Row Ratios" ImGuiDataType_Float $::rratios $::rows 0.01
    imgui::DragScalarN "Col Ratios" ImGuiDataType_Float $::cratios $::cols 0.01
}

# add cmds 'Implot' on the fly
$f addLinePlotCmds {

    if {[implot::BeginSubplots "My Subplots" $::rows $::cols {x -1 y -1} $::flags $::rratios $::cratios]} {
    
        for {set i 0} {$i < [expr {$::rows * $::cols}]} {incr i} {
            if {[implot::BeginPlot "" {x -1 y -1} ImPlotFlags_NoLegend]} {
                implot::SetupAxes "" "" ImPlotAxisFlags_NoDecorations ImPlotAxisFlags_NoDecorations
                set fi [expr {0.01 * ($i + 1)}]
                implot::SampleColormap var_imvec4 [expr {$i / double($::rows * $::cols - 1)}] ImPlotColormap_Jet
                implot::SetNextLineStyle $var_imvec4
                set len 1000
                set coords [sineWaveGetter $fi $len]
                # callback plot line..
                implot::PlotLineG "data" $implot::cbplot NULL $len
                implot::EndPlot
            }
        }
        implot::EndSubplots
    }
}

# Map Tk Frame
pack .f1 -fill both -expand 1