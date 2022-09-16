# Copyright (c) 2022 Nicolas ROBERT.
# Distributed under MIT license. Please see LICENSE for details.

namespace eval ::imgui {

    # ImDrawFlags_None                    : ImDrawFlags_None                        = 0,
    # ImDrawFlags_Closed                  : (Legacy: bit 0 must always correspond to ImDrawFlags_Closed to be backward compatible with old API using a bool. Bits 1..3 must be unused)
    # ImDrawFlags_RoundCornersTopLeft     : AddRect(), AddRectFilled(), PathRect(): enable rounding top-left corner only (when rounding > 0.0f, we default to all corners). Was 0x01.
    # ImDrawFlags_RoundCornersTopRight    : AddRect(), AddRectFilled(), PathRect(): enable rounding top-right corner only (when rounding > 0.0f, we default to all corners). Was 0x02.
    # ImDrawFlags_RoundCornersBottomLeft  : AddRect(), AddRectFilled(), PathRect(): enable rounding bottom-left corner only (when rounding > 0.0f, we default to all corners). Was 0x04.
    # ImDrawFlags_RoundCornersBottomRight : AddRect(), AddRectFilled(), PathRect(): enable rounding bottom-right corner only (when rounding > 0.0f, we default to all corners). Wax 0x08.
    # ImDrawFlags_RoundCornersNone        : AddRect(), AddRectFilled(), PathRect(): disable rounding on all corners (when rounding > 0.0f). This is NOT zero, NOT an implicit flag!
    # ImDrawFlags_RoundCornersTop         : AddRect(), AddRectFilled(), PathRect(): enable rounding top-left corner only (when rounding > 0.0f, we default to all corners). Was 0x01.
    # ImDrawFlags_RoundCornersBottom      : AddRect(), AddRectFilled(), PathRect(): enable rounding bottom-left corner only (when rounding > 0.0f, we default to all corners). Was 0x04.
    # ImDrawFlags_RoundCornersLeft        : ImDrawFlags_RoundCornersLeft            = ImDrawFlags_RoundCornersBottomLeft | ImDrawFlags_RoundCornersTopLeft,
    # ImDrawFlags_RoundCornersRight       : ImDrawFlags_RoundCornersRight           = ImDrawFlags_RoundCornersBottomRight | ImDrawFlags_RoundCornersTopRight,
    # ImDrawFlags_RoundCornersAll         : ImDrawFlags_RoundCornersAll             = ImDrawFlags_RoundCornersTopLeft | ImDrawFlags_RoundCornersTopRight | ImDrawFlags_RoundCornersBottomLeft | ImDrawFlags_RoundCornersBottomRight,
    # ImDrawFlags_RoundCornersDefault_    : Default to ALL corners if none of the _RoundCornersXX flags are specified.
    # ImDrawFlags_RoundCornersMask_       : ImDrawFlags_RoundCornersMask_           = ImDrawFlags_RoundCornersAll | ImDrawFlags_RoundCornersNone
    cffi::enum define ImDrawFlags_ {
        ImDrawFlags_None                    0
        ImDrawFlags_Closed                  1
        ImDrawFlags_RoundCornersTopLeft     16
        ImDrawFlags_RoundCornersTopRight    32
        ImDrawFlags_RoundCornersBottomLeft  64
        ImDrawFlags_RoundCornersBottomRight 128
        ImDrawFlags_RoundCornersNone        256
        ImDrawFlags_RoundCornersTop         48
        ImDrawFlags_RoundCornersBottom      192
        ImDrawFlags_RoundCornersLeft        80
        ImDrawFlags_RoundCornersRight       160
        ImDrawFlags_RoundCornersAll         240
        ImDrawFlags_RoundCornersDefault_    240
        ImDrawFlags_RoundCornersMask_       496
    }

    # ImDrawListFlags_None                   : ImDrawListFlags_None                    = 0,
    # ImDrawListFlags_AntiAliasedLines       : borders (*2 the number of triangles for 1.0f wide line or lines thin enough to be drawn using textures, otherwise *3 the number of triangles)
    # ImDrawListFlags_AntiAliasedLinesUseTex : nearest filtering).
    # ImDrawListFlags_AntiAliasedFill        : Enable anti-aliased edge around filled shapes (rounded rectangles, circles).
    # ImDrawListFlags_AllowVtxOffset         : Can emit 'VtxOffset > 0' to allow large meshes. Set when 'ImGuiBackendFlags_RendererHasVtxOffset' is enabled.
    cffi::enum define ImDrawListFlags_ {
        ImDrawListFlags_None                   0
        ImDrawListFlags_AntiAliasedLines       1
        ImDrawListFlags_AntiAliasedLinesUseTex 2
        ImDrawListFlags_AntiAliasedFill        4
        ImDrawListFlags_AllowVtxOffset         8
    }

    # ImFontAtlasFlags_None               : ImFontAtlasFlags_None               = 0,
    # ImFontAtlasFlags_NoPowerOfTwoHeight : Don't round the height to next power of two
    # ImFontAtlasFlags_NoMouseCursors     : Don't build software mouse cursors into the atlas (save a little texture memory)
    # ImFontAtlasFlags_NoBakedLines       : The maximum line width to bake anti-aliased textures for. Build atlas with ImFontAtlasFlags_NoBakedLines to disable baking.
    cffi::enum define ImFontAtlasFlags_ {
        ImFontAtlasFlags_None               0
        ImFontAtlasFlags_NoPowerOfTwoHeight 1
        ImFontAtlasFlags_NoMouseCursors     2
        ImFontAtlasFlags_NoBakedLines       4
    }

    cffi::enum define ImGuiActivateFlags_ {
        ImGuiActivateFlags_None               0
        ImGuiActivateFlags_PreferInput        1
        ImGuiActivateFlags_PreferTweak        2
        ImGuiActivateFlags_TryToPreserveState 4
    }

    cffi::enum define ImGuiAxis {
        ImGuiAxis_None -1
        ImGuiAxis_X    0
        ImGuiAxis_Y    1
    }

    # ImGuiBackendFlags_None                    : ImGuiBackendFlags_None                  = 0,
    # ImGuiBackendFlags_HasGamepad              : Gamepad:  Set io.ConfigFlags |= ImGuiConfigFlags_NavEnableGamepad to enable. Backend: set ImGuiBackendFlags_HasGamepad and fill the io.NavInputs[] fields before calling NewFrame(). Note that io.NavInputs[] is cleared by EndFrame().
    # ImGuiBackendFlags_HasMouseCursors         : [Obsolete] --> Set io.ConfigWindowsResizeFromEdges=true and make sure mouse cursors are supported by backend (io.BackendFlags & ImGuiBackendFlags_HasMouseCursors)
    # ImGuiBackendFlags_HasSetMousePos          : Backend Platform supports io.WantSetMousePos requests to reposition the OS mouse position (only used if ImGuiConfigFlags_NavEnableSetMousePos is set).
    # ImGuiBackendFlags_RendererHasVtxOffset    : - To use 16-bit indices + allow large meshes: backend need to set 'io.BackendFlags |= ImGuiBackendFlags_RendererHasVtxOffset' and handle ImDrawCmd::VtxOffset (recommended).
    # ImGuiBackendFlags_PlatformHasViewports    : Viewport enable flags (require both ImGuiBackendFlags_PlatformHasViewports + ImGuiBackendFlags_RendererHasViewports set by the respective backends)
    # ImGuiBackendFlags_HasMouseHoveredViewport : Backend Platform supports calling io.AddMouseViewportEvent() with the viewport under the mouse. IF POSSIBLE, ignore viewports with the ImGuiViewportFlags_NoInputs flag (Win32 backend, GLFW 3.30+ backend can do this, SDL backend cannot). If this cannot be done, Dear ImGui needs to use a flawed heuristic to find the viewport under.
    # ImGuiBackendFlags_RendererHasViewports    : Viewport enable flags (require both ImGuiBackendFlags_PlatformHasViewports + ImGuiBackendFlags_RendererHasViewports set by the respective backends)
    cffi::enum define ImGuiBackendFlags_ {
        ImGuiBackendFlags_None                    0
        ImGuiBackendFlags_HasGamepad              1
        ImGuiBackendFlags_HasMouseCursors         2
        ImGuiBackendFlags_HasSetMousePos          4
        ImGuiBackendFlags_RendererHasVtxOffset    8
        ImGuiBackendFlags_PlatformHasViewports    1024
        ImGuiBackendFlags_HasMouseHoveredViewport 2048
        ImGuiBackendFlags_RendererHasViewports    4096
    }

    cffi::enum define ImGuiButtonFlagsPrivate_ {
        ImGuiButtonFlags_PressedOnClick                16
        ImGuiButtonFlags_PressedOnClickRelease         32
        ImGuiButtonFlags_PressedOnClickReleaseAnywhere 64
        ImGuiButtonFlags_PressedOnRelease              128
        ImGuiButtonFlags_PressedOnDoubleClick          256
        ImGuiButtonFlags_PressedOnDragDropHold         512
        ImGuiButtonFlags_Repeat                        1024
        ImGuiButtonFlags_FlattenChildren               2048
        ImGuiButtonFlags_AllowItemOverlap              4096
        ImGuiButtonFlags_DontClosePopups               8192
        ImGuiButtonFlags_AlignTextBaseLine             32768
        ImGuiButtonFlags_NoKeyModifiers                65536
        ImGuiButtonFlags_NoHoldingActiveId             131072
        ImGuiButtonFlags_NoNavFocus                    262144
        ImGuiButtonFlags_NoHoveredOnFocus              524288
        ImGuiButtonFlags_PressedOnMask_                1008
        ImGuiButtonFlags_PressedOnDefault_             32
    }

    # ImGuiButtonFlags_None                : ImGuiButtonFlags_None                   = 0,
    # ImGuiButtonFlags_MouseButtonLeft     : React on left mouse button (default)
    # ImGuiButtonFlags_MouseButtonRight    : React on right mouse button
    # ImGuiButtonFlags_MouseButtonMiddle   : React on center mouse button
    # ImGuiButtonFlags_MouseButtonMask_    : ImGuiButtonFlags_MouseButtonMask_       = ImGuiButtonFlags_MouseButtonLeft | ImGuiButtonFlags_MouseButtonRight | ImGuiButtonFlags_MouseButtonMiddle,
    # ImGuiButtonFlags_MouseButtonDefault_ : ImGuiButtonFlags_MouseButtonDefault_    = ImGuiButtonFlags_MouseButtonLeft
    cffi::enum define ImGuiButtonFlags_ {
        ImGuiButtonFlags_None                0
        ImGuiButtonFlags_MouseButtonLeft     1
        ImGuiButtonFlags_MouseButtonRight    2
        ImGuiButtonFlags_MouseButtonMiddle   4
        ImGuiButtonFlags_MouseButtonMask_    7
        ImGuiButtonFlags_MouseButtonDefault_ 1
    }

    # ImGuiCol_Text                  : shortcut for PushStyleColor(ImGuiCol_Text, col); Text(fmt, ...); PopStyleColor();
    # ImGuiCol_TextDisabled          : shortcut for PushStyleColor(ImGuiCol_Text, style.Colors[ImGuiCol_TextDisabled]); Text(fmt, ...); PopStyleColor();
    # ImGuiCol_WindowBg              : PopupBg. you may also use ImGuiWindowFlags_NoBackground.
    # ImGuiCol_ChildBg               : Background of child windows
    # ImGuiCol_PopupBg               : Background of popups, menus, tooltips windows
    # ImGuiCol_Border                : ImGuiCol_Border,
    # ImGuiCol_BorderShadow          : ImGuiCol_BorderShadow,
    # ImGuiCol_FrameBg               : Background of checkbox, radio button, plot, slider, text input
    # ImGuiCol_FrameBgHovered        : ImGuiCol_FrameBgHovered,
    # ImGuiCol_FrameBgActive         : ImGuiCol_FrameBgActive,
    # ImGuiCol_TitleBg               : ImGuiCol_TitleBg,
    # ImGuiCol_TitleBgActive         : ImGuiCol_TitleBgActive,
    # ImGuiCol_TitleBgCollapsed      : ImGuiCol_TitleBgCollapsed,
    # ImGuiCol_MenuBarBg             : ImGuiCol_MenuBarBg,
    # ImGuiCol_ScrollbarBg           : ImGuiCol_ScrollbarBg,
    # ImGuiCol_ScrollbarGrab         : ImGuiCol_ScrollbarGrab,
    # ImGuiCol_ScrollbarGrabHovered  : ImGuiCol_ScrollbarGrabHovered,
    # ImGuiCol_ScrollbarGrabActive   : ImGuiCol_ScrollbarGrabActive,
    # ImGuiCol_CheckMark             : ImGuiCol_CheckMark,
    # ImGuiCol_SliderGrab            : ImGuiCol_SliderGrab,
    # ImGuiCol_SliderGrabActive      : ImGuiCol_SliderGrabActive,
    # ImGuiCol_Button                : ImGuiCol_Button,
    # ImGuiCol_ButtonHovered         : ImGuiCol_ButtonHovered,
    # ImGuiCol_ButtonActive          : ImGuiCol_ButtonActive,
    # ImGuiCol_Header                : Header* colors are used for CollapsingHeader, TreeNode, Selectable, MenuItem
    # ImGuiCol_HeaderHovered         : ImGuiCol_HeaderHovered,
    # ImGuiCol_HeaderActive          : ImGuiCol_HeaderActive,
    # ImGuiCol_Separator             : ImGuiCol_Separator,
    # ImGuiCol_SeparatorHovered      : ImGuiCol_SeparatorHovered,
    # ImGuiCol_SeparatorActive       : ImGuiCol_SeparatorActive,
    # ImGuiCol_ResizeGrip            : Resize grip in lower-right and lower-left corners of windows.
    # ImGuiCol_ResizeGripHovered     : ImGuiCol_ResizeGripHovered,
    # ImGuiCol_ResizeGripActive      : ImGuiCol_ResizeGripActive,
    # ImGuiCol_Tab                   : Set each RowBg color with ImGuiCol_TableRowBg or ImGuiCol_TableRowBgAlt (equivalent of calling TableSetBgColor with ImGuiTableBgFlags_RowBg0 on each row manually)
    # ImGuiCol_TabHovered            : ImGuiCol_TabHovered,
    # ImGuiCol_TabActive             : ImGuiCol_TabActive,
    # ImGuiCol_TabUnfocused          : ImGuiCol_TabUnfocused,
    # ImGuiCol_TabUnfocusedActive    : ImGuiCol_TabUnfocusedActive,
    # ImGuiCol_DockingPreview        : Preview overlay color when about to docking something
    # ImGuiCol_DockingEmptyBg        : Background color for empty node (e.g. CentralNode with no window docked into it)
    # ImGuiCol_PlotLines             : ImGuiCol_PlotLines,
    # ImGuiCol_PlotLinesHovered      : ImGuiCol_PlotLinesHovered,
    # ImGuiCol_PlotHistogram         : ImGuiCol_PlotHistogram,
    # ImGuiCol_PlotHistogramHovered  : ImGuiCol_PlotHistogramHovered,
    # ImGuiCol_TableHeaderBg         : Table header background
    # ImGuiCol_TableBorderStrong     : Table outer and header borders (prefer using Alpha=1.0 here)
    # ImGuiCol_TableBorderLight      : Table inner borders (prefer using Alpha=1.0 here)
    # ImGuiCol_TableRowBg            : Set each RowBg color with ImGuiCol_TableRowBg or ImGuiCol_TableRowBgAlt (equivalent of calling TableSetBgColor with ImGuiTableBgFlags_RowBg0 on each row manually)
    # ImGuiCol_TableRowBgAlt         : Set each RowBg color with ImGuiCol_TableRowBg or ImGuiCol_TableRowBgAlt (equivalent of calling TableSetBgColor with ImGuiTableBgFlags_RowBg0 on each row manually)
    # ImGuiCol_TextSelectedBg        : ImGuiCol_TextSelectedBg,
    # ImGuiCol_DragDropTarget        : Rectangle highlighting a drop target
    # ImGuiCol_NavHighlight          : keyboard: current highlighted item
    # ImGuiCol_NavWindowingHighlight : Highlight window when using CTRL+TAB
    # ImGuiCol_NavWindowingDimBg     : colorize entire screen behind the CTRL+TAB window list, when active
    # ImGuiCol_ModalWindowDimBg      : colorize entire screen behind a modal window, when one is active
    # ImGuiCol_COUNT                 : ImGuiCol_COUNT
    cffi::enum define ImGuiCol_ {
        ImGuiCol_Text                  0
        ImGuiCol_TextDisabled          1
        ImGuiCol_WindowBg              2
        ImGuiCol_ChildBg               3
        ImGuiCol_PopupBg               4
        ImGuiCol_Border                5
        ImGuiCol_BorderShadow          6
        ImGuiCol_FrameBg               7
        ImGuiCol_FrameBgHovered        8
        ImGuiCol_FrameBgActive         9
        ImGuiCol_TitleBg               10
        ImGuiCol_TitleBgActive         11
        ImGuiCol_TitleBgCollapsed      12
        ImGuiCol_MenuBarBg             13
        ImGuiCol_ScrollbarBg           14
        ImGuiCol_ScrollbarGrab         15
        ImGuiCol_ScrollbarGrabHovered  16
        ImGuiCol_ScrollbarGrabActive   17
        ImGuiCol_CheckMark             18
        ImGuiCol_SliderGrab            19
        ImGuiCol_SliderGrabActive      20
        ImGuiCol_Button                21
        ImGuiCol_ButtonHovered         22
        ImGuiCol_ButtonActive          23
        ImGuiCol_Header                24
        ImGuiCol_HeaderHovered         25
        ImGuiCol_HeaderActive          26
        ImGuiCol_Separator             27
        ImGuiCol_SeparatorHovered      28
        ImGuiCol_SeparatorActive       29
        ImGuiCol_ResizeGrip            30
        ImGuiCol_ResizeGripHovered     31
        ImGuiCol_ResizeGripActive      32
        ImGuiCol_Tab                   33
        ImGuiCol_TabHovered            34
        ImGuiCol_TabActive             35
        ImGuiCol_TabUnfocused          36
        ImGuiCol_TabUnfocusedActive    37
        ImGuiCol_DockingPreview        38
        ImGuiCol_DockingEmptyBg        39
        ImGuiCol_PlotLines             40
        ImGuiCol_PlotLinesHovered      41
        ImGuiCol_PlotHistogram         42
        ImGuiCol_PlotHistogramHovered  43
        ImGuiCol_TableHeaderBg         44
        ImGuiCol_TableBorderStrong     45
        ImGuiCol_TableBorderLight      46
        ImGuiCol_TableRowBg            47
        ImGuiCol_TableRowBgAlt         48
        ImGuiCol_TextSelectedBg        49
        ImGuiCol_DragDropTarget        50
        ImGuiCol_NavHighlight          51
        ImGuiCol_NavWindowingHighlight 52
        ImGuiCol_NavWindowingDimBg     53
        ImGuiCol_ModalWindowDimBg      54
        ImGuiCol_COUNT                 55
    }

    # ImGuiColorEditFlags_None             : ImGuiColorEditFlags_None            = 0,
    # ImGuiColorEditFlags_NoAlpha          : ColorEdit, ColorPicker, ColorButton: ignore Alpha component (will only read 3 components from the input pointer).
    # ImGuiColorEditFlags_NoPicker         : ColorEdit: disable picker when clicking on color square.
    # ImGuiColorEditFlags_NoOptions        : small preview.
    # ImGuiColorEditFlags_NoSmallPreview   : ColorEdit, ColorPicker: disable color square preview next to the inputs. (e.g. to show only the inputs)
    # ImGuiColorEditFlags_NoInputs         : text widgets (e.g. to show only the small preview color square).
    # ImGuiColorEditFlags_NoTooltip        : ColorEdit, ColorPicker, ColorButton: disable tooltip when hovering the preview.
    # ImGuiColorEditFlags_NoLabel          : ColorEdit, ColorPicker: disable display of inline text label (the label is still forwarded to the tooltip and picker).
    # ImGuiColorEditFlags_NoSidePreview    : ColorPicker: disable bigger color preview on right side of the picker, use small color square preview instead.
    # ImGuiColorEditFlags_NoDragDrop       : ColorEdit: disable drag and drop target. ColorButton: disable drag and drop source.
    # ImGuiColorEditFlags_NoBorder         : ColorButton: disable border (which is enforced by default)
    # ImGuiColorEditFlags_AlphaBar         : gradient in picker.
    # ImGuiColorEditFlags_AlphaPreview     : ColorEdit, ColorPicker, ColorButton: display preview as a transparent color over a checkerboard, instead of opaque.
    # ImGuiColorEditFlags_AlphaPreviewHalf : half checkerboard, instead of opaque.
    # ImGuiColorEditFlags_HDR              : (WIP) ColorEdit: Currently only disable 0.0f..1.0f limits in RGBA edition (note: you probably want to use ImGuiColorEditFlags_Float flag as well).
    # ImGuiColorEditFlags_DisplayRGB       : Hex.
    # ImGuiColorEditFlags_DisplayHSV       : "
    # ImGuiColorEditFlags_DisplayHex       : "
    # ImGuiColorEditFlags_Uint8            : ColorEdit, ColorPicker, ColorButton: _display_ values formatted as 0..255.
    # ImGuiColorEditFlags_Float            : (WIP) ColorEdit: Currently only disable 0.0f..1.0f limits in RGBA edition (note: you probably want to use ImGuiColorEditFlags_Float flag as well).
    # ImGuiColorEditFlags_PickerHueBar     : Value.
    # ImGuiColorEditFlags_PickerHueWheel   : Value.
    # ImGuiColorEditFlags_InputRGB         : ColorEdit, ColorPicker: input and output data in RGB format.
    # ImGuiColorEditFlags_InputHSV         : ColorEdit, ColorPicker: input and output data in HSV format.
    # ImGuiColorEditFlags_DefaultOptions_  : ImGuiColorEditFlags_DefaultOptions_ = ImGuiColorEditFlags_Uint8 | ImGuiColorEditFlags_DisplayRGB | ImGuiColorEditFlags_InputRGB | ImGuiColorEditFlags_PickerHueBar,
    # ImGuiColorEditFlags_DisplayMask_     : ImGuiColorEditFlags_DisplayMask_    = ImGuiColorEditFlags_DisplayRGB | ImGuiColorEditFlags_DisplayHSV | ImGuiColorEditFlags_DisplayHex,
    # ImGuiColorEditFlags_DataTypeMask_    : ImGuiColorEditFlags_DataTypeMask_   = ImGuiColorEditFlags_Uint8 | ImGuiColorEditFlags_Float,
    # ImGuiColorEditFlags_PickerMask_      : ImGuiColorEditFlags_PickerMask_     = ImGuiColorEditFlags_PickerHueWheel | ImGuiColorEditFlags_PickerHueBar,
    # ImGuiColorEditFlags_InputMask_       : ImGuiColorEditFlags_InputMask_      = ImGuiColorEditFlags_InputRGB | ImGuiColorEditFlags_InputHSV
    cffi::enum define ImGuiColorEditFlags_ {
        ImGuiColorEditFlags_None             0
        ImGuiColorEditFlags_NoAlpha          2
        ImGuiColorEditFlags_NoPicker         4
        ImGuiColorEditFlags_NoOptions        8
        ImGuiColorEditFlags_NoSmallPreview   16
        ImGuiColorEditFlags_NoInputs         32
        ImGuiColorEditFlags_NoTooltip        64
        ImGuiColorEditFlags_NoLabel          128
        ImGuiColorEditFlags_NoSidePreview    256
        ImGuiColorEditFlags_NoDragDrop       512
        ImGuiColorEditFlags_NoBorder         1024
        ImGuiColorEditFlags_AlphaBar         65536
        ImGuiColorEditFlags_AlphaPreview     131072
        ImGuiColorEditFlags_AlphaPreviewHalf 262144
        ImGuiColorEditFlags_HDR              524288
        ImGuiColorEditFlags_DisplayRGB       1048576
        ImGuiColorEditFlags_DisplayHSV       2097152
        ImGuiColorEditFlags_DisplayHex       4194304
        ImGuiColorEditFlags_Uint8            8388608
        ImGuiColorEditFlags_Float            16777216
        ImGuiColorEditFlags_PickerHueBar     33554432
        ImGuiColorEditFlags_PickerHueWheel   67108864
        ImGuiColorEditFlags_InputRGB         134217728
        ImGuiColorEditFlags_InputHSV         268435456
        ImGuiColorEditFlags_DefaultOptions_  177209344
        ImGuiColorEditFlags_DisplayMask_     7340032
        ImGuiColorEditFlags_DataTypeMask_    25165824
        ImGuiColorEditFlags_PickerMask_      100663296
        ImGuiColorEditFlags_InputMask_       402653184
    }

    cffi::enum define ImGuiComboFlagsPrivate_ {
        ImGuiComboFlags_CustomPreview 1048576
    }

    # ImGuiComboFlags_None           : ImGuiComboFlags_None                    = 0,
    # ImGuiComboFlags_PopupAlignLeft : Align the popup toward the left by default
    # ImGuiComboFlags_HeightSmall    : Max ~4 items visible. Tip: If you want your combo popup to be a specific size you can use SetNextWindowSizeConstraints() prior to calling BeginCombo()
    # ImGuiComboFlags_HeightRegular  : Max ~8 items visible (default)
    # ImGuiComboFlags_HeightLarge    : Max ~20 items visible
    # ImGuiComboFlags_HeightLargest  : As many fitting items as possible
    # ImGuiComboFlags_NoArrowButton  : Display on the preview box without the square arrow button
    # ImGuiComboFlags_NoPreview      : Display only a square arrow button
    # ImGuiComboFlags_HeightMask_    : ImGuiComboFlags_HeightMask_             = ImGuiComboFlags_HeightSmall | ImGuiComboFlags_HeightRegular | ImGuiComboFlags_HeightLarge | ImGuiComboFlags_HeightLargest
    cffi::enum define ImGuiComboFlags_ {
        ImGuiComboFlags_None           0
        ImGuiComboFlags_PopupAlignLeft 1
        ImGuiComboFlags_HeightSmall    2
        ImGuiComboFlags_HeightRegular  4
        ImGuiComboFlags_HeightLarge    8
        ImGuiComboFlags_HeightLargest  16
        ImGuiComboFlags_NoArrowButton  32
        ImGuiComboFlags_NoPreview      64
        ImGuiComboFlags_HeightMask_    30
    }

    # ImGuiCond_None         : No condition (always set the variable), same as _Always
    # ImGuiCond_Always       : Important: Treat as a regular enum! Do NOT combine multiple values using binary operators! All the functions above treat 0 as a shortcut to ImGuiCond_Always.
    # ImGuiCond_Once         : Set the variable once per runtime session (only the first call will succeed)
    # ImGuiCond_FirstUseEver : window has no persistently saved data (no entry in .ini file)
    # ImGuiCond_Appearing    : inactive (or the first time)
    cffi::enum define ImGuiCond_ {
        ImGuiCond_None         0
        ImGuiCond_Always       1
        ImGuiCond_Once         2
        ImGuiCond_FirstUseEver 4
        ImGuiCond_Appearing    8
    }

    # ImGuiConfigFlags_None                    : ImGuiConfigFlags_None                   = 0,
    # ImGuiConfigFlags_NavEnableKeyboard       : Keyboard: Set io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard to enable. NewFrame() will automatically fill io.NavInputs[] based on your io.AddKeyEvent() calls.
    # ImGuiConfigFlags_NavEnableGamepad        : Gamepad:  Set io.ConfigFlags |= ImGuiConfigFlags_NavEnableGamepad to enable. Backend: set ImGuiBackendFlags_HasGamepad and fill the io.NavInputs[] fields before calling NewFrame(). Note that io.NavInputs[] is cleared by EndFrame().
    # ImGuiConfigFlags_NavEnableSetMousePos    : console systems where moving a virtual mouse is awkward. Will update io.MousePos and set io.WantSetMousePos=true. If enabled you MUST honor io.WantSetMousePos requests in your backend, otherwise ImGui will react as if the mouse is jumping around back and forth.
    # ImGuiConfigFlags_NavNoCaptureKeyboard    : Instruct navigation to not set the io.WantCaptureKeyboard flag when io.NavActive is set.
    # ImGuiConfigFlags_NoMouse                 : buttons in NewFrame(). This allows ignoring the mouse information set by the backend.
    # ImGuiConfigFlags_NoMouseCursorChange     : Instruct backend to not alter mouse cursor shape and visibility. Use if the backend cursor changes are interfering with yours and you don't want to use SetMouseCursor() to change mouse cursor. You may want to honor requests from imgui by reading GetMouseCursor() yourself instead.
    # ImGuiConfigFlags_DockingEnable           : [BETA API] Enable with io.ConfigFlags |= ImGuiConfigFlags_DockingEnable.
    # ImGuiConfigFlags_ViewportsEnable         : Viewport enable flags (require both ImGuiBackendFlags_PlatformHasViewports + ImGuiBackendFlags_RendererHasViewports set by the respective backends)
    # ImGuiConfigFlags_DpiEnableScaleViewports : [BETA: Don't use] FIXME-DPI: Reposition and resize imgui windows when the DpiScale of a viewport changed (mostly useful for the main viewport hosting other window). Note that resizing the main window itself is up to your application.
    # ImGuiConfigFlags_DpiEnableScaleFonts     : or fonts in the Platform_OnChangedViewport callback, but this is all early work in progress.
    # ImGuiConfigFlags_IsSRGB                  : Application is SRGB-aware.
    # ImGuiConfigFlags_IsTouchScreen           : Application is using a touch screen instead of a mouse.
    cffi::enum define ImGuiConfigFlags_ {
        ImGuiConfigFlags_None                    0
        ImGuiConfigFlags_NavEnableKeyboard       1
        ImGuiConfigFlags_NavEnableGamepad        2
        ImGuiConfigFlags_NavEnableSetMousePos    4
        ImGuiConfigFlags_NavNoCaptureKeyboard    8
        ImGuiConfigFlags_NoMouse                 16
        ImGuiConfigFlags_NoMouseCursorChange     32
        ImGuiConfigFlags_DockingEnable           64
        ImGuiConfigFlags_ViewportsEnable         1024
        ImGuiConfigFlags_DpiEnableScaleViewports 16384
        ImGuiConfigFlags_DpiEnableScaleFonts     32768
        ImGuiConfigFlags_IsSRGB                  1048576
        ImGuiConfigFlags_IsTouchScreen           2097152
    }

    cffi::enum define ImGuiContextHookType {
        ImGuiContextHookType_NewFramePre     0
        ImGuiContextHookType_NewFramePost    1
        ImGuiContextHookType_EndFramePre     2
        ImGuiContextHookType_EndFramePost    3
        ImGuiContextHookType_RenderPre       4
        ImGuiContextHookType_RenderPost      5
        ImGuiContextHookType_Shutdown        6
        ImGuiContextHookType_PendingRemoval_ 7
    }

    cffi::enum define ImGuiDataAuthority_ {
        ImGuiDataAuthority_Auto     0
        ImGuiDataAuthority_DockNode 1
        ImGuiDataAuthority_Window   2
    }

    cffi::enum define ImGuiDataTypePrivate_ {
        ImGuiDataType_String  11
        ImGuiDataType_Pointer 12
        ImGuiDataType_ID      13
    }

    # ImGuiDataType_S8     : char (with sensible compilers)
    # ImGuiDataType_U8     : unsigned char
    # ImGuiDataType_S16    : short
    # ImGuiDataType_U16    : unsigned short
    # ImGuiDataType_S32    : int
    # ImGuiDataType_U32    : unsigned int
    # ImGuiDataType_S64    : __int64
    # ImGuiDataType_U64    : unsigned __int64
    # ImGuiDataType_Float  : float
    # ImGuiDataType_Double : double
    # ImGuiDataType_COUNT  : ImGuiDataType_COUNT
    cffi::enum define ImGuiDataType_ {
        ImGuiDataType_S8     0
        ImGuiDataType_U8     1
        ImGuiDataType_S16    2
        ImGuiDataType_U16    3
        ImGuiDataType_S32    4
        ImGuiDataType_U32    5
        ImGuiDataType_S64    6
        ImGuiDataType_U64    7
        ImGuiDataType_Float  8
        ImGuiDataType_Double 9
        ImGuiDataType_COUNT  10
    }

    cffi::enum define ImGuiDebugLogFlags_ {
        ImGuiDebugLogFlags_None          0
        ImGuiDebugLogFlags_EventActiveId 1
        ImGuiDebugLogFlags_EventFocus    2
        ImGuiDebugLogFlags_EventPopup    4
        ImGuiDebugLogFlags_EventNav      8
        ImGuiDebugLogFlags_EventIO       16
        ImGuiDebugLogFlags_EventDocking  32
        ImGuiDebugLogFlags_EventViewport 64
        ImGuiDebugLogFlags_EventMask_    127
        ImGuiDebugLogFlags_OutputToTTY   1024
    }

    # ImGuiDir_None  : ImGuiDir_None    = -1,
    # ImGuiDir_Left  : ImGuiDir_Left    = 0,
    # ImGuiDir_Right : ImGuiDir_Right   = 1,
    # ImGuiDir_Up    : ImGuiDir_Up      = 2,
    # ImGuiDir_Down  : ImGuiDir_Down    = 3,
    # ImGuiDir_COUNT : ImGuiDir_COUNT
    cffi::enum define ImGuiDir_ {
        ImGuiDir_None  -1
        ImGuiDir_Left  0
        ImGuiDir_Right 1
        ImGuiDir_Up    2
        ImGuiDir_Down  3
        ImGuiDir_COUNT 4
    }

    # ImGuiDockNodeFlags_NoDocking               : Disable docking inside the Central Node, which will be always kept empty.
    cffi::enum define ImGuiDockNodeFlagsPrivate_ {
        ImGuiDockNodeFlags_DockSpace               1024
        ImGuiDockNodeFlags_CentralNode             2048
        ImGuiDockNodeFlags_NoTabBar                4096
        ImGuiDockNodeFlags_HiddenTabBar            8192
        ImGuiDockNodeFlags_NoWindowMenuButton      16384
        ImGuiDockNodeFlags_NoCloseButton           32768
        ImGuiDockNodeFlags_NoDocking               65536
        ImGuiDockNodeFlags_NoDockingSplitMe        131072
        ImGuiDockNodeFlags_NoDockingSplitOther     262144
        ImGuiDockNodeFlags_NoDockingOverMe         524288
        ImGuiDockNodeFlags_NoDockingOverOther      1048576
        ImGuiDockNodeFlags_NoDockingOverEmpty      2097152
        ImGuiDockNodeFlags_NoResizeX               4194304
        ImGuiDockNodeFlags_NoResizeY               8388608
        ImGuiDockNodeFlags_SharedFlagsInheritMask_ -1
        ImGuiDockNodeFlags_NoResizeFlagsMask_      12582944
        ImGuiDockNodeFlags_LocalFlagsMask_         12713072
        ImGuiDockNodeFlags_LocalFlagsTransferMask_ 12712048
        ImGuiDockNodeFlags_SavedFlagsMask_         12712992
    }

    # ImGuiDockNodeFlags_None                   : ImGuiDockNodeFlags_None                         = 0,
    # ImGuiDockNodeFlags_KeepAliveOnly          : e.g. if you have multiple tabs with a dockspace inside each tab: submit the non-visible dockspaces with ImGuiDockNodeFlags_KeepAliveOnly.
    # ImGuiDockNodeFlags_NoDockingInCentralNode : Disable docking inside the Central Node, which will be always kept empty.
    # ImGuiDockNodeFlags_PassthruCentralNode    : This is often used with ImGuiDockNodeFlags_PassthruCentralNode.
    # ImGuiDockNodeFlags_NoSplit                : Disable splitting the node into smaller nodes. Useful e.g. when embedding dockspaces into a main root one (the root one may have splitting disabled to reduce confusion). Note: when turned off, existing splits will be preserved.
    # ImGuiDockNodeFlags_NoResize               : separators. Useful with programmatically setup dockspaces.
    # ImGuiDockNodeFlags_AutoHideTabBar         : Tab bar will automatically hide when there is a single window in the dock node.
    cffi::enum define ImGuiDockNodeFlags_ {
        ImGuiDockNodeFlags_None                   0
        ImGuiDockNodeFlags_KeepAliveOnly          1
        ImGuiDockNodeFlags_NoDockingInCentralNode 4
        ImGuiDockNodeFlags_PassthruCentralNode    8
        ImGuiDockNodeFlags_NoSplit                16
        ImGuiDockNodeFlags_NoResize               32
        ImGuiDockNodeFlags_AutoHideTabBar         64
    }

    cffi::enum define ImGuiDockNodeState {
        ImGuiDockNodeState_Unknown                                   0
        ImGuiDockNodeState_HostWindowHiddenBecauseSingleWindow       1
        ImGuiDockNodeState_HostWindowHiddenBecauseWindowsAreResizing 2
        ImGuiDockNodeState_HostWindowVisible                         3
    }

    # ImGuiDragDropFlags_None                     : ImGuiDragDropFlags_None                         = 0,
    # ImGuiDragDropFlags_SourceNoPreviewTooltip   : By default, a successful call to BeginDragDropSource opens a tooltip so you can display a preview or description of the source contents. This flag disable this behavior.
    # ImGuiDragDropFlags_SourceNoDisableHover     : By default, when dragging we clear data so that IsItemHovered() will return false, to avoid subsequent user code submitting tooltips. This flag disable this behavior so you can still call IsItemHovered() on the source item.
    # ImGuiDragDropFlags_SourceNoHoldToOpenOthers : Disable the behavior that allows to open tree nodes and collapsing header by holding over them while dragging a source item.
    # ImGuiDragDropFlags_SourceAllowNullID        : Allow items such as Text(), Image() that have no unique identifier to be used as drag source, by manufacturing a temporary identifier based on their window-relative position. This is extremely unusual within the dear imgui ecosystem and so we made it explicit.
    # ImGuiDragDropFlags_SourceExtern             : window info. Will always return true. Only one Extern source can be active simultaneously.
    # ImGuiDragDropFlags_SourceAutoExpirePayload  : Automatically expire the payload if the source cease to be submitted (otherwise payloads are persisting while being dragged)
    # ImGuiDragDropFlags_AcceptBeforeDelivery     : accept contents of a given type. If ImGuiDragDropFlags_AcceptBeforeDelivery is set you can peek into the payload before the mouse button is released.
    # ImGuiDragDropFlags_AcceptNoDrawDefaultRect  : Do not draw the default highlight rectangle when hovering over target.
    # ImGuiDragDropFlags_AcceptNoPreviewTooltip   : Request hiding the BeginDragDropSource tooltip from the BeginDragDropTarget site.
    # ImGuiDragDropFlags_AcceptPeekOnly           : For peeking ahead and inspecting the payload before delivery.
    cffi::enum define ImGuiDragDropFlags_ {
        ImGuiDragDropFlags_None                     0
        ImGuiDragDropFlags_SourceNoPreviewTooltip   1
        ImGuiDragDropFlags_SourceNoDisableHover     2
        ImGuiDragDropFlags_SourceNoHoldToOpenOthers 4
        ImGuiDragDropFlags_SourceAllowNullID        8
        ImGuiDragDropFlags_SourceExtern             16
        ImGuiDragDropFlags_SourceAutoExpirePayload  32
        ImGuiDragDropFlags_AcceptBeforeDelivery     1024
        ImGuiDragDropFlags_AcceptNoDrawDefaultRect  2048
        ImGuiDragDropFlags_AcceptNoPreviewTooltip   4096
        ImGuiDragDropFlags_AcceptPeekOnly           3072
    }

    # ImGuiFocusedFlags_None                : ImGuiFocusedFlags_None                          = 0,
    # ImGuiFocusedFlags_ChildWindows        : Return true if any children of the window is focused
    # ImGuiFocusedFlags_RootWindow          : Test from root window (top most parent of the current hierarchy)
    # ImGuiFocusedFlags_AnyWindow           : Return true if any window is focused. Important: If you are trying to tell how to dispatch your low-level inputs, do NOT use this. Use 'io.WantCaptureMouse' instead! Please read the FAQ!
    # ImGuiFocusedFlags_NoPopupHierarchy    : Do not consider popup hierarchy (do not treat popup emitter as parent of popup) (when used with _ChildWindows or _RootWindow)
    # ImGuiFocusedFlags_DockHierarchy       : Consider docking hierarchy (treat dockspace host as parent of docked window) (when used with _ChildWindows or _RootWindow)
    # ImGuiFocusedFlags_RootAndChildWindows : ImGuiFocusedFlags_RootAndChildWindows           = ImGuiFocusedFlags_RootWindow | ImGuiFocusedFlags_ChildWindows
    cffi::enum define ImGuiFocusedFlags_ {
        ImGuiFocusedFlags_None                0
        ImGuiFocusedFlags_ChildWindows        1
        ImGuiFocusedFlags_RootWindow          2
        ImGuiFocusedFlags_AnyWindow           4
        ImGuiFocusedFlags_NoPopupHierarchy    8
        ImGuiFocusedFlags_DockHierarchy       16
        ImGuiFocusedFlags_RootAndChildWindows 3
    }

    # ImGuiHoveredFlags_None                         : window, not obstructed by another window, not obstructed by an active popup or modal blocking inputs under them.
    # ImGuiHoveredFlags_ChildWindows                 : IsWindowHovered() only: Return true if any children of the window is hovered
    # ImGuiHoveredFlags_RootWindow                   : IsWindowHovered() only: Test from root window (top most parent of the current hierarchy)
    # ImGuiHoveredFlags_AnyWindow                    : IsWindowHovered() only: Return true if any window is hovered
    # ImGuiHoveredFlags_NoPopupHierarchy             : IsWindowHovered() only: Do not consider popup hierarchy (do not treat popup emitter as parent of popup) (when used with _ChildWindows or _RootWindow)
    # ImGuiHoveredFlags_DockHierarchy                : IsWindowHovered() only: Consider docking hierarchy (treat dockspace host as parent of docked window) (when used with _ChildWindows or _RootWindow)
    # ImGuiHoveredFlags_AllowWhenBlockedByPopup      : - You can bypass the hovering restriction by using ImGuiHoveredFlags_AllowWhenBlockedByPopup when calling IsItemHovered() or IsWindowHovered().
    # ImGuiHoveredFlags_AllowWhenBlockedByActiveItem : window. Useful for Drag and Drop patterns.
    # ImGuiHoveredFlags_AllowWhenOverlapped          : IsItemHovered() only: Return true even if the position is obstructed or overlapped by another window
    # ImGuiHoveredFlags_AllowWhenDisabled            : IsItemHovered() only: Return true even if the item is disabled
    # ImGuiHoveredFlags_NoNavOverride                : keyboard navigation state when active, always query mouse.
    # ImGuiHoveredFlags_RectOnly                     : ImGuiHoveredFlags_RectOnly                      = ImGuiHoveredFlags_AllowWhenBlockedByPopup | ImGuiHoveredFlags_AllowWhenBlockedByActiveItem | ImGuiHoveredFlags_AllowWhenOverlapped,
    # ImGuiHoveredFlags_RootAndChildWindows          : ImGuiHoveredFlags_RootAndChildWindows           = ImGuiHoveredFlags_RootWindow | ImGuiHoveredFlags_ChildWindows
    cffi::enum define ImGuiHoveredFlags_ {
        ImGuiHoveredFlags_None                         0
        ImGuiHoveredFlags_ChildWindows                 1
        ImGuiHoveredFlags_RootWindow                   2
        ImGuiHoveredFlags_AnyWindow                    4
        ImGuiHoveredFlags_NoPopupHierarchy             8
        ImGuiHoveredFlags_DockHierarchy                16
        ImGuiHoveredFlags_AllowWhenBlockedByPopup      32
        ImGuiHoveredFlags_AllowWhenBlockedByActiveItem 128
        ImGuiHoveredFlags_AllowWhenOverlapped          256
        ImGuiHoveredFlags_AllowWhenDisabled            512
        ImGuiHoveredFlags_NoNavOverride                1024
        ImGuiHoveredFlags_RectOnly                     416
        ImGuiHoveredFlags_RootAndChildWindows          3
    }

    cffi::enum define ImGuiInputEventType {
        ImGuiInputEventType_None          0
        ImGuiInputEventType_MousePos      1
        ImGuiInputEventType_MouseWheel    2
        ImGuiInputEventType_MouseButton   3
        ImGuiInputEventType_MouseViewport 4
        ImGuiInputEventType_Key           5
        ImGuiInputEventType_Text          6
        ImGuiInputEventType_Focus         7
        ImGuiInputEventType_COUNT         8
    }

    cffi::enum define ImGuiInputSource {
        ImGuiInputSource_None      0
        ImGuiInputSource_Mouse     1
        ImGuiInputSource_Keyboard  2
        ImGuiInputSource_Gamepad   3
        ImGuiInputSource_Clipboard 4
        ImGuiInputSource_Nav       5
        ImGuiInputSource_COUNT     6
    }

    cffi::enum define ImGuiInputTextFlagsPrivate_ {
        ImGuiInputTextFlags_Multiline    67108864
        ImGuiInputTextFlags_NoMarkEdited 134217728
        ImGuiInputTextFlags_MergedItem   268435456
    }

    # ImGuiInputTextFlags_None                : ImGuiInputTextFlags_None                = 0,
    # ImGuiInputTextFlags_CharsDecimal        : 
    # ImGuiInputTextFlags_CharsHexadecimal    : Allow 0123456789ABCDEFabcdef
    # ImGuiInputTextFlags_CharsUppercase      : Turn a..z into A..Z
    # ImGuiInputTextFlags_CharsNoBlank        : Filter out spaces, tabs
    # ImGuiInputTextFlags_AutoSelectAll       : Select entire text when first taking mouse focus
    # ImGuiInputTextFlags_EnterReturnsTrue    : Return 'true' when Enter is pressed (as opposed to every time the value was modified). Consider looking at the IsItemDeactivatedAfterEdit() function.
    # ImGuiInputTextFlags_CallbackCompletion  : Callback on pressing TAB (for completion handling)
    # ImGuiInputTextFlags_CallbackHistory     : Down arrows (for history handling)
    # ImGuiInputTextFlags_CallbackAlways      : Callback on each iteration. User code may query cursor position, modify text buffer.
    # ImGuiInputTextFlags_CallbackCharFilter  : Callback on character inputs to replace or discard them. Modify 'EventChar' to replace or discard, or return 1 in callback to discard.
    # ImGuiInputTextFlags_AllowTabInput       : Pressing TAB input a '\t' character into the text field
    # ImGuiInputTextFlags_CtrlEnterForNewLine : In multi-line mode, unfocus with Enter, add new line with Ctrl+Enter (default is opposite: unfocus with Ctrl+Enter, add line with Enter).
    # ImGuiInputTextFlags_NoHorizontalScroll  : Disable following the cursor horizontally
    # ImGuiInputTextFlags_AlwaysOverwrite     : Overwrite mode
    # ImGuiInputTextFlags_ReadOnly            : Read-only mode
    # ImGuiInputTextFlags_Password            : Password mode, display all characters as '*'
    # ImGuiInputTextFlags_NoUndoRedo          : redo stack you need e.g. to call ClearActiveID().
    # ImGuiInputTextFlags_CharsScientific     : eE (Scientific notation input)
    # ImGuiInputTextFlags_CallbackResize      : imgui_stdlib.h for an example of using this)
    # ImGuiInputTextFlags_CallbackEdit        : Callback on any edit (note that InputText() already returns true on edit, the callback is useful mainly to manipulate the underlying buffer while focus is active)
    cffi::enum define ImGuiInputTextFlags_ {
        ImGuiInputTextFlags_None                0
        ImGuiInputTextFlags_CharsDecimal        1
        ImGuiInputTextFlags_CharsHexadecimal    2
        ImGuiInputTextFlags_CharsUppercase      4
        ImGuiInputTextFlags_CharsNoBlank        8
        ImGuiInputTextFlags_AutoSelectAll       16
        ImGuiInputTextFlags_EnterReturnsTrue    32
        ImGuiInputTextFlags_CallbackCompletion  64
        ImGuiInputTextFlags_CallbackHistory     128
        ImGuiInputTextFlags_CallbackAlways      256
        ImGuiInputTextFlags_CallbackCharFilter  512
        ImGuiInputTextFlags_AllowTabInput       1024
        ImGuiInputTextFlags_CtrlEnterForNewLine 2048
        ImGuiInputTextFlags_NoHorizontalScroll  4096
        ImGuiInputTextFlags_AlwaysOverwrite     8192
        ImGuiInputTextFlags_ReadOnly            16384
        ImGuiInputTextFlags_Password            32768
        ImGuiInputTextFlags_NoUndoRedo          65536
        ImGuiInputTextFlags_CharsScientific     131072
        ImGuiInputTextFlags_CallbackResize      262144
        ImGuiInputTextFlags_CallbackEdit        524288
    }

    cffi::enum define ImGuiItemFlags_ {
        ImGuiItemFlags_None                     0
        ImGuiItemFlags_NoTabStop                1
        ImGuiItemFlags_ButtonRepeat             2
        ImGuiItemFlags_Disabled                 4
        ImGuiItemFlags_NoNav                    8
        ImGuiItemFlags_NoNavDefaultFocus        16
        ImGuiItemFlags_SelectableDontClosePopup 32
        ImGuiItemFlags_MixedValue               64
        ImGuiItemFlags_ReadOnly                 128
        ImGuiItemFlags_Inputable                256
    }

    cffi::enum define ImGuiItemStatusFlags_ {
        ImGuiItemStatusFlags_None             0
        ImGuiItemStatusFlags_HoveredRect      1
        ImGuiItemStatusFlags_HasDisplayRect   2
        ImGuiItemStatusFlags_Edited           4
        ImGuiItemStatusFlags_ToggledSelection 8
        ImGuiItemStatusFlags_ToggledOpen      16
        ImGuiItemStatusFlags_HasDeactivated   32
        ImGuiItemStatusFlags_Deactivated      64
        ImGuiItemStatusFlags_HoveredWindow    128
        ImGuiItemStatusFlags_FocusedByTabbing 256
    }

    cffi::enum define ImGuiKeyPrivate_ {
        ImGuiKey_LegacyNativeKey_BEGIN 0
        ImGuiKey_LegacyNativeKey_END   512
        ImGuiKey_Gamepad_BEGIN         617
        ImGuiKey_Gamepad_END           641
    }

    # ImGuiKey_None               : ImGuiKey_None = 0,
    # ImGuiKey_Tab                : == ImGuiKey_NamedKey_BEGIN
    # ImGuiKey_LeftArrow          : ImGuiKey_LeftArrow,
    # ImGuiKey_RightArrow         : ImGuiKey_RightArrow,
    # ImGuiKey_UpArrow            : ImGuiKey_UpArrow,
    # ImGuiKey_DownArrow          : ImGuiKey_DownArrow,
    # ImGuiKey_PageUp             : ImGuiKey_PageUp,
    # ImGuiKey_PageDown           : ImGuiKey_PageDown,
    # ImGuiKey_Home               : ImGuiKey_Home,
    # ImGuiKey_End                : ImGuiKey_End,
    # ImGuiKey_Insert             : ImGuiKey_Insert,
    # ImGuiKey_Delete             : ImGuiKey_Delete,
    # ImGuiKey_Backspace          : ImGuiKey_Backspace,
    # ImGuiKey_Space              : ImGuiKey_Space,
    # ImGuiKey_Enter              : ImGuiKey_Enter,
    # ImGuiKey_Escape             : ImGuiKey_Escape,
    # ImGuiKey_LeftCtrl           : ImGuiKey_LeftCtrl, ImGuiKey_LeftShift, ImGuiKey_LeftAlt, ImGuiKey_LeftSuper,
    # ImGuiKey_LeftShift          : ImGuiKey_LeftCtrl, ImGuiKey_LeftShift, ImGuiKey_LeftAlt, ImGuiKey_LeftSuper,
    # ImGuiKey_LeftAlt            : ImGuiKey_LeftCtrl, ImGuiKey_LeftShift, ImGuiKey_LeftAlt, ImGuiKey_LeftSuper,
    # ImGuiKey_LeftSuper          : ImGuiKey_LeftCtrl, ImGuiKey_LeftShift, ImGuiKey_LeftAlt, ImGuiKey_LeftSuper,
    # ImGuiKey_RightCtrl          : ImGuiKey_RightCtrl, ImGuiKey_RightShift, ImGuiKey_RightAlt, ImGuiKey_RightSuper,
    # ImGuiKey_RightShift         : ImGuiKey_RightCtrl, ImGuiKey_RightShift, ImGuiKey_RightAlt, ImGuiKey_RightSuper,
    # ImGuiKey_RightAlt           : ImGuiKey_RightCtrl, ImGuiKey_RightShift, ImGuiKey_RightAlt, ImGuiKey_RightSuper,
    # ImGuiKey_RightSuper         : ImGuiKey_RightCtrl, ImGuiKey_RightShift, ImGuiKey_RightAlt, ImGuiKey_RightSuper,
    # ImGuiKey_Menu               : ImGuiKey_Menu,
    # ImGuiKey_0                  : ImGuiKey_0, ImGuiKey_1, ImGuiKey_2, ImGuiKey_3, ImGuiKey_4, ImGuiKey_5, ImGuiKey_6, ImGuiKey_7, ImGuiKey_8, ImGuiKey_9,
    # ImGuiKey_1                  : ImGuiKey_0, ImGuiKey_1, ImGuiKey_2, ImGuiKey_3, ImGuiKey_4, ImGuiKey_5, ImGuiKey_6, ImGuiKey_7, ImGuiKey_8, ImGuiKey_9,
    # ImGuiKey_2                  : ImGuiKey_0, ImGuiKey_1, ImGuiKey_2, ImGuiKey_3, ImGuiKey_4, ImGuiKey_5, ImGuiKey_6, ImGuiKey_7, ImGuiKey_8, ImGuiKey_9,
    # ImGuiKey_3                  : ImGuiKey_0, ImGuiKey_1, ImGuiKey_2, ImGuiKey_3, ImGuiKey_4, ImGuiKey_5, ImGuiKey_6, ImGuiKey_7, ImGuiKey_8, ImGuiKey_9,
    # ImGuiKey_4                  : ImGuiKey_0, ImGuiKey_1, ImGuiKey_2, ImGuiKey_3, ImGuiKey_4, ImGuiKey_5, ImGuiKey_6, ImGuiKey_7, ImGuiKey_8, ImGuiKey_9,
    # ImGuiKey_5                  : ImGuiKey_0, ImGuiKey_1, ImGuiKey_2, ImGuiKey_3, ImGuiKey_4, ImGuiKey_5, ImGuiKey_6, ImGuiKey_7, ImGuiKey_8, ImGuiKey_9,
    # ImGuiKey_6                  : ImGuiKey_0, ImGuiKey_1, ImGuiKey_2, ImGuiKey_3, ImGuiKey_4, ImGuiKey_5, ImGuiKey_6, ImGuiKey_7, ImGuiKey_8, ImGuiKey_9,
    # ImGuiKey_7                  : ImGuiKey_0, ImGuiKey_1, ImGuiKey_2, ImGuiKey_3, ImGuiKey_4, ImGuiKey_5, ImGuiKey_6, ImGuiKey_7, ImGuiKey_8, ImGuiKey_9,
    # ImGuiKey_8                  : ImGuiKey_0, ImGuiKey_1, ImGuiKey_2, ImGuiKey_3, ImGuiKey_4, ImGuiKey_5, ImGuiKey_6, ImGuiKey_7, ImGuiKey_8, ImGuiKey_9,
    # ImGuiKey_9                  : ImGuiKey_0, ImGuiKey_1, ImGuiKey_2, ImGuiKey_3, ImGuiKey_4, ImGuiKey_5, ImGuiKey_6, ImGuiKey_7, ImGuiKey_8, ImGuiKey_9,
    # ImGuiKey_A                  : ImGuiKey_A, ImGuiKey_B, ImGuiKey_C, ImGuiKey_D, ImGuiKey_E, ImGuiKey_F, ImGuiKey_G, ImGuiKey_H, ImGuiKey_I, ImGuiKey_J,
    # ImGuiKey_B                  : ImGuiKey_Backspace,
    # ImGuiKey_C                  : ImGuiKey_A, ImGuiKey_B, ImGuiKey_C, ImGuiKey_D, ImGuiKey_E, ImGuiKey_F, ImGuiKey_G, ImGuiKey_H, ImGuiKey_I, ImGuiKey_J,
    # ImGuiKey_D                  : ImGuiKey_DownArrow,
    # ImGuiKey_E                  : ImGuiKey_End,
    # ImGuiKey_F                  : ImGuiKey_A, ImGuiKey_B, ImGuiKey_C, ImGuiKey_D, ImGuiKey_E, ImGuiKey_F, ImGuiKey_G, ImGuiKey_H, ImGuiKey_I, ImGuiKey_J,
    # ImGuiKey_G                  : ImGuiKey_A, ImGuiKey_B, ImGuiKey_C, ImGuiKey_D, ImGuiKey_E, ImGuiKey_F, ImGuiKey_G, ImGuiKey_H, ImGuiKey_I, ImGuiKey_J,
    # ImGuiKey_H                  : ImGuiKey_Home,
    # ImGuiKey_I                  : ImGuiKey_Insert,
    # ImGuiKey_J                  : ImGuiKey_A, ImGuiKey_B, ImGuiKey_C, ImGuiKey_D, ImGuiKey_E, ImGuiKey_F, ImGuiKey_G, ImGuiKey_H, ImGuiKey_I, ImGuiKey_J,
    # ImGuiKey_K                  : ImGuiKey_K, ImGuiKey_L, ImGuiKey_M, ImGuiKey_N, ImGuiKey_O, ImGuiKey_P, ImGuiKey_Q, ImGuiKey_R, ImGuiKey_S, ImGuiKey_T,
    # ImGuiKey_L                  : ImGuiKey_LeftArrow,
    # ImGuiKey_M                  : ImGuiKey_Menu,
    # ImGuiKey_N                  : ImGuiKey_None = 0,
    # ImGuiKey_O                  : ImGuiKey_K, ImGuiKey_L, ImGuiKey_M, ImGuiKey_N, ImGuiKey_O, ImGuiKey_P, ImGuiKey_Q, ImGuiKey_R, ImGuiKey_S, ImGuiKey_T,
    # ImGuiKey_P                  : ImGuiKey_PageUp,
    # ImGuiKey_Q                  : ImGuiKey_K, ImGuiKey_L, ImGuiKey_M, ImGuiKey_N, ImGuiKey_O, ImGuiKey_P, ImGuiKey_Q, ImGuiKey_R, ImGuiKey_S, ImGuiKey_T,
    # ImGuiKey_R                  : ImGuiKey_RightArrow,
    # ImGuiKey_S                  : ImGuiKey_Space,
    # ImGuiKey_T                  : == ImGuiKey_NamedKey_BEGIN
    # ImGuiKey_U                  : ImGuiKey_UpArrow,
    # ImGuiKey_V                  : ImGuiKey_U, ImGuiKey_V, ImGuiKey_W, ImGuiKey_X, ImGuiKey_Y, ImGuiKey_Z,
    # ImGuiKey_W                  : ImGuiKey_U, ImGuiKey_V, ImGuiKey_W, ImGuiKey_X, ImGuiKey_Y, ImGuiKey_Z,
    # ImGuiKey_X                  : ImGuiKey_U, ImGuiKey_V, ImGuiKey_W, ImGuiKey_X, ImGuiKey_Y, ImGuiKey_Z,
    # ImGuiKey_Y                  : ImGuiKey_U, ImGuiKey_V, ImGuiKey_W, ImGuiKey_X, ImGuiKey_Y, ImGuiKey_Z,
    # ImGuiKey_Z                  : ImGuiKey_U, ImGuiKey_V, ImGuiKey_W, ImGuiKey_X, ImGuiKey_Y, ImGuiKey_Z,
    # ImGuiKey_F1                 : ImGuiKey_F1, ImGuiKey_F2, ImGuiKey_F3, ImGuiKey_F4, ImGuiKey_F5, ImGuiKey_F6,
    # ImGuiKey_F2                 : ImGuiKey_F1, ImGuiKey_F2, ImGuiKey_F3, ImGuiKey_F4, ImGuiKey_F5, ImGuiKey_F6,
    # ImGuiKey_F3                 : ImGuiKey_F1, ImGuiKey_F2, ImGuiKey_F3, ImGuiKey_F4, ImGuiKey_F5, ImGuiKey_F6,
    # ImGuiKey_F4                 : ImGuiKey_F1, ImGuiKey_F2, ImGuiKey_F3, ImGuiKey_F4, ImGuiKey_F5, ImGuiKey_F6,
    # ImGuiKey_F5                 : ImGuiKey_F1, ImGuiKey_F2, ImGuiKey_F3, ImGuiKey_F4, ImGuiKey_F5, ImGuiKey_F6,
    # ImGuiKey_F6                 : ImGuiKey_F1, ImGuiKey_F2, ImGuiKey_F3, ImGuiKey_F4, ImGuiKey_F5, ImGuiKey_F6,
    # ImGuiKey_F7                 : ImGuiKey_F7, ImGuiKey_F8, ImGuiKey_F9, ImGuiKey_F10, ImGuiKey_F11, ImGuiKey_F12,
    # ImGuiKey_F8                 : ImGuiKey_F7, ImGuiKey_F8, ImGuiKey_F9, ImGuiKey_F10, ImGuiKey_F11, ImGuiKey_F12,
    # ImGuiKey_F9                 : ImGuiKey_F7, ImGuiKey_F8, ImGuiKey_F9, ImGuiKey_F10, ImGuiKey_F11, ImGuiKey_F12,
    # ImGuiKey_F10                : ImGuiKey_F7, ImGuiKey_F8, ImGuiKey_F9, ImGuiKey_F10, ImGuiKey_F11, ImGuiKey_F12,
    # ImGuiKey_F11                : ImGuiKey_F7, ImGuiKey_F8, ImGuiKey_F9, ImGuiKey_F10, ImGuiKey_F11, ImGuiKey_F12,
    # ImGuiKey_F12                : ImGuiKey_F7, ImGuiKey_F8, ImGuiKey_F9, ImGuiKey_F10, ImGuiKey_F11, ImGuiKey_F12,
    # ImGuiKey_Apostrophe         : '
    # ImGuiKey_Comma              : ,
    # ImGuiKey_Minus              : -
    # ImGuiKey_Period             : .
    # ImGuiKey_Slash              : 
    # ImGuiKey_Semicolon          : ;
    # ImGuiKey_Equal              : =
    # ImGuiKey_LeftBracket        : [
    # ImGuiKey_Backslash          : \ (this text inhibit multiline comment caused by backslash)
    # ImGuiKey_RightBracket       : ]
    # ImGuiKey_GraveAccent        : `
    # ImGuiKey_CapsLock           : ImGuiKey_CapsLock,
    # ImGuiKey_ScrollLock         : ImGuiKey_ScrollLock,
    # ImGuiKey_NumLock            : ImGuiKey_NumLock,
    # ImGuiKey_PrintScreen        : ImGuiKey_PrintScreen,
    # ImGuiKey_Pause              : ImGuiKey_Pause,
    # ImGuiKey_Keypad0            : ImGuiKey_Keypad0, ImGuiKey_Keypad1, ImGuiKey_Keypad2, ImGuiKey_Keypad3, ImGuiKey_Keypad4,
    # ImGuiKey_Keypad1            : ImGuiKey_Keypad0, ImGuiKey_Keypad1, ImGuiKey_Keypad2, ImGuiKey_Keypad3, ImGuiKey_Keypad4,
    # ImGuiKey_Keypad2            : ImGuiKey_Keypad0, ImGuiKey_Keypad1, ImGuiKey_Keypad2, ImGuiKey_Keypad3, ImGuiKey_Keypad4,
    # ImGuiKey_Keypad3            : ImGuiKey_Keypad0, ImGuiKey_Keypad1, ImGuiKey_Keypad2, ImGuiKey_Keypad3, ImGuiKey_Keypad4,
    # ImGuiKey_Keypad4            : ImGuiKey_Keypad0, ImGuiKey_Keypad1, ImGuiKey_Keypad2, ImGuiKey_Keypad3, ImGuiKey_Keypad4,
    # ImGuiKey_Keypad5            : ImGuiKey_Keypad5, ImGuiKey_Keypad6, ImGuiKey_Keypad7, ImGuiKey_Keypad8, ImGuiKey_Keypad9,
    # ImGuiKey_Keypad6            : ImGuiKey_Keypad5, ImGuiKey_Keypad6, ImGuiKey_Keypad7, ImGuiKey_Keypad8, ImGuiKey_Keypad9,
    # ImGuiKey_Keypad7            : ImGuiKey_Keypad5, ImGuiKey_Keypad6, ImGuiKey_Keypad7, ImGuiKey_Keypad8, ImGuiKey_Keypad9,
    # ImGuiKey_Keypad8            : ImGuiKey_Keypad5, ImGuiKey_Keypad6, ImGuiKey_Keypad7, ImGuiKey_Keypad8, ImGuiKey_Keypad9,
    # ImGuiKey_Keypad9            : ImGuiKey_Keypad5, ImGuiKey_Keypad6, ImGuiKey_Keypad7, ImGuiKey_Keypad8, ImGuiKey_Keypad9,
    # ImGuiKey_KeypadDecimal      : ImGuiKey_KeypadDecimal,
    # ImGuiKey_KeypadDivide       : ImGuiKey_KeypadDivide,
    # ImGuiKey_KeypadMultiply     : ImGuiKey_KeypadMultiply,
    # ImGuiKey_KeypadSubtract     : ImGuiKey_KeypadSubtract,
    # ImGuiKey_KeypadAdd          : ImGuiKey_KeypadAdd,
    # ImGuiKey_KeypadEnter        : ImGuiKey_KeypadEnter,
    # ImGuiKey_KeypadEqual        : ImGuiKey_KeypadEqual,
    # ImGuiKey_GamepadStart       : --
    # ImGuiKey_GamepadBack        : --
    # ImGuiKey_GamepadFaceUp      : -> ImGuiNavInput_Input
    # ImGuiKey_GamepadFaceDown    : -> ImGuiNavInput_Activate
    # ImGuiKey_GamepadFaceLeft    : -> ImGuiNavInput_Menu
    # ImGuiKey_GamepadFaceRight   : -> ImGuiNavInput_Cancel
    # ImGuiKey_GamepadDpadUp      : -> ImGuiNavInput_DpadUp
    # ImGuiKey_GamepadDpadDown    : -> ImGuiNavInput_DpadDown
    # ImGuiKey_GamepadDpadLeft    : -> ImGuiNavInput_DpadLeft
    # ImGuiKey_GamepadDpadRight   : -> ImGuiNavInput_DpadRight
    # ImGuiKey_GamepadL1          : -> ImGuiNavInput_FocusPrev + ImGuiNavInput_TweakSlow
    # ImGuiKey_GamepadR1          : -> ImGuiNavInput_FocusNext + ImGuiNavInput_TweakFast
    # ImGuiKey_GamepadL2          : L Trigger (Xbox)     ZL (Switch)  L2 (PS) [Analog]
    # ImGuiKey_GamepadR2          : R Trigger (Xbox)     ZR (Switch)  R2 (PS) [Analog]
    # ImGuiKey_GamepadL3          : L Thumbstick (Xbox)  L3 (Switch)  L3 (PS)
    # ImGuiKey_GamepadR3          : R Thumbstick (Xbox)  R3 (Switch)  R3 (PS)
    # ImGuiKey_GamepadLStickUp    : -> ImGuiNavInput_LStickUp
    # ImGuiKey_GamepadLStickDown  : -> ImGuiNavInput_LStickDown
    # ImGuiKey_GamepadLStickLeft  : -> ImGuiNavInput_LStickLeft
    # ImGuiKey_GamepadLStickRight : -> ImGuiNavInput_LStickRight
    # ImGuiKey_GamepadRStickUp    : [Analog]
    # ImGuiKey_GamepadRStickDown  : [Analog]
    # ImGuiKey_GamepadRStickLeft  : [Analog]
    # ImGuiKey_GamepadRStickRight : [Analog]
    # ImGuiKey_ModCtrl            : and prefer using the real keys (e.g. ImGuiKey_LeftCtrl, ImGuiKey_RightCtrl instead of ImGuiKey_ModCtrl).
    # ImGuiKey_ModShift           : ImGuiKey_ModCtrl, ImGuiKey_ModShift, ImGuiKey_ModAlt, ImGuiKey_ModSuper,
    # ImGuiKey_ModAlt             : ImGuiKey_ModCtrl, ImGuiKey_ModShift, ImGuiKey_ModAlt, ImGuiKey_ModSuper,
    # ImGuiKey_ModSuper           : ImGuiKey_ModCtrl, ImGuiKey_ModShift, ImGuiKey_ModAlt, ImGuiKey_ModSuper,
    # ImGuiKey_COUNT              : No valid ImGuiKey is ever greater than this value
    # ImGuiKey_NamedKey_BEGIN     : == ImGuiKey_NamedKey_BEGIN
    # ImGuiKey_NamedKey_END       : ImGuiKey_NamedKey_END           = ImGuiKey_COUNT,
    # ImGuiKey_NamedKey_COUNT     : ImGuiKey_NamedKey_COUNT         = ImGuiKey_NamedKey_END - ImGuiKey_NamedKey_BEGIN,
    # ImGuiKey_KeysData_SIZE      : Size of KeysData[]: only hold named keys
    # ImGuiKey_KeysData_OFFSET    : First key stored in io.KeysData[0]. Accesses to io.KeysData[] must use (key - ImGuiKey_KeysData_OFFSET).
    cffi::enum define ImGuiKey_ {
        ImGuiKey_None               0
        ImGuiKey_Tab                512
        ImGuiKey_LeftArrow          513
        ImGuiKey_RightArrow         514
        ImGuiKey_UpArrow            515
        ImGuiKey_DownArrow          516
        ImGuiKey_PageUp             517
        ImGuiKey_PageDown           518
        ImGuiKey_Home               519
        ImGuiKey_End                520
        ImGuiKey_Insert             521
        ImGuiKey_Delete             522
        ImGuiKey_Backspace          523
        ImGuiKey_Space              524
        ImGuiKey_Enter              525
        ImGuiKey_Escape             526
        ImGuiKey_LeftCtrl           527
        ImGuiKey_LeftShift          528
        ImGuiKey_LeftAlt            529
        ImGuiKey_LeftSuper          530
        ImGuiKey_RightCtrl          531
        ImGuiKey_RightShift         532
        ImGuiKey_RightAlt           533
        ImGuiKey_RightSuper         534
        ImGuiKey_Menu               535
        ImGuiKey_0                  536
        ImGuiKey_1                  537
        ImGuiKey_2                  538
        ImGuiKey_3                  539
        ImGuiKey_4                  540
        ImGuiKey_5                  541
        ImGuiKey_6                  542
        ImGuiKey_7                  543
        ImGuiKey_8                  544
        ImGuiKey_9                  545
        ImGuiKey_A                  546
        ImGuiKey_B                  547
        ImGuiKey_C                  548
        ImGuiKey_D                  549
        ImGuiKey_E                  550
        ImGuiKey_F                  551
        ImGuiKey_G                  552
        ImGuiKey_H                  553
        ImGuiKey_I                  554
        ImGuiKey_J                  555
        ImGuiKey_K                  556
        ImGuiKey_L                  557
        ImGuiKey_M                  558
        ImGuiKey_N                  559
        ImGuiKey_O                  560
        ImGuiKey_P                  561
        ImGuiKey_Q                  562
        ImGuiKey_R                  563
        ImGuiKey_S                  564
        ImGuiKey_T                  565
        ImGuiKey_U                  566
        ImGuiKey_V                  567
        ImGuiKey_W                  568
        ImGuiKey_X                  569
        ImGuiKey_Y                  570
        ImGuiKey_Z                  571
        ImGuiKey_F1                 572
        ImGuiKey_F2                 573
        ImGuiKey_F3                 574
        ImGuiKey_F4                 575
        ImGuiKey_F5                 576
        ImGuiKey_F6                 577
        ImGuiKey_F7                 578
        ImGuiKey_F8                 579
        ImGuiKey_F9                 580
        ImGuiKey_F10                581
        ImGuiKey_F11                582
        ImGuiKey_F12                583
        ImGuiKey_Apostrophe         584
        ImGuiKey_Comma              585
        ImGuiKey_Minus              586
        ImGuiKey_Period             587
        ImGuiKey_Slash              588
        ImGuiKey_Semicolon          589
        ImGuiKey_Equal              590
        ImGuiKey_LeftBracket        591
        ImGuiKey_Backslash          592
        ImGuiKey_RightBracket       593
        ImGuiKey_GraveAccent        594
        ImGuiKey_CapsLock           595
        ImGuiKey_ScrollLock         596
        ImGuiKey_NumLock            597
        ImGuiKey_PrintScreen        598
        ImGuiKey_Pause              599
        ImGuiKey_Keypad0            600
        ImGuiKey_Keypad1            601
        ImGuiKey_Keypad2            602
        ImGuiKey_Keypad3            603
        ImGuiKey_Keypad4            604
        ImGuiKey_Keypad5            605
        ImGuiKey_Keypad6            606
        ImGuiKey_Keypad7            607
        ImGuiKey_Keypad8            608
        ImGuiKey_Keypad9            609
        ImGuiKey_KeypadDecimal      610
        ImGuiKey_KeypadDivide       611
        ImGuiKey_KeypadMultiply     612
        ImGuiKey_KeypadSubtract     613
        ImGuiKey_KeypadAdd          614
        ImGuiKey_KeypadEnter        615
        ImGuiKey_KeypadEqual        616
        ImGuiKey_GamepadStart       617
        ImGuiKey_GamepadBack        618
        ImGuiKey_GamepadFaceUp      619
        ImGuiKey_GamepadFaceDown    620
        ImGuiKey_GamepadFaceLeft    621
        ImGuiKey_GamepadFaceRight   622
        ImGuiKey_GamepadDpadUp      623
        ImGuiKey_GamepadDpadDown    624
        ImGuiKey_GamepadDpadLeft    625
        ImGuiKey_GamepadDpadRight   626
        ImGuiKey_GamepadL1          627
        ImGuiKey_GamepadR1          628
        ImGuiKey_GamepadL2          629
        ImGuiKey_GamepadR2          630
        ImGuiKey_GamepadL3          631
        ImGuiKey_GamepadR3          632
        ImGuiKey_GamepadLStickUp    633
        ImGuiKey_GamepadLStickDown  634
        ImGuiKey_GamepadLStickLeft  635
        ImGuiKey_GamepadLStickRight 636
        ImGuiKey_GamepadRStickUp    637
        ImGuiKey_GamepadRStickDown  638
        ImGuiKey_GamepadRStickLeft  639
        ImGuiKey_GamepadRStickRight 640
        ImGuiKey_ModCtrl            641
        ImGuiKey_ModShift           642
        ImGuiKey_ModAlt             643
        ImGuiKey_ModSuper           644
        ImGuiKey_COUNT              645
        ImGuiKey_NamedKey_BEGIN     512
        ImGuiKey_NamedKey_END       645
        ImGuiKey_NamedKey_COUNT     133
        ImGuiKey_KeysData_SIZE      645
        ImGuiKey_KeysData_OFFSET    0
    }

    cffi::enum define ImGuiLayoutType_ {
        ImGuiLayoutType_Horizontal 0
        ImGuiLayoutType_Vertical   1
    }

    cffi::enum define ImGuiLogType {
        ImGuiLogType_None      0
        ImGuiLogType_TTY       1
        ImGuiLogType_File      2
        ImGuiLogType_Buffer    3
        ImGuiLogType_Clipboard 4
    }

    # ImGuiModFlags_None  : ImGuiModFlags_None              = 0,
    # ImGuiModFlags_Ctrl  : ImGuiModFlags_Ctrl              = 1 << 0,
    # ImGuiModFlags_Shift : ImGuiModFlags_Shift             = 1 << 1,
    # ImGuiModFlags_Alt   : Menu
    # ImGuiModFlags_Super : Windows key
    cffi::enum define ImGuiModFlags_ {
        ImGuiModFlags_None  0
        ImGuiModFlags_Ctrl  1
        ImGuiModFlags_Shift 2
        ImGuiModFlags_Alt   4
        ImGuiModFlags_Super 8
    }

    # ImGuiMouseButton_Left   : - To refer to a mouse button, you may use named enums in your code e.g. ImGuiMouseButton_Left, ImGuiMouseButton_Right.
    # ImGuiMouseButton_Right  : - To refer to a mouse button, you may use named enums in your code e.g. ImGuiMouseButton_Left, ImGuiMouseButton_Right.
    # ImGuiMouseButton_Middle : For BeginPopupContext*(): open on Middle Mouse release. Guaranteed to always be == 2 (same as ImGuiMouseButton_Middle)
    # ImGuiMouseButton_COUNT  : ImGuiMouseButton_COUNT = 5
    cffi::enum define ImGuiMouseButton_ {
        ImGuiMouseButton_Left   0
        ImGuiMouseButton_Right  1
        ImGuiMouseButton_Middle 2
        ImGuiMouseButton_COUNT  5
    }

    # ImGuiMouseCursor_None       : ImGuiMouseCursor_None = -1,
    # ImGuiMouseCursor_Arrow      : ImGuiMouseCursor_Arrow = 0,
    # ImGuiMouseCursor_TextInput  : When hovering over InputText, etc.
    # ImGuiMouseCursor_ResizeAll  : (Unused by Dear ImGui functions)
    # ImGuiMouseCursor_ResizeNS   : When hovering over an horizontal border
    # ImGuiMouseCursor_ResizeEW   : When hovering over a vertical border or a column
    # ImGuiMouseCursor_ResizeNESW : When hovering over the bottom-left corner of a window
    # ImGuiMouseCursor_ResizeNWSE : When hovering over the bottom-right corner of a window
    # ImGuiMouseCursor_Hand       : (Unused by Dear ImGui functions. Use for e.g. hyperlinks)
    # ImGuiMouseCursor_NotAllowed : When hovering something with disallowed interaction. Usually a crossed circle.
    # ImGuiMouseCursor_COUNT      : ImGuiMouseCursor_COUNT
    cffi::enum define ImGuiMouseCursor_ {
        ImGuiMouseCursor_None       -1
        ImGuiMouseCursor_Arrow      0
        ImGuiMouseCursor_TextInput  1
        ImGuiMouseCursor_ResizeAll  2
        ImGuiMouseCursor_ResizeNS   3
        ImGuiMouseCursor_ResizeEW   4
        ImGuiMouseCursor_ResizeNESW 5
        ImGuiMouseCursor_ResizeNWSE 6
        ImGuiMouseCursor_Hand       7
        ImGuiMouseCursor_NotAllowed 8
        ImGuiMouseCursor_COUNT      9
    }

    cffi::enum define ImGuiNavDirSourceFlags_ {
        ImGuiNavDirSourceFlags_None        0
        ImGuiNavDirSourceFlags_RawKeyboard 1
        ImGuiNavDirSourceFlags_Keyboard    2
        ImGuiNavDirSourceFlags_PadDPad     4
        ImGuiNavDirSourceFlags_PadLStick   8
    }

    cffi::enum define ImGuiNavHighlightFlags_ {
        ImGuiNavHighlightFlags_None        0
        ImGuiNavHighlightFlags_TypeDefault 1
        ImGuiNavHighlightFlags_TypeThin    2
        ImGuiNavHighlightFlags_AlwaysDraw  4
        ImGuiNavHighlightFlags_NoRounding  8
    }

    # ImGuiNavInput_Activate    : -> ImGuiNavInput_Activate
    # ImGuiNavInput_Cancel      : -> ImGuiNavInput_Cancel
    # ImGuiNavInput_Input       : -> ImGuiNavInput_Input
    # ImGuiNavInput_Menu        : -> ImGuiNavInput_Menu
    # ImGuiNavInput_DpadLeft    : -> ImGuiNavInput_DpadLeft
    # ImGuiNavInput_DpadRight   : -> ImGuiNavInput_DpadRight
    # ImGuiNavInput_DpadUp      : -> ImGuiNavInput_DpadUp
    # ImGuiNavInput_DpadDown    : -> ImGuiNavInput_DpadDown
    # ImGuiNavInput_LStickLeft  : -> ImGuiNavInput_LStickLeft
    # ImGuiNavInput_LStickRight : -> ImGuiNavInput_LStickRight
    # ImGuiNavInput_LStickUp    : -> ImGuiNavInput_LStickUp
    # ImGuiNavInput_LStickDown  : -> ImGuiNavInput_LStickDown
    # ImGuiNavInput_FocusPrev   : -> ImGuiNavInput_FocusPrev + ImGuiNavInput_TweakSlow
    # ImGuiNavInput_FocusNext   : -> ImGuiNavInput_FocusNext + ImGuiNavInput_TweakFast
    # ImGuiNavInput_TweakSlow   : -> ImGuiNavInput_FocusPrev + ImGuiNavInput_TweakSlow
    # ImGuiNavInput_TweakFast   : -> ImGuiNavInput_FocusNext + ImGuiNavInput_TweakFast
    # ImGuiNavInput_KeyLeft_    : = Arrow keys
    # ImGuiNavInput_KeyRight_   : Move right
    # ImGuiNavInput_KeyUp_      : Move up
    # ImGuiNavInput_KeyDown_    : Move down
    # ImGuiNavInput_COUNT       : ImGuiNavInput_COUNT
    cffi::enum define ImGuiNavInput_ {
        ImGuiNavInput_Activate    0
        ImGuiNavInput_Cancel      1
        ImGuiNavInput_Input       2
        ImGuiNavInput_Menu        3
        ImGuiNavInput_DpadLeft    4
        ImGuiNavInput_DpadRight   5
        ImGuiNavInput_DpadUp      6
        ImGuiNavInput_DpadDown    7
        ImGuiNavInput_LStickLeft  8
        ImGuiNavInput_LStickRight 9
        ImGuiNavInput_LStickUp    10
        ImGuiNavInput_LStickDown  11
        ImGuiNavInput_FocusPrev   12
        ImGuiNavInput_FocusNext   13
        ImGuiNavInput_TweakSlow   14
        ImGuiNavInput_TweakFast   15
        ImGuiNavInput_KeyLeft_    16
        ImGuiNavInput_KeyRight_   17
        ImGuiNavInput_KeyUp_      18
        ImGuiNavInput_KeyDown_    19
        ImGuiNavInput_COUNT       20
    }

    cffi::enum define ImGuiNavLayer {
        ImGuiNavLayer_Main  0
        ImGuiNavLayer_Menu  1
        ImGuiNavLayer_COUNT 2
    }

    cffi::enum define ImGuiNavMoveFlags_ {
        ImGuiNavMoveFlags_None                0
        ImGuiNavMoveFlags_LoopX               1
        ImGuiNavMoveFlags_LoopY               2
        ImGuiNavMoveFlags_WrapX               4
        ImGuiNavMoveFlags_WrapY               8
        ImGuiNavMoveFlags_AllowCurrentNavId   16
        ImGuiNavMoveFlags_AlsoScoreVisibleSet 32
        ImGuiNavMoveFlags_ScrollToEdgeY       64
        ImGuiNavMoveFlags_Forwarded           128
        ImGuiNavMoveFlags_DebugNoResult       256
        ImGuiNavMoveFlags_FocusApi            512
        ImGuiNavMoveFlags_Tabbing             1024
        ImGuiNavMoveFlags_Activate            2048
        ImGuiNavMoveFlags_DontSetNavHighlight 4096
    }

    cffi::enum define ImGuiNavReadMode {
        ImGuiNavReadMode_Down       0
        ImGuiNavReadMode_Pressed    1
        ImGuiNavReadMode_Released   2
        ImGuiNavReadMode_Repeat     3
        ImGuiNavReadMode_RepeatSlow 4
        ImGuiNavReadMode_RepeatFast 5
    }

    cffi::enum define ImGuiNextItemDataFlags_ {
        ImGuiNextItemDataFlags_None     0
        ImGuiNextItemDataFlags_HasWidth 1
        ImGuiNextItemDataFlags_HasOpen  2
    }

    cffi::enum define ImGuiNextWindowDataFlags_ {
        ImGuiNextWindowDataFlags_None              0
        ImGuiNextWindowDataFlags_HasPos            1
        ImGuiNextWindowDataFlags_HasSize           2
        ImGuiNextWindowDataFlags_HasContentSize    4
        ImGuiNextWindowDataFlags_HasCollapsed      8
        ImGuiNextWindowDataFlags_HasSizeConstraint 16
        ImGuiNextWindowDataFlags_HasFocus          32
        ImGuiNextWindowDataFlags_HasBgAlpha        64
        ImGuiNextWindowDataFlags_HasScroll         128
        ImGuiNextWindowDataFlags_HasViewport       256
        ImGuiNextWindowDataFlags_HasDock           512
        ImGuiNextWindowDataFlags_HasWindowClass    1024
    }

    cffi::enum define ImGuiOldColumnFlags_ {
        ImGuiOldColumnFlags_None                   0
        ImGuiOldColumnFlags_NoBorder               1
        ImGuiOldColumnFlags_NoResize               2
        ImGuiOldColumnFlags_NoPreserveWidths       4
        ImGuiOldColumnFlags_NoForceWithinWindow    8
        ImGuiOldColumnFlags_GrowParentContentsSize 16
    }

    cffi::enum define ImGuiPlotType {
        ImGuiPlotType_Lines     0
        ImGuiPlotType_Histogram 1
    }

    # ImGuiPopupFlags_None                    : ImGuiPopupFlags_None                    = 0,
    # ImGuiPopupFlags_MouseButtonLeft         : For BeginPopupContext*(): open on Left Mouse release. Guaranteed to always be == 0 (same as ImGuiMouseButton_Left)
    # ImGuiPopupFlags_MouseButtonRight        : - IMPORTANT: Notice that for OpenPopupOnItemClick() we exceptionally default flags to 1 (== ImGuiPopupFlags_MouseButtonRight) for backward compatibility with older API taking 'int mouse_button = 1' parameter
    # ImGuiPopupFlags_MouseButtonMiddle       : For BeginPopupContext*(): open on Middle Mouse release. Guaranteed to always be == 2 (same as ImGuiMouseButton_Middle)
    # ImGuiPopupFlags_MouseButtonMask_        : ImGuiPopupFlags_MouseButtonMask_        = 0x1F,
    # ImGuiPopupFlags_MouseButtonDefault_     : ImGuiPopupFlags_MouseButtonDefault_     = 1,
    # ImGuiPopupFlags_NoOpenOverExistingPopup : - Use ImGuiPopupFlags_NoOpenOverExistingPopup to avoid opening a popup if there's already one at the same level. This is equivalent to e.g. testing for !IsAnyPopupOpen() prior to OpenPopup().
    # ImGuiPopupFlags_NoOpenOverItems         : For BeginPopupContextWindow(): don't return true when hovering items, only when hovering empty space
    # ImGuiPopupFlags_AnyPopupId              : - IsPopupOpen() with ImGuiPopupFlags_AnyPopupId: return true if any popup is open at the current BeginPopup() level of the popup stack.
    # ImGuiPopupFlags_AnyPopupLevel           : - IsPopupOpen() with ImGuiPopupFlags_AnyPopupId + ImGuiPopupFlags_AnyPopupLevel: return true if any popup is open.
    # ImGuiPopupFlags_AnyPopup                : - IsPopupOpen() with ImGuiPopupFlags_AnyPopupId: return true if any popup is open at the current BeginPopup() level of the popup stack.
    cffi::enum define ImGuiPopupFlags_ {
        ImGuiPopupFlags_None                    0
        ImGuiPopupFlags_MouseButtonLeft         0
        ImGuiPopupFlags_MouseButtonRight        1
        ImGuiPopupFlags_MouseButtonMiddle       2
        ImGuiPopupFlags_MouseButtonMask_        31
        ImGuiPopupFlags_MouseButtonDefault_     1
        ImGuiPopupFlags_NoOpenOverExistingPopup 32
        ImGuiPopupFlags_NoOpenOverItems         64
        ImGuiPopupFlags_AnyPopupId              128
        ImGuiPopupFlags_AnyPopupLevel           256
        ImGuiPopupFlags_AnyPopup                384
    }

    cffi::enum define ImGuiPopupPositionPolicy {
        ImGuiPopupPositionPolicy_Default  0
        ImGuiPopupPositionPolicy_ComboBox 1
        ImGuiPopupPositionPolicy_Tooltip  2
    }

    cffi::enum define ImGuiScrollFlags_ {
        ImGuiScrollFlags_None               0
        ImGuiScrollFlags_KeepVisibleEdgeX   1
        ImGuiScrollFlags_KeepVisibleEdgeY   2
        ImGuiScrollFlags_KeepVisibleCenterX 4
        ImGuiScrollFlags_KeepVisibleCenterY 8
        ImGuiScrollFlags_AlwaysCenterX      16
        ImGuiScrollFlags_AlwaysCenterY      32
        ImGuiScrollFlags_NoScrollParent     64
        ImGuiScrollFlags_MaskX_             21
        ImGuiScrollFlags_MaskY_             42
    }

    cffi::enum define ImGuiSelectableFlagsPrivate_ {
        ImGuiSelectableFlags_NoHoldingActiveID    1048576
        ImGuiSelectableFlags_SelectOnNav          2097152
        ImGuiSelectableFlags_SelectOnClick        4194304
        ImGuiSelectableFlags_SelectOnRelease      8388608
        ImGuiSelectableFlags_SpanAvailWidth       16777216
        ImGuiSelectableFlags_DrawHoveredWhenHeld  33554432
        ImGuiSelectableFlags_SetNavIdOnHover      67108864
        ImGuiSelectableFlags_NoPadWithHalfSpacing 134217728
    }

    # ImGuiSelectableFlags_None             : ImGuiSelectableFlags_None               = 0,
    # ImGuiSelectableFlags_DontClosePopups  : Clicking this don't close parent popup window
    # ImGuiSelectableFlags_SpanAllColumns   : Selectable frame can span all columns (text will still fit in current column)
    # ImGuiSelectableFlags_AllowDoubleClick : Generate press events on double clicks too
    # ImGuiSelectableFlags_Disabled         : Cannot be selected, display grayed out text
    # ImGuiSelectableFlags_AllowItemOverlap : (WIP) Hit testing to allow subsequent widgets to overlap this one
    cffi::enum define ImGuiSelectableFlags_ {
        ImGuiSelectableFlags_None             0
        ImGuiSelectableFlags_DontClosePopups  1
        ImGuiSelectableFlags_SpanAllColumns   2
        ImGuiSelectableFlags_AllowDoubleClick 4
        ImGuiSelectableFlags_Disabled         8
        ImGuiSelectableFlags_AllowItemOverlap 16
    }

    cffi::enum define ImGuiSeparatorFlags_ {
        ImGuiSeparatorFlags_None           0
        ImGuiSeparatorFlags_Horizontal     1
        ImGuiSeparatorFlags_Vertical       2
        ImGuiSeparatorFlags_SpanAllColumns 4
    }

    cffi::enum define ImGuiSliderFlagsPrivate_ {
        ImGuiSliderFlags_Vertical 1048576
        ImGuiSliderFlags_ReadOnly 2097152
    }

    # ImGuiSliderFlags_None            : ImGuiSliderFlags_None                   = 0,
    # ImGuiSliderFlags_AlwaysClamp     : - CTRL+Click on any drag box to turn them into an input box. Manually input values aren't clamped by default and can go off-bounds. Use ImGuiSliderFlags_AlwaysClamp to always clamp.
    # ImGuiSliderFlags_Logarithmic     : Make the widget logarithmic (linear otherwise). Consider using ImGuiSliderFlags_NoRoundToFormat with this if using a format-string with small amount of digits.
    # ImGuiSliderFlags_NoRoundToFormat : Make the widget logarithmic (linear otherwise). Consider using ImGuiSliderFlags_NoRoundToFormat with this if using a format-string with small amount of digits.
    # ImGuiSliderFlags_NoInput         : Disable CTRL+Click or Enter key allowing to input text directly into the widget
    # ImGuiSliderFlags_InvalidMask_    : [Internal] We treat using those bits as being potentially a 'float power' argument from the previous API that has got miscast to this enum, and will trigger an assert if needed.
    cffi::enum define ImGuiSliderFlags_ {
        ImGuiSliderFlags_None            0
        ImGuiSliderFlags_AlwaysClamp     16
        ImGuiSliderFlags_Logarithmic     32
        ImGuiSliderFlags_NoRoundToFormat 64
        ImGuiSliderFlags_NoInput         128
        ImGuiSliderFlags_InvalidMask_    1879048207
    }

    # ImGuiSortDirection_None       : ImGuiSortDirection_None         = 0,
    # ImGuiSortDirection_Ascending  : Ascending = 0->9, A->Z etc.
    # ImGuiSortDirection_Descending : Descending = 9->0, Z->A etc.
    cffi::enum define ImGuiSortDirection_ {
        ImGuiSortDirection_None       0
        ImGuiSortDirection_Ascending  1
        ImGuiSortDirection_Descending 2
    }

    # ImGuiStyleVar_Alpha               : float     Alpha
    # ImGuiStyleVar_DisabledAlpha       : float     DisabledAlpha
    # ImGuiStyleVar_WindowPadding       : ImVec2    WindowPadding
    # ImGuiStyleVar_WindowRounding      : float     WindowRounding
    # ImGuiStyleVar_WindowBorderSize    : float     WindowBorderSize
    # ImGuiStyleVar_WindowMinSize       : ImVec2    WindowMinSize
    # ImGuiStyleVar_WindowTitleAlign    : ImVec2    WindowTitleAlign
    # ImGuiStyleVar_ChildRounding       : float     ChildRounding
    # ImGuiStyleVar_ChildBorderSize     : float     ChildBorderSize
    # ImGuiStyleVar_PopupRounding       : float     PopupRounding
    # ImGuiStyleVar_PopupBorderSize     : float     PopupBorderSize
    # ImGuiStyleVar_FramePadding        : ImVec2    FramePadding
    # ImGuiStyleVar_FrameRounding       : float     FrameRounding
    # ImGuiStyleVar_FrameBorderSize     : float     FrameBorderSize
    # ImGuiStyleVar_ItemSpacing         : ImVec2    ItemSpacing
    # ImGuiStyleVar_ItemInnerSpacing    : ImVec2    ItemInnerSpacing
    # ImGuiStyleVar_IndentSpacing       : float     IndentSpacing
    # ImGuiStyleVar_CellPadding         : ImVec2    CellPadding
    # ImGuiStyleVar_ScrollbarSize       : float     ScrollbarSize
    # ImGuiStyleVar_ScrollbarRounding   : float     ScrollbarRounding
    # ImGuiStyleVar_GrabMinSize         : float     GrabMinSize
    # ImGuiStyleVar_GrabRounding        : float     GrabRounding
    # ImGuiStyleVar_TabRounding         : float     TabRounding
    # ImGuiStyleVar_ButtonTextAlign     : ImVec2    ButtonTextAlign
    # ImGuiStyleVar_SelectableTextAlign : ImVec2    SelectableTextAlign
    # ImGuiStyleVar_COUNT               : ImGuiStyleVar_COUNT
    cffi::enum define ImGuiStyleVar_ {
        ImGuiStyleVar_Alpha               0
        ImGuiStyleVar_DisabledAlpha       1
        ImGuiStyleVar_WindowPadding       2
        ImGuiStyleVar_WindowRounding      3
        ImGuiStyleVar_WindowBorderSize    4
        ImGuiStyleVar_WindowMinSize       5
        ImGuiStyleVar_WindowTitleAlign    6
        ImGuiStyleVar_ChildRounding       7
        ImGuiStyleVar_ChildBorderSize     8
        ImGuiStyleVar_PopupRounding       9
        ImGuiStyleVar_PopupBorderSize     10
        ImGuiStyleVar_FramePadding        11
        ImGuiStyleVar_FrameRounding       12
        ImGuiStyleVar_FrameBorderSize     13
        ImGuiStyleVar_ItemSpacing         14
        ImGuiStyleVar_ItemInnerSpacing    15
        ImGuiStyleVar_IndentSpacing       16
        ImGuiStyleVar_CellPadding         17
        ImGuiStyleVar_ScrollbarSize       18
        ImGuiStyleVar_ScrollbarRounding   19
        ImGuiStyleVar_GrabMinSize         20
        ImGuiStyleVar_GrabRounding        21
        ImGuiStyleVar_TabRounding         22
        ImGuiStyleVar_ButtonTextAlign     23
        ImGuiStyleVar_SelectableTextAlign 24
        ImGuiStyleVar_COUNT               25
    }

    cffi::enum define ImGuiTabBarFlagsPrivate_ {
        ImGuiTabBarFlags_DockNode     1048576
        ImGuiTabBarFlags_IsFocused    2097152
        ImGuiTabBarFlags_SaveSettings 4194304
    }

    # ImGuiTabBarFlags_None                         : ImGuiTabBarFlags_None                           = 0,
    # ImGuiTabBarFlags_Reorderable                  : Allow manually dragging tabs to re-order them + New tabs are appended at the end of list
    # ImGuiTabBarFlags_AutoSelectNewTabs            : Automatically select new tabs when they appear
    # ImGuiTabBarFlags_TabListPopupButton           : Disable buttons to open the tab list popup
    # ImGuiTabBarFlags_NoCloseWithMiddleMouseButton : Disable behavior of closing tabs (that are submitted with p_open != NULL) with middle mouse button. You can still repro this behavior on user's side with if (IsItemHovered() && IsMouseClicked(2)) *p_open = false.
    # ImGuiTabBarFlags_NoTabListScrollingButtons    : Disable scrolling buttons (apply when fitting policy is ImGuiTabBarFlags_FittingPolicyScroll)
    # ImGuiTabBarFlags_NoTooltip                    : Disable tooltips when hovering a tab
    # ImGuiTabBarFlags_FittingPolicyResizeDown      : Resize tabs when they don't fit
    # ImGuiTabBarFlags_FittingPolicyScroll          : Disable scrolling buttons (apply when fitting policy is ImGuiTabBarFlags_FittingPolicyScroll)
    # ImGuiTabBarFlags_FittingPolicyMask_           : ImGuiTabBarFlags_FittingPolicyMask_             = ImGuiTabBarFlags_FittingPolicyResizeDown | ImGuiTabBarFlags_FittingPolicyScroll,
    # ImGuiTabBarFlags_FittingPolicyDefault_        : ImGuiTabBarFlags_FittingPolicyDefault_          = ImGuiTabBarFlags_FittingPolicyResizeDown
    cffi::enum define ImGuiTabBarFlags_ {
        ImGuiTabBarFlags_None                         0
        ImGuiTabBarFlags_Reorderable                  1
        ImGuiTabBarFlags_AutoSelectNewTabs            2
        ImGuiTabBarFlags_TabListPopupButton           4
        ImGuiTabBarFlags_NoCloseWithMiddleMouseButton 8
        ImGuiTabBarFlags_NoTabListScrollingButtons    16
        ImGuiTabBarFlags_NoTooltip                    32
        ImGuiTabBarFlags_FittingPolicyResizeDown      64
        ImGuiTabBarFlags_FittingPolicyScroll          128
        ImGuiTabBarFlags_FittingPolicyMask_           192
        ImGuiTabBarFlags_FittingPolicyDefault_        64
    }

    cffi::enum define ImGuiTabItemFlagsPrivate_ {
        ImGuiTabItemFlags_SectionMask_  192
        ImGuiTabItemFlags_NoCloseButton 1048576
        ImGuiTabItemFlags_Button        2097152
        ImGuiTabItemFlags_Unsorted      4194304
        ImGuiTabItemFlags_Preview       8388608
    }

    # ImGuiTabItemFlags_None                         : ImGuiTabItemFlags_None                          = 0,
    # ImGuiTabItemFlags_UnsavedDocument              : Display a dot next to the title + tab is selected when clicking the X + closure is not assumed (will wait for user to stop submitting the tab). Otherwise closure is assumed when pressing the X, so if you keep submitting the tab may reappear at end of tab bar.
    # ImGuiTabItemFlags_SetSelected                  : Trigger flag to programmatically make the tab selected when calling BeginTabItem()
    # ImGuiTabItemFlags_NoCloseWithMiddleMouseButton : Disable behavior of closing tabs (that are submitted with p_open != NULL) with middle mouse button. You can still repro this behavior on user's side with if (IsItemHovered() && IsMouseClicked(2)) *p_open = false.
    # ImGuiTabItemFlags_NoPushId                     : EndTabItem()
    # ImGuiTabItemFlags_NoTooltip                    : Disable tooltip for the given tab
    # ImGuiTabItemFlags_NoReorder                    : Disable reordering this tab or having another tab cross over this tab
    # ImGuiTabItemFlags_Leading                      : Enforce the tab position to the left of the tab bar (after the tab list popup button)
    # ImGuiTabItemFlags_Trailing                     : Enforce the tab position to the right of the tab bar (before the scrolling buttons)
    cffi::enum define ImGuiTabItemFlags_ {
        ImGuiTabItemFlags_None                         0
        ImGuiTabItemFlags_UnsavedDocument              1
        ImGuiTabItemFlags_SetSelected                  2
        ImGuiTabItemFlags_NoCloseWithMiddleMouseButton 4
        ImGuiTabItemFlags_NoPushId                     8
        ImGuiTabItemFlags_NoTooltip                    16
        ImGuiTabItemFlags_NoReorder                    32
        ImGuiTabItemFlags_Leading                      64
        ImGuiTabItemFlags_Trailing                     128
    }

    # ImGuiTableBgTarget_None   : ImGuiTableBgTarget_None                         = 0,
    # ImGuiTableBgTarget_RowBg0 : Set row background color 0 (generally used for background, automatically set when ImGuiTableFlags_RowBg is used)
    # ImGuiTableBgTarget_RowBg1 : Set row background color 1 (generally used for selection marking)
    # ImGuiTableBgTarget_CellBg : Set cell background color (top-most color)
    cffi::enum define ImGuiTableBgTarget_ {
        ImGuiTableBgTarget_None   0
        ImGuiTableBgTarget_RowBg0 1
        ImGuiTableBgTarget_RowBg1 2
        ImGuiTableBgTarget_CellBg 3
    }

    # ImGuiTableColumnFlags_None                 : ImGuiTableColumnFlags_None                  = 0,
    # ImGuiTableColumnFlags_Disabled             : master disable flag: hide column, won't show in context menu (unlike calling TableSetColumnEnabled() which manipulates the user accessible state)
    # ImGuiTableColumnFlags_DefaultHide          : disabled column.
    # ImGuiTableColumnFlags_DefaultSort          : Default as a sorting column.
    # ImGuiTableColumnFlags_WidthStretch         : - Table defaults to ImGuiTableFlags_SizingStretchSame -> all Columns defaults to ImGuiTableColumnFlags_WidthStretch with same weight.
    # ImGuiTableColumnFlags_WidthFixed           : - Table defaults to ImGuiTableFlags_SizingFixedFit -> all Columns defaults to ImGuiTableColumnFlags_WidthFixed
    # ImGuiTableColumnFlags_NoResize             : Disable manual resizing.
    # ImGuiTableColumnFlags_NoReorder            : Disable manual reordering this column, this will also prevent other columns from crossing over this column.
    # ImGuiTableColumnFlags_NoHide               : disable this column.
    # ImGuiTableColumnFlags_NoClip               : Disable clipping for this column (all NoClip columns will render in a same draw command).
    # ImGuiTableColumnFlags_NoSort               : Disable ability to sort on this field (even if ImGuiTableFlags_Sortable is set on the table).
    # ImGuiTableColumnFlags_NoSortAscending      : Disable ability to sort in the ascending direction.
    # ImGuiTableColumnFlags_NoSortDescending     : Disable ability to sort in the descending direction.
    # ImGuiTableColumnFlags_NoHeaderLabel        : TableHeadersRow() will not submit label for this column. Convenient for some small columns. Name will still appear in context menu.
    # ImGuiTableColumnFlags_NoHeaderWidth        : Disable header text width contribution to automatic column width.
    # ImGuiTableColumnFlags_PreferSortAscending  : Make the initial sort direction Ascending when first sorting on this column (default).
    # ImGuiTableColumnFlags_PreferSortDescending : Make the initial sort direction Descending when first sorting on this column.
    # ImGuiTableColumnFlags_IndentEnable         : Use current Indent value when entering cell (default for column 0).
    # ImGuiTableColumnFlags_IndentDisable        : Ignore current Indent value when entering cell (default for columns > 0). Indentation changes _within_ the cell will still be honored.
    # ImGuiTableColumnFlags_IsEnabled            : api (referred to as "Hide" in _DefaultHide and _NoHide) flags.
    # ImGuiTableColumnFlags_IsVisible            : Status: is visible == is enabled AND not clipped by scrolling.
    # ImGuiTableColumnFlags_IsSorted             : Status: is currently part of the sort specs
    # ImGuiTableColumnFlags_IsHovered            : Status: is hovered by mouse
    # ImGuiTableColumnFlags_WidthMask_           : ImGuiTableColumnFlags_WidthMask_            = ImGuiTableColumnFlags_WidthStretch | ImGuiTableColumnFlags_WidthFixed,
    # ImGuiTableColumnFlags_IndentMask_          : ImGuiTableColumnFlags_IndentMask_           = ImGuiTableColumnFlags_IndentEnable | ImGuiTableColumnFlags_IndentDisable,
    # ImGuiTableColumnFlags_StatusMask_          : ImGuiTableColumnFlags_StatusMask_           = ImGuiTableColumnFlags_IsEnabled | ImGuiTableColumnFlags_IsVisible | ImGuiTableColumnFlags_IsSorted | ImGuiTableColumnFlags_IsHovered,
    # ImGuiTableColumnFlags_NoDirectResize_      : [Internal] Disable user resizing this column directly (it may however we resized indirectly from its left edge)
    cffi::enum define ImGuiTableColumnFlags_ {
        ImGuiTableColumnFlags_None                 0
        ImGuiTableColumnFlags_Disabled             1
        ImGuiTableColumnFlags_DefaultHide          2
        ImGuiTableColumnFlags_DefaultSort          4
        ImGuiTableColumnFlags_WidthStretch         8
        ImGuiTableColumnFlags_WidthFixed           16
        ImGuiTableColumnFlags_NoResize             32
        ImGuiTableColumnFlags_NoReorder            64
        ImGuiTableColumnFlags_NoHide               128
        ImGuiTableColumnFlags_NoClip               256
        ImGuiTableColumnFlags_NoSort               512
        ImGuiTableColumnFlags_NoSortAscending      1024
        ImGuiTableColumnFlags_NoSortDescending     2048
        ImGuiTableColumnFlags_NoHeaderLabel        4096
        ImGuiTableColumnFlags_NoHeaderWidth        8192
        ImGuiTableColumnFlags_PreferSortAscending  16384
        ImGuiTableColumnFlags_PreferSortDescending 32768
        ImGuiTableColumnFlags_IndentEnable         65536
        ImGuiTableColumnFlags_IndentDisable        131072
        ImGuiTableColumnFlags_IsEnabled            16777216
        ImGuiTableColumnFlags_IsVisible            33554432
        ImGuiTableColumnFlags_IsSorted             67108864
        ImGuiTableColumnFlags_IsHovered            134217728
        ImGuiTableColumnFlags_WidthMask_           24
        ImGuiTableColumnFlags_IndentMask_          196608
        ImGuiTableColumnFlags_StatusMask_          251658240
        ImGuiTableColumnFlags_NoDirectResize_      1073741824
    }

    # ImGuiTableFlags_None                       : ImGuiTableFlags_None                       = 0,
    # ImGuiTableFlags_Resizable                  : Enable resizing columns.
    # ImGuiTableFlags_Reorderable                : Enable reordering columns in header row (need calling TableSetupColumn() + TableHeadersRow() to display headers)
    # ImGuiTableFlags_Hideable                   : disabling columns in context menu.
    # ImGuiTableFlags_Sortable                   : Enable sorting. Call TableGetSortSpecs() to obtain sort specs. Also see ImGuiTableFlags_SortMulti and ImGuiTableFlags_SortTristate.
    # ImGuiTableFlags_NoSavedSettings            : Disable persisting columns order, width and sort settings in the .ini file.
    # ImGuiTableFlags_ContextMenuInBody          : The context menu can also be made available in columns body using ImGuiTableFlags_ContextMenuInBody.
    # ImGuiTableFlags_RowBg                      : Set each RowBg color with ImGuiCol_TableRowBg or ImGuiCol_TableRowBgAlt (equivalent of calling TableSetBgColor with ImGuiTableBgFlags_RowBg0 on each row manually)
    # ImGuiTableFlags_BordersInnerH              : Draw horizontal borders between rows.
    # ImGuiTableFlags_BordersOuterH              : Draw horizontal borders at the top and bottom.
    # ImGuiTableFlags_BordersInnerV              : Draw vertical borders between columns.
    # ImGuiTableFlags_BordersOuterV              : Draw vertical borders on the left and right sides.
    # ImGuiTableFlags_BordersH                   : Draw horizontal borders.
    # ImGuiTableFlags_BordersV                   : Draw vertical borders.
    # ImGuiTableFlags_BordersInner               : Draw horizontal borders between rows.
    # ImGuiTableFlags_BordersOuter               : Draw horizontal borders at the top and bottom.
    # ImGuiTableFlags_Borders                    : Draw horizontal borders between rows.
    # ImGuiTableFlags_NoBordersInBody            : [ALPHA] Disable vertical borders in columns Body (borders will always appears in Headers). -> May move to style
    # ImGuiTableFlags_NoBordersInBodyUntilResize : [ALPHA] Disable vertical borders in columns Body until hovered for resize (borders will always appears in Headers). -> May move to style
    # ImGuiTableFlags_SizingFixedFit             : - Default to ImGuiTableFlags_SizingFixedFit    if ScrollX is on, or if host window has ImGuiWindowFlags_AlwaysAutoResize.
    # ImGuiTableFlags_SizingFixedSame            : Columns default to _WidthFixed or _WidthAuto (if resizable or not resizable), matching the maximum contents width of all columns. Implicitly enable ImGuiTableFlags_NoKeepColumnsVisible.
    # ImGuiTableFlags_SizingStretchProp          : Columns default to _WidthStretch with default weights proportional to each columns contents widths.
    # ImGuiTableFlags_SizingStretchSame          : - Default to ImGuiTableFlags_SizingStretchSame if ScrollX is off.
    # ImGuiTableFlags_NoHostExtendX              : ScrollY are disabled and Stretch columns are not used.
    # ImGuiTableFlags_NoHostExtendY              : ScrollY are disabled. Data below the limit will be clipped and not visible.
    # ImGuiTableFlags_NoKeepColumnsVisible       : Columns default to _WidthFixed or _WidthAuto (if resizable or not resizable), matching the maximum contents width of all columns. Implicitly enable ImGuiTableFlags_NoKeepColumnsVisible.
    # ImGuiTableFlags_PreciseWidths              : Disable distributing remainder width to stretched columns (width allocation on a 100-wide table with 3 columns: Without this flag: 33,33,34. With this flag: 33,33,33). With larger number of columns, resizing will appear to be less smooth.
    # ImGuiTableFlags_NoClip                     : Disable clipping rectangle for every individual columns (reduce draw command count, items will be able to overflow into other columns). Generally incompatible with TableSetupScrollFreeze().
    # ImGuiTableFlags_PadOuterX                  : Default if BordersOuterV is on. Enable outer-most padding. Generally desirable if you have headers.
    # ImGuiTableFlags_NoPadOuterX                : Default if BordersOuterV is off. Disable outer-most padding.
    # ImGuiTableFlags_NoPadInnerX                : Disable inner padding between columns (double inner padding if BordersOuterV is on, single inner padding if BordersOuterV is off).
    # ImGuiTableFlags_ScrollX                    : Enable horizontal scrolling. Require 'outer_size' parameter of BeginTable() to specify the container size. Changes default sizing policy. Because this create a child window, ScrollY is currently generally recommended when using ScrollX.
    # ImGuiTableFlags_ScrollY                    : Enable vertical scrolling. Require 'outer_size' parameter of BeginTable() to specify the container size.
    # ImGuiTableFlags_SortMulti                  : Enable sorting. Call TableGetSortSpecs() to obtain sort specs. Also see ImGuiTableFlags_SortMulti and ImGuiTableFlags_SortTristate.
    # ImGuiTableFlags_SortTristate               : Enable sorting. Call TableGetSortSpecs() to obtain sort specs. Also see ImGuiTableFlags_SortMulti and ImGuiTableFlags_SortTristate.
    # ImGuiTableFlags_SizingMask_                : ImGuiTableFlags_SizingMask_                = ImGuiTableFlags_SizingFixedFit | ImGuiTableFlags_SizingFixedSame | ImGuiTableFlags_SizingStretchProp | ImGuiTableFlags_SizingStretchSame
    cffi::enum define ImGuiTableFlags_ {
        ImGuiTableFlags_None                       0
        ImGuiTableFlags_Resizable                  1
        ImGuiTableFlags_Reorderable                2
        ImGuiTableFlags_Hideable                   4
        ImGuiTableFlags_Sortable                   8
        ImGuiTableFlags_NoSavedSettings            16
        ImGuiTableFlags_ContextMenuInBody          32
        ImGuiTableFlags_RowBg                      64
        ImGuiTableFlags_BordersInnerH              128
        ImGuiTableFlags_BordersOuterH              256
        ImGuiTableFlags_BordersInnerV              512
        ImGuiTableFlags_BordersOuterV              1024
        ImGuiTableFlags_BordersH                   384
        ImGuiTableFlags_BordersV                   1536
        ImGuiTableFlags_BordersInner               640
        ImGuiTableFlags_BordersOuter               1280
        ImGuiTableFlags_Borders                    1920
        ImGuiTableFlags_NoBordersInBody            2048
        ImGuiTableFlags_NoBordersInBodyUntilResize 4096
        ImGuiTableFlags_SizingFixedFit             8192
        ImGuiTableFlags_SizingFixedSame            16384
        ImGuiTableFlags_SizingStretchProp          24576
        ImGuiTableFlags_SizingStretchSame          32768
        ImGuiTableFlags_NoHostExtendX              65536
        ImGuiTableFlags_NoHostExtendY              131072
        ImGuiTableFlags_NoKeepColumnsVisible       262144
        ImGuiTableFlags_PreciseWidths              524288
        ImGuiTableFlags_NoClip                     1048576
        ImGuiTableFlags_PadOuterX                  2097152
        ImGuiTableFlags_NoPadOuterX                4194304
        ImGuiTableFlags_NoPadInnerX                8388608
        ImGuiTableFlags_ScrollX                    16777216
        ImGuiTableFlags_ScrollY                    33554432
        ImGuiTableFlags_SortMulti                  67108864
        ImGuiTableFlags_SortTristate               134217728
        ImGuiTableFlags_SizingMask_                57344
    }

    # ImGuiTableRowFlags_None    : ImGuiTableRowFlags_None                         = 0,
    # ImGuiTableRowFlags_Headers : Identify header row (set default background color + width of its contents accounted differently for auto column width)
    cffi::enum define ImGuiTableRowFlags_ {
        ImGuiTableRowFlags_None    0
        ImGuiTableRowFlags_Headers 1
    }

    cffi::enum define ImGuiTextFlags_ {
        ImGuiTextFlags_None                       0
        ImGuiTextFlags_NoWidthForLargeClippedText 1
    }

    cffi::enum define ImGuiTooltipFlags_ {
        ImGuiTooltipFlags_None                    0
        ImGuiTooltipFlags_OverridePreviousTooltip 1
    }

    cffi::enum define ImGuiTreeNodeFlagsPrivate_ {
        ImGuiTreeNodeFlags_ClipLabelForTrailingButton 1048576
    }

    # ImGuiTreeNodeFlags_None                 : ImGuiTreeNodeFlags_None                 = 0,
    # ImGuiTreeNodeFlags_Selected             : Draw as selected
    # ImGuiTreeNodeFlags_Framed               : Draw frame with background (e.g. for CollapsingHeader)
    # ImGuiTreeNodeFlags_AllowItemOverlap     : Hit testing to allow subsequent widgets to overlap this one
    # ImGuiTreeNodeFlags_NoTreePushOnOpen     : Don't do a TreePush() when open (e.g. for CollapsingHeader) = no extra indent nor pushing on ID stack
    # ImGuiTreeNodeFlags_NoAutoOpenOnLog      : Don't automatically and temporarily open node when Logging is active (by default logging will automatically open tree nodes)
    # ImGuiTreeNodeFlags_DefaultOpen          : Default node to be open
    # ImGuiTreeNodeFlags_OpenOnDoubleClick    : Need double-click to open node
    # ImGuiTreeNodeFlags_OpenOnArrow          : Only open when clicking on the arrow part. If ImGuiTreeNodeFlags_OpenOnDoubleClick is also set, single-click arrow or double-click all box to open.
    # ImGuiTreeNodeFlags_Leaf                 : No collapsing, no arrow (use as a convenience for leaf nodes).
    # ImGuiTreeNodeFlags_Bullet               : Display a bullet instead of arrow
    # ImGuiTreeNodeFlags_FramePadding         : Use FramePadding (even for an unframed text node) to vertically align text baseline to regular widget height. Equivalent to calling AlignTextToFramePadding().
    # ImGuiTreeNodeFlags_SpanAvailWidth       : Extend hit box to the right-most edge, even if not framed. This is not the default in order to allow adding other items on the same line. In the future we may refactor the hit system to be front-to-back, allowing natural overlaps and then this can become the default.
    # ImGuiTreeNodeFlags_SpanFullWidth        : Extend hit box to the left-most and right-most edges (bypass the indented area).
    # ImGuiTreeNodeFlags_NavLeftJumpsBackHere : (WIP) Nav: left direction may move to this TreeNode() from any of its child (items submitted between TreeNode and TreePop)
    # ImGuiTreeNodeFlags_CollapsingHeader     : ImGuiTreeNodeFlags_CollapsingHeader     = ImGuiTreeNodeFlags_Framed | ImGuiTreeNodeFlags_NoTreePushOnOpen | ImGuiTreeNodeFlags_NoAutoOpenOnLog
    cffi::enum define ImGuiTreeNodeFlags_ {
        ImGuiTreeNodeFlags_None                 0
        ImGuiTreeNodeFlags_Selected             1
        ImGuiTreeNodeFlags_Framed               2
        ImGuiTreeNodeFlags_AllowItemOverlap     4
        ImGuiTreeNodeFlags_NoTreePushOnOpen     8
        ImGuiTreeNodeFlags_NoAutoOpenOnLog      16
        ImGuiTreeNodeFlags_DefaultOpen          32
        ImGuiTreeNodeFlags_OpenOnDoubleClick    64
        ImGuiTreeNodeFlags_OpenOnArrow          128
        ImGuiTreeNodeFlags_Leaf                 256
        ImGuiTreeNodeFlags_Bullet               512
        ImGuiTreeNodeFlags_FramePadding         1024
        ImGuiTreeNodeFlags_SpanAvailWidth       2048
        ImGuiTreeNodeFlags_SpanFullWidth        4096
        ImGuiTreeNodeFlags_NavLeftJumpsBackHere 8192
        ImGuiTreeNodeFlags_CollapsingHeader     26
    }

    # ImGuiViewportFlags_None                : ImGuiViewportFlags_None                     = 0,
    # ImGuiViewportFlags_IsPlatformWindow    : Represent a Platform Window
    # ImGuiViewportFlags_IsPlatformMonitor   : Represent a Platform Monitor (unused yet)
    # ImGuiViewportFlags_OwnedByApp          : managed by the application (rather than a dear imgui backend)
    # ImGuiViewportFlags_NoDecoration        : Disable default OS window decoration flag for secondary viewports. When a viewport doesn't want window decorations, ImGuiViewportFlags_NoDecoration will be set on it. Enabling decoration can create subsequent issues at OS levels (e.g. minimum window size).
    # ImGuiViewportFlags_NoTaskBarIcon       : Disable default OS task bar icon flag for secondary viewports. When a viewport doesn't want a task bar icon, ImGuiViewportFlags_NoTaskBarIcon will be set on it.
    # ImGuiViewportFlags_NoFocusOnAppearing  : Platform Window: Don't take focus when created.
    # ImGuiViewportFlags_NoFocusOnClick      : Platform Window: Don't take focus when clicked on.
    # ImGuiViewportFlags_NoInputs            : Backend Platform supports calling io.AddMouseViewportEvent() with the viewport under the mouse. IF POSSIBLE, ignore viewports with the ImGuiViewportFlags_NoInputs flag (Win32 backend, GLFW 3.30+ backend can do this, SDL backend cannot). If this cannot be done, Dear ImGui needs to use a flawed heuristic to find the viewport under.
    # ImGuiViewportFlags_NoRendererClear     : Platform Window: Renderer doesn't need to clear the framebuffer ahead (because we will fill it entirely).
    # ImGuiViewportFlags_TopMost             : Platform Window: Display on top (for tooltips only).
    # ImGuiViewportFlags_Minimized           : SwapBuffers platform functions for each secondary viewport which doesn't have the ImGuiViewportFlags_Minimized flag set. May be reimplemented by user for custom rendering needs.
    # ImGuiViewportFlags_NoAutoMerge         : Set to make all floating imgui windows always create their own viewport. Otherwise, they are merged into the main host viewports when overlapping it. May also set ImGuiViewportFlags_NoAutoMerge on individual viewport.
    # ImGuiViewportFlags_CanHostOtherWindows : Main viewport: can host multiple imgui windows (secondary viewports are associated to a single window).
    cffi::enum define ImGuiViewportFlags_ {
        ImGuiViewportFlags_None                0
        ImGuiViewportFlags_IsPlatformWindow    1
        ImGuiViewportFlags_IsPlatformMonitor   2
        ImGuiViewportFlags_OwnedByApp          4
        ImGuiViewportFlags_NoDecoration        8
        ImGuiViewportFlags_NoTaskBarIcon       16
        ImGuiViewportFlags_NoFocusOnAppearing  32
        ImGuiViewportFlags_NoFocusOnClick      64
        ImGuiViewportFlags_NoInputs            128
        ImGuiViewportFlags_NoRendererClear     256
        ImGuiViewportFlags_TopMost             512
        ImGuiViewportFlags_Minimized           1024
        ImGuiViewportFlags_NoAutoMerge         2048
        ImGuiViewportFlags_CanHostOtherWindows 4096
    }

    cffi::enum define ImGuiWindowDockStyleCol {
        ImGuiWindowDockStyleCol_Text               0
        ImGuiWindowDockStyleCol_Tab                1
        ImGuiWindowDockStyleCol_TabHovered         2
        ImGuiWindowDockStyleCol_TabActive          3
        ImGuiWindowDockStyleCol_TabUnfocused       4
        ImGuiWindowDockStyleCol_TabUnfocusedActive 5
        ImGuiWindowDockStyleCol_COUNT              6
    }

    # ImGuiWindowFlags_None                      : ImGuiWindowFlags_None                   = 0,
    # ImGuiWindowFlags_NoTitleBar                : Disable title-bar
    # ImGuiWindowFlags_NoResize                  : Disable user resizing with the lower-right grip
    # ImGuiWindowFlags_NoMove                    : Disable user moving the window
    # ImGuiWindowFlags_NoScrollbar               : Disable scrollbars (window can still scroll with mouse or programmatically)
    # ImGuiWindowFlags_NoScrollWithMouse         : Disable user vertically scrolling with mouse wheel. On child window, mouse wheel will be forwarded to the parent unless NoScrollbar is also set.
    # ImGuiWindowFlags_NoCollapse                : Disable user collapsing window by double-clicking on it. Also referred to as Window Menu Button (e.g. within a docking node).
    # ImGuiWindowFlags_AlwaysAutoResize          : Resize every window to its content every frame
    # ImGuiWindowFlags_NoBackground              : PopupBg. you may also use ImGuiWindowFlags_NoBackground.
    # ImGuiWindowFlags_NoSavedSettings           : save settings in .ini file
    # ImGuiWindowFlags_NoMouseInputs             : Disable catching mouse, hovering test with pass through.
    # ImGuiWindowFlags_MenuBar                   : - Use BeginMenuBar() on a window ImGuiWindowFlags_MenuBar to append to its menu bar.
    # ImGuiWindowFlags_HorizontalScrollbar       : Allow horizontal scrollbar to appear (off by default). You may use SetNextWindowContentSize(ImVec2(width,0.0f)); prior to calling Begin() to specify width. Read code in imgui_demo in the "Horizontal Scrolling" section.
    # ImGuiWindowFlags_NoFocusOnAppearing        : Disable taking focus when transitioning from hidden to visible state
    # ImGuiWindowFlags_NoBringToFrontOnFocus     : Disable bringing window to front when taking focus (e.g. clicking on it or programmatically giving it focus)
    # ImGuiWindowFlags_AlwaysVerticalScrollbar   : Always show vertical scrollbar (even if ContentSize.y < Size.y)
    # ImGuiWindowFlags_AlwaysHorizontalScrollbar : Always show horizontal scrollbar (even if ContentSize.x < Size.x)
    # ImGuiWindowFlags_AlwaysUseWindowPadding    : Ensure child windows without border uses style.WindowPadding (ignored by default for non-bordered child windows, because more convenient)
    # ImGuiWindowFlags_NoNavInputs               : keyboard navigation within the window
    # ImGuiWindowFlags_NoNavFocus                : keyboard navigation (e.g. skipped by CTRL+TAB)
    # ImGuiWindowFlags_UnsavedDocument           : docking context, tab is selected when clicking the X + closure is not assumed (will wait for user to stop submitting the tab). Otherwise closure is assumed when pressing the X, so if you keep submitting the tab may reappear at end of tab bar.
    # ImGuiWindowFlags_NoDocking                 : Disable docking of this window
    # ImGuiWindowFlags_NoNav                     : keyboard navigation within the window
    # ImGuiWindowFlags_NoDecoration              : ImGuiWindowFlags_NoDecoration           = ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoScrollbar | ImGuiWindowFlags_NoCollapse,
    # ImGuiWindowFlags_NoInputs                  : ImGuiWindowFlags_NoInputs               = ImGuiWindowFlags_NoMouseInputs | ImGuiWindowFlags_NoNavInputs | ImGuiWindowFlags_NoNavFocus,
    # ImGuiWindowFlags_NavFlattened              : keyboard navigation to cross over parent border to this child or between sibling child windows.
    # ImGuiWindowFlags_ChildWindow               : Don't use! For internal use by BeginChild()
    # ImGuiWindowFlags_Tooltip                   : Don't use! For internal use by BeginTooltip()
    # ImGuiWindowFlags_Popup                     : Don't use! For internal use by BeginPopup()
    # ImGuiWindowFlags_Modal                     : Don't use! For internal use by BeginPopupModal()
    # ImGuiWindowFlags_ChildMenu                 : Don't use! For internal use by BeginMenu()
    # ImGuiWindowFlags_DockNodeHost              : NewFrame()
    cffi::enum define ImGuiWindowFlags_ {
        ImGuiWindowFlags_None                      0
        ImGuiWindowFlags_NoTitleBar                1
        ImGuiWindowFlags_NoResize                  2
        ImGuiWindowFlags_NoMove                    4
        ImGuiWindowFlags_NoScrollbar               8
        ImGuiWindowFlags_NoScrollWithMouse         16
        ImGuiWindowFlags_NoCollapse                32
        ImGuiWindowFlags_AlwaysAutoResize          64
        ImGuiWindowFlags_NoBackground              128
        ImGuiWindowFlags_NoSavedSettings           256
        ImGuiWindowFlags_NoMouseInputs             512
        ImGuiWindowFlags_MenuBar                   1024
        ImGuiWindowFlags_HorizontalScrollbar       2048
        ImGuiWindowFlags_NoFocusOnAppearing        4096
        ImGuiWindowFlags_NoBringToFrontOnFocus     8192
        ImGuiWindowFlags_AlwaysVerticalScrollbar   16384
        ImGuiWindowFlags_AlwaysHorizontalScrollbar 32768
        ImGuiWindowFlags_AlwaysUseWindowPadding    65536
        ImGuiWindowFlags_NoNavInputs               262144
        ImGuiWindowFlags_NoNavFocus                524288
        ImGuiWindowFlags_UnsavedDocument           1048576
        ImGuiWindowFlags_NoDocking                 2097152
        ImGuiWindowFlags_NoNav                     786432
        ImGuiWindowFlags_NoDecoration              43
        ImGuiWindowFlags_NoInputs                  786944
        ImGuiWindowFlags_NavFlattened              8388608
        ImGuiWindowFlags_ChildWindow               16777216
        ImGuiWindowFlags_Tooltip                   33554432
        ImGuiWindowFlags_Popup                     67108864
        ImGuiWindowFlags_Modal                     134217728
        ImGuiWindowFlags_ChildMenu                 268435456
        ImGuiWindowFlags_DockNodeHost              536870912
    }


    cffi::alias define ImDrawFlags                 {int {enum ImDrawFlags_}}
    cffi::alias define ImDrawListFlags             {int {enum ImDrawListFlags_}}
    cffi::alias define ImFontAtlasFlags            {int {enum ImFontAtlasFlags_}}
    cffi::alias define ImGuiActivateFlags          {int {enum ImGuiActivateFlags_}}
    cffi::alias define ImGuiAxis                   {int {enum ImGuiAxis}}
    cffi::alias define ImGuiBackendFlags           {int {enum ImGuiBackendFlags_}}
    cffi::alias define ImGuiButtonFlagsPrivate     {int {enum ImGuiButtonFlagsPrivate_}}
    cffi::alias define ImGuiButtonFlags            {int {enum ImGuiButtonFlags_}}
    cffi::alias define ImGuiCol                    {int {enum ImGuiCol_}}
    cffi::alias define ImGuiColorEditFlags         {int {enum ImGuiColorEditFlags_}}
    cffi::alias define ImGuiComboFlagsPrivate      {int {enum ImGuiComboFlagsPrivate_}}
    cffi::alias define ImGuiComboFlags             {int {enum ImGuiComboFlags_}}
    cffi::alias define ImGuiCond                   {int {enum ImGuiCond_}}
    cffi::alias define ImGuiConfigFlags            {int {enum ImGuiConfigFlags_}}
    cffi::alias define ImGuiContextHookType        {int {enum ImGuiContextHookType}}
    cffi::alias define ImGuiDataAuthority          {int {enum ImGuiDataAuthority_}}
    cffi::alias define ImGuiDataTypePrivate        {int {enum ImGuiDataTypePrivate_}}
    cffi::alias define ImGuiDataType               {int {enum ImGuiDataType_}}
    cffi::alias define ImGuiDebugLogFlags          {int {enum ImGuiDebugLogFlags_}}
    cffi::alias define ImGuiDir                    {int {enum ImGuiDir_}}
    cffi::alias define ImGuiDockNodeFlagsPrivate   {int {enum ImGuiDockNodeFlagsPrivate_}}
    cffi::alias define ImGuiDockNodeFlags          {int {enum ImGuiDockNodeFlags_}}
    cffi::alias define ImGuiDockNodeState          {int {enum ImGuiDockNodeState}}
    cffi::alias define ImGuiDragDropFlags          {int {enum ImGuiDragDropFlags_}}
    cffi::alias define ImGuiFocusedFlags           {int {enum ImGuiFocusedFlags_}}
    cffi::alias define ImGuiHoveredFlags           {int {enum ImGuiHoveredFlags_}}
    cffi::alias define ImGuiInputEventType         {int {enum ImGuiInputEventType}}
    cffi::alias define ImGuiInputSource            {int {enum ImGuiInputSource}}
    cffi::alias define ImGuiInputTextFlagsPrivate  {int {enum ImGuiInputTextFlagsPrivate_}}
    cffi::alias define ImGuiInputTextFlags         {int {enum ImGuiInputTextFlags_}}
    cffi::alias define ImGuiItemFlags              {int {enum ImGuiItemFlags_}}
    cffi::alias define ImGuiItemStatusFlags        {int {enum ImGuiItemStatusFlags_}}
    cffi::alias define ImGuiKeyPrivate             {int {enum ImGuiKeyPrivate_}}
    cffi::alias define ImGuiKey                    {int {enum ImGuiKey_}}
    cffi::alias define ImGuiLayoutType             {int {enum ImGuiLayoutType_}}
    cffi::alias define ImGuiLogType                {int {enum ImGuiLogType}}
    cffi::alias define ImGuiModFlags               {int {enum ImGuiModFlags_}}
    cffi::alias define ImGuiMouseButton            {int {enum ImGuiMouseButton_}}
    cffi::alias define ImGuiMouseCursor            {int {enum ImGuiMouseCursor_}}
    cffi::alias define ImGuiNavDirSourceFlags      {int {enum ImGuiNavDirSourceFlags_}}
    cffi::alias define ImGuiNavHighlightFlags      {int {enum ImGuiNavHighlightFlags_}}
    cffi::alias define ImGuiNavInput               {int {enum ImGuiNavInput_}}
    cffi::alias define ImGuiNavLayer               {int {enum ImGuiNavLayer}}
    cffi::alias define ImGuiNavMoveFlags           {int {enum ImGuiNavMoveFlags_}}
    cffi::alias define ImGuiNavReadMode            {int {enum ImGuiNavReadMode}}
    cffi::alias define ImGuiNextItemDataFlags      {int {enum ImGuiNextItemDataFlags_}}
    cffi::alias define ImGuiNextWindowDataFlags    {int {enum ImGuiNextWindowDataFlags_}}
    cffi::alias define ImGuiOldColumnFlags         {int {enum ImGuiOldColumnFlags_}}
    cffi::alias define ImGuiPlotType               {int {enum ImGuiPlotType}}
    cffi::alias define ImGuiPopupFlags             {int {enum ImGuiPopupFlags_}}
    cffi::alias define ImGuiPopupPositionPolicy    {int {enum ImGuiPopupPositionPolicy}}
    cffi::alias define ImGuiScrollFlags            {int {enum ImGuiScrollFlags_}}
    cffi::alias define ImGuiSelectableFlagsPrivate {int {enum ImGuiSelectableFlagsPrivate_}}
    cffi::alias define ImGuiSelectableFlags        {int {enum ImGuiSelectableFlags_}}
    cffi::alias define ImGuiSeparatorFlags         {int {enum ImGuiSeparatorFlags_}}
    cffi::alias define ImGuiSliderFlagsPrivate     {int {enum ImGuiSliderFlagsPrivate_}}
    cffi::alias define ImGuiSliderFlags            {int {enum ImGuiSliderFlags_}}
    cffi::alias define ImGuiSortDirection          {int {enum ImGuiSortDirection_}}
    cffi::alias define ImGuiStyleVar               {int {enum ImGuiStyleVar_}}
    cffi::alias define ImGuiTabBarFlagsPrivate     {int {enum ImGuiTabBarFlagsPrivate_}}
    cffi::alias define ImGuiTabBarFlags            {int {enum ImGuiTabBarFlags_}}
    cffi::alias define ImGuiTabItemFlagsPrivate    {int {enum ImGuiTabItemFlagsPrivate_}}
    cffi::alias define ImGuiTabItemFlags           {int {enum ImGuiTabItemFlags_}}
    cffi::alias define ImGuiTableBgTarget          {int {enum ImGuiTableBgTarget_}}
    cffi::alias define ImGuiTableColumnFlags       {int {enum ImGuiTableColumnFlags_}}
    cffi::alias define ImGuiTableFlags             {int {enum ImGuiTableFlags_}}
    cffi::alias define ImGuiTableRowFlags          {int {enum ImGuiTableRowFlags_}}
    cffi::alias define ImGuiTextFlags              {int {enum ImGuiTextFlags_}}
    cffi::alias define ImGuiTooltipFlags           {int {enum ImGuiTooltipFlags_}}
    cffi::alias define ImGuiTreeNodeFlagsPrivate   {int {enum ImGuiTreeNodeFlagsPrivate_}}
    cffi::alias define ImGuiTreeNodeFlags          {int {enum ImGuiTreeNodeFlags_}}
    cffi::alias define ImGuiViewportFlags          {int {enum ImGuiViewportFlags_}}
    cffi::alias define ImGuiWindowDockStyleCol     {int {enum ImGuiWindowDockStyleCol}}
    cffi::alias define ImGuiWindowFlags            {int {enum ImGuiWindowFlags_}}
}