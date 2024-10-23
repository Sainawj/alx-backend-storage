#!/usr/bin/env python3
'''Task 14's module: prints students sorted by average score.
'''


def top_students(mongo_collection):
    '''Fetches all students sorted by average score.
    
    Args:
        mongo_collection: The pymongo collection object to query.
        
    Returns:
        Cursor: A cursor to the sorted students' documents.
    '''
    students = mongo_collection.aggregate(
        [
            {
                '$project': {
                    '_id': 1,  # Include the document ID.
                    'name': 1,  # Include the student's name.
                    'averageScore': {
                        '$avg': '$topics.score',  # Calculate average score.
                    },
                    'topics': 1,  # Include the topics field.
                },
            },
            {
                '$sort': {'averageScore': -1},  # Sort by average score (desc).
            },
        ]
    )
    return students