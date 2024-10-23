#!/usr/bin/env python3
'''Task 10's module: updates document topics in a MongoDB collection.
'''


def update_topics(mongo_collection, name, topics):
    '''Updates all topics of documents in mongo_collection based on name.
    
    Args:
        mongo_collection: The pymongo collection object to update.
        name (str): The name of the document to match.
        topics (list): The list of topics to set for the matched document(s).
    '''
    mongo_collection.update_many(
        {'name': name},  # Filter documents by 'name'.
        {'$set': {'topics': topics}}  # Update 'topics' field.
    )