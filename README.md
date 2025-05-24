display-filter-heightmap
========================

This is a GIMP display filter module that renders greyscale images with a topographic heightmap gradient.

Installation
------------

Download the appropriate file for your OS, and put it in the `modules` directory for your GIMP installation. On Windows, this is:
```
%AppData%\GIMP\3.0\modules
```
On Linux, this is:
```
~/.config/GIMP/3.0/modules
```

Usage
-----

To enable the filter open `View > Display Filters...`, and add the 'Heightmap' filter to the list of active filters.

The filter has two settings: Sea Level, and Resolution.

Sea Level is a value between 0 and 1 that determines which greyscale values are mapped to land colours and which are mapped to water colours. The default value is 0.369, which is equivalent to 94/255 and is the default sea level for EU4 heightmaps.

Resolution is the number of points from the gradient that will be cached and used to render the image. Lower values will introduce more banding artifacts but use less memory. The default value of 1024 should result in no visible banding with the default gradient, and will use 12KiB of memory for the cache.

You may need to disable and re-enable the display filter for changed settings to become visible.
