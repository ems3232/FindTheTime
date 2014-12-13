package ee461l;

import java.util.ArrayList;






public class FTTAlgorithm {
	
	final private int resultNum = 3;
	private ArrayList<IntegerResult> resultIndexes;
	private ArrayList<String> resultStrings;
	private ArrayList<Integer> columnSums;
	private int meetingColumns;
	private int columnsPerDay;	//  FTTCalendar index mod columnsPerDay should give index in a day.  288 mod 96 (for 15-min segments) should give 0, for 0:00 on wednesday
	private int startIndex;
	private int endIndex;
	
	public class IntegerResult {
		private int startIndex;
		private int numConflicts;
		public IntegerResult(int startIndex, int numConflicts) {
			this.startIndex = startIndex;
			this.numConflicts = numConflicts;
		}
		public int getStartIndex() {
			return startIndex;
		}
		public int getNumConflicts() {
			return numConflicts;
		}
		public void setStartIndex(int startIndex) {
			this.startIndex = startIndex;
		}
		public void setNumConflicts(int numConflicts) {
			this.numConflicts = numConflicts;
		}
	}
	
	private volatile static FTTAlgorithm algorithmInstance; 
	
	private FTTAlgorithm () {}
	
	public static FTTAlgorithm getAlgorithmInstance() { 
		if (algorithmInstance == null) {
			synchronized (FTTAlgorithm.class) { 
				if (algorithmInstance == null) {
					algorithmInstance = new FTTAlgorithm(); 
				} 
			} 
		}
	return algorithmInstance; }
	 
	
	/* Returns the 3 most optimal meeting times in the form of a String event.
	 * Passed times should be in military time (0:00 to 24:00).  encode 6:15 pm as integer 1,815.
	 * Assumes: times are divisible by 15 (12:00, 12:15, 12:30, or 12:45).
	 * 	        0 <= startTime < endTime <= 2359.  
	 * 			15 <= meetingLength
	 */
	public ArrayList<String> runAlgorithm(FTTCalendar groupCalendar, int meetingLength, int startTime, int endTime) {
		
		this.meetingColumns = meetingLength/15;
		this.startIndex = (((int) startTime/100)*4 + (startTime%100)/15);
		this.endIndex = (((int) endTime/100)*4 + (endTime%100)/15);
		
		this.columnsPerDay = groupCalendar.getNumberSegments()/7;
		
		this.resultIndexes = new ArrayList<IntegerResult>(this.resultNum);
		for(int y=0;y<3;y++){
			this.resultIndexes.add(new IntegerResult(0,0x0FFFFFFF));
		}
		//this.resultIndexes.set(0, new IntegerResult(0,0xFFFFFFFF));
		//this.resultIndexes.set(1, new IntegerResult(0,0xFFFFFFFF));
		//this.resultIndexes.set(2, new IntegerResult(0,0xFFFFFFFF));
		this.resultStrings = new ArrayList<String>(this.resultNum);
		this.columnSums = new ArrayList<Integer>(groupCalendar.getNumberSegments());
		
		for (int i = 0; i < groupCalendar.getNumberSegments(); i++) {
			this.columnSums.add(groupCalendar.isConflict(i));
		}
		
		IntegerResult temp = new IntegerResult(0,0);
		IntegerResult temp2 = new IntegerResult(0,0);

		for (int i = 0; i < (groupCalendar.getNumberSegments()-this.meetingColumns); i++) {
			if ((this.startIndex <= i%96) && ( i%96 <= this.endIndex)) {
				
				temp.setStartIndex(i);
				temp.setNumConflicts(0);
				for (int j = 0; j < this.meetingColumns; j++) {
					temp.setNumConflicts(temp.getNumConflicts() + columnSums.get(i+j));
				}
				if (this.resultIndexes.get(0).getNumConflicts() > temp.getNumConflicts()) {
					this.resultIndexes.set(2, this.resultIndexes.get(1));
					this.resultIndexes.set(1, this.resultIndexes.get(0));
					this.resultIndexes.set(0,new IntegerResult(temp.getStartIndex(),temp.getNumConflicts()));				
				}
				else if (this.resultIndexes.get(1).getNumConflicts() > temp.getNumConflicts()) {
					this.resultIndexes.set(2, this.resultIndexes.get(1));
					this.resultIndexes.set(1, new IntegerResult(temp.getStartIndex(),temp.getNumConflicts()));				
				}
				else if (this.resultIndexes.get(2).numConflicts > temp.numConflicts) {
					this.resultIndexes.set(2, new IntegerResult(temp.getStartIndex(),temp.getNumConflicts()));				
				}
			}
		}
		
		this.resultStrings.add(indexToString(resultIndexes.get(0), 0));
		this.resultStrings.add(indexToString(resultIndexes.get(1), 1));
		this.resultStrings.add(indexToString(resultIndexes.get(2), 2));
		
		
		return this.resultStrings;
	}

	private String indexToString(IntegerResult integerResult, int index) {
		String result = null;
		
		String name = "Optimal" + Integer.toString(index);
		String reoccur = "True";
		String start;
		int startTemp;
		String end;
		int endTemp;
		String day;
		int dayTemp;
		
		startTemp = integerResult.getStartIndex() % this.columnsPerDay;
		start = Integer.toString((int) startTemp/4) +":"+ Integer.toString((startTemp%4)*15);
		endTemp = (integerResult.getStartIndex() + this.meetingColumns) % this.columnsPerDay;
		end = Integer.toString((int) endTemp/4) +":"+ Integer.toString((endTemp%4)*15);
		if((startTemp%4)*15==0){
			start=start+"0";
		}
		if((endTemp%4)*15==0){
			end=end+"0";
		}
		dayTemp = integerResult.getStartIndex()/this.columnsPerDay;
		switch (dayTemp) {
		case 0: day = "sun"; break;
		case 1: day = "mon"; break;
		case 2: day = "tue"; break;
		case 3: day = "wed"; break;
		case 4: day = "thu"; break;
		case 5: day = "fri"; break;
		case 6: day = "sat"; break;
		default: day = "errorInAlg";
		}
		
		result = name + '_' + reoccur + '_' + start + '_' + end + '_' + day;
		
		return result;
	}
}
