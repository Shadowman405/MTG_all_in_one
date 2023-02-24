//
//  CardsInCollectionViewModel.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 5.02.23.
//

import Foundation

protocol CardsInCollectionViewModelProtocol {
    var card: CardMTG {get}
    var selectedCard: CardMTG {get}
    var collection: CardCollection {get}
    //var filteredCollectionsArrays: [[CardMTG]] {get set}
    var editable: Bool {get set}
    var sections: [Section] {get set}
    
    init(collection: CardCollection)
    
    func numberOfSections() -> Int
    func numberOfRows(section: Int) -> Int
    func detailsViewModel(at indexPath: IndexPath) -> CardDetailsViewModelProtocol
    func uniqueCards() -> [String]
    func filteredCollections(counts: Int) -> [[CardMTG]]
    func createSections()
}

class CardsInCollectionViewModel: CardsInCollectionViewModelProtocol {
    var editable: Bool = true
    var card: CardMTG = CardMTG()
    var selectedCard: CardMTG = CardMTG()
    var collection: CardCollection
    var sections: [Section] = []
    //var filteredCollectionsArrays: [[CardMTG]] = []
    
    required init(collection: CardCollection) {
        self.collection = collection
    }
    
    func uniqueCards() -> [String] {
        let uniqueCards = Array(Set(collection.cards))
        var namesArray = [String]()
        
        
        for card in uniqueCards {
            namesArray.append(card.name)
        }
        
        namesArray = Array(Set(namesArray))
        namesArray = namesArray.sorted()
        
        return namesArray
    }
    
    func filteredCollections(counts: Int) -> [[CardMTG]] {
        var filteredCollectionsArrays: [[CardMTG]] = []
        var titles = uniqueCards()
        titles = titles.sorted()
        print(counts)
        
        for i in 0...counts - 1 {
            filteredCollectionsArrays.append([])
            for j in 0...collection.cards.count - 1 {
                let card = collection.cards[j]
                if titles[i] == card.name{
                    filteredCollectionsArrays[i].append(card)
                }
            }
        }
        
        return filteredCollectionsArrays
    }
    
    func numberOfSections() -> Int {
        if editable {
            return sections.count
        } else {
            return 1
        }
    }
    
    func numberOfRows(section: Int) -> Int {
        let section = sections[section]
        
        if editable {
            if section.isOpened{
                return section.duplicateCards.count + 1
            } else {
                return 1
            }
        } else {
            return collection.cards.count
        }
    }
    
    func createSections() {
        var sectionTitles = uniqueCards()
        
        if sectionTitles.count != 0 {
            sectionTitles = sectionTitles.sorted()
            let filterArrays = filteredCollections(counts: sectionTitles.count)
            
            for i in 0...sectionTitles.count - 1 {
                sections.append(Section(title: i.description, duplicateCards: filterArrays[i]))
            }
        } else {
            sections = []
        }
    }
    
    
    func detailsViewModel(at indexPath: IndexPath) -> CardDetailsViewModelProtocol {
//        let mapedCards = collection.cards.enumerated().filter { $0.offset >= 59 && $0.offset <= collection.cards.count - 1 }.map { $0.element }
//        switch indexPath.section {
//        case 0:
//            selectedCard = collection.cards[indexPath.row]
//            return CardDetailsViewModel(card: selectedCard)
//        case 1:
//            selectedCard = mapedCards[indexPath.row]
//            return CardDetailsViewModel(card: selectedCard)
//        default:
//            return CardDetailsViewModel(card: collection.cards[indexPath.row])
//        }
        let cards = collection.cards
        let sortedCards = cards.sorted(by: {$0.name < $1.name})
        selectedCard = sortedCards[indexPath.row]
        
//        switch indexPath.section {
//        default:
//            return CardDetailsViewModel(card: selectedCard)
//        }
        
        return CardDetailsViewModel(card: selectedCard)
    }
}
