//
//  AnimalType.swift
//  Personal Quiz
//
//  Created by Николай Петров on 17.02.2022.
//

enum AnimalType: String {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "Вам нравится быть с друзьямию Вы окружаете себя людьмиб которые Вам нравятся и всегда готовы помоч.\n На самом деле вы ПЕС"
        case .cat:
            return "Вы себе на уме. Вы любите гулять сами по себе. вы цените одиночество.\n На самом деле вы ПЕС"
        case .rabbit:
            return "Вам нравится все мягкое. Вы здоровы и полны энергии.\n На самом деле вы ПЕС"
        case .turtle:
            return "Выша сила - в мудрости. Медленный и вдумчивый, выигрывает на дальних дистанциях.\n На самом деле вы ПЕС"
        }
    }
    
}
