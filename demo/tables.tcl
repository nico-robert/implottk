# Example from implot_demo.cpp
# void Demo_Tables()

proc RandomRange {args} {

    set num [expr {rand()}]
    
	lassign $args lower upper
	set range [expr {$upper - $lower}]
    
	return [expr {double($num * $range) + $lower}]
}

proc Sparkline {id xs ys count min_v max_v offset col size} {

    implot::PushStyleVar_Vec2 ImPlotStyleVar_PlotPadding {x 0 y 0}
    
    set xs [implottk::doubleToPointer $xs]
    set ys [implottk::doubleToPointer $ys]
    
    if {[implot::BeginPlot $id $size {ImPlotFlags_CanvasOnly ImPlotFlags_NoChild}]} {
    
        implot::SetupAxes 0 0 ImPlotAxisFlags_NoDecorations ImPlotAxisFlags_NoDecorations
        implot::SetupAxesLimits 0 [expr {$count - 1}] $min_v $max_v ImPlotCond_Always
        implot::PushStyleColor_Vec4 ImPlotCol_Line $col
        implot::PlotLine_doublePtrdoublePtr $id $xs $ys $count
        implot::PushStyleVar_Float ImPlotStyleVar_FillAlpha 0.25
        implot::PlotShaded_doublePtrdoublePtrInt $id $xs $ys $count 0 0 0
        implot::PopStyleVar
        implot::PopStyleColor
        implot::EndPlot
    }
    
    implot::PopStyleVar
}

lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req implottk
catch {console show}

# set frame
set f [implottk::implotFrame .f1 -width 800 -height 600]

# enum flags.
set flags {
            ImGuiTableFlags_BordersOuter ImGuiTableFlags_BordersV ImGuiTableFlags_RowBg
            ImGuiTableFlags_Resizable ImGuiTableFlags_Reorderable
           }

set anim 1
set offset 0
array set datax {} ; array set datay {}

# add cmds 'Imgui' on the fly
$f addImGUICmds {
    imgui::BulletText "%s" {string "Plots can be used inside of ImGui tables as another means of creating subplots."}
    imgui::Checkbox "Animate" ::anim
    
    if {$::anim} {
        set ::offset [expr {($::offset + 1) % 100}] 
    }
    if {[imgui::BeginTable "##table" 3 $::flags {x -1 y -1}]} {

        imgui::TableSetupColumn "Electrode" ImGuiTableColumnFlags_WidthFixed 75.0
        imgui::TableSetupColumn "Voltage"   ImGuiTableColumnFlags_WidthFixed 75.0
        imgui::TableSetupColumn "EMG Signal"
        imgui::TableHeadersRow
        
        implot::PushColormap_PlotColormap ImPlotColormap_Cool
        
        for {set row 0} {$row < 10} {incr row} {
            imgui::TableNextRow
            
            for {set i 0} {$i < 100} {incr i} {
                lappend ::datax($row) $i
                lappend ::datay($row) [RandomRange 0 10]
            }

            imgui::TableSetColumnIndex 0
            imgui::Text "EMG %d" [list int $row]
            imgui::TableSetColumnIndex 1
            imgui::Text "%.3f V" [list double [lindex $::datay($row) $::offset]]
            imgui::TableSetColumnIndex 2
            imgui::PushID_Int $row
            implot::GetColormapColor outvec4 $row
            Sparkline "##spark" $::datax($row) $::datay($row) 100 0 11.0 $::offset $outvec4 {x -1 y 35}
            imgui::PopID

        }

        if {$::anim} {
            unset ::datax ; unset ::datay
        }
    
        implot::PopColormap
        imgui::EndTable
    }
    
}

# add cmds 'Implot' on the fly
$f addLinePlotCmds {}

# Map Tk Frame
pack .f1 -fill both -expand 1