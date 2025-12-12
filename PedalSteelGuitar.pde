import java.util.HashMap;
// Enum для педалей и рычагов
enum Control {
  P1, P2, P3, P4, LKL, LKR, RKL, RKR
}

public class PedalSteelGuitar {

  byte[] tuningC6;
  byte stringCount = 12;

  private MusicBasics mb;
  private Fretboard fretboard;

  private ControlP5 cp5;
  private HashMap<Control, Boolean> controlState = new HashMap<Control, Boolean>();

  private byte[] correction = new byte[12];

  private final byte[][] changes = {
    { 0, 0, 0, 0, 0, +2, 0, 0, 0, +2, 0, 0 },     // P1
    { 0, 0, 0, 0, 0,  0, -1, 0, 0,  0, +1, +2 },  // P2
    { 0, 0, 0, +1, 0, 0, 0, -1, 0, 0, 0, 0 },     // P3
    { 0, 0, 0, 0, +2, +2, 0, 0, 0, 0, 0, 0 },     // P4
    { 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0 },      // LKL
    { 0, 0, 0, 0, 0, +1, 0, 0, 0, 0, 0, 0 },      // LKR
    { 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0 },      // RKL
    { 0, 0, 0, 0, +1, 0, 0, 0, +1, 0, 0, 0 }       // RKR
  };

  PedalSteelGuitar(MusicBasics musBasa) {
    this.mb = musBasa;

    tuningC6 = new byte[] {
      mb.perf_fourth, mb.perf_fifth, mb.maj_second, mb.maj_third,
      mb.root, mb.maj_sixth, mb.perf_fifth, mb.maj_third,
      mb.root, mb.maj_sixth, mb.perf_fourth, mb.root
    };

    this.fretboard = new Fretboard(mb, this);
  }

  void initUI(ControlP5 cp5Instance) {
    this.cp5 = cp5Instance;

    // Педали A–D
    addStyledButton(Control.P1, 470, 622, 68, 53, "P4");
    addStyledButton(Control.P2, 584, 622, 68, 53, "P5");
    addStyledButton(Control.P3, 698, 622, 68, 53, "P6");
    addStyledButton(Control.P4, 812, 622, 68, 53, "P7");

    // Рычаги LKL, LKR, RKL, RKR
    addStyledButton(Control.LKL, 480, 482, 17, 95, "LKL");
    addStyledButton(Control.LKR, 730, 482, 17, 95, "LKR");
    addStyledButton(Control.RKL, 980, 482, 17, 95, "RKL");
    addStyledButton(Control.RKR, 1230, 482, 17, 95, "RKR");
  }

  void addStyledButton(Control ctrl, int x, int y, int w, int h, String label) {
    Button btn = cp5.addButton(ctrl.name())
      .setPosition(x, y)
      .setSize(w, h)
      .setCaptionLabel(label)
      .setFont(createFont("Arial", 14))
      .setColorLabel(color(255))
      .setColorBackground(color(60))
      .setColorForeground(color(100))
      .setColorActive(color(200, 0, 0));

    btn.getCaptionLabel().align(CENTER, BOTTOM); 

    controlState.put(ctrl, false);

    btn.onClick(e -> toggleControl(ctrl));
  }

  void toggleControl(Control ctrl) {
    boolean isActive = !controlState.get(ctrl);
    controlState.put(ctrl, isActive);

    int activeColor = color(0, 180, 0);
    int defaultColor = color(60);

    cp5.getController(ctrl.name()).setColorBackground(isActive ? activeColor : defaultColor);
  }

  byte[] getActiveCorrectionByString() {
    for (byte i = 0; i < stringCount; i++) {
      correction[i] = 0;

      for (Control ctrl : Control.values()) {
        if (controlState.get(ctrl)) {
          correction[i] += changes[ctrl.ordinal()][i];
        }
      }
    }
    return correction;
  }

  void setRootAndRedraw(byte newRoot) {
    mb.setRoot(newRoot);
    fretboard.updateRoot(newRoot);
    redraw();
  }

  void drawFretBoard() {
    fretboard.updateRoot(mb.root);
    fretboard.draw();
  }
}
