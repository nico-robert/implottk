# Copyright (c) 2022 Nicolas ROBERT.
# Distributed under MIT license. Please see LICENSE for details.

namespace eval ::imgui {

    cffi::Struct create ImVec2 {
        x float
        y float
    }

    cffi::Struct create ImVec4 {
        x float
        y float
        z float
        w float
    }

    cffi::Struct create ImGuiStoragePair {
        key   ImGuiID
        val_i int
        val_f float
        val_p pointer
    }

    cffi::Struct create ImVector_ImGuiStoragePair {
        Size int
        Data pointer.ImGuiStoragePair
    }

    cffi::Struct create ImGuiStorage {
        Data struct.ImVector_ImGuiStoragePair
    }

    cffi::Struct create ImVector_char {
        Size     int
        Capacity int
        Data     string
    }

    cffi::Struct create ImGuiTextBuffer {
        Buf struct.ImVector_char
    }

    cffi::Struct create ImRect {
        Min struct.ImVec2
        Max struct.ImVec2
    }

    cffi::Struct create ImVector_ImGuiColorMod {
        Size     int
        Capacity int
        Data     pointer.ImGuiColorMod
    }

    cffi::Struct create ImVector_ImGuiStyleMod {
        Size     int
        Capacity int
        Data     pointer.ImGuiStyleMod
    }

    cffi::Struct create tm {
        tm_sec   int
        tm_min   int
        tm_hour  int
        tm_mday  int
        tm_mon   int
        tm_year  int
        tm_wday  int
        tm_yday  int
        tm_isdst int
    }

    cffi::Struct create ImGuiKeyData {
        Down             ImBool
        DownDuration     float
        DownDurationPrev float
        AnalogValue      float
    }

    cffi::Struct create ImGuiIO {
        ConfigFlags                       {ImGuiConfigFlags bitmask {default 0}}
        BackendFlags                      ImGuiBackendFlags
        DisplaySize                       struct.ImVec2
        DeltaTime                         float
        IniSavingRate                     float
        IniFilename                       string
        LogFilename                       string
        MouseDoubleClickTime              float
        MouseDoubleClickMaxDist           float
        MouseDragThreshold                float
        KeyRepeatDelay                    float
        KeyRepeatRate                     float
        UserData                          pointer
        Fonts                             pointer.ImFontAtlas
        FontGlobalScale                   float
        FontAllowUserScaling              ImBool
        FontDefault                       pointer.ImFont
        DisplayFramebufferScale           struct.ImVec2
        ConfigDockingNoSplit              ImBool
        ConfigDockingWithShift            ImBool
        ConfigDockingAlwaysTabBar         ImBool
        ConfigDockingTransparentPayload   ImBool
        ConfigViewportsNoAutoMerge        ImBool
        ConfigViewportsNoTaskBarIcon      ImBool
        ConfigViewportsNoDecoration       ImBool
        ConfigViewportsNoDefaultParent    ImBool
        MouseDrawCursor                   ImBool
        ConfigMacOSXBehaviors             ImBool
        ConfigInputTrickleEventQueue      ImBool
        ConfigInputTextCursorBlink        ImBool
        ConfigDragClickToInputText        ImBool
        ConfigWindowsResizeFromEdges      ImBool
        ConfigWindowsMoveFromTitleBarOnly ImBool
        ConfigMemoryCompactTimer          float
        BackendPlatformName               chars[512]
        BackendRendererName               chars[512]
        BackendPlatformUserData           pointer
        BackendRendererUserData           pointer
        BackendLanguageUserData           pointer
        GetClipboardTextFn                pointer.getClipTextFn
        SetClipboardTextFn                pointer.setClipTextFn
        ClipboardUserData                 pointer
        SetPlatformImeDataFn              pointer.SetPlatformImeDataFn
        _UnusedPadding                    pointer
        WantCaptureMouse                  ImBool
        WantCaptureKeyboard               ImBool
        WantTextInput                     ImBool
        WantSetMousePos                   ImBool
        WantSaveIniSettings               ImBool
        NavActive                         ImBool
        NavVisible                        ImBool
        Framerate                         float
        MetricsRenderVertices             int
        MetricsRenderIndices              int
        MetricsRenderWindows              int
        MetricsActiveWindows              int
        MetricsActiveAllocations          int
        MouseDelta                        struct.ImVec2
        KeyMap                            int[645]
        KeysDown                          int[645]
        MousePos                          struct.ImVec2
        MouseDown                         int[5]
        MouseWheel                        float
        MouseWheelH                       float
        MouseHoveredViewport              ImGuiID
        KeyCtrl                           ImBool
        KeyShift                          ImBool
        KeyAlt                            ImBool
        KeySuper                          ImBool
        NavInputs                         float[20]
        KeyMods                           ImGuiModFlags
        KeysData                          struct.ImGuiKeyData[645]
        WantCaptureMouseUnlessPopupClose  ImBool
        MousePosPrev                      struct.ImVec2
        MouseClickedPos                   struct.ImVec2[5]
        MouseClickedTime                  double[5]
        MouseClicked                      int[5]
        MouseDoubleClicked                int[5]
        MouseClickedCount                 ushort[5]
        MouseClickedLastCount             ushort[5]
        MouseReleased                     int[5]
        MouseDownOwned                    int[5]
        MouseDownOwnedUnlessPopupClose    int[5]
        MouseDownDuration                 float[5]
        MouseDownDurationPrev             float[5]
        MouseDragMaxDistanceAbs           struct.ImVec2[5]
        MouseDragMaxDistanceSqr           float[5]
        NavInputsDownDuration             float[20]
        NavInputsDownDurationPrev         float[20]
        PenPressure                       float
        AppFocusLost                      ImBool
        AppAcceptingEvents                ImBool
        BackendUsingLegacyKeyArrays       ImS8
        BackendUsingLegacyNavInputArray   ImBool
        InputQueueSurrogate               ImWchar16
    }

    cffi::Struct create ImGuiViewport {
        ID                    ImGuiID
        Flags                 ImGuiViewportFlags
        Pos                   struct.ImVec2
        Size                  struct.ImVec2
        WorkPos               struct.ImVec2
        WorkSize              struct.ImVec2
        DpiScale              float
        ParentViewportId      ImGuiID
        DrawData              pointer.ImDrawData
        RendererUserData      pointer
        PlatformUserData      pointer
        PlatformHandle        pointer
        PlatformHandleRaw     pointer
        PlatformRequestMove   ImBool
        PlatformRequestResize ImBool
        PlatformRequestClose  ImBool
    }

}
