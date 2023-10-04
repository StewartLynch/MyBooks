//
// Created for MyBooks
// by  Stewart Lynch on 2023-10-04
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch


import Foundation

extension Book {
    static let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date.now)!
    static let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date.now)!
    static var sampleBooks: [Book] {
        [
            Book(title: "QBVII",
                 author: "Leon Uris"),
            Book(title: "Macbeth",
                 author: "William Shakespear",
                 dateAdded: lastWeek,
                 dateStarted: Date.now,
                 status: Status.inProgress),
            Book(title: "Silence of the Grave",
                 author: "Arnuldur Indrason, Bernard Scudder",
                 dateAdded: lastMonth,
                 dateStarted: lastWeek,
                 dateCompleted: Date.now,
                 summary: "Inheriting Ian Fleming's long-lost account of his spy activities during World War II, young American academic Amy Greenberg finds herself targeted by unknown assailants and must race to finish the manuscript in order to save her life and reveal the actions of a traitor.",
                 rating: 4,
                 status: Status.completed),
            Book(title: "Cardinal",
                 author: "Giles Blunt"),
            Book(title: "Jackdaws",
                 author: "Ken Follett",
                 dateAdded: lastWeek,
                 dateStarted: Date.now,
                 summary: "In his own bestselling tradition of Eye of the Needle and The Key to Rebecca, Ken Follett delivers a breathtaking novel of suspense set in the most dangerous days of World War II. Look out for Ken's newest book, A Column of Fire, available now. D-Day is approaching. They don’t know where or when, but the Germans know it’ll be soon, and for Felicity “Flick” Clariet, the stakes have never been higher. A senior agent in the ranks of the Special Operations Executive (SOE) responsible for sabotage, Flick has survived to become one of Britain’s most effective operatives in Northern France. She knows that the Germans’ ability to thwart the Allied attack depends upon their lines of communications, and in the days before the invasion no target is of greater strategic importance than the largest telephone exchange in Europe. But when Flick and her Resistance-leader husband try a direct, head-on assault that goes horribly wrong, her world turns upside down. Her group destroyed, her husband missing, her superiors unsure of her, her own confidence badly shaken, she has one last chance at the target, but the challenge, once daunting, is now near impossible. The new plan requires an all-woman team, none of them professionals, to be assembled and trained within days. Code-named the Jackdaws, they will attempt to infiltrate the exchange under the noses of the Germans—but the Germans are waiting for them now and have plans of their own. There are secrets Flick does not know—secrets within the German ranks, secrets among her hastily recruited team, secrets among those she trusts the most. And as the hours tick down to the point of no return, most daunting of all, there are secrets within herself. . . . Filled with the powerful storytelling, unforgettable characters, and authentic detail that have become his hallmarks, Jackdaws is Ken Follett writing at the height of his powers.",
                 status: Status.inProgress),
            Book(title: "Blackout",
                 author: "John Lawton",
                 dateAdded: lastMonth,
                 dateStarted: lastWeek,
                 dateCompleted: Date.now,
                 summary: "In London, during World War II, a dog uncovers a severed arm, which turns out to be that of a rocket scientist--and it was not a bomb that killed him. Sgt. Frederick Troy of Scotland Yard is assigned to the case, which pits him against the U.S. Office of Strategic Services, the wartime spy agency.",
                 rating: 3,
                 status: Status.completed),
            Book(title: "The Sandman",
                 author: "Lars Keplar"),
            Book(title: "The Redbreast",
                 author: "Jo Nesbo",
                 dateAdded: lastWeek,
                 dateStarted: Date.now,
                 status: Status.inProgress),
            Book(title: "Fatherland",
                 author: "Robert Harris",
                 dateAdded: lastMonth,
                 dateStarted: lastWeek,
                 summary: "Twenty years after Germany's victory in World War II, while the entire country prepares for the U.S. president's visit, Berlin Detective Xavier March attempts to solve the murder of a high-ranking Nazi commander. Reprint.",
                 rating: 5,
                 status: Status.completed)
        ]
    }
}
