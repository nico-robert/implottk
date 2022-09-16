# Copyright (c) 2022 Nicolas ROBERT.
# Distributed under MIT license. Please see LICENSE for details.

namespace eval ::implot {

    cffi::Struct create ImPlotTime {
        S  time_t
        Us int
    }

    cffi::Struct create ImPlotDateTimeSpec {
        Date           ImPlotDateFmt
        Time           ImPlotTimeFmt
        UseISO8601     ImBool
        Use24HourClock ImBool
    }

    cffi::Struct create Formatter_Time_Data {
        Time              struct.ImPlotTime
        Spec              struct.ImPlotDateTimeSpec
        UserFormatter     pointer.ImPlotFormatter
        UserFormatterData pointer
    }

    cffi::Struct create ImPlotAlignmentData {
        Vertical ImBool
        PadA     float
        PadB     float
        PadAMax  float
        PadBMax  float
    }

    cffi::Struct create ImPlotAnnotation {
        Pos        struct.::imgui::ImVec2
        Offset     struct.::imgui::ImVec2
        ColorBg    ImU32
        ColorFg    ImU32
        TextOffset int
        Clamp      ImBool
    }

    cffi::Struct create ImVector_ImPlotAnnotation {
        Size     int
        Capacity int
        Data     pointer.ImPlotAnnotation
    }

    cffi::Struct create ImPlotAnnotationCollection {
        Annotations struct.ImVector_ImPlotAnnotation
        TextBuffer  struct.::imgui::ImGuiTextBuffer
        Size        int
    }

    cffi::Struct create ImPlotTick {
        PlotPos    double
        PixelPos   float
        LabelSize  struct.::imgui::ImVec2
        TextOffset int
        Major      ImBool
        ShowLabel  ImBool
        Level      int
        Idx        int
    }

    cffi::Struct create ImVector_ImPlotTick {
        Size     int
        Capacity int
        Data     pointer.ImPlotTick
    }

    cffi::Struct create ImPlotTicker {
        Ticks      struct.ImVector_ImPlotTick
        TextBuffer struct.::imgui::ImGuiTextBuffer
        MaxSize    struct.::imgui::ImVec2
        LateSize   struct.::imgui::ImVec2
        Levels     int
    }

    cffi::Struct create ImPlotAxis {
        ID               ImGuiID
        Flags            ImPlotAxisFlags
        PreviousFlags    ImPlotAxisFlags
        Range            struct.ImPlotRange
        RangeCond        ImPlotCond
        Scale            ImPlotScale
        FitExtents       struct.ImPlotRange
        OrthoAxis        pointer.ImPlotAxis
        ConstraintRange  struct.ImPlotRange
        ConstraintZoom   struct.ImPlotRange
        Ticker           struct.ImPlotTicker
        Formatter        pointer.ImPlotFormatter
        FormatterData    pointer
        FormatSpec       chars[16]
        Locator          pointer.ImPlotLocator
        LinkedMin        pointer.double
        LinkedMax        pointer.double
        PickerLevel      int
        PickerTimeMin    struct.ImPlotTime
        PickerTimeMax    struct.ImPlotTime
        TransformForward pointer.ImPlotTransform
        TransformInverse pointer.ImPlotTransform
        TransformData    pointer
        PixelMin         float
        PixelMax         float
        ScaleMin         double
        ScaleMax         double
        ScaleToPixel     double
        Datum1           float
        Datum2           float
        HoverRect        struct.::imgui::ImRect
        LabelOffset      int
        ColorMaj         ImU32
        ColorMin         ImU32
        ColorTick        ImU32
        ColorTxt         ImU32
        ColorBg          ImU32
        ColorHov         ImU32
        ColorAct         ImU32
        ColorHiLi        ImU32
        Enabled          ImBool
        Vertical         ImBool
        FitThisFrame     ImBool
        HasRange         ImBool
        HasFormatSpec    ImBool
        ShowDefaultTicks ImBool
        Hovered          ImBool
        Held             ImBool
    }

    cffi::Struct create ImVector_int {
        Size     int
        Capacity int
        Data     pointer.int
    }

    cffi::Struct create ImVector_bool {
        Size     int
        Capacity int
        Data     pointer.bool
    }

    cffi::Struct create ImPlotColormapData {
        Keys         ImVector_ImU32
        KeyCounts    struct.ImVector_int
        KeyOffsets   struct.ImVector_int
        Tables       ImVector_ImU32
        TableSizes   struct.ImVector_int
        TableOffsets struct.ImVector_int
        Text         struct.::imgui::ImGuiTextBuffer
        TextOffsets  struct.ImVector_int
        Quals        struct.ImVector_bool
        Map          struct.::imgui::ImGuiStorage
        Count        int
    }


    cffi::Struct create ImVector_ImPlotPlot {
        Size     int
        Capacity int
        Data     pointer.ImPlotPlot
    }

    cffi::Struct create ImPool_ImPlotPlot {
        Buf        struct.ImVector_ImPlotPlot
        Map        struct.::imgui::ImGuiStorage
        FreeIdx    ImPoolIdx
        AliveCount ImPoolIdx
    }

    cffi::Struct create ImVector_ImPlotSubplot {
        Size     int
        Capacity int
        Data     pointer.ImPlotSubplot
    }

    cffi::Struct create ImPool_ImPlotSubplot {
        Buf        struct.ImVector_ImPlotSubplot
        Map        struct.::imgui::ImGuiStorage
        FreeIdx    ImPoolIdx
        AliveCount ImPoolIdx
    }

    cffi::Struct create ImVector_ImPlotTag {
        Size     int
        Capacity int
        Data     pointer.ImPlotTag
    }

    cffi::Struct create ImPlotTagCollection {
        Tags       struct.ImVector_ImPlotTag
        TextBuffer struct.::imgui::ImGuiTextBuffer
        Size       int
    }

    cffi::Struct create ImPlotStyle {
        LineWeight              float
        Marker                  int
        MarkerSize              float
        MarkerWeight            float
        FillAlpha               float
        ErrorBarSize            float
        ErrorBarWeight          float
        DigitalBitHeight        float
        DigitalBitGap           float
        PlotBorderSize          float
        MinorAlpha              float
        MajorTickLen            struct.::imgui::ImVec2
        MinorTickLen            struct.::imgui::ImVec2
        MajorTickSize           struct.::imgui::ImVec2
        MinorTickSize           struct.::imgui::ImVec2
        MajorGridSize           struct.::imgui::ImVec2
        MinorGridSize           struct.::imgui::ImVec2
        PlotPadding             struct.::imgui::ImVec2
        LabelPadding            struct.::imgui::ImVec2
        LegendPadding           struct.::imgui::ImVec2
        LegendInnerPadding      struct.::imgui::ImVec2
        LegendSpacing           struct.::imgui::ImVec2
        MousePosPadding         struct.::imgui::ImVec2
        AnnotationPadding       struct.::imgui::ImVec2
        FitPadding              struct.::imgui::ImVec2
        PlotDefaultSize         struct.::imgui::ImVec2
        PlotMinSize             struct.::imgui::ImVec2
        Colors                  struct.::imgui::ImVec4[21]
        Colormap                ImPlotColormap
        UseLocalTime            ImBool
        UseISO8601              ImBool
        Use24HourClock          ImBool
    }

    cffi::Struct create ImVector_ImPlotColormap {
        Size     int
        Capacity int
        Data     pointer.ImPlotColormap
    }

    cffi::Struct create ImVector_double {
        Size     int
        Capacity int
        Data     pointer.double
    }

    cffi::Struct create ImPlotNextPlotData {
        RangeCond[6]            ImPlotCond
        Range                   struct.ImPlotRange[6]
        HasRange                int[6]
        Fit                     int[6]
        LinkedMin               pointer.double[6]
        LinkedMax               pointer.double[6]
    }

    cffi::Struct create ImPlotNextItemData {
        Colors           struct.::imgui::ImVec4[5]
        LineWeight       float
        Marker           ImPlotMarker
        MarkerSize       float
        MarkerWeight     float
        FillAlpha        float
        ErrorBarSize     float
        ErrorBarWeight   float
        DigitalBitHeight float
        DigitalBitGap    float
        RenderLine       ImBool
        RenderFill       ImBool
        RenderMarkerLine ImBool
        RenderMarkerFill ImBool
        HasHidden        ImBool
        Hidden           ImBool
        HiddenCond       ImPlotCond
    }

    cffi::Struct create ImPlotInputMap {
        Pan           ::imgui::ImGuiMouseButton
        PanMod        ::imgui::ImGuiModFlags
        Fit           ::imgui::ImGuiMouseButton
        Select        ::imgui::ImGuiMouseButton
        SelectCancel  ::imgui::ImGuiMouseButton
        SelectMod     ::imgui::ImGuiModFlags
        SelectHorzMod ::imgui::ImGuiModFlags
        SelectVertMod ::imgui::ImGuiModFlags
        Menu          ::imgui::ImGuiMouseButton
        OverrideMod   ::imgui::ImGuiModFlags
        ZoomMod       ::imgui::ImGuiModFlags
        ZoomRate      float
    }

    cffi::Struct create ImVector_ImPlotAlignmentData {
        Size     int
        Capacity int
        Data     pointer.ImPlotAlignmentData
    }

    cffi::Struct create ImPool_ImPlotAlignmentData {
        Buf        struct.ImVector_ImPlotAlignmentData
        Map        struct.::imgui::ImGuiStorage
        FreeIdx    ImPoolIdx
        AliveCount ImPoolIdx
    }

    cffi::Struct create ImPlotContext {
        Plots                 struct.ImPool_ImPlotPlot
        Subplots              struct.ImPool_ImPlotSubplot
        CurrentPlot           pointer.ImPlotPlot
        CurrentSubplot        pointer.ImPlotSubplot
        CurrentItems          pointer.ImPlotItemGroup
        CurrentItem           pointer.ImPlotItem
        PreviousItem          pointer.ImPlotItem
        CTicker               struct.ImPlotTicker
        Annotations           struct.ImPlotAnnotationCollection
        Tags                  struct.ImPlotTagCollection
        ChildWindowMade       ImBool
        Style                 struct.ImPlotStyle
        ColorModifiers        struct.::imgui::ImVector_ImGuiColorMod
        StyleModifiers        struct.::imgui::ImVector_ImGuiStyleMod
        ColormapData          struct.ImPlotColormapData
        ColormapModifiers     struct.ImVector_ImPlotColormap
        Tm                    struct.::imgui::tm
        TempDouble1           struct.ImVector_double
        TempDouble2           struct.ImVector_double
        TempInt1              struct.ImVector_int
        DigitalPlotItemCnt    int
        DigitalPlotOffset     int
        NextPlotData          struct.ImPlotNextPlotData
        NextItemData          struct.ImPlotNextItemData
        InputMap              struct.ImPlotInputMap
        OpenContextThisFrame  ImBool
        MousePosStringBuilder struct.::imgui::ImGuiTextBuffer
        AlignmentData         struct.ImPool_ImPlotAlignmentData
        CurrentAlignmentH     pointer.ImPlotAlignmentData
        CurrentAlignmentV     pointer.ImPlotAlignmentData
    }

    cffi::Struct create ImPlotItem {
        ID              ImGuiID
        Color           ImU32
        LegendHoverRect struct.::imgui::ImRect
        NameOffset      int
        Show            ImBool
        LegendHovered   ImBool
        SeenThisFrame   ImBool
    }

    cffi::Struct create ImPlotLegend {
        Flags            ImPlotLegendFlags
        PreviousFlags    ImPlotLegendFlags
        Location         ImPlotLocation
        PreviousLocation ImPlotLocation
        Indices          struct.ImVector_int
        Labels           struct.::imgui::ImGuiTextBuffer
        Rect             struct.::imgui::ImRect
        Hovered          ImBool
        Held             ImBool
        CanGoInside      ImBool
    }


    cffi::Struct create ImVector_ImPlotItem {
        Size     int
        Capacity int
        Data     pointer.ImPlotItem
    }

    cffi::Struct create ImPool_ImPlotItem {
        Buf        struct.ImVector_ImPlotItem
        Map        struct.::imgui::ImGuiStorage
        FreeIdx    ImPoolIdx
        AliveCount ImPoolIdx
    }

    cffi::Struct create ImPlotItemGroup {
        ID          ImGuiID
        Legend      struct.ImPlotLegend
        ItemPool    struct.ImPool_ImPlotItem
        ColormapIdx int
    }

    cffi::Struct create ImPlotPlot {
        ID                 ImGuiID
        Flags              ImPlotFlags
        PreviousFlags      ImPlotFlags
        MouseTextLocation  ImPlotLocation
        MouseTextFlags     ImPlotMouseTextFlags
        Axes               struct.ImPlotAxis[6]
        TextBuffer         struct.::imgui::ImGuiTextBuffer
        Items              struct.ImPlotItemGroup
        CurrentX           ImAxis
        CurrentY           ImAxis
        FrameRect          struct.::imgui::ImRect
        CanvasRect         struct.::imgui::ImRect
        PlotRect           struct.::imgui::ImRect
        AxesRect           struct.::imgui::ImRect
        SelectRect         struct.::imgui::ImRect
        SelectStart        struct.::imgui::ImVec2
        TitleOffset        int
        JustCreated        ImBool
        Initialized        ImBool
        SetupLocked        ImBool
        FitThisFrame       ImBool
        Hovered            ImBool
        Held               ImBool
        Selecting          ImBool
        Selected           ImBool
        ContextLocked      ImBool
    }

    cffi::Struct create ImPlotPoint {
        x double
        y double
    }

    cffi::Struct create ImPlotPointError {
        X   double
        Y   double
        Neg double
        Pos double
    }

    cffi::Struct create ImPlotRect {
        X struct.ImPlotRange
        Y struct.ImPlotRange
    }

    cffi::Struct create ImVector_float {
        Size     int
        Capacity int
        Data     pointer.float
    }

    cffi::Struct create ImVector_ImPlotRange {
        Size     int
        Capacity int
        Data     pointer.ImPlotRange
    }

    cffi::Struct create ImPlotSubplot {
        ID               ImGuiID
        Flags            ImPlotSubplotFlags
        PreviousFlags    ImPlotSubplotFlags
        Items            struct.ImPlotItemGroup
        Rows             int
        Cols             int
        CurrentIdx       int
        FrameRect        struct.::imgui::ImRect
        GridRect         struct.::imgui::ImRect
        CellSize         struct.::imgui::ImVec2
        RowAlignmentData struct.ImVector_ImPlotAlignmentData
        ColAlignmentData struct.ImVector_ImPlotAlignmentData
        RowRatios        struct.ImVector_float
        ColRatios        struct.ImVector_float
        RowLinkData      struct.ImVector_ImPlotRange
        ColLinkData      struct.ImVector_ImPlotRange
        TempSizes        float[2]
        FrameHovered     ImBool
        HasTitle         ImBool
    }

    cffi::Struct create ImPlotTag {
        Axis       ImAxis
        Value      double
        ColorBg    ImU32
        ColorFg    ImU32
        TextOffset int
    }
}