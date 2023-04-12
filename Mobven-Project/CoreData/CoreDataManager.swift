//
//  CoreDataManager.swift
//  Mobven-Project
//
//  Created by Zehra on 4.04.2023.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Mobven-Project")
        container.loadPersistentStores(completionHandler: {( storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private lazy var context = persistentContainer.viewContext
    
    private init() {}
    
    func create<T>(type: T.Type, completion: @escaping ((Result<T, CoreDataError>) -> Void)) {
        do {
            guard let newItem = NSEntityDescription.insertNewObject(forEntityName: "\(T.self)", into: context) as? T else {
                completion(.failure(.create))
                return
            }
            try context.save()
            completion(.success(newItem))
        } catch {
            completion(.failure(.save))
        }
    }
    
    func read<T>(type: T.Type, completion: @escaping ((Result<[T], CoreDataError>) -> Void)) {
        do {
            guard let item = try context.fetch(Account.fetchRequest()) as? [T] else {
                completion(.failure(.fetch))
                return
            }
            completion(.success(item))
        } catch {
            completion(.failure(.read))
        }
    }
    
    func update(completion: @escaping ((Result<Void, CoreDataError>) -> Void)) {
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(.update))
        }
    }
    
    func delete(objects: [some NSManagedObject], completion: @escaping ((Result<Void, CoreDataError>) -> Void)) {
            do {
                for object in objects {
                    context.delete(object)
                }
                try context.save()
                completion(.success(()))
            } catch {
                completion(.failure(.unknown))
            }
        }
}
