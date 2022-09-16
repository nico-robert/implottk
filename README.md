# implotTk
This project aims to generate `Tcl` bindings for [implot](https://github.com/epezent/implot).

> **Warning**
> This project is in beta state, **anything** may change... 

## Dependencies:
- [Tcl cffi](https://cffi.magicsplat.com) >= 1.1
- [Dear Imgui](https://github.com/ocornut/imgui) 1.88 & [implot](https://github.com/epezent/implot) (see [build](lib/BUILD.md))

## Platform(s):
- Windows(x64/32).

## Known issues:
- Multiple `implottk::implotFrame` (contexts) is not supported (maybe with multiple interpreters Tcl... I don't know , `Viewports` would be (maybe) the solution but see below).
- Viewports with `opengl` and `win32` (multi windows) doesn't work (I have the same problem as this [one](https://github.com/ocornut/imgui/issues/2600)).
- And probably many others...

## Demo: 
- See [demo](demo/) folder for others examples with `Dear ImGui` integration.

```tcl
package require implottk

# add frame with options width & height
set f [implottk::implotFrame .f1 -width 500 -height 400]

# Set options
#   -title    : display 'title' plot 
#   -axisName : display name axis
$f options -title     "Demo_LinePlots" \
           -axisName  {x y}

# Add serie
#    '1'        : num serie
#    -dataX     : x coordinates
#    -dataY     : y coordinates
#    -lineStyle : color line serie (red RGB color here)
#    -name      : name line serie
$f series 1 -dataX {0 1 2 3 4} \
            -dataY {0 1 0.5 4 1} \
            -lineStyle {color {255 0 0}} \
            -name "Line 1"

# Map Tk .f1 frame
pack .f1 -fill both -expand 1
```

## Contributing :
If you like this project and want to contribute, you are welcome!

## Inspiration:
- [opengl-tcltk](https://github.com/codeplea/opengl-tcltk)
- [Tcl cffi examples](https://github.com/apnadkarni/tcl-cffi/tree/main/examples)

## Currently plots supported are :
- [x] line plots (partially...)
- [ ] shaded plots
- [ ] scatter plots
- [ ] vertical/horizontal/stacked bars graphs
- [ ] vertical/horizontal error bars
- [ ] stem plots
- [ ] stair plots
- [ ] pie charts
- [ ] heatmap charts
- [ ] 1D/2D histograms
- [ ] images

## License:
**implotTk** is covered under the terms of the [MIT](LICENSE) license.

## Release:
*  **15-09-2022** : 1.0b0