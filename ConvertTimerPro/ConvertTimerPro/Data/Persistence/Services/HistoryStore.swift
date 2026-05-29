//
//  HistoryStore.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import Foundation
import SwiftData

final class HistoryStore {
    
    // MARK: - Dependencies
    
    private let context:
    ModelContext
    
    // MARK: - Init
    
    init(
        context: ModelContext
    ) {
        
        self.context = context
    }
    
    // MARK: - Public
    
    func save(
        expression: String,
        result: String
    ) {
        
        do {
            
            let descriptor =
            FetchDescriptor<
                HistoryRecord
            >(
                sortBy: [
                    SortDescriptor(
                        \.createdAt,
                         order: .reverse
                    )
                ]
            )
            
            let records =
            try context.fetch(
                descriptor
            )
            
            // Prevent duplicate latest record
            
            if let latest = records.first,
               latest.expression ==
                expression {
                
                return
            }
            
            let record =
            HistoryRecord(
                expression: expression,
                result: result
            )
            
            context.insert(record)
            
            try context.save()
            
        } catch {
            
            print(
                "❌ Save history failed:",
                error
            )
        }
    }
    
    func fetchRecent(
        limit: Int = 20
    ) -> [HistoryRecord] {
        
        do {
            
            var descriptor =
            FetchDescriptor<
                HistoryRecord
            >(
                sortBy: [
                    SortDescriptor(
                        \.createdAt,
                         order: .reverse
                    )
                ]
            )
            
            descriptor.fetchLimit =
            limit
            
            return try context.fetch(
                descriptor
            )
            
        } catch {
            
            print(
                "❌ Fetch history failed:",
                error
            )
            
            return []
        }
    }
    
    func fetchPinned() -> [HistoryRecord] {
        
        do {
            
            let descriptor =
            FetchDescriptor<
                HistoryRecord
            >(
                predicate: #Predicate {
                    
                    $0.isPinned == true
                },
                sortBy: [
                    
                    SortDescriptor(
                        \.createdAt,
                         order: .reverse
                    )
                ]
            )
            
            return try context.fetch(
                descriptor
            )
            
        } catch {
            
            return []
        }
    }
    
    func delete(
        _ record: HistoryRecord
    ) {
        
        do {
            
            context.delete(record)
            
            try context.save()
            
        } catch {
            
            print(
                "❌ Delete history failed:",
                error
            )
        }
    }
    
    func clearAll() {
        
        do {
            
            let descriptor =
            FetchDescriptor<
                HistoryRecord
            >()
            
            let records =
            try context.fetch(
                descriptor
            )
            
            records.forEach {
                context.delete($0)
            }
            
            try context.save()
            
        } catch {
            
            print(
                "❌ Clear history failed:",
                error
            )
        }
    }
    
    func togglePin(
        _ record: HistoryRecord
    ) {

        do {

            record.isPinned.toggle()

            try context.save()

        } catch {

            print(
                "❌ Toggle pin failed:",
                error
            )
        }
    }
}
