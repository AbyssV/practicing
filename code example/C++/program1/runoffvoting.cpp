#include <string>
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <limits>                    //Biggest int: std::numeric_limits<int>::max()
#include "ics46goody.hpp"
#include "array_queue.hpp"
#include "array_priority_queue.hpp"
#include "array_set.hpp"
#include "array_map.hpp"


typedef ics::ArrayQueue<std::string>              CandidateQueue;
typedef ics::ArraySet<std::string>                CandidateSet;
typedef ics::ArrayMap<std::string,int>            CandidateTally;

typedef ics::ArrayMap<std::string,CandidateQueue> Preferences;
typedef ics::pair<std::string,CandidateQueue>     PreferencesEntry;
typedef ics::ArrayPriorityQueue<PreferencesEntry> PreferencesEntryPQ; //Must supply gt at construction

typedef ics::pair<std::string,int>                TallyEntry;
typedef ics::ArrayPriorityQueue<TallyEntry>       TallyEntryPQ;



//Read an open file stating voter preferences (each line is (a) a voter
//  followed by (b) all the candidates the voter would vote for, in
//  preference order (from most to least preferred candidate, separated
//  by semicolons), and return a Map of preferences: a Map whose keys are
//  voter names and whose values are a queue of candidate preferences.
Preferences read_voter_preferences(std::ifstream &file) {
 Preferences preferences;
 std::string line;
 while (getline(file,line)) {
   std::vector<std::string> line_sp = ics::split(line,";");
   std::string voter = line_sp[0];
   CandidateQueue cq;
   for (unsigned i=1; i<line_sp.size(); ++i)
     cq.enqueue(line_sp[i]);
   preferences.put(voter,cq);
 }
 file.close();

 return preferences;
}


//Print a label and all the entries in the preferences Map, in alphabetical
//  order according to the voter.
//Use a "->" to separate the voter name from the Queue of candidates.
void print_voter_preferences(const Preferences& preferences) {
   std::cout << "Voter Preferences" << std::endl;
   PreferencesEntryPQ cands_sorted(preferences, [](const PreferencesEntry& a, const PreferencesEntry& b){return a.first<b.first;});
   for (const PreferencesEntry& kv : cands_sorted) {
     std::cout << "  " << kv.first << " -> " << kv.second << std::endl;
 }
}


//Print the message followed by all the entries in the CandidateTally, in
//  the order specified by has_higher_priority: i is printed before j, if
//  has_higher_priority(i,j) returns true: sometimes alphabetically by candidate,
//  other times by decreasing votes for the candidate.
//Use a "->" to separate the candidat name from the number of votes they
//  received.
void print_tally(std::string message, const CandidateTally& tally, bool (*has_higher_priority)(const TallyEntry& i,const TallyEntry& j)) {
 std::cout << message << std::endl;
 TallyEntryPQ te(tally,has_higher_priority);
 for (const TallyEntry& k : te) {
   std::cout << "  " << k.first << " -> " << k.second << std::endl;
 }
}


//Return the CandidateTally: a Map of candidates (as keys) and the number of
//  votes they received, based on the unchanging Preferences (read from the
//  file) and the candidates who are currently still in the election (which changes).
//Every possible candidate should appear as a key in the resulting tally.
//Each voter should tally one vote: for their highest-ranked candidate who is
//  still in the the election.
CandidateTally evaluate_ballot(const Preferences& preferences, const CandidateSet& candidates) {
 CandidateTally tally;
 for (const std::string& cand : candidates)
   tally[cand] = 0;

 for (const PreferencesEntry& vp : preferences)
   for (const std::string& cand : vp.second)
     if (candidates.contains(cand)) {
       tally[cand]++;
       break;
     }
 return tally;
}


//Return the Set of candidates who are still in the election, based on the
//  tally of votes: compute the minimum number of votes and return a Set of
//  all candidates receiving more than that minimum; if all candidates
//  receive the same number of votes (that would be the minimum), the empty
//  Set is returned.
CandidateSet remaining_candidates(const CandidateTally& tally) {
 int vote_threshold = std::numeric_limits<int>::max();
 for (const TallyEntry& p : tally)
   if (p.second < vote_threshold)
     vote_threshold = p.second;

 CandidateSet to_return;
 for (const TallyEntry& p : tally)
   if (p.second > vote_threshold)
     to_return.insert(p.first);

 return to_return;
}


//Prompt the user for a file, create a voter preference Map, and print it.
//Determine the Set of all the candidates in the election, from this Map.
//Repeatedly evaluate the ballot based on the candidates (still) in the
//  election, printing the vote count (tally) two ways: with the candidates
//  (a) shown alphabetically increasing and (b) shown with the vote count
//  decreasing (candidates with equal vote counts are shown alphabetically
//  increasing); from this tally, compute which candidates remain in the
//  election: all candidates receiving more than the minimum number of votes;
//  continue this process until there are less than 2 candidates.
//Print the final result: there may 1 candidate left (the winner) or 0 left
//   (no winner).
int main() {
 try {
   std::ifstream in_votes;
   ics::safe_open(in_votes,"Enter voter preference file name","votepref1.txt");
   Preferences preferences = read_voter_preferences(in_votes);
   print_voter_preferences(preferences);

   CandidateSet candidates;
   for (const PreferencesEntry& vp : preferences)
     for (const std::string& c : vp.second)
       candidates.insert(c);

   int ballot = 1;
   while (candidates.size() > 1) {
     CandidateTally tally = evaluate_ballot(preferences,candidates);

     std::ostringstream message1;
     message1 << "\nVote count on ballot #" << ballot << " with candidates alphabetically: still in election = " << candidates;
     print_tally(message1.str(),tally,[](const TallyEntry& i,const TallyEntry& j){return (i.first == j.first ? i.second < j.second : i.first < j.first);});

     std::ostringstream message2;
     message2 << "\nVote count on ballot #" << ballot << " with candidates numerically: still in election = " << candidates;
     print_tally(message2.str(),tally,[](const TallyEntry& i,const TallyEntry& j){return (i.second == j.second ? i.first < j.first : i.second > j.second);});

     candidates = remaining_candidates(tally);
     ballot += 1;
   }

   if (candidates.size() == 1) {
     std::cout << "\nWinner is ";
     for (const std::string& c : candidates)
       std::cout << c << " ";
     std::cout << std::endl;
   }else
     std::cout << "\nNo winner: election is a tie among candidate remaining on the last ballot." << std::endl;
 } catch (ics::IcsError& e) {
   std::cout << e.what() << std::endl;
 }
 return 0;
}
