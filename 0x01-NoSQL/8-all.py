#!/usr/bin/env python3
'''Task 8's module: lists all documents in a MongoDB collection.
'''


def list_all(mongo_collection):
    '''Returns all documents in the given MongoDB collection.
    
    Args:
        mongo_collection: The pymongo collection object to query.
        
    Returns:
        List of documents in the collection.
    '''
    # Return all documents from the collection as a list
    return [doc for doc in mongo_collection.find()]