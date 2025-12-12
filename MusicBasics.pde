public static class Mode {
  String name;
  byte[]formula;
  Mode(String n, byte[]f) {
    name = n;
    formula = f;
  }
}

class MusicBasics{
  byte mode;
  
  byte root = 1;

  byte min_second = 2;
  byte maj_second = 3;
  
  byte min_third = 4;
  byte maj_third = 5;
  
  byte perf_fourth = 6;
  byte aug_fourth = 7;
  
  byte dim_fifth = 7;
  byte perf_fifth = 8;
  
  byte min_sixth = 9;
  byte maj_sixth = 10;
  
  byte min_seventh = 11;
  byte maj_seventh = 12;

  Mode mIonian = new Mode("Ionian",         new byte[] {root, maj_second, maj_third, perf_fourth, perf_fifth, maj_sixth, maj_seventh});
  Mode mDorian = new Mode("Dorian",         new byte[] {root, maj_second, min_third, perf_fourth, perf_fifth, maj_sixth, min_seventh});
  Mode mFrigian = new Mode("Frigian",       new byte[] {root, min_second, min_third, perf_fourth, perf_fifth, min_sixth, min_seventh});
  Mode mLydian = new Mode("Lydian",         new byte[] {root, maj_second, maj_third, dim_fifth,   perf_fifth, maj_sixth, maj_seventh});
  Mode mMixolydian = new Mode("Mixolydian", new byte[] {root, maj_second, maj_third, perf_fourth, perf_fifth, maj_sixth, min_seventh});
  Mode Aolian = new Mode("Aolian",          new byte[] {root, maj_second, min_third, perf_fourth, perf_fifth, min_sixth, min_seventh});
  Mode Locrian = new Mode("Locrian",        new byte[] {root, min_second, min_third, perf_fourth, dim_fifth,  min_sixth, min_seventh});
  Mode MelMinor = new Mode("Mel.Minor",     new byte[] {root, maj_second, min_third, perf_fourth, perf_fifth, maj_sixth, maj_seventh});
  
  Mode BebopMajor = new Mode("Bebop Maj",   new byte[] {root, maj_second, maj_third, perf_fourth, perf_fifth, min_sixth, maj_sixth, maj_seventh});
  Mode BebopMinor = new Mode("Bebop Min",   new byte[] {root, maj_second, min_third, maj_third, perf_fourth, perf_fifth, maj_sixth, min_seventh});
  Mode BebopDom   = new Mode("Bebop Dom",   new byte[] {root, maj_second, maj_third, perf_fourth, perf_fifth, maj_sixth, min_seventh, maj_seventh});
  
  Mode MinorPentatonic = new Mode("Min Pentatonic", new byte[] {root, min_third, perf_fourth, perf_fifth, min_seventh});
  Mode MajorPentatonic = new Mode("Maj Pentatonic", new byte[] {root, maj_second, maj_third, perf_fifth, maj_sixth});
  
  Mode[] modes = {mIonian, mDorian, mFrigian, mLydian, mMixolydian, Aolian, Locrian, MelMinor, BebopMajor, BebopMinor, BebopDom, MinorPentatonic, MajorPentatonic};
   
  String[] keySymbol = {"C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab", "A", "A#/Bb", "B"};
  
  void setRoot(byte _root)
  {
      root = _root;
  }
  void setMode(byte _mode)
  {
      mode = _mode;
  }

  byte getMode ()
  {
    return mode;
  }
  
  boolean isInTheScale (byte curr_degree){    
    for (byte cnt = 0; cnt < modes[mode].formula.length; cnt++ ) {
      if (curr_degree == modes[mode].formula[cnt]) {
        return true;
      }
    }   
    return false;
  }
}
