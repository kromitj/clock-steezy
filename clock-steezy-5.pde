// The following array has x and y positions for all 60 seconds of a minute...
// (the 1 second visual rect is located at coordinate x=60, y=92, ...
// the 59 second visual rect is located at coordinate x=112, y=26) ...
// { 0x, 0y, 1x, 1y,  2x, 2y,  3x, 3y, 4x, 4y...
int[] minuteLocations = { 
    40, 128, 40, 117, 40, 106, 40, 95, 40, 84, 40, 73, 40, 62, 40, 51, 40, 40, 40, 29,
    51, 128, 51, 117, 51, 106, 51, 95, 51, 84, 51, 73, 51, 62, 51, 51, 51, 40, 51, 29,
    62, 128, 62, 117, 62, 106, 62, 95, 62, 84, 62, 73, 62, 62, 62, 51, 62, 40, 62, 29,
    73, 128, 73, 117, 73, 106, 73, 95, 73, 84, 73, 73, 73, 62, 73, 51, 73, 40, 73, 29,
    84, 128, 84, 117, 84, 106, 84, 95, 84, 84, 84, 73, 84, 62, 84, 51, 84, 40, 84, 29,
    95, 128, 95, 117, 95, 106, 95, 95, 95, 84, 95, 73, 95, 62, 95, 51, 95, 40, 95, 29,    
  };
int[] hourLocations = {0,0, 27, 117, 27, 106, 27, 95,  27, 84, 27, 73, 27, 62, 27, 51, 27, 40, 27, 29, 40, 16,
     51, 16, 62, 16, 73, 16, 84, 16, 95, 16, 108, 29, 108, 40, 108, 51, 108, 62, 108, 73, 108, 84, 108, 95, 108, 106,
     108, 117
    };
                 
 int[] dayLocations = {0,0,14,117,14,106,14,95,14,84,14,73,14,62,14,51,14,40,14,29,40,3,51,3,62,3,73,3,
 84,3,95,121,29,121,40,121,51,121,62,121,73,121,84,121,95,121,106,121,117,95,154,84,154,73,154,62,154,51,
 154,40,154,128,14
 };
 
int[] dayOfTheWeekLocations = {0,0,40,154,51,154,62,154,73,154,84,154,95,154};

int[] monthLocations = { 14,155,14,148,14,141,14,3,21,3,28,3,108,3,108,10,108,17,129,141,122,141,115,141
};

byte[][] dayOfTheWeek; // filled with every day of the year and a num of 0 - 6 were 0 = monday and 6 = sunday
               
byte isLeapYear[] = {0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0};
byte firstDayOfTheYear[] = {3,4,6,0,1,2,4,5,6,0,2,3,4,5,0,1,2,3,5,6};
int yearsSince2015 = year() - 2015;

int lastSecond = second();
int lastMinute = minute();
int lastHour = hour();
int lastDay = day();
int lastMonth = month();
int lastYear = year();
int iterationCounter =0;


                      
void setup() {
   size(144, 168);
   initDaysOfTheWeekforYear();   
};

void draw(){
  
  background(0);
   
   ///////////////////////////////////////         Capture, Store and display Current Time  
  handleCurrentTime();
  delay(50); // meant to keep iterations low for battery
  drawAllTimeElements();
  delay(50); // delay split up so movement is smoother
};

void handleCurrentTime() {
  int currentSecond = second();  
    lastSecond = currentSecond; 
    if(currentSecond <1){                        // if current second is zero run minute()
      int currentMinute = minute();      
      lastMinute = currentMinute;
        if (currentMinute < 1) {                 // if current minute is zero run hour()
          int currentHour = hour();          
          lastHour = currentHour;
            if (currentHour < 1) {               // if current hour is zero run day()
              int currentDay = day();              
              lastDay = currentDay;
                if (currentDay <2) {             // if current day the first of the month...
                  int currentMonth = month();    
                  lastMonth = currentMonth;
                  if (currentMonth < 2) {
                     int currentYear = year();
                     lastYear = currentYear;
                     initDaysOfTheWeekforYear();
                     
                  };
                };
            };
        };
    }; 
};

void initDaysOfTheWeekforYear() {
  dayOfTheWeek = new byte[12][31];
  byte[] daysInMonth = {31,28,31,30,31,30,31,31,30,31,30,31};
  if (isLeapYear[yearsSince2015] == 1) {
    daysInMonth[1] = 29;
  };
  byte currentDay =firstDayOfTheYear[yearsSince2015]; 
  for (byte i = 0; i<12; i++) {
    for (byte j = 0; j<daysInMonth[i]; j++) {
      dayOfTheWeek[i][j] = currentDay;
      if (currentDay != 6) {
        currentDay++;
      } else {
        currentDay = 0;
      };        
    };
  };
};

void drawAllTimeElements() {
  drawMonth(255);
  drawDay(255);
  drawDayOfTheWeek(255);
  drawHour(255);
  drawMinute(255);
  blackOutSecondHoles(0);
  drawSecond(255);
};

void drawMonth(int thisColor) {
   fill(thisColor);
   for (int k=0; k= lastMonth; k++) {
     if (k<3) {
       rect(monthLocations[k*2], monthLocations[k*2+1], 21, 7);
     } else if (k<6) {
       rect(monthLocations[k*2], monthLocations[k*2+1], 7, 21);
     } else if (k<9) {
      rect(monthLocations[k*2], monthLocations[k*2+1], 21, 7);
     } else {
       rect(monthLocations[k*2], monthLocations[k*2+1], 21, 7);
     };         
   };  // end for loop for currentHour
};

void drawDay(int thisColor) {
  fill(thisColor);
  strokeWeight(0);
  for (byte k=1; k<= lastDay; k++) {
    rect(dayLocations[k*2], dayLocations[k*2+1], 8, 8);
  };     
};

void drawDayOfTheWeek(int thisColor) {
 fill(thisColor);
 byte dayOfTheWeekNum = dayOfTheWeek[lastMonth-1][lastDay-1];
 for (byte k=1; k<= dayOfTheWeekNum; k++) {
   rect(dayOfTheWeekLocations[k*2], dayOfTheWeekLocations[k*2+1], 8, 8);
 }; 
}

void drawHour(int thisColor) {
  fill(thisColor);
  for (int k=0; k<= lastHour; k++) {
    if (k == 0) {
    } else if (k == 12) {
      rect(hourLocations[k*2], hourLocations[k*2+1], 18, 8);
    } else {
      rect(hourLocations[k*2], hourLocations[k*2+1], 8, 8);
    };
      
  }; 
};

void drawMinute(int thisColor) {
  fill(thisColor);
  for (int k=1; k<= lastMinute; k++) {
    rect(minuteLocations[k*2], minuteLocations[k*2+1], 8, 8);
  };
};

void blackOutSecondHoles(int thisColor) {
 fill(thisColor);
 noStroke();;
 int blackOutTo = lastMinute;
 for (int k=0; k<= blackOutTo; k++) {
    rect(minuteLocations[k*2]+3, minuteLocations[k*2+1]+3, 2, 2);
  };
};

void drawSecond(int thisColor) {
 fill(thisColor);
  noStroke();
  for (int k=1; k<= lastSecond; k++) {
    if (k == lastSecond) {
      secondAnimation(k);
    };
    rect(minuteLocations[k*2]+3, minuteLocations[k*2+1]+3, 2, 2);
   };
};

void secondAnimation(int secondToAnimate) {  
  if (secondToAnimate <= lastMinute) {
    fill(0);
  } else {
    fill(255);
  };
  rect(minuteLocations[secondToAnimate*2]+2, minuteLocations[secondToAnimate*2+1]+2, 4, 4);
};



