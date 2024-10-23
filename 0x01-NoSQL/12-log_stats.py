#!/usr/bin/env python3
'''Task 12's module: provides stats about Nginx request logs.
'''
from pymongo import MongoClient


def print_nginx_request_logs(nginx_collection):
    '''Prints statistics about Nginx request logs from a MongoDB collection.
    
    Args:
        nginx_collection: The pymongo collection object to query.
    '''
    # Print the total number of logs
    print('{} logs'.format(nginx_collection.count_documents({})))
    print('Methods:')
    methods = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE']
    
    # Count and print the number of logs for each HTTP method
    for method in methods:
        req_count = len(list(nginx_collection.find({'method': method})))
        print('\tmethod {}: {}'.format(method, req_count))
    
    # Count and print the number of status check logs (GET /status)
    status_checks_count = len(list(
        nginx_collection.find({'method': 'GET', 'path': '/status'})
    ))
    print('{} status check'.format(status_checks_count))


def run():
    '''Provides statistics about Nginx logs stored in MongoDB.
    '''
    # Connect to MongoDB server at the default local host and port
    client = MongoClient('mongodb://127.0.0.1:27017')
    print_nginx_request_logs(client.logs.nginx)  # Print log stats


if __name__ == '__main__':  # Run if executed as a script
    run()