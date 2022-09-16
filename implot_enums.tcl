# Copyright (c) 2022 Nicolas ROBERT.
# Distributed under MIT license. Please see LICENSE for details.

namespace eval ::implot {

    # ImAxis_X1    : enabled by default
    # ImAxis_X2    : disabled by default
    # ImAxis_X3    : disabled by default
    # ImAxis_Y1    : enabled by default
    # ImAxis_Y2    : disabled by default
    # ImAxis_Y3    : disabled by default
    # ImAxis_COUNT : ImAxis_COUNT
    cffi::enum define ImAxis_ {
        ImAxis_X1    0
        ImAxis_X2    1
        ImAxis_X3    2
        ImAxis_Y1    3
        ImAxis_Y2    4
        ImAxis_Y3    5
        ImAxis_COUNT 6
    }

    # ImPlotAxisFlags_None          : default
    # ImPlotAxisFlags_NoLabel       : the axis label will not be displayed (axis labels also hidden if the supplied string name is NULL)
    # ImPlotAxisFlags_NoGridLines   : no grid lines will be displayed
    # ImPlotAxisFlags_NoTickMarks   : no tick marks will be displayed
    # ImPlotAxisFlags_NoTickLabels  : no text labels will be displayed
    # ImPlotAxisFlags_NoInitialFit  : axis will not be initially fit to data extents on the first rendered frame
    # ImPlotAxisFlags_NoMenus       : the user will not be able to open context menus with right-click
    # ImPlotAxisFlags_Opposite      : axis ticks and labels will be rendered on the conventionally opposite side (i.e, right or top)
    # ImPlotAxisFlags_Foreground    : grid lines will be displayed in the foreground (i.e. on top of data) in stead of the background
    # ImPlotAxisFlags_Invert        : the axis will be inverted
    # ImPlotAxisFlags_AutoFit       : axis will be auto-fitting to data extents
    # ImPlotAxisFlags_RangeFit      : axis will only fit points if the point is in the visible range of the **orthogonal** axis
    # ImPlotAxisFlags_PanStretch    : panning in a locked or constrained state will cause the axis to stretch if possible
    # ImPlotAxisFlags_LockMin       : zooming
    # ImPlotAxisFlags_LockMax       : zooming
    # ImPlotAxisFlags_Lock          : zooming
    # ImPlotAxisFlags_NoDecorations : ImPlotAxisFlags_NoDecorations = ImPlotAxisFlags_NoLabel | ImPlotAxisFlags_NoGridLines | ImPlotAxisFlags_NoTickMarks | ImPlotAxisFlags_NoTickLabels,
    # ImPlotAxisFlags_AuxDefault    : ImPlotAxisFlags_AuxDefault    = ImPlotAxisFlags_NoGridLines | ImPlotAxisFlags_Opposite
    cffi::enum define ImPlotAxisFlags_ {
        ImPlotAxisFlags_None          0
        ImPlotAxisFlags_NoLabel       1
        ImPlotAxisFlags_NoGridLines   2
        ImPlotAxisFlags_NoTickMarks   4
        ImPlotAxisFlags_NoTickLabels  8
        ImPlotAxisFlags_NoInitialFit  16
        ImPlotAxisFlags_NoMenus       32
        ImPlotAxisFlags_Opposite      64
        ImPlotAxisFlags_Foreground    128
        ImPlotAxisFlags_Invert        256
        ImPlotAxisFlags_AutoFit       512
        ImPlotAxisFlags_RangeFit      1024
        ImPlotAxisFlags_PanStretch    2048
        ImPlotAxisFlags_LockMin       4096
        ImPlotAxisFlags_LockMax       8192
        ImPlotAxisFlags_Lock          12288
        ImPlotAxisFlags_NoDecorations 15
        ImPlotAxisFlags_AuxDefault    66
    }

    # ImPlotBarGroupsFlags_None       : default
    # ImPlotBarGroupsFlags_Horizontal : bar groups will be rendered horizontally on the current y-axis
    # ImPlotBarGroupsFlags_Stacked    : items in a group will be stacked on top of each other
    cffi::enum define ImPlotBarGroupsFlags_ {
        ImPlotBarGroupsFlags_None       0
        ImPlotBarGroupsFlags_Horizontal 1024
        ImPlotBarGroupsFlags_Stacked    2048
    }

    # ImPlotBarsFlags_None       : default
    # ImPlotBarsFlags_Horizontal : bars will be rendered horizontally on the current y-axis
    cffi::enum define ImPlotBarsFlags_ {
        ImPlotBarsFlags_None       0
        ImPlotBarsFlags_Horizontal 1024
    }

    # ImPlotBin_Sqrt    : k = sqrt(n)
    # ImPlotBin_Sturges : k = 1 + log2(n)
    # ImPlotBin_Rice    : k = 2 * cbrt(n)
    # ImPlotBin_Scott   : cbrt(n)
    cffi::enum define ImPlotBin_ {
        ImPlotBin_Sqrt    -1
        ImPlotBin_Sturges -2
        ImPlotBin_Rice    -3
        ImPlotBin_Scott   -4
    }

    # ImPlotCol_Line          : outline color (defaults to next unused color in current colormap)
    # ImPlotCol_Fill          : plot fill color for bars (defaults to the current line color)
    # ImPlotCol_MarkerOutline : marker outline color (defaults to the current line color)
    # ImPlotCol_MarkerFill    : marker fill color (defaults to the current line color)
    # ImPlotCol_ErrorBar      : error bar color (defaults to ImGuiCol_Text)
    # ImPlotCol_FrameBg       : plot frame background color (defaults to ImGuiCol_FrameBg)
    # ImPlotCol_PlotBg        : plot area background color (defaults to ImGuiCol_WindowBg)
    # ImPlotCol_PlotBorder    : plot area border color (defaults to ImGuiCol_Border)
    # ImPlotCol_LegendBg      : legend background color (defaults to ImGuiCol_PopupBg)
    # ImPlotCol_LegendBorder  : legend border color (defaults to ImPlotCol_PlotBorder)
    # ImPlotCol_LegendText    : legend text color (defaults to ImPlotCol_InlayText)
    # ImPlotCol_TitleText     : plot title text color (defaults to ImGuiCol_Text)
    # ImPlotCol_InlayText     : legend text color (defaults to ImPlotCol_InlayText)
    # ImPlotCol_AxisText      : axis label and tick lables color (defaults to ImGuiCol_Text)
    # ImPlotCol_AxisGrid      : axis grid color (defaults to 25% ImPlotCol_AxisText)
    # ImPlotCol_AxisTick      : axis tick color (defaults to AxisGrid)
    # ImPlotCol_AxisBg        : background color of axis hover region (defaults to transparent)
    # ImPlotCol_AxisBgHovered : axis hover color (defaults to ImGuiCol_ButtonHovered)
    # ImPlotCol_AxisBgActive  : axis active color (defaults to ImGuiCol_ButtonActive)
    # ImPlotCol_Selection     : box-selection color (defaults to yellow)
    # ImPlotCol_Crosshairs    : crosshairs color (defaults to ImPlotCol_PlotBorder)
    # ImPlotCol_COUNT         : ImPlotCol_COUNT
    cffi::enum define ImPlotCol_ {
        ImPlotCol_Line          0
        ImPlotCol_Fill          1
        ImPlotCol_MarkerOutline 2
        ImPlotCol_MarkerFill    3
        ImPlotCol_ErrorBar      4
        ImPlotCol_FrameBg       5
        ImPlotCol_PlotBg        6
        ImPlotCol_PlotBorder    7
        ImPlotCol_LegendBg      8
        ImPlotCol_LegendBorder  9
        ImPlotCol_LegendText    10
        ImPlotCol_TitleText     11
        ImPlotCol_InlayText     12
        ImPlotCol_AxisText      13
        ImPlotCol_AxisGrid      14
        ImPlotCol_AxisTick      15
        ImPlotCol_AxisBg        16
        ImPlotCol_AxisBgHovered 17
        ImPlotCol_AxisBgActive  18
        ImPlotCol_Selection     19
        ImPlotCol_Crosshairs    20
        ImPlotCol_COUNT         21
    }

    # ImPlotColormapScaleFlags_None     : default
    # ImPlotColormapScaleFlags_NoLabel  : the colormap axis label will not be displayed
    # ImPlotColormapScaleFlags_Opposite : render the colormap label and tick labels on the opposite side
    # ImPlotColormapScaleFlags_Invert   : invert the colormap bar and axis scale (this only affects rendering; if you only want to reverse the scale mapping, make scale_min > scale_max)
    cffi::enum define ImPlotColormapScaleFlags_ {
        ImPlotColormapScaleFlags_None     0
        ImPlotColormapScaleFlags_NoLabel  1
        ImPlotColormapScaleFlags_Opposite 2
        ImPlotColormapScaleFlags_Invert   4
    }

    # ImPlotColormap_Deep     : a.k.a. seaborn deep             (qual=true,  n=10) (default)
    # ImPlotColormap_Dark     : a.k.a. matplotlib "Set1"        (qual=true,  n=9 )
    # ImPlotColormap_Pastel   : a.k.a. matplotlib "Pastel1"     (qual=true,  n=9 )
    # ImPlotColormap_Paired   : a.k.a. matplotlib "Paired"      (qual=true,  n=12)
    # ImPlotColormap_Viridis  : a.k.a. matplotlib "viridis"     (qual=false, n=11)
    # ImPlotColormap_Plasma   : a.k.a. matplotlib "plasma"      (qual=false, n=11)
    # ImPlotColormap_Hot      : MATLAB "hot"  (qual=false, n=11)
    # ImPlotColormap_Cool     : MATLAB "cool" (qual=false, n=11)
    # ImPlotColormap_Pink     : MATLAB "pink" (qual=false, n=11)
    # ImPlotColormap_Jet      : a.k.a. MATLAB "jet"             (qual=false, n=11)
    # ImPlotColormap_Twilight : a.k.a. matplotlib "twilight"    (qual=false, n=11)
    # ImPlotColormap_RdBu     : blue, Color Brewer          (qual=false, n=11)
    # ImPlotColormap_BrBG     : blue-green, Color Brewer  (qual=false, n=11)
    # ImPlotColormap_PiYG     : yellow-green, Color Brewer (qual=false, n=11)
    # ImPlotColormap_Spectral : color spectrum, Color Brewer    (qual=false, n=11)
    # ImPlotColormap_Greys    : black                     (qual=false, n=2 )
    cffi::enum define ImPlotColormap_ {
        ImPlotColormap_Deep     0
        ImPlotColormap_Dark     1
        ImPlotColormap_Pastel   2
        ImPlotColormap_Paired   3
        ImPlotColormap_Viridis  4
        ImPlotColormap_Plasma   5
        ImPlotColormap_Hot      6
        ImPlotColormap_Cool     7
        ImPlotColormap_Pink     8
        ImPlotColormap_Jet      9
        ImPlotColormap_Twilight 10
        ImPlotColormap_RdBu     11
        ImPlotColormap_BrBG     12
        ImPlotColormap_PiYG     13
        ImPlotColormap_Spectral 14
        ImPlotColormap_Greys    15
    }

    # ImPlotCond_None   : No condition (always set the variable), same as _Always
    # ImPlotCond_Always : No condition (always set the variable)
    # ImPlotCond_Once   : Set the variable once per runtime session (only the first call will succeed)
    cffi::enum define ImPlotCond_ {
        ImPlotCond_None   0
        ImPlotCond_Always 1
        ImPlotCond_Once   2
    }

    cffi::enum define ImPlotDateFmt_ {
        ImPlotDateFmt_None    0
        ImPlotDateFmt_DayMo   1
        ImPlotDateFmt_DayMoYr 2
        ImPlotDateFmt_MoYr    3
        ImPlotDateFmt_Mo      4
        ImPlotDateFmt_Yr      5
    }

    # ImPlotDigitalFlags_None : default
    cffi::enum define ImPlotDigitalFlags_ {
        ImPlotDigitalFlags_None 0
    }

    # ImPlotDragToolFlags_None      : default
    # ImPlotDragToolFlags_NoCursors : drag tools won't change cursor icons when hovered or held
    # ImPlotDragToolFlags_NoFit     : the drag tool won't be considered for plot fits
    # ImPlotDragToolFlags_NoInputs  : lock the tool from user inputs
    # ImPlotDragToolFlags_Delayed   : tool rendering will be delayed one frame; useful when applying position-constraints
    cffi::enum define ImPlotDragToolFlags_ {
        ImPlotDragToolFlags_None      0
        ImPlotDragToolFlags_NoCursors 1
        ImPlotDragToolFlags_NoFit     2
        ImPlotDragToolFlags_NoInputs  4
        ImPlotDragToolFlags_Delayed   8
    }

    # ImPlotDummyFlags_None : default
    cffi::enum define ImPlotDummyFlags_ {
        ImPlotDummyFlags_None 0
    }

    # ImPlotErrorBarsFlags_None       : default
    # ImPlotErrorBarsFlags_Horizontal : error bars will be rendered horizontally on the current y-axis
    cffi::enum define ImPlotErrorBarsFlags_ {
        ImPlotErrorBarsFlags_None       0
        ImPlotErrorBarsFlags_Horizontal 1024
    }

    # ImPlotFlags_None        : default
    # ImPlotFlags_NoTitle     : the plot title will not be displayed (titles are also hidden if preceeded by double hashes, e.g. "##MyPlot")
    # ImPlotFlags_NoLegend    : the legend will not be displayed
    # ImPlotFlags_NoMouseText : the mouse position, in plot coordinates, will not be displayed inside of the plot
    # ImPlotFlags_NoInputs    : the user will not be able to interact with the plot
    # ImPlotFlags_NoMenus     : the user will not be able to open context menus
    # ImPlotFlags_NoBoxSelect : the user will not be able to box-select
    # ImPlotFlags_NoChild     : a child window region will not be used to capture mouse scroll (can boost performance for single ImGui window applications)
    # ImPlotFlags_NoFrame     : the ImGui frame will not be rendered
    # ImPlotFlags_Equal       : pixel
    # ImPlotFlags_Crosshairs  : the default mouse cursor will be replaced with a crosshair when hovered
    # ImPlotFlags_CanvasOnly  : ImPlotFlags_CanvasOnly    = ImPlotFlags_NoTitle | ImPlotFlags_NoLegend | ImPlotFlags_NoMenus | ImPlotFlags_NoBoxSelect | ImPlotFlags_NoMouseText
    cffi::enum define ImPlotFlags_ {
        ImPlotFlags_None        0
        ImPlotFlags_NoTitle     1
        ImPlotFlags_NoLegend    2
        ImPlotFlags_NoMouseText 4
        ImPlotFlags_NoInputs    8
        ImPlotFlags_NoMenus     16
        ImPlotFlags_NoBoxSelect 32
        ImPlotFlags_NoChild     64
        ImPlotFlags_NoFrame     128
        ImPlotFlags_Equal       256
        ImPlotFlags_Crosshairs  512
        ImPlotFlags_CanvasOnly  55
    }

    # ImPlotHeatmapFlags_None     : default
    # ImPlotHeatmapFlags_ColMajor : data will be read in column major order
    cffi::enum define ImPlotHeatmapFlags_ {
        ImPlotHeatmapFlags_None     0
        ImPlotHeatmapFlags_ColMajor 1024
    }

    # ImPlotHistogramFlags_None       : default
    # ImPlotHistogramFlags_Horizontal : histogram bars will be rendered horizontally (not supported by PlotHistogram2D)
    # ImPlotHistogramFlags_Cumulative : each bin will contain its count plus the counts of all previous bins (not supported by PlotHistogram2D)
    # ImPlotHistogramFlags_Density    : counts will be normalized, i.e. the PDF will be visualized, or the CDF will be visualized if Cumulative is also set
    # ImPlotHistogramFlags_NoOutliers : exclude values outside the specifed histogram range from the count toward normalizing and cumulative counts
    # ImPlotHistogramFlags_ColMajor   : data will be read in column major order (not supported by PlotHistogram)
    cffi::enum define ImPlotHistogramFlags_ {
        ImPlotHistogramFlags_None       0
        ImPlotHistogramFlags_Horizontal 1024
        ImPlotHistogramFlags_Cumulative 2048
        ImPlotHistogramFlags_Density    4096
        ImPlotHistogramFlags_NoOutliers 8192
        ImPlotHistogramFlags_ColMajor   16384
    }

    # ImPlotImageFlags_None : default
    cffi::enum define ImPlotImageFlags_ {
        ImPlotImageFlags_None 0
    }

    # ImPlotInfLinesFlags_None       : default
    # ImPlotInfLinesFlags_Horizontal : lines will be rendered horizontally on the current y-axis
    cffi::enum define ImPlotInfLinesFlags_ {
        ImPlotInfLinesFlags_None       0
        ImPlotInfLinesFlags_Horizontal 1024
    }

    # ImPlotItemFlags_None     : ImPlotItemFlags_None     = 0,
    # ImPlotItemFlags_NoLegend : the item won't have a legend entry displayed
    # ImPlotItemFlags_NoFit    : the item won't be considered for plot fits
    cffi::enum define ImPlotItemFlags_ {
        ImPlotItemFlags_None     0
        ImPlotItemFlags_NoLegend 1
        ImPlotItemFlags_NoFit    2
    }

    # ImPlotLegendFlags_None            : default
    # ImPlotLegendFlags_NoButtons       : show buttons
    # ImPlotLegendFlags_NoHighlightItem : plot items will not be highlighted when their legend entry is hovered
    # ImPlotLegendFlags_NoHighlightAxis : y-axis count > 1)
    # ImPlotLegendFlags_NoMenus         : the user will not be able to open context menus with right-click
    # ImPlotLegendFlags_Outside         : legend will be rendered outside of the plot area
    # ImPlotLegendFlags_Horizontal      : legend entries will be displayed horizontally
    cffi::enum define ImPlotLegendFlags_ {
        ImPlotLegendFlags_None            0
        ImPlotLegendFlags_NoButtons       1
        ImPlotLegendFlags_NoHighlightItem 2
        ImPlotLegendFlags_NoHighlightAxis 4
        ImPlotLegendFlags_NoMenus         8
        ImPlotLegendFlags_Outside         16
        ImPlotLegendFlags_Horizontal      32
    }

    # ImPlotLineFlags_None     : default
    # ImPlotLineFlags_Segments : a line segment will be rendered from every two consecutive points
    # ImPlotLineFlags_Loop     : the last and first point will be connected to form a closed loop
    # ImPlotLineFlags_SkipNaN  : NaNs values will be skipped instead of rendered as missing data
    # ImPlotLineFlags_NoClip   : markers (if displayed) on the edge of a plot will not be clipped
    cffi::enum define ImPlotLineFlags_ {
        ImPlotLineFlags_None     0
        ImPlotLineFlags_Segments 1024
        ImPlotLineFlags_Loop     2048
        ImPlotLineFlags_SkipNaN  4096
        ImPlotLineFlags_NoClip   8192
    }

    # ImPlotLocation_Center    : center-center
    # ImPlotLocation_North     : top-center
    # ImPlotLocation_South     : bottom-center
    # ImPlotLocation_West      : center-left
    # ImPlotLocation_East      : center-right
    # ImPlotLocation_NorthWest : top-left
    # ImPlotLocation_NorthEast : top-right
    # ImPlotLocation_SouthWest : bottom-left
    # ImPlotLocation_SouthEast : bottom-right
    cffi::enum define ImPlotLocation_ {
        ImPlotLocation_Center    0
        ImPlotLocation_North     1
        ImPlotLocation_South     2
        ImPlotLocation_West      4
        ImPlotLocation_East      8
        ImPlotLocation_NorthWest 5
        ImPlotLocation_NorthEast 9
        ImPlotLocation_SouthWest 6
        ImPlotLocation_SouthEast 10
    }

    # ImPlotMarker_None     : no marker
    # ImPlotMarker_Circle   : a circle marker (default)
    # ImPlotMarker_Square   : a square maker
    # ImPlotMarker_Diamond  : a diamond marker
    # ImPlotMarker_Up       : an upward-pointing triangle marker
    # ImPlotMarker_Down     : an downward-pointing triangle marker
    # ImPlotMarker_Left     : an leftward-pointing triangle marker
    # ImPlotMarker_Right    : an rightward-pointing triangle marker
    # ImPlotMarker_Cross    : a cross marker (not fillable)
    # ImPlotMarker_Plus     : a plus marker (not fillable)
    # ImPlotMarker_Asterisk : a asterisk marker (not fillable)
    # ImPlotMarker_COUNT    : ImPlotMarker_COUNT
    cffi::enum define ImPlotMarker_ {
        ImPlotMarker_None     -1
        ImPlotMarker_Circle   0
        ImPlotMarker_Square   1
        ImPlotMarker_Diamond  2
        ImPlotMarker_Up       3
        ImPlotMarker_Down     4
        ImPlotMarker_Left     5
        ImPlotMarker_Right    6
        ImPlotMarker_Cross    7
        ImPlotMarker_Plus     8
        ImPlotMarker_Asterisk 9
        ImPlotMarker_COUNT    10
    }

    # ImPlotMouseTextFlags_None       : default
    # ImPlotMouseTextFlags_NoAuxAxes  : only show the mouse position for primary axes
    # ImPlotMouseTextFlags_NoFormat   : axes label formatters won't be used to render text
    # ImPlotMouseTextFlags_ShowAlways : always display mouse position even if plot not hovered
    cffi::enum define ImPlotMouseTextFlags_ {
        ImPlotMouseTextFlags_None       0
        ImPlotMouseTextFlags_NoAuxAxes  1
        ImPlotMouseTextFlags_NoFormat   2
        ImPlotMouseTextFlags_ShowAlways 4
    }

    # ImPlotPieChartFlags_None      : default
    # ImPlotPieChartFlags_Normalize : force normalization of pie chart values (i.e. always make a full circle if sum < 0)
    cffi::enum define ImPlotPieChartFlags_ {
        ImPlotPieChartFlags_None      0
        ImPlotPieChartFlags_Normalize 1024
    }

    # ImPlotScale_Linear : default linear scale
    # ImPlotScale_Time   : time scale
    # ImPlotScale_Log10  : base 10 logartithmic scale
    # ImPlotScale_SymLog : symmetric log scale
    cffi::enum define ImPlotScale_ {
        ImPlotScale_Linear 0
        ImPlotScale_Time   1
        ImPlotScale_Log10  2
        ImPlotScale_SymLog 3
    }

    # ImPlotScatterFlags_None   : default
    # ImPlotScatterFlags_NoClip : markers on the edge of a plot will not be clipped
    cffi::enum define ImPlotScatterFlags_ {
        ImPlotScatterFlags_None   0
        ImPlotScatterFlags_NoClip 1024
    }

    # ImPlotShadedFlags_None : default
    cffi::enum define ImPlotShadedFlags_ {
        ImPlotShadedFlags_None 0
    }

    # ImPlotStairsFlags_None    : default
    # ImPlotStairsFlags_PreStep : the y value is continued constantly to the left from every x position, i.e. the interval (x[i-1], x[i]] has the value y[i]
    cffi::enum define ImPlotStairsFlags_ {
        ImPlotStairsFlags_None    0
        ImPlotStairsFlags_PreStep 1024
    }

    # ImPlotStemsFlags_None       : default
    # ImPlotStemsFlags_Horizontal : stems will be rendered horizontally on the current y-axis
    cffi::enum define ImPlotStemsFlags_ {
        ImPlotStemsFlags_None       0
        ImPlotStemsFlags_Horizontal 1024
    }

    # ImPlotStyleVar_LineWeight         : float,  plot item line weight in pixels
    # ImPlotStyleVar_Marker             : int,    marker specification
    # ImPlotStyleVar_MarkerSize         : float,  marker size in pixels (roughly the marker's "radius")
    # ImPlotStyleVar_MarkerWeight       : float,  plot outline weight of markers in pixels
    # ImPlotStyleVar_FillAlpha          : float,  alpha modifier applied to all plot item fills
    # ImPlotStyleVar_ErrorBarSize       : float,  error bar whisker width in pixels
    # ImPlotStyleVar_ErrorBarWeight     : float,  error bar whisker weight in pixels
    # ImPlotStyleVar_DigitalBitHeight   : float,  digital channels bit height (at 1) in pixels
    # ImPlotStyleVar_DigitalBitGap      : float,  digital channels bit padding gap in pixels
    # ImPlotStyleVar_PlotBorderSize     : float,  thickness of border around plot area
    # ImPlotStyleVar_MinorAlpha         : float,  alpha multiplier applied to minor axis grid lines
    # ImPlotStyleVar_MajorTickLen       : ImVec2, major tick lengths for X and Y axes
    # ImPlotStyleVar_MinorTickLen       : ImVec2, minor tick lengths for X and Y axes
    # ImPlotStyleVar_MajorTickSize      : ImVec2, line thickness of major ticks
    # ImPlotStyleVar_MinorTickSize      : ImVec2, line thickness of minor ticks
    # ImPlotStyleVar_MajorGridSize      : ImVec2, line thickness of major grid lines
    # ImPlotStyleVar_MinorGridSize      : ImVec2, line thickness of minor grid lines
    # ImPlotStyleVar_PlotPadding        : ImVec2, padding between widget frame and plot area, labels, or outside legends (i.e. main padding)
    # ImPlotStyleVar_LabelPadding       : ImVec2, padding between axes labels, tick labels, and plot edge
    # ImPlotStyleVar_LegendPadding      : ImVec2, legend padding from plot edges
    # ImPlotStyleVar_LegendInnerPadding : ImVec2, legend inner padding from legend edges
    # ImPlotStyleVar_LegendSpacing      : ImVec2, spacing between legend entries
    # ImPlotStyleVar_MousePosPadding    : ImVec2, padding between plot edge and interior info text
    # ImPlotStyleVar_AnnotationPadding  : ImVec2, text padding around annotation labels
    # ImPlotStyleVar_FitPadding         : ImVec2, additional fit padding as a percentage of the fit extents (e.g. ImVec2(0.1f,0.1f) adds 10% to the fit extents of X and Y)
    # ImPlotStyleVar_PlotDefaultSize    : ImVec2, default size used when ImVec2(0,0) is passed to BeginPlot
    # ImPlotStyleVar_PlotMinSize        : ImVec2, minimum size plot frame can be when shrunk
    # ImPlotStyleVar_COUNT              : ImPlotStyleVar_COUNT
    cffi::enum define ImPlotStyleVar_ {
        ImPlotStyleVar_LineWeight         0
        ImPlotStyleVar_Marker             1
        ImPlotStyleVar_MarkerSize         2
        ImPlotStyleVar_MarkerWeight       3
        ImPlotStyleVar_FillAlpha          4
        ImPlotStyleVar_ErrorBarSize       5
        ImPlotStyleVar_ErrorBarWeight     6
        ImPlotStyleVar_DigitalBitHeight   7
        ImPlotStyleVar_DigitalBitGap      8
        ImPlotStyleVar_PlotBorderSize     9
        ImPlotStyleVar_MinorAlpha         10
        ImPlotStyleVar_MajorTickLen       11
        ImPlotStyleVar_MinorTickLen       12
        ImPlotStyleVar_MajorTickSize      13
        ImPlotStyleVar_MinorTickSize      14
        ImPlotStyleVar_MajorGridSize      15
        ImPlotStyleVar_MinorGridSize      16
        ImPlotStyleVar_PlotPadding        17
        ImPlotStyleVar_LabelPadding       18
        ImPlotStyleVar_LegendPadding      19
        ImPlotStyleVar_LegendInnerPadding 20
        ImPlotStyleVar_LegendSpacing      21
        ImPlotStyleVar_MousePosPadding    22
        ImPlotStyleVar_AnnotationPadding  23
        ImPlotStyleVar_FitPadding         24
        ImPlotStyleVar_PlotDefaultSize    25
        ImPlotStyleVar_PlotMinSize        26
        ImPlotStyleVar_COUNT              27
    }

    # ImPlotSubplotFlags_None       : default
    # ImPlotSubplotFlags_NoTitle    : the subplot title will not be displayed (titles are also hidden if preceeded by double hashes, e.g. "##MySubplot")
    # ImPlotSubplotFlags_NoLegend   : the legend will not be displayed (only applicable if ImPlotSubplotFlags_ShareItems is enabled)
    # ImPlotSubplotFlags_NoMenus    : the user will not be able to open context menus with right-click
    # ImPlotSubplotFlags_NoResize   : resize splitters between subplot cells will be not be provided
    # ImPlotSubplotFlags_NoAlign    : subplot edges will not be aligned vertically or horizontally
    # ImPlotSubplotFlags_ShareItems : the legend will not be displayed (only applicable if ImPlotSubplotFlags_ShareItems is enabled)
    # ImPlotSubplotFlags_LinkRows   : link the y-axis limits of all plots in each row (does not apply to auxiliary axes)
    # ImPlotSubplotFlags_LinkCols   : link the x-axis limits of all plots in each column (does not apply to auxiliary axes)
    # ImPlotSubplotFlags_LinkAllX   : link the x-axis limits in every plot in the subplot (does not apply to auxiliary axes)
    # ImPlotSubplotFlags_LinkAllY   : link the y-axis limits in every plot in the subplot (does not apply to auxiliary axes)
    # ImPlotSubplotFlags_ColMajor   : subplots are added in column major order instead of the default row major order
    cffi::enum define ImPlotSubplotFlags_ {
        ImPlotSubplotFlags_None       0
        ImPlotSubplotFlags_NoTitle    1
        ImPlotSubplotFlags_NoLegend   2
        ImPlotSubplotFlags_NoMenus    4
        ImPlotSubplotFlags_NoResize   8
        ImPlotSubplotFlags_NoAlign    16
        ImPlotSubplotFlags_ShareItems 32
        ImPlotSubplotFlags_LinkRows   64
        ImPlotSubplotFlags_LinkCols   128
        ImPlotSubplotFlags_LinkAllX   256
        ImPlotSubplotFlags_LinkAllY   512
        ImPlotSubplotFlags_ColMajor   1024
    }

    # ImPlotTextFlags_None     : default
    # ImPlotTextFlags_Vertical : text will be rendered vertically
    cffi::enum define ImPlotTextFlags_ {
        ImPlotTextFlags_None     0
        ImPlotTextFlags_Vertical 1024
    }

    cffi::enum define ImPlotTimeFmt_ {
        ImPlotTimeFmt_None     0
        ImPlotTimeFmt_Us       1
        ImPlotTimeFmt_SUs      2
        ImPlotTimeFmt_SMs      3
        ImPlotTimeFmt_S        4
        ImPlotTimeFmt_HrMinSMs 5
        ImPlotTimeFmt_HrMinS   6
        ImPlotTimeFmt_HrMin    7
        ImPlotTimeFmt_Hr       8
    }

    cffi::enum define ImPlotTimeUnit_ {
        ImPlotTimeUnit_Us    0
        ImPlotTimeUnit_Ms    1
        ImPlotTimeUnit_S     2
        ImPlotTimeUnit_Min   3
        ImPlotTimeUnit_Hr    4
        ImPlotTimeUnit_Day   5
        ImPlotTimeUnit_Mo    6
        ImPlotTimeUnit_Yr    7
        ImPlotTimeUnit_COUNT 8
    }


    cffi::alias define ImAxis                   {int {enum ImAxis_}}
    cffi::alias define ImPlotAxisFlags          {int {enum ImPlotAxisFlags_}}
    cffi::alias define ImPlotBarGroupsFlags     {int {enum ImPlotBarGroupsFlags_}}
    cffi::alias define ImPlotBarsFlags          {int {enum ImPlotBarsFlags_}}
    cffi::alias define ImPlotBin                {int {enum ImPlotBin_}}
    cffi::alias define ImPlotCol                {int {enum ImPlotCol_}}
    cffi::alias define ImPlotColormapScaleFlags {int {enum ImPlotColormapScaleFlags_}}
    cffi::alias define ImPlotColormap           {int {enum ImPlotColormap_}}
    cffi::alias define ImPlotCond               {int {enum ImPlotCond_}}
    cffi::alias define ImPlotDateFmt            {int {enum ImPlotDateFmt_}}
    cffi::alias define ImPlotDigitalFlags       {int {enum ImPlotDigitalFlags_}}
    cffi::alias define ImPlotDragToolFlags      {int {enum ImPlotDragToolFlags_}}
    cffi::alias define ImPlotDummyFlags         {int {enum ImPlotDummyFlags_}}
    cffi::alias define ImPlotErrorBarsFlags     {int {enum ImPlotErrorBarsFlags_}}
    cffi::alias define ImPlotFlags              {int {enum ImPlotFlags_}}
    cffi::alias define ImPlotHeatmapFlags       {int {enum ImPlotHeatmapFlags_}}
    cffi::alias define ImPlotHistogramFlags     {int {enum ImPlotHistogramFlags_}}
    cffi::alias define ImPlotImageFlags         {int {enum ImPlotImageFlags_}}
    cffi::alias define ImPlotInfLinesFlags      {int {enum ImPlotInfLinesFlags_}}
    cffi::alias define ImPlotItemFlags          {int {enum ImPlotItemFlags_}}
    cffi::alias define ImPlotLegendFlags        {int {enum ImPlotLegendFlags_}}
    cffi::alias define ImPlotLineFlags          {int {enum ImPlotLineFlags_}}
    cffi::alias define ImPlotLocation           {int {enum ImPlotLocation_}}
    cffi::alias define ImPlotMarker             {int {enum ImPlotMarker_}}
    cffi::alias define ImPlotMouseTextFlags     {int {enum ImPlotMouseTextFlags_}}
    cffi::alias define ImPlotPieChartFlags      {int {enum ImPlotPieChartFlags_}}
    cffi::alias define ImPlotScale              {int {enum ImPlotScale_}}
    cffi::alias define ImPlotScatterFlags       {int {enum ImPlotScatterFlags_}}
    cffi::alias define ImPlotShadedFlags        {int {enum ImPlotShadedFlags_}}
    cffi::alias define ImPlotStairsFlags        {int {enum ImPlotStairsFlags_}}
    cffi::alias define ImPlotStemsFlags         {int {enum ImPlotStemsFlags_}}
    cffi::alias define ImPlotStyleVar           {int {enum ImPlotStyleVar_}}
    cffi::alias define ImPlotSubplotFlags       {int {enum ImPlotSubplotFlags_}}
    cffi::alias define ImPlotTextFlags          {int {enum ImPlotTextFlags_}}
    cffi::alias define ImPlotTimeFmt            {int {enum ImPlotTimeFmt_}}
    cffi::alias define ImPlotTimeUnit           {int {enum ImPlotTimeUnit_}}
}