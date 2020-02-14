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


typedef ics::ArraySet<std::string>                     States;
typedef ics::ArrayQueue<std::string>                   InputsQueue;
typedef ics::ArrayMap<std::string,States>              InputStatesMap;

typedef ics::ArrayMap<std::string,InputStatesMap>       NDFA;
typedef ics::pair<std::string,InputStatesMap>           NDFAEntry;

bool gt_NDFAEntry (const NDFAEntry& a, const NDFAEntry& b)
{return a.first<b.first;}

typedef ics::ArrayPriorityQueue<NDFAEntry,gt_NDFAEntry> NDFAPQ;

typedef ics::pair<std::string,States>                   Transitions;
typedef ics::ArrayQueue<Transitions>                    TransitionsQueue;


//Read an open file describing the non-deterministic finite automaton (each
//  line starts with a state name followed by pairs of transitions from that
//  state: (input followed by a new state, all separated by semicolons), and
//  return a Map whose keys are states and whose associated values are another
//  Map with each input in that state (keys) and the resulting set of states it
//  can lead to.
const NDFA read_ndfa(std::ifstream &file) {
	NDFA ndfa;
 std::string line;
	while (getline(file,line)) {
		std::vector<std::string> input_states = ics::split(line,";");
		std::string state = input_states[0];
   InputStatesMap ism;
   for (unsigned i=1; i<input_states.size(); i+=2) {
     std::string input     = input_states[i];
     std::string new_state = input_states[i+1];
     ism[input].insert(new_state);
   }
   ndfa[state] = ism;
	}

	file.close();
 return ndfa;
}


//Print a label and all the entries in the finite automaton Map, in
//  alphabetical order of the states: each line has a state, the text
//  "transitions:" and the Map of its transitions.
void print_ndfa(const NDFA& ndfa) {
 std::cout << "Non-Deterministic Finite Automaton Description" << std::endl;
 NDFAPQ states_sorted(ndfa);
 for (const NDFAEntry& k : states_sorted)
   std::cout << "  " << k.first << " transitions: " << k.second << std::endl;
}


//Return a queue of the calculated transition pairs, based on the non-deterministic
//  finite automaton, initial state, and queue of inputs; each pair in the returned
//  queue is of the form: input, set of new states.
//The first pair contains "" as the input and the initial state.
//If any input i is illegal (does not lead to any state in the non-deterministic finite
//  automaton, ignore it).
TransitionsQueue process(const NDFA& ndfa, std::string state, const InputsQueue& inputs) {
 TransitionsQueue result( {Transitions("",States({state}))} );
 States states ({state});
 for (const std::string& i : inputs) {
   States new_states;
   for (const std::string& s : states)
     if (ndfa[s].has_key(i))
       new_states.insert_all(ndfa[s][i]);
   result.enqueue(Transitions(i,new_states));
   states = new_states;
 }

 return result;
}


//Print a TransitionsQueue (the result of calling process) in a nice form.
//Print the Start state on the first line; then print each input and the
//  resulting new states indented on subsequent lines; on the last line, print
//  the Stop state.
void interpret(TransitionsQueue& tq) {  //or TransitionsQueue or TransitionsQueue&&
 std::cout << "Start state = " << tq.dequeue().second << std::endl;

 States last;
 for (const Transitions& t : tq) {
   std::cout << "  Input = " << t.first;
   std::cout << "; new states = " << t.second <<std::endl;
   last = t.second;
 }

 std::cout << "Stop state(s) = " << last << std::endl;
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
   ics::safe_open(fa_description,"Enter file name of Non-Determinstic Finite Automaton","ndfaendin01.txt");
   NDFA ndfa = read_ndfa(fa_description);
   print_ndfa(ndfa);

   std::ifstream start_inputs;
   ics::safe_open(start_inputs,"\nEnter file name of start-states and input","ndfainputendin01.txt");

   std::string line;
   while (getline(start_inputs,line)) {
     std::cout << "\nStarting new simulation with description: " << line << std::endl;
     std::vector<std::string> state_inputs = ics::split(line,";");
     InputsQueue iq;
     for (unsigned i=1; i<state_inputs.size(); ++i)
       iq.enqueue(state_inputs[i]);
     TransitionsQueue tq = process(ndfa,state_inputs[0],iq);
     interpret(tq);
     //We could use: interpret(process(ndfa,state_inputs[0],iq));
     //if we declared: void interpret(TransitionQueue&& tq) {
   }

 } catch (ics::IcsError& e) {
   std::cout << e.what() << std::endl;
 }

 return 0;
}
