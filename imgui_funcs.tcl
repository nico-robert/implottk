# Copyright (c) 2022 Nicolas ROBERT.
# Distributed under MIT license. Please see LICENSE for details.

namespace eval ::imgui {
    variable imgui_funcs
}

proc ::imgui::initprocFunc {} {
    variable imgui_funcs
    
    foreach {name func} $imgui_funcs {
        # remove cimgui header name declaration
        regsub {(^ImGui_)|(^ig)} $name {} procname
        proc $procname args "CIMGUI function $name [list {*}$func]; tailcall $name {*}\$args"
    }
}

proc ::imgui::init {} {
    variable imgui_funcs

    set imgui_funcs {

        igGetVersion                       {string                        {}}
        igShowUserGuide                    {void                          {}}
        igNewFrame                         {void                          {}}
        igEndFrame                         {void                          {}}
        igText                             {void                          {fmt string}}
        igEnd                              {void                          {}}
        igRender                           {void                          {}}
        igGetIO                            {pointer.ImGuiIO               {}}
        igGetDrawData                      {pointer.ImDrawData            {}}
        igGetCurrentContext                {{pointer.ImGuiContext nullok} {}}
        igSetCurrentContext                {void                          {ctx pointer.ImGuiContext}}
        igGetMainViewport                  {pointer.ImGuiViewport         {}}
        igUpdatePlatformWindows            {void                          {}}
        igGetMousePos                      {void                          {pOut {struct.ImVec2 out}}}
        igGetTime                          {double                        {}}
        ImGui_ImplOpenGL3_NewFrame         {void                          {}}
        ImGui_ImplOpenGL3_Shutdown         {void                          {}}
        ImGui_ImplWin32_NewFrame           {void                          {}}
        ImGui_ImplWin32_Shutdown           {void                          {}}
        ImGui_ImplWin32_EnableDpiAwareness {void                          {}}
        

        igRenderPlatformWindowsDefault {void {
                platform_render_arg {pointer nullok {default NULL}}
                renderer_render_arg {pointer nullok {default NULL}}
            }
        }
        
        igBegin {CIMGUI_BOOL {
                name   string
                p_open {pointer.bool     nullok  {default NULL}}
                flags  {ImGuiWindowFlags bitmask {default 0}}
            }
        }
        
        igShowDemoWindow {void {
                p_open {pointer.bool nullok {default NULL}}
            }
        }
        
        igCreateContext {pointer.ImGuiContext {
                shared_font_atlas {pointer.ImFontAtlas nullok {default NULL}}
            }
        }
        
        ImFontAtlas_GetTexDataAsRGBA32 {void {
                self                pointer.ImFontAtlas
                out_pixels          {binary nullifempty}
                out_width           {int out}
                out_height          {int out}
                out_bytes_per_pixel {pointer.int nullok}
            }
        }

        igSliderFloat {CIMGUI_BOOL {
                label  string
                v      {float inout}
                v_min  float
                v_max  float
                format string
                flags  {ImGuiSliderFlags {default ImGuiSliderFlags_None}} 
            }
        }

        igDestroyContext {void {
                ctx {pointer.ImGuiContext nullok}
            }
        }

        igSetNextWindowPos {void {
                pos   struct.ImVec2
                cond  ImGuiCond
                pivot struct.ImVec2
            }
        }

        igSetNextWindowSize {void {
                size struct.ImVec2
                cond ImGuiCond
            }
        }

        igButton {CIMGUI_BOOL {
                label string
                size  struct.ImVec2
            }
        }

        ImGuiIO_AddKeyEvent {void {
                self pointer.ImGuiIO
                key  ImGuiKey
                down int
            }
        }

        ImGui_ImplOpenGL3_Init {CIMGUI_BOOL {
                glsl_version {string nullifempty {default ""}}
            }
        }
        
        ImGui_ImplOpenGL3_RenderDrawData {void {
                draw_data pointer.ImDrawData
            }
        }
        
        ImGui_ImplWin32_Init {CIMGUI_BOOL {
                hwnd pointer.::win32::HWND
            }
        }
        
        ImGui_ImplWin32_WndProcHandler {LRESULT {
                hWnd   pointer.::win32::HWND
                msg    UINT
                wParam WPARAM
                lParam LPARAM
            }
        }
        
        igPushStyleColor_Vec4 {void {
                idx ImGuiCol
                col struct.ImVec4
            }
        }
        
        igPushStyleColor_U32 {void {
                idx ImGuiCol
                col ImU32
            }
        }
        
        igInputText {CIMGUI_BOOL {
                label     string
                buf       {chars[buf_size] inout}
                buf_size  {size_t {default 512}}
                flags     {ImGuiInputTextFlags {default 0}}
                callback  {pointer.ImGuiInputTextCallback nullok {default NULL}}
                user_data {pointer nullok {default NULL}}
            }
        }
        
        igPopStyleColor {void {
                count {int {default 1}}
            }
        }
        
        igPushStyleVar_Vec2 {void {
                idx ImGuiStyleVar
                val struct.ImVec2
            }
        }
        
        igSameLine {void {
                offset_from_start_x {float {default 0.0}}
                spacing             {float {default 0.0}}
            }
        }
        
        igColorEdit4 {CIMGUI_BOOL {
                label string
                col   {float[4] inout}
                flags {ImGuiColorEditFlags {default 0}}
            }
        }
        
        igColorPicker4 {CIMGUI_BOOL {
                label   string
                col     {float[4] inout}
                flags   {ImGuiColorEditFlags {default 0}}
                ref_col {pointer.float nullok {default NULL}}
            }
        }
        
        ImFontAtlas_AddFontFromFileTTF {pointer.ImFont {
                self         pointer.ImFontAtlas
                filename     string
                size_pixels  float
                font_cfg     {pointer.ImFontConfig nullok {default NULL}}
                glyph_ranges {pointer.ImWchar nullok {default NULL}}
            }
        }

        igColorConvertRGBtoHSV {void {
                r     float
                g     float
                b     float
                out_h {float out}
                out_s {float out}
                out_v {float out}
            }
        }
        
        igCheckbox {CIMGUI_BOOL {
                label string
                vOut  {ImBool inout}
            }
        }
        
        igRadioButton_IntPtr {CIMGUI_BOOL {
                label    string
                v        {int inout}
                v_button int
            }
        }
      
        igSetNextItemWidth {void {
                item_width float
            }
        }
        
        igDragFloat {CIMGUI_BOOL {
                label   string
                v       {float inout}
                v_speed {float  {default 1.0}}
                v_min   {float  {default 0.0}}
                v_max   {float  {default 0.0}}
                format  {string {default "%.3f"}}
                flags   {ImGuiSliderFlags {default 0}}
            }
        }
        
        igDestroyContext {void {
                ctx pointer.ImGuiContext
            }
        }
    }
}

