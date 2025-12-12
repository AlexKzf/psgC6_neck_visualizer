class Fretboard {

  private MusicBasics mb;
  private PedalSteelGuitar gtr;
  
  private color neckColor = color(204, 153, 102);  
  private int neckX = 350;
  private int neckY = 50;
  private int fretWidth = 73;
  private int fretHeight = 28;  
  private int stringCount = 12;
  private byte fretCount = 13; /* 0 - 12 */
  // Названия ступеней от 0 до 12
  private String[] degreeNames = {"0", "1", "b2", "2", "b3", "3", "4", "#4", "5", "b6", "6", "b7", "7"};    
  private byte keyNmbr;
  private String[] noteSymbol = {"0", "C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab", "A", "A#/Bb", "B"};
  
  Fretboard(MusicBasics musbaza, PedalSteelGuitar psg) {
    this.mb = musbaza;
    this.gtr = psg;
  }  

  // Вычисляет ступень ноты относительно текущего корня
  private byte computeDegree(byte noteValue) {
    int degree = (noteValue - keyNmbr + 12) % 12;
    return (byte) (degree + 1);
  }
  
  void draw() {
    keyNmbr = mb.root;

    printFretsNumbers();
    printStringsNumbers();
    
    byte[] currStringCorrection = gtr.getActiveCorrectionByString();
     for (byte stringIndex = 0; stringIndex < stringCount; stringIndex++) {     
      byte openNote = (byte)(gtr.tuningC6[stringIndex] + currStringCorrection[stringIndex]);
      for (byte fretIndex = 0; fretIndex < fretCount; fretIndex++) {
        byte noteValue = (byte)((openNote + fretIndex) % 12);
        drawFret(stringIndex, fretIndex, noteValue);
      }
    }    
  }
  
  private void drawFret(byte stringIndex, byte fretIndex, byte noteValue) {
    int x = neckX + (fretWidth + 2) * fretIndex;
    int y = neckY + (fretHeight + 4) * stringIndex;

    // Рисуем прямоугольник лада
    fill(neckColor);
    rect(x, y, fretWidth, fretHeight);

    // Вычисляем ступень относительно корня
    byte degree = computeDegree(noteValue);
  
    String label = degreeNames[degree];

    //String label = noteSymbol[degree];
    

    // Определяем цвет
    if (mb.isInTheScale(degree)) {
      if (degree == 1) {
        fill(255, 0, 0); // Тоника — красный
      } else {
        fill(0); // Остальные ступени гаммы — черный
      }
    } else {
      fill(150); // Вне гаммы — серый
    }

    // Отображаем текст ступени
    textSize(16);
    textAlign(CENTER, CENTER);
    text(label, x + fretWidth / 2, y + fretHeight / 2);
  }  
  
  private void printFretsNumbers() {
    for (byte i = 0; i < fretCount; i++) {
      textSize(12);
      fill(0);
      textAlign(CENTER);
      text(i, neckX + i * (fretWidth + 2) + fretWidth / 2, 30);
    }
  }
  
  private void printStringsNumbers() {
    for (byte i = 0; i < stringCount; i++) {
      textSize(12);
      fill(0);
      text(i + 1, neckX - 20, neckY + i * (fretHeight + 4) + fretHeight / 2);
    }
  }
  
  void updateRoot(byte newRoot) {
    this.keyNmbr = newRoot;
  }
}
