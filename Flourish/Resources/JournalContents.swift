//
//  JournalContents.swift
//  Flourish
//
//  Created by Agfi on 25/06/24.
//

import Foundation

struct JournalContents {
    static let contents: [EntryCardData] = [
        EntryCardData(
            image: "Activity",
            title: "Activity",
            description: "Review your experiences with personalized prompt."
        ),
        EntryCardData(
            image: "Reflection",
            title: "Reflection",
            description: "Take a few minutes each day to review your experiences."
        ),
        EntryCardData(
            image: "To-Do List",
            title: "To-Do List",
            description: "Write down your tasks to stay organized and focused."
        ),
        EntryCardData(
                    image: "Default Journal",
                    title: "Default Journal",
                    description: "Review your daily experiences freely from scratch."
        )
    ]
}
