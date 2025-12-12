 //<>// //<>//
import controlP5.*;
static ControlP5 cp5;

private PedalSteelGuitar guitar; 
private MusicBasics mb = new MusicBasics();

DropdownList ddlKey, ddlMode;
color backgroundColor = #774223;

int modeItemHeight = 40;
int keyItemHeight = 45;

void setup() {  
  
  guitar = new PedalSteelGuitar(mb);  
  
  orientation(LANDSCAPE);      
//  size(displayWidth, displayHeight);
  size(1440,720);
  cp5 = new ControlP5(this);
  textSize(14);
  
  text("Key:", 20, 20);  
  ddlKey = cp5.addDropdownList("KEYS")
              .setPosition(40, 70)
              .setFont(createFont("Arial Bold", 20, true));              
  customizeDdlKey(ddlKey); 

  text("Mode:", 150, 20);
  ddlMode = cp5.addDropdownList("MODES").setPosition(150, 70).setFont(createFont("Arial Bold", 16, true));
  customizeDdlMode(ddlMode);
  
  guitar.initUI(cp5); 
}

void draw() {
  background(backgroundColor);
  
  fill(255);
  textSize(14);
  text("Key:", 20, 20);
  text("Mode:", 210, 20);  

  guitar.drawFretBoard();
  
}

void controlEvent(ControlEvent theEvent) {
  // DropdownList is of type ControlGroup.
  // A controlEvent will be triggered from inside the ControlGroup class.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message thrown by controlP5.
  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());   
  } else if (theEvent.isController()) {
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
    
    if (theEvent.getController().getName() == "KEYS") {     
      mb.setRoot(byte(theEvent.getController().getValue() + 1));      
    } else if (theEvent.getController().getName() == "MODES") {   
      mb.setMode(byte(theEvent.getController().getValue()));       
    } else if (theEvent.getController().getName().equals("pedal1")){
     // guitar.switchP1();   
    } else if (theEvent.getController().getName().equals("pedal2")){  
     // guitar.switchP2(); 
    } else if (theEvent.getController().getName().equals("pedal3")){  
    //  guitar.switchP3(); 
    } else if (theEvent.getController().getName().equals("pedal4")){  
    //  guitar.switchP4(); 
    } else if (theEvent.getController().getName().equals("lever1")){
    //  guitar.switchLKL();   
    } else if (theEvent.getController().getName().equals("lever2")){  
     // guitar.switchLKR(); 
    } else if (theEvent.getController().getName().equals("lever3")){  
     // guitar.switchRKL(); 
    } else if (theEvent.getController().getName().equals("lever4")){  
     // guitar.switchRKR(); 
    }   
  }  
}

void customizeDdlKey(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setSize(70, (mb.keySymbol.length + 1) * keyItemHeight);
  ddl.setItemHeight(keyItemHeight);
  ddl.setBarHeight(keyItemHeight); 
  ddl.getCaptionLabel().set("KEY");
  ddl.getCaptionLabel().toUpperCase(false);
  
  for (int i=0; i < 12; i++) {    
    ddl.addItem(mb.keySymbol[i], i);
    ddl.getValueLabel().toUpperCase(false);
  } 
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}

void customizeDdlMode(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setSize(150,  (mb.modes.length + 1) * modeItemHeight);
  ddl.setItemHeight(modeItemHeight);
  ddl.setBarHeight(modeItemHeight);    
  ddl.getCaptionLabel().set("MODE");
  for (int i=0; i < mb.modes.length; i++) {
    ddl.addItem(mb.modes[i].name, i);
  }
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}
