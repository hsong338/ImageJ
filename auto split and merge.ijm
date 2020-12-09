macro "auto split and merge"
{
	dir_saving = getDirectory("choose folder for saving");
	dir_processing = getDirectory("choose folder for processing");
	list = getFileList(dir_processing);
	for(i = 0; i < list.length; i++)
	{
	open(list[i]);
	run("Split Channels");
	
	selectWindow("C2-"+list[i]);
	run("Z Project...", "projection=[Average Intensity]");
	selectWindow("C1-"+list[i]);
	run("Z Project...", "projection=[Average Intensity]");
	selectWindow("C1-"+list[i]);
	close();
	selectWindow("C2-"+list[i]);
	close();
	selectWindow("AVG_C1-"+list[i]);
	//run("Brightness/Contrast...");
	run("Enhance Contrast", "saturated=0.35");
	selectWindow("AVG_C2-"+list[i]);
	run("Enhance Contrast", "saturated=0.35");
	R="AVG_C1-"+list[i];
	G="AVG_C2-"+list[i];
	run("Merge Channels...", "c1=["+R+"] c2=["+G+"] create keep");
	selectWindow("AVG_C1-"+list[i]);
	saveAs("Tiff", dir_saving + getTitle);
	close();
	selectWindow("AVG_C2-"+list[i]);
	saveAs("Tiff", dir_saving + getTitle);
	close();
	selectWindow("Composite");
	run("RGB Color");
	saveAs("Tiff", dir_saving + list[i] + getTitle);
	close();
	selectWindow("Composite");
	close();
	}
}