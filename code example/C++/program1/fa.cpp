#include <string>
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include "ics46goody.hpp"
#include "array_queue.hpp"
#include "array_priority_queue.hpp"
#include "array_set.hpp"
#include "array_map.hpp"


typedef ics::ArrayQueue<std::string>                InputsQueue;
typedef ics::ArrayMap<std::string,std::string>      InputStateMap;

typedef ics::ArrayMap<std::string,InputStateMap>    FA;
typedef ics::pair<std::string,InputStateMap>        FAEntry;

bool gt_FAEntry (const FAEntry& a, const FAEntry& b)
{return a.first<b.first;}

typedef ics::ArrayPriorityQueue<FAEntry,gt_FAEntry> FAPQ;

typedef ics::pair<std::string,std::string>          Transition;
typedef ics::ArrayQueue<Transition>                 TransitionQueue;


//Read an open file describing the finite automaton (each line starts with
//  a state name followed by pairs of transitions from that state: (input
//  followed by new state, all separated by semicolons), and return a Map
//  whose keys are states and whose associated values are another Map with
//  each input in that state (keys) and the resulting state it leads to.
const FA read_fa(std::ifstream &file) {
	FA fa;
 std::string line;
	while (getline(file,line)) {
		std::vector<std::string> input_states = ics::split(line,";");
		std::string state = input_states[0];
   InputStateMap ism;
   for (unsigned i=1; i<input_states.size(); i+=2) {
     std::string input     = input_states[i];
     std::string new_state = input_states[i+1];
     ism[input] = new_state;
   }
   fa[state] =ism;
	}

	file.close();
 return fa;
}


//Print a label and all the entries in the finite automaton Map, in
//  alphabetical order of the states: each line has a state, the text
//  "transitions:" and the Map of its transitions.
void print_fa(const FA& fa) {
 std::cout << "Finite Automaton Description" << std::endl;
 FAPQ states_sorted(fa);
 for (const FAEntry& k : states_sorted)
   std::cout << "  " << k.first << " transitions: " << k.second << std::endl;
}


//Return a queue of the calculated transition pairs, based on the finite
//  automaton, initial state, and queue of inputs; each pair in the returned
//  queue is of the form: input, new state.
//The first pair contains "" as the input and the initial state.
//If any input i is illegal (does not lead to a state in the finite
//  automaton), then the last pair in the returned queue is i,"None".
TransitionQueue process(const FA& fa, std::string state, const InputsQueue& inputs) {
 TransitionQueue result( {Transition("",state)} );

 for (const std::string& i : inputs)
   if (!fa[state].has_key(i)) {
     result.enqueue(Transition(i,"None"));
     break;
   }else{
     state = fa[state][i];
     result.enqueue(Transition(i,state));
   }

 return result;
}


//Print a TransitionQueue (the result of calling the process function above)
// in a nice form.
//Print the Start state on the first line; then print each input and the
//  resulting new state (or "illegal input: terminated", if the state is
//  "None") indented on subsequent lines; on the last line, print the Stop
//  state (which might be "None").
void interpret(TransitionQueue& tq) {  //or TransitionQueue or TransitionQueue&&
 std::cout << "Start state = " << tq.dequeue().second << std::endl;

 std::string last;
 for (const Transition& t : tq) {
   std::cout << "  Input = " << t.first;
   if (t.second != "None")
     std::cout << "; new state = " << t.second <<std::endl;
   else
     std::cout << "; illegal input: terminated" << std::endl;
   last = t.second;
 }

 std::cout << "Stop state = " << last << std::endl;
}



//Prompt the user for a file, create a finite automaton Map, and print it.
//Prompt the user for a file containing any number of simulation descriptions
//  for the finite automaton to process, one description per line; each
//  description contains a start state followed by its inputs, all separated by
//  semicolons.
//Repeatedly read a description, print that description, put each input in a
//  Queue, process the Queue and print the results in a nice form.
int main() {
 try {
   std::ifstream fa_description;
   ics::safe_open(fa_description,"Enter file name of Finite Automaton","faparity.txt");
   FA fa = read_fa(fa_description);
   print_fa(fa);

   std::ifstream start_inputs;
   ics::safe_open(start_inputs,"\nEnter file name of start-states and input","fainputparity.txt");

   std::string line;
   while (getline(start_inputs,line)) {
     std::cout << "\nStarting new simulation with description: " << line << std::endl;
     std::vector<std::string> state_inputs = ics::split(line,";");
     InputsQueue iq;
     for (unsigned i=1; i<state_inputs.size(); ++i)
       iq.enqueue(state_inputs[i]);
     TransitionQueue tq = process(fa,state_inputs[0],iq);
     interpret(tq);
     //Could use: interpret(process(fa,state_inputs[0],iq));
     //if we declared: void interpret(TransitionQueue&& tq) {

   }

 } catch (ics::IcsError& e) {
   std::cout << e.what() << std::endl;
 }

 return 0;
}
