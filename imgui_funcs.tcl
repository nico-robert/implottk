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
        ImGui_ImplGlfw_InitForOpenGL       {int                           {window pointer.::glfw3::GLFWwindow install_callbacks int}}
        ImGui_ImplWin32_NewFrame           {void                          {}}
        ImGui_ImplWin32_Shutdown           {void                          {}}
        ImGui_ImplWin32_EnableDpiAwareness {void                          {}}
        igSetNextWindowFocus               {void                          {}}
        igEndTable                         {void                          {}}
        igTableHeadersRow                  {void                          {}}
        igPopID                            {void                          {}}
        ImGui_ImplGlfw_NewFrame            {void                          {}}
        

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
                format {string           {default "%.3f"}}
                flags  {ImGuiSliderFlags {default 0}} 
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
                hwnd pointer.::user32::HWND
            }
        }
        
        ImGui_ImplWin32_WndProcHandler {LRESULT {
                hWnd   pointer.::user32::HWND
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
                buf_size  {size_t                                {default 512}}
                flags     {ImGuiInputTextFlags                   {default 0}}
                callback  {pointer.ImGuiInputTextCallback nullok {default NULL}}
                user_data {pointer nullok                        {default NULL}}
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
                flags   {ImGuiColorEditFlags  {default 0}}
                ref_col {pointer.float nullok {default NULL}}
            }
        }
        
        ImFontAtlas_AddFontFromFileTTF {pointer.ImFont {
                self         pointer.ImFontAtlas
                filename     string
                size_pixels  float
                font_cfg     {pointer.ImFontConfig nullok {default NULL}}
                glyph_ranges {pointer.ImWchar nullok      {default NULL}}
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
                v_speed {float            {default 1.0}}
                v_min   {float            {default 0.0}}
                v_max   {float            {default 0.0}}
                format  {string           {default "%.3f"}}
                flags   {ImGuiSliderFlags {default 0}}
            }
        }
        
        igDestroyContext {void {
                ctx pointer.ImGuiContext
            }
        }
        
        igCheckboxFlags_UintPtr {CIMGUI_BOOL {
                label       string
                flags       {uint inout}
                flags_value uint
            }
        }
        
        igSliderInt {CIMGUI_BOOL {
                label  string
                v      {int inout}
                v_min  int
                v_max  int
                format {string           {default "%.3f"}}
                flags  {ImGuiSliderFlags {default 0}}
            }
        }
   
        igDragScalarN {CIMGUI_BOOL {
                label      string
                data_type  ImGuiDataType
                p_data     pointer
                components int
                v_speed    {float               {default 1.0}}
                p_min      {pointer nullok      {default NULL}}
                p_max      {pointer nullok      {default NULL}}
                format     {string nullifempty  {default ""}}
                flags      {ImGuiSliderFlags    {default 0}}
            }
        }

        igBulletText {void {
                fmt string
                ...
            }
        }

        igSetDragDropPayload {CIMGUI_BOOL {
                type string
                data {pointer nullok}
                sz   size_t
                cond {ImGuiCond {default 0}}
            }
        }

        igTextUnformatted {void {
                text     string
                text_end {string nullifempty {default ""}}
            }
        }

        igAcceptDragDropPayload {{pointer.ImGuiPayload nullok} {
                type  string
                flags {ImGuiDragDropFlags {default 0}}
            }
        }
        
        igIsWindowFocused {CIMGUI_BOOL {
                flags {ImGuiFocusedFlags {default 0}}
            }
        }
        
        igBeginTable {CIMGUI_BOOL {
                str_id      string
                column      int
                flags       {ImGuiTableFlags bitmask {default 0}}
                outer_size  {struct.ImVec2           {default {x 0 y 0}}}
                inner_width {float                   {default 0.0}}
            }
        }
        
        igTableSetupColumn {void {
                label                string
                flags                {ImGuiTableColumnFlags {default 0}}
                init_width_or_weight {float                 {default 0.0}}
                user_id              {ImGuiID               {default 0}}
            }
        }
        
        igTableNextRow {void {
                row_flags      {ImGuiTableRowFlags {default 0}}
                min_row_height {float              {default 0.0}}
            }
        }
        
        igTableSetColumnIndex {CIMGUI_BOOL {
                column_n int
            }
        }
        
        igText {void {
                fmt string
                ...
            }
        }
        
        igPushID_Int {void {
                int_id int
            }
        }
        
    }
}

