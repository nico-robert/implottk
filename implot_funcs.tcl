# Copyright (c) 2022 Nicolas ROBERT.
# Distributed under MIT license. Please see LICENSE for details.

namespace eval ::implot {
    variable cbplot
    variable implot_funcs
}

proc ::implot::initprocFunc {} {
    variable implot_funcs
    
    foreach {name func} $implot_funcs {
        # remove cimgui header name declaration
        regsub {(^ImPlot_)} $name {} procname
        proc $procname args "CIMGUI function $name [list {*}$func]; tailcall $name {*}\$args"
    }
}

proc ::implot::init {} {
    variable cbplot
    variable implot_funcs
    
    cffi::prototype function ImPlotPoint_getter void {
        data {pointer unsafe}
        idx int
        point {pointer.ImPlotPoint unsafe}
    }

    set implot_funcs {

        ImPlot_CreateContext           {pointer.ImPlotContext {}}
        ImPlot_GetCurrentContext       {pointer.ImPlotContext {}}
        ImPlot_SetCurrentContext       {void                  {ctx pointer.ImPlotContext}}
        ImPlot_SetImGuiContext         {void                  {ctx pointer.::imgui::ImGuiContext}}
        ImPlot_EndPlot                 {void                  {}}
        ImPlot_EndSubplots             {void                  {}}
        ImPlot_EndDragDropSource       {void                  {}}
        ImPlot_BeginDragDropTargetPlot {CIMGUI_BOOL           {}}
        ImPlot_EndDragDropTarget       {void                  {}}
        

        ImPlot_BeginPlot {CIMGUI_BOOL {
                title_id string
                size     {struct.::imgui::ImVec2 {default {x -1 y -1}}}
                flags    {ImPlotFlags bitmask    {default 0}}
            }
        }
        
        ImPlot_SetNextMarkerStyle {void {
                marker  {ImPlotMarker           {default -1}}
                size    {float                  {default -1}}
                fill    {struct.::imgui::ImVec4 {default {x 0 y 0 z 0 w -1}}}
                weight  {float                  {default -1}}
                outline {struct.::imgui::ImVec4 {default {x 0 y 0 z 0 w -1}}}
            }
        }
        
        ImPlot_ShowDemoWindow {void {
                p_open {pointer.bool nullok {default NULL}}
            }
        }
        
        ImPlot_PlotLineG {void {
                label_id string
                getter   pointer.ImPlotPoint_getter
                data     {pointer nullok} 
                count    int 
                flags    {ImPlotLineFlags {default 0}}
            }
        }
        
        ImPlot_PlotLine_doublePtrdoublePtr {void {
                label_id string
                xs       pointer.double
                ys       pointer.double
                count    int
                flags    {ImPlotLineFlags {default 0}}
                offset   {int {default 0}}
                stride   {int {default 8}}
            }
        }
        
        ImPlot_SetupAxesLimits {void {
                x_min double
                x_max double
                y_min double
                y_max double
                cond  {ImPlotCond {default 2}}
            }
        }
        
        ImPlot_GetPlotLimits {struct.ImPlotRect {
                x_axis {ImAxis {default -1}}
                y_axis {ImAxis {default -1}}
            }
        }
        
        ImPlot_SetNextLineStyle {void {
                col    struct.::imgui::ImVec4
                weight {float {default -1}}
            }
        }
        
        ImPlot_GetPlotSize {void {
                pOut {struct.::imgui::ImVec2 out}
            }
        }
        
        ImPlot_GetPlotPos {void {
                pOut {struct.::imgui::ImVec2 out}
            }
        }

        ImPlot_PushStyleColor_Vec4 {void {
                idx ImPlotCol
                col struct.::imgui::ImVec4
            }
        }

        ImPlot_PopStyleColor {void {
                count {int {default 1}}
            }
        }
        
        ImPlot_SetupAxes {void {
                x_label {string nullifempty}
                y_label {string nullifempty}
                x_flags {ImPlotAxisFlags {default 0}}
                y_flags {ImPlotAxisFlags {default 0}}
            }
        }
        
        ImPlot_PushStyleVar_Float {void {
                idx ImPlotStyleVar
                val float
            }
        }
        
        ImPlot_PushStyleVar_Vec2 {void {
                idx ImPlotStyleVar
                val struct.::imgui::ImVec2
            }
        }
        
        ImPlot_PlotShaded_doublePtrdoublePtrInt {void {
                label_id string
                xs       pointer.double
                ys       pointer.double
                count    int
                yref     {double  {default 0}}
                flags    {ImPlotShadedFlags {default 0}}
                offset   {int {default 0}}
                stride   {int {default 8}}
            }
        }
        
        ImPlot_PlotShaded_doublePtrdoublePtrdoublePtr {void {
                label_id string
                xs       pointer.double
                ys1      pointer.double
                ys2      pointer.double
                count    int
                flags    {ImPlotShadedFlags {default 0}}
                offset   {int {default 0}}
                stride   {int {default 8}}
            }
        }
        
        ImPlot_PlotShaded_doublePtrdoublePtrInt {void {
                label_id string
                xs       pointer.double
                ys       pointer.double
                count    int
                yref     double
                flags    {ImPlotShadedFlags {default 0}}
                offset   {int {default 0}}
                stride   {int {default 8}}
            }
        }

        ImPlot_PopStyleVar {void {
                count {int {default 1}}
            }
        }
        
        ImPlot_BeginSubplots {CIMGUI_BOOL {
                title_id   string
                rows       int
                cols       int
                size       struct.::imgui::ImVec2
                flags      ImPlotSubplotFlags
                row_ratios {pointer nullok {default NULL}}
                col_ratios {pointer nullok {default NULL}}
            }
        }
        
        ImPlot_SampleColormap {void {
                pOut {struct.::imgui::ImVec4 out}
                t    float
                cmap {ImPlotColormap {default -1}}
            }
        }

        ImPlot_BeginDragDropSourceItem {CIMGUI_BOOL {
                label_id string
                flags    {imgui::ImGuiDragDropFlags {default 0}}
            }
        }

        ImPlot_ItemIcon_Vec4 {void {
                col struct.::imgui::ImVec4
            }
        }

        ImPlot_GetLastItemColor {void {
                pOut {struct.::imgui::ImVec4 out}
            }
        }
        
        ImPlot_PushColormap_PlotColormap {void {
                cmap ImPlotColormap
            }
        }
        
        ImPlot_PopColormap {void {
                count {int {default 1}}
            }
        }
        
        ImPlot_GetColormapColor {void {
                pOut {struct.::imgui::ImVec4 out}
                idx  int
                cmap {ImPlotColormap {default -1}}
            }
        }
        
        ImPlot_PlotStems_doublePtrdoublePtr {void {
                label_id string
                xs       pointer.double
                ys       pointer.double
                count    int
                ref      {double {default 0}}
                flags    {ImPlotStemsFlags {default 0}}
                offset   {int {default 0}}
                stride   {int {default 8}}
            }
        }
        
        ImPlot_DragRect {CIMGUI_BOOL {
                id    int
                x_min {double inout}
                y_min {double inout}
                x_max {double inout}
                y_max {double inout}
                col   struct.::imgui::ImVec4
                flags {ImPlotDragToolFlags {default 0}}
            }
        }
        
    }
    

    set cbplot [cffi::callback new ImPlotPoint_getter implottk::cbFuncPlot struct.ImPlotPoint]
    
}
