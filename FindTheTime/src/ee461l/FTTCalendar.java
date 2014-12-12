package ee461l;

import java.util.ArrayList;

public class FTTCalendar{
        private int userIndex;
		final private int maxUserNum = 6;
		//	Length of time for each segment (default 15 min)
		private int segmentLength = 15;
		//	Number of segments in a users calendar.  10,080 is the number of minutes per week.  
		private int numberSegments = 10080/segmentLength;
		//	Collection of users' calendars.  
		private ArrayList<ArrayList<Boolean>> groupConflicts;		
		//	If usersInGroup[1] == true, then groupConflicts[1] is valid and represents a group member's calendar.  
		private ArrayList<Boolean> usersInGroup;
		
		FTTCalendar() {
			userIndex=0;
			this.groupConflicts = new ArrayList<ArrayList<Boolean>>(this.maxUserNum);
			this.setUsersInGroup(new ArrayList<Boolean>(this.maxUserNum));
			for (int i = 0; i < this.maxUserNum; i++) {
				this.groupConflicts.add(new ArrayList<Boolean>(this.numberSegments));
				this.getUsersInGroup().add(false);
			}
		}

		public int isConflict(int Segment) {
			int numConflicts = 0;
			
			for (int i = 0; i < this.maxUserNum; i++) {
				if ( (this.getUsersInGroup().get(i)) && (this.groupConflicts.get(i).get(Segment)) ) {
					numConflicts++;
				}
			}
			
			return numConflicts;
		}

		//Getters
		protected ArrayList<ArrayList<Boolean>> getgroupConflicts() {
			return groupConflicts;
		}
		
		//	userNum goes from 0 to maxUserNum - 1
		protected boolean getUserFlag(int userNum) {
			if (userNum < this.maxUserNum && userNum >= 0)
				return getUsersInGroup().get(userNum);
			else {
				return false;
			}
		}

		protected int getSegmentLength() {
			return segmentLength;
		}

		public int getNumberSegments() {
			return numberSegments;
		}

		//Setters
		public  ArrayList<Boolean> setUserCalendar(String userCal,int index) {	
			if(userCal.equalsIgnoreCase("false")){
				getUsersInGroup().set(index, false);
				
				return getSixSeventyTwo();
			}
			getUsersInGroup().set(index,true);
		
			ArrayList<Boolean> userCalendar=getSixSeventyTwo();
			 String[] eventList=userCal.split("&");
			//System.out.println(eventList);
			 for(int i=0; i<eventList.length;i++){
				System.out.println("hello"+i+"   "+eventList[i]);
				String[] event=eventList[i].split("_");
				
				//Get Starting Location Start Time
				String[] startTime=event[2].split(":");
			  //System.out.println(event[1]);
				int startTimeHour=Integer.parseInt(startTime[0]);
				int startTimeMin=Integer.parseInt(startTime[1]);
				//
				int placeStart= startTimeHour*4+startTimeMin/15;
				
				//Get Ending Location End Time
				String[] endTime=event[3].split(":");			
				int endTimeHour=Integer.parseInt(endTime[0]);
				int endTimeMin=Integer.parseInt(endTime[1]);
				//
				int placeEnd= endTimeHour*4+endTimeMin/15;
			
				for(int j=4; j<event.length;j++){
					
					System.out.println("THIS IS IMPortant"+"  "+event[j]+"  "+ j+"  "+ eventList[i]+"   ");
			        System.out.println(event[j]);
			         
				    if (event[j].equalsIgnoreCase("mon")){
			           for(int y=96+placeStart;y<(96+placeStart+(placeEnd-placeStart));y++){
			        	  userCalendar.set(y, true);
			                                       }
			           }
			          
				    if (event[j].equalsIgnoreCase("tue")){
			        	   //System.out.println(event[j]+"  "+placeStart+"  "+placeEnd);
				           for(int y=192+placeStart;y<(192+placeStart+(placeEnd-placeStart));y++){
				        	  userCalendar.set(y, true);
				        	  
				           }
				    }
				           if (event[j].equalsIgnoreCase("wed")){
			        	  // System.out.println(event[j]+"  "+placeStart+"  "+placeEnd);
				           for(int y=288+placeStart;y<(288+placeStart+(placeEnd-placeStart));y++){
				        	  userCalendar.set(y, true);
				        	  
				           }
				           }
				           if (event[j].equalsIgnoreCase("thu")){
			        	   //System.out.println(event[j]+"  "+placeStart+"  "+placeEnd);
				           for(int y=384+placeStart;y<(384+placeStart+(placeEnd-placeStart));y++){
				        	  userCalendar.set(y, true);
				        	  
				           }
				           }
				           if (event[j].equalsIgnoreCase("fri")){
			        	   //System.out.println(event[j]+"  "+placeStart+"  "+placeEnd);
				           for(int y=480+placeStart;y<(480+placeStart+(placeEnd-placeStart));y++){
				        	  userCalendar.set(y, true);
				        	  
				           }
				           }
				           if (event[j].equalsIgnoreCase("sat")){
			        	   //System.out.println(event[j]+"  "+placeStart+"  "+placeEnd);
				           for(int y=576+placeStart;y<(576+placeStart+(placeEnd-placeStart));y++){
				        	  userCalendar.set(y, true);
				           }
				           }
				           if (event[j].equalsIgnoreCase("sun")){
			        	   //System.out.println(event[j]+"  "+placeStart+"  "+placeEnd);
				           for(int y=0+placeStart;y<(0+placeStart+(placeEnd-placeStart));y++){
				        	  userCalendar.set(y, true);
				        	  
				           }
				           }
				}
			 }
			
			
				return userCalendar;
		}
		protected ArrayList<Boolean> getSixSeventyTwo(){
			ArrayList<Boolean> testing=new ArrayList<Boolean>();
			for(int k=0; k<672;k++){
				testing.add(false);
			}
			return testing;
		}
		protected void setUserFlag(int userNum, boolean userFlag) {
			this.getUsersInGroup().set(userNum, userFlag);
		}

		protected void setSegmentLength(int segmentLength) {
			this.segmentLength = segmentLength;
		}

		public ArrayList<Boolean> getUsersInGroup() {
			return usersInGroup;
		}

		public void setUsersInGroup(ArrayList<Boolean> usersInGroup) {
			this.usersInGroup = usersInGroup;
		}
		
	
}
