#!/usr/bin/env python3
'''Task 15's module: provides stats about Nginx logs from MongoDB.
'''
from pymongo import MongoClient


def print_nginx_request_logs(nginx_collection):
    '''Prints stats about Nginx request logs from a MongoDB collection.
    
    Args:
        nginx_collection: The pymongo collection object to query.
    '''
    # Print total number of logs
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


def print_top_ips(server_collection):
    '''Prints statistics about the top 10 IPs by HTTP requests.
    
    Args:
        server_collection: The pymongo collection object to query.
    '''
    print('IPs:')
    
    # Aggregate top 10 IPs by request count
    request_logs = server_collection.aggregate(
        [
            {
                '$group': {'_id': "$ip", 'totalRequests': {'$sum': 1}}
            },
            {
                '$sort': {'totalRequests': -1}  # Sort by most requests
            },
            {
                '$limit': 10  # Limit to top 10 IPs
            },
        ]
    )
    
    # Print each IP and its request count
    for request_log in request_logs:
        ip = request_log['_id']
        ip_requests_count = request_log['totalRequests']
        print('\t{}: {}'.format(ip, ip_requests_count))


def run():
    '''Provides stats about Nginx logs stored in MongoDB.
    '''
    client = MongoClient('mongodb://127.0.0.1:27017')
    print_nginx_request_logs(client.logs.nginx)
    print_top_ips(client.logs.nginx)


if __name__ == '__main__':  # Run if executed as a script
    run()