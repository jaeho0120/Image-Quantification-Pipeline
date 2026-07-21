#@ String(label="Subfolder name (e.g., COL IV)") subfolderName

cols = 32;
rows = 32;
basePath = "D:/BM study/Image quantification pipeline/RAW File/Fmi/";
saveDir = basePath + "/" + subfolderName;

File.makeDirectory(saveDir);

id = getImageID();
title = getTitle();
width = getWidth();
height = getHeight();
tileWidth = width / cols;
tileHeight = height / rows;

// Remove the file extension
dotIndex = lastIndexOf(title, ".");
if (dotIndex != -1) {
    baseTitle = substring(title, 0, dotIndex);
} else {
    baseTitle = title;
}

// Iterate through all tiles
for (y = 0; y < rows; y++) {
    for (x = 0; x < cols; x++) {
        offsetX = x * tileWidth;
        offsetY = y * tileHeight;

        // Create a subfolder for each x-index
        xFolder = saveDir + "/" + x;
        File.makeDirectory(xFolder);

        selectImage(id);
        run("Duplicate...", "title=tempTile");
        makeRectangle(offsetX, offsetY, tileWidth, tileHeight);
        run("Crop");

        // Force string concatenation to prevent NaN in the filename
        filename = "" + y + ".tif";
        fullpath = xFolder + "/" + filename;
        saveAs("Tiff", fullpath);

        close();
    }
}
selectImage(id);
