//
//  SortingActionSheet.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 21.09.2023.
//

import SwiftUI

struct SortingActionSheet {
    @Binding var selectedSortOption: MovieSortOption
    let action: (MovieSortOption) -> Void

    func actionSheet() -> ActionSheet {
        ActionSheet(title: Text(NSLocalizedString("Select Sorting Option", comment: "Action sheet title")),
                    buttons: sortingOptions())
    }

    func sortingOptions() -> [ActionSheet.Button] {
        var buttons: [ActionSheet.Button] = []
        for option in MovieSortOption.allCases {
            let buttonText = NSLocalizedString(option.rawValue, comment: "Sort option title") + (selectedSortOption == option ? " ✓" : "")
            buttons.append(
                .default(Text(buttonText), action: {
                    selectedSortOption = option
                    action(option)
                })
            )
        }
        buttons.append(.cancel())
        return buttons
    }
}
