//
//  Excuse.swift
//  Let's Not
//
//  Created by jiachen on 31/10/21.
//

import Foundation

struct Excuse: Identifiable, Codable, Equatable {
    var id: Int
    var title: String
    
    static let allRaw = [
        "I can't do my homework because my pet monkey ate it",
        "I must have left my homework in my other pants",
        "I've got to do my homework in the morning. I've only got the afternoon to live.",
        "I left my homework in another dimension",
        "I had to do so much last minute homework I'm exhausted",
        "It's monday? That can't be right",
        "I think aliens entered my body and erased my memory so I couldn't remember my homework",
        "I couldn't do my homework, so I put a note in my textbooks saying \"DO NOT HAND IN\"",
        "Last night I needed to finish my homework but all the lights went out so I used my cell phone for light. Unfortunately, I ran down my batteries and forgot to charge it",
        "My dog ate my homework",
        "I wrestled an octopus who was an alien who erased my memory",
        "Arrows were shot at me while I was taking my homework to the other side (no, I'm serious)",
        "I woke up in the future with no memory. I only just found out that I had to do work in class today",
        "I was walking in with my homework, but my dog turned into a motorcycle and I had to chase him",
        "I just noticed that my bookbag's tire was flat. It must have been slashed by a ninja.",
        "The school bells rang but I don't speak bell so I couldn't hear them",
        "My homework fell through a black hole and got erased from reality",
        "All my homework suddenly transformed into hyenas and ran away",
        "My parents couldn't afford to pay our internet bill so my homework is stuck behind a pay wall",
        "Your tasks were so hard I had to clone myself so I could work harder",
        "My cat accidentally ate my homework",
        "My teleporter glitched and erased all my homework",
        "I was so excited during lunch that I stepped into a random time machine by accident",
        "I had to find some food so I could eat the food to have strength to do my homework",
        "I couldn't do my homework because my 3D printer was printing a marble statue of me",
        "I saw a unicorn and I chased him and I forgot that I had to do my homework",
        "Like most things I build, my homework blew up in my face",
        "I collapsed from exhaustion after working on my homework inside a lucid dream",
        "My homework was actually a giant boulder that chased me",
        "I stacked up all my homework on legos and accidentally knocked it over",
        "My Mp3 player ran out of juice so I couldn't do my homework",
        "Somebody farted and it went through my headset, destroying my homework",
        "I accidentally built my homework on a model of the atom and my teleporter exploded it",
        "A bird flew through a window and erased my homework",
        "My cellphone suddenly appeared in my hand and it said I won the lottery so I thought \"why bother with homework?\". So I put it in my pocket",
        "My head gave me a headache so I couldn't do the crossword puzzle looking for my homework",
        "I had to take all of my homework to the jungle to protect it from Batman",
        "I was on mars with my homework but my oxygen supply ran out",
        "My homework got swarmed by bees",
        "I forgot to assign my homework to memory",
        "I was walking in when the janitor accidentally erased my homework when he pulled out his vacuum cleaner",
        "My dog ran away with my homework when he saw a squirrel",
        "I was walking in when I saw a magical painting and because of it, I forgot I had to do my homework",
        "I was taking my homework to the cave of time until it got attacked by flying dinosaurs",
        "I was moving my homework onto the \"BAD HOMEWORK JAR\" when the lid cracked open",
        "Nanomachines were responsible for losing my homework",
        "I got pulled into a black hole while I was trying to eat my homework",
        "A thief robbed me and stole my homework",
        "I put a carrot inside my homework to see what would happen",
        "I couldn't find my homework because my uncle broke my command headquarters",
        "I woke up from a nap and my homework was gone",
        "I couldn't do my homework during lunch earlier because my stomach was making too much noise",
        "My pets took my homework so they could do it for me",
        "I couldn't find my homework because I put it on the grocery store scanner",
        "My computer ate my homework",
        "I was rushing in to hand my homework in but I tripped",
        "My homework was stolen by an evil twin who lives in that mirror",
        "During the experiment blast I tripped into my homework experiment that caused it to be burned",
        "I woke up late because my alarm clock was empty",
        "I couldn't find the chalk so I couldn't write on the chalkboard",
        "Got sucked into a wormhole while painting my homework",
        "I woke up and saw that the internet was broken so I couldn't access the solution",
        "Unknown forces caused me to black out and I forgot my homework",
        "Somebody stole my homework and hid it in Brazil",
        "My dog meditated to get in contact with my homework",
        "I was listening to mp3 players that play homework, but it ran out before I finished",
        "My black hole was late discovering the gravity anomaly while i was doing my homework",
        "All my batteries ran out and I had no way of finishing my homework",
        "I wouldn't do my homework because a killer clown tricked me",
        "My dog ran away whilst I was trying to feed him my homework after a confusing description I thought he actually wanted it",
        "I brought my homework to school, but a bird ate it",
        "I was attacked by a large, carnivorous bird",
        "A cougar chased me all the way home from school",
        "I seemed to have misplaced my backpack",
        "I saw a large python slink right past my locker, and I was too scared to go get my homework from it.",
        "I was bitten by my homework",
        "A flood filled my bedroom with several feet of water",
        "My homework was knocked from my hands by a radioactive spider",
        "My homework blew away in a tornado",
        "My homework was taken by a tractor trailer",
        "A pack of giant spiders ate my homework.",
        "Dolphins stole my homework",
        "My homework was hit by a stray football",
        "The earth was attacked by giant rabbits who devoured everyone's homework.",
        "I lost my homework chasing ghosts",
        "When I got home from school there was an evil gnome standing guard over my homework, who thrust his spear into my heart for coming near.",
        "Pac man ate my homework.",
        "My homework was taken by Capt. Crunch.",
        "I have been drafted into the army.",
        "I drop my homework in a sink hole",
        "I forgot my backpack so I didn't have my homework.",
        "My teacher forgot to hand out homework.",
        "Nobody told me there was homework.",
        "My homework was annihilated by the laser on my pet iguana.",
        "Algebra took over the bodies of my teacher and my homework, they merged and the resulting creature devoured my homework.",
        "My homework was abducted by aliens.",
        "I couldn't finish my project because the clocks in the building all ran backwards.",
        "On the way to school a tornado carried my backpack off into a land of dragons.",
        "I lost my backpack which contained my homework.",
        "My homework was eaten by gremlins.",
        "A tornado took my homework out to sea."
    ]
    
    static var all: [Excuse] {
        return allRaw.enumerated().map { (n, excuse) in
            Excuse(id: n, title: excuse)
        }
    }
    
    static var sample: [Excuse] {
        return Array(all.shuffled().prefix(through: 5))
    }
    
    func usedOn(teachers: [Teacher]) -> [Teacher] {
        teachers.filter { teacher in
            teacher.excuses.contains(self)
        }
    }
}
