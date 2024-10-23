#!/usr/bin/env python3
'''Task 11's module: finds schools by a specific topic.
'''


def schools_by_topic(mongo_collection, topic):
    '''Returns the list of schools having a specific topic in their "topics".
    
    Args:
        mongo_collection: The pymongo collection object to query.
        topic (str): The topic to search for.
        
    Returns:
        List of documents where the topic is found.
    '''
    # Define the filter to find documents where 'topics' contains the topic
    topic_filter = {
        'topics': {
            '$elemMatch': {
                '$eq': topic,  # Match if the topic exists in 'topics'
            },
        },
    }
    # Return the list of documents that match the filter
    return [doc for doc in mongo_collection.find(topic_filter)]