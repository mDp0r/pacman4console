 #include <stdio.h>
 #include <stdlib.h>
extern "C" {
	#include "agent.h"
	
	
}
/*extern void getAction(int *action, int *Invincible, int *Lives, int *Points, int *LevelNumber, int *Loc, int *Level){
	*action = 1;
}
*/
extern "C" void getAction(int *action,int State){
	*action = State%4;
}

//ToDO: 0) Score für vorherigen Funktionsaufruf berechnen und in Modell schreiben
//1) State Represantation auf Basis der Übergaben
//2) Model laden, wenn vorhanden
//3) Q-Learning: Explore/use Knowledge, Scoring function
//4) Schreiben der selektierten Aktion und des Statespaces in Modell
//5) *action entsprechend Q-Learning Auswahl ändern
//optional: 6) Batch Script für automatisches Training
//7) Parallelisiertes Training: Mehrere Trainingssessions starten
//Ergebnisse aus mehreren Sessions zusammenführen
