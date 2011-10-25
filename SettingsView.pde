class SettingsView extends View {
  HSlider yearSlider;
  HSlider monthSlider;
  HSlider timeSlider;
  Checkbox yearCheckbox, monthCheckbox, timeCheckbox;
  Map<SightingType, Checkbox> typeCheckboxMap;
  Checkbox showAirport;
  
  int CHECKBOX_X = 450;
  int CHECKBOX_Y = 10;
  int CHECKBOX_W = 300;
  
  boolean showView;
  float heightView ;
  String title;
  
  SettingsView(float x_, float y_, float w_, float h_)
  {
    super(x_, y_, w_, h_);
    heightView = h;
    textFont(font,normalFontSize);
    
    monthCheckbox = new Checkbox(10,40,12,12,"Month:");
    this.subviews.add(monthCheckbox);
    
    timeCheckbox = new Checkbox(10,70,12,12,"Time:");
    this.subviews.add(timeCheckbox);
    
    yearSlider = new HSlider(75,10,0,0,yearLabels,"",3);
    this.subviews.add(yearSlider);

    monthSlider = new HSlider(75,40,0,0,monthLabels,"",2);
    this.subviews.add(monthSlider);

    timeSlider = new HSlider(75,70,0,0,timeLabels,"",2);
    this.subviews.add(timeSlider);
    
    int i = 0;
    typeCheckboxMap = new HashMap<SightingType, Checkbox>();
    for (SightingType st : sightingTypeMap.values()) {
      int x_delta = (i / 4) * 160;
      int y_delta = (i % 4) * 20;
      Checkbox cb = new Checkbox(CHECKBOX_X + 10 + x_delta ,CHECKBOX_Y + 9 + y_delta, 12, 12, st.name, st.icon);
      typeCheckboxMap.put(st, cb);
      subviews.add(cb);
      i++;
    }
    
    showAirport = new Checkbox(800,10,12,12,"Show airports",loadImage("plane.png"));
    this.subviews.add(showAirport);
    
    showView = false;
  }
  
   void drawContent()
  {
    fill(viewBackgroundColor,220);
    stroke(viewBackgroundColor,220);
    rect(0,0, w, h-25);
    rect(0,h-25,95,25);
    textFont(font,normalFontSize);
    textAlign(LEFT,TOP);
    fill(textColor);
    text((showView)?"Hide Settings":"Show Settings",5,h-20);
  
    text("Year: ",10,10);
    textAlign(LEFT,CENTER);
    title = " Type of UFO ";
    text(title,CHECKBOX_X,CHECKBOX_Y);
    stroke(textColor);
    line(CHECKBOX_X + textWidth(title)+5,CHECKBOX_Y,CHECKBOX_X+CHECKBOX_W,CHECKBOX_Y);
    line(CHECKBOX_X,CHECKBOX_Y,CHECKBOX_X,h-30);
    line(CHECKBOX_X,h-30,CHECKBOX_X+CHECKBOX_W,h-30);
    line(CHECKBOX_X+CHECKBOX_W,CHECKBOX_Y,CHECKBOX_X+CHECKBOX_W,h-30);
    
    textAlign(LEFT,TOP);
    title = "MAP " + ((yearSlider.minIndex()!=yearSlider.maxIndex())?("From: "+yearLabelsToPrint[yearSlider.minIndex()] + " To: " + yearLabelsToPrint[yearSlider.maxIndex()]):("Year: "+yearLabelsToPrint[yearSlider.minIndex()]));
    title = title + ((monthCheckbox.value)?((monthSlider.minIndex()!=monthSlider.maxIndex())?(" - " + monthLabelsToPrint[monthSlider.minIndex()] + " to " + monthLabelsToPrint[monthSlider.maxIndex()]):(" - " +  monthLabelsToPrint[monthSlider.minIndex()])):(""));
    title = title +  ((timeCheckbox.value)?((timeSlider.minIndex()!=timeSlider.maxIndex())?(" - " + timeLabels[timeSlider.minIndex()] + ":00 to " + timeLabels[timeSlider.maxIndex()] +":00"):(" - " + timeLabels[timeSlider.minIndex()])+":00"):(""));   
    text(title,(w-textWidth(title))/2,h-20);      
  }
  
  boolean contentPressed(float lx, float ly)
  {
    if(lx > 0 && lx <95 && ly>h-25 && ly < h){
        settingsAnimator.target((showView)?(-heightView+25):0);
        showView = !showView;    
    }
    return true;
  }
 
}

