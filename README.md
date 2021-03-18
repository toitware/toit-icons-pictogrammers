# Pictogrammers Icons

These icons are from the Pictogrammers project which builds
on the free icons released by the Google Material Design
project.  See https://materialdesignicons.com/ and
https://pictogrammers.com/

## Usage

``` toit
import pixel_display show TwoColorPixelDisplay
import pictogrammers_icons.size_96 as icons

main:
  display := TwoColorPixelDisplay "eink"

  context := display.context --landscape

  weather := display.icon context 30 78 icons.WEATHER_LIGHTNING_RAINY

  display.draw
```
