#!/usr/bin/env python3
'''Task 9's module: inserts a new document into a MongoDB collection.
'''


def insert_school(mongo_collection, **kwargs):
    '''Inserts a new document into the specified MongoDB collection.
    
    Args:
        mongo_collection: The pymongo collection object to insert into.
        **kwargs: The fields and values for the new document.
        
    Returns:
        ObjectId: The ID of the newly inserted document.
    '''
    # Insert the new document and return its ID
    result = mongo_collection.insert_one(kwargs)
    return result.inserted_id