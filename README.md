# Robotic Drawing!
![](https://github.com/garciadelcastillo/robot-drawing/blob/master/00_docs/banner.jpg)

This repository is an interactive robotic drawing installation for [Kids at Autodesk Day 2017](https://photos.google.com/share/AF1QipNmiNZb0ONTltFPZ2k-U9t5vJetCAaGuFqNOfMEcbKtAdXJZHJB0w53q9Yt25U1Uw?key=NkREd2hleGI4QXhNdkRRN1FhLVlVdXJSeUdDVlNR), by [@nonoesp](https://github.com/nonoesp) and [@garciadelcastillo](https://github.com/garciadelcastillo). 

A touchscreen allows kids to draw their creations, and a series of scripts convert their designs to robotic instructions.

The project is built with [Processing](https://processing.org/), [Dynamo](http://dynamobim.org/) and [Machina](https://github.com/garciadelcastillo/Machina) for [Dynamo](https://github.com/garciadelcastillo/Machina-Dynamo).

## Setup

If you want to try this at home (or probably better, your robot-enabled shop), please do the following:

- Install [Processing](https://processing.org/) and [Dynamo Studio](http://dynamobim.org/) in your Windows machine. 

- Inside of Dynamo, you should install two packages from the Package Manager. Go to `Packages > Search for a package...` and install `JsonData` and `Machina`. If at the time of this reading the packages have updated and broken some functionality, you can find copies of the working packages with this project in the folder `01_dynamo_packages`.

- Go to `02_processing_sketch` and open it with Processing. When you run it, you should see a full screen window where you can draw with your fingers or mouse. It also has some buttons that allow you to start a new drawing, undo some actions or export the current drawing. As you hit `Export`, two `.json` and `.jpg` files will be saved to the `data` folder in the sketch with the bitmap drawing and the json representation of the strokes. 

- Go to `03_dynamo_script` and open the Dynamo file with Dynamo Studio. On the far left of the screen, there is a code block with drawing parameters that you can customize based on your screen resolution, paper dimensions, location and orientation of the paper in robot world coordinates, and some speed settings.

- Once the settings are customized, load the `.json` file exported by Processing into the script with the `File Path` loader. If everything goes well, you should see planes representing the planes of your drawing in the 3D view. If that is the case, a `.prg` file will be saved to the dynamo script folder with the offline program that can be loaded in the robot controller and ran to draw the strokes ;)

The installation has been designed and tested for an ABB IRB 120 robot, but ideally, with small changes in the [Machina](https://github.com/garciadelcastillo/Machina) script, it could be used for Kuka, Universal Robots, GCode, etc.

Have fun!

## Gallery

A collage of some of the drawings kids did at the event:

![](https://github.com/garciadelcastillo/robot-drawing/blob/master/00_docs/montage_6x6.jpg)

![](https://github.com/garciadelcastillo/robot-drawing/blob/master/00_docs/montage_3x13.jpg)


## Disclaimer

**Robots can be dangerous**. Make sure you are properly trained in the machines you are using, and are following all the adequate security protocols. Also make sure to simulate and test all your offline programs in robot simulation software, and performing "dry runs" before engaging in actual real drawing. 

This project and script are provided as-is, no warranties provided whatsoever. The authors are not responsive nor liable for any unintended consequences, harm or losses to personal or physical property. Use at your own risk.