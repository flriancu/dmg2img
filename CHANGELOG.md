# Changelog

## [1.6.5] - 23 July 2013 - vu1tur

-   Fixed a bug in handling some types of dmg files

## [1.6.4] - 25 April 2012 - vu1tur

-   Compilation bugfix (Linux)

## [1.6.3] - 07 April 2012 - vu1tur

-   Added option -l to list partitions
-   Added option -p to extract only specific partition
-   Added support for a rare case scenario of koly block being at the the beginning of the image (thanks to Friik)

## [1.6.2] - 24 March 2010 - vu1tur

-   Fixed a bug in processing a terminal block type
-   Added periodic flushing of debug log file

## [1.6.1] - 12 August 2009 - vu1tur

-   Fixed a bug in handling large files on win32 systems

## [1.6] - 15 April 2009 - vu1tur

-   Added support for dmg images that only have binary resource fork but no XML plist
-   Refined koly block processing
-   Fixed a bug in finding the offset for the next compressed block when offsets are defined relative to the current partition
-   Fixed broken progress indicator
-   Added detection of images with GUID Partition Table and respective mount commands in linux

## [1.5.1] - 11 April 2009 - vu1tur

-   Added missing zero block type
-   Small fixes and clean up

## [1.5] - 8 April 2009 - vu1tur

-   Fixed a bug in parsing partition list from plist
-   Added support for ADC-compressed DMG images

## [1.4.1] - 6 April 2009 - vu1tur

-   Fixed a bug in writing the output file that caused some DMG images to convert to a broken unmountable IMG image

## [1.4] - 5 April 2009 - Jean-Pierre Demailly

-   Applied patch from Vladimir 'phcoder' Serbinenko which brings correct handling of 64bit integers in koly signature and plist data, and should enable dmg2img to work on huge archives > 4GBytes (tested by 'phcoder')
-   Added support for dmg archives involving bzip2 instead of zlib compression (this has not received much testing yet, as those archives are still unfrequent)
Many thanks to Pierre Duhem for useful hints

## [1.3] - 19 September 2008 - Jean-Pierre Demailly

-   Further fixes which (hopefully) enable dmg2img to work on dmg archives of arbitrary size, while reducing RAM usage a lot
-   A lot of thanks to Alfred E. Hegge and Randy Broman for testing and reporting bugs

## [1.2] - 17 September 2008 - Jean-Pierre Demailly

-   Fixed segfault bug due to buffer overflow (buffer sizes incorrectly set, resulting in insufficient memory allocation)
-   Fixed most compilation warnings - remaining ones are irrelevant with standard compilers
-   Big thanks to Alfred E. Hegge and Randy Broman for bug reports

## [1.1] - 4 August 2008 - Jean-Pierre Demailly

-   Fixed segfault bug occurring when decompressing certain dmg files beyond the actual end of the file (due to not correctly setting the size of the compressed parts)
-   Added slightly modified vfdecrypt utility from Weinmann-Appelbaum-Fromme in order to decrypt encrypted dmg files

## [1.0] - 7 August 2007 - Jean-Pierre Demailly

-   Initial version
